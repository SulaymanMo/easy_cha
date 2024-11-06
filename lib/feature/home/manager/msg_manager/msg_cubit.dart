import 'dart:convert';
import 'dart:io';
import 'package:easy_cha/feature/chat/model/chat_msg_model.dart';
import 'package:easy_cha/feature/home/manager/home_manager/home_cubit.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mime_type/mime_type.dart';
import '../../../chat/model/send_file_model.dart';
import '../../model/socket_model/send_msg_model.dart';
import '../../../../core/constant/const_string.dart';
import 'package:easy_cha/feature/home/manager/socket_manager/socket_cubit.dart';

part 'msg_state.dart';

class MsgCubit extends Cubit<MsgState> {
  int limit = 5;
  final HomeCubit _homeCubit;
  final SocketCubit _socketCubit;
  MsgCubit(this._socketCubit, this._homeCubit) : super(MsgInitial());

  Future<void> pickFiles(FileType fileType) async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: fileType,
      allowMultiple: true,
      compressionQuality: 1, // todo: remove this property.
    );

    if (result == null) {
      return;
    } else if (result.files.length > 5) {
      emit(MsgFailure("Maximum limit are only 5 files at once"));
    } else {
      List<File> files = result.paths.map((path) => File(path!)).toList();
      emit(FilesPickedState(files));
    }
  }

  Future<void> sendFiles(SendFileModel fileModel) async {
    try {
      // ! Emit the file via socket with the Base64 string including MIME type
      _socketCubit.socket.emit(
        SocketEvent.file.event,
        jsonEncode(
          SendFileModel(
            type: fileModel.type,
            sender: _socketCubit.user.id,
            receiver: fileModel.receiver,
            files: await _toBase64(fileModel),
          ).toJosn(),
        ),
      );
      _isFileUploaded();
    } catch (e) {
      debugPrint("SEND FILE ERROR: $e");
      emit(MsgFailure("$e"));
    }
  }

  void _isFileUploaded() async {
    try {
      // Remove any existing listener to avoid duplication
      _socketCubit.socket.off(SocketEvent.filesUploaded.event);

      _socketCubit.socket.on(
        SocketEvent.filesUploaded.event,
        (data) {
          // RESPONSE HERE ARE MAP.
          final Map<String, dynamic> response = data;
          final List files = response["files"];
          for (String? file in files) {
            emit(NewMsgState(ChatMsgModel.file(response, fileName: file)));
          }
        },
      );
    } catch (e) {
      debugPrint("IS FILE UPLOADED ERROR: $e");
      emit(MsgFailure("e"));
    }
  }

  Future<List<String>> _toBase64(SendFileModel fileModel) async {
    List<String> base64Files = [];
    // ! Convert each file to Base64 with MIME type prefix
    for (String filePath in fileModel.files) {
      File file = File(filePath);
      // ! Determine the MIME type from the file extension (e.g., png, jpeg)
      String? mimeType = mime(filePath);
      if (mimeType == null) continue;
      // ! Read the file as bytes
      List<int> imageBytes = await file.readAsBytes();
      // ! Convert the bytes to a Base64 string
      String base64Image = base64Encode(imageBytes);
      // ! Add the MIME type prefix to the Base64 string
      String base64WithMime = 'data:$mimeType;base64,$base64Image';
      // ! Add to the list of Base64 files
      base64Files.add(base64WithMime);
      // debugPrint("Base64 File: $base64WithMime");
    }
    return base64Files;
  }

  void receiveFile() {
    try {
      _socketCubit.socket.on(
        SocketEvent.file.event,
        (data) {
          // RESPONSE HERE ARE JSON NOT MAP LIKE OTHER EVENTS.
          final Map<String, dynamic> response = jsonDecode(data);
          final List files = response["files"];
          for (String file in files) {
            emit(NewMsgState(
              ChatMsgModel(
                type: response["type"],
                id: response["messageID"],
                text: "${ConstString.path}${response["type"]}/$file",
                seenAt: "${DateTime.now()}",
                sender: response["sender"],
                receiver: response["receiver"],
              ),
            ));
          }
        },
      );
    } catch (e) {
      emit(MsgFailure("$e"));
    }
  }

  void removeFile({required List<File> files, required int index}) {
    files.removeAt(index);
    emit(FilesPickedState(files));
    if (files.isEmpty) emit(MsgInitial());
  }

  void removeAll(List<File> files) {
    files.clear();
    emit(MsgInitial());
  }

  // ! Receive msg from users (used in home & chat view)
  void receiveMsg() {
    _socketCubit.socket.on(SocketEvent.msg.event, (data) {
      // SENDER AND RECEIVER HERE ARE STRING
      emit(NewMsgState(ChatMsgModel.newMsg(data)));
    });
  }

  // ! Send msg to user (used in chat)
  void sendMsg(int receiver, String msg) {
    _socketCubit.socket.emit(
      SocketEvent.msg.event,
      jsonEncode(
        SendMsgModel(
          sender: _socketCubit.user.id,
          receiver: receiver,
          msg: msg,
        ).toJson(),
      ),
    );
    emit(
      NewMsgState(
        ChatMsgModel(
          text: msg,
          // id: homeMsg.msgid,
          sender: _socketCubit.user.id,
          receiver: receiver,
          type: ConstString.textType,
          seenAt: "${DateTime.now()}",
        ),
      ),
    );
  }

  // ! Seen Sender msg (used in ChatView, receiver is me & sender is other)
  void seenMsg({required int receiver, required int index}) {
    _socketCubit.socket.emit(
      SocketEvent.seenMsg.event,
      jsonEncode({"sender": _socketCubit.user.id, "receiver": receiver}),
    );
    // print(
    // "userid: ${_homeCubit.counters[index].keys.first} || user counter: ${_homeCubit.counters[index][_socketCubit.user.id]}");
    _homeCubit.counters[index][_socketCubit.user.id] = 0;
    // print("user counter: ${_homeCubit.counters[index][_socketCubit.user.id]}");
    // emit(MsgInitial());
  }
}
