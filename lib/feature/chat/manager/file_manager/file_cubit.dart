import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../../../../core/constant/const_string.dart';
import '../../model/chat_msg_model.dart';
import '../../model/send_file_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../home/manager/socket_manager/socket_cubit.dart';
import 'package:mime_type/mime_type.dart'; // ! For determining MIME type based on file extension

part 'file_state.dart';

class FileCubit extends Cubit<FileState> {
  int limit = 5;
  final SocketCubit _socket;
  FileCubit(this._socket) : super(FileInitialState());

  Future<void> pickFiles(FileType fileType) async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: fileType,
      allowMultiple: true,
      compressionQuality: 1, // todo: remove this property.
    );

    if (result == null) {
      return;
    } else if (result.files.length > 5) {
      emit(FileFailure("Maximum limit are only 5 files at once"));
    } else {
      List<File> files = result.paths.map((path) => File(path!)).toList();
      emit(FilesPickedState(files));
    }
  }

  Future<void> sendFiles(SendFileModel fileModel) async {
    try {
      List<String> base64Files = [];
      // ! Convert each file to Base64 with MIME type prefix
      for (String filePath in fileModel.files) {
        File file = File(filePath);
        // ! Determine the MIME type from the file extension (e.g., png, jpeg)
        String? mimeType = mime(filePath);
        if (mimeType == null) return;
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

      // ! Emit the file via socket with the Base64 string including MIME type
      _socket.socket.emit(
        SocketEvent.file.event,
        jsonEncode(
          SendFileModel(
            files: base64Files,
            type: fileModel.type,
            sender: _socket.user.id,
            receiver: fileModel.receiver,
          ).toJosn(),
        ),
      );
      _isFileUploaded(ChatMsgModel(
        type: fileModel.type,
        file: fileModel.files,
        sender: _socket.user.id,
        receiver: fileModel.receiver,
        seenAt: "${DateTime.now()}",
      )..toString()); // TODO: remove toString
    } catch (e) {
      debugPrint("SEND FILE ERROR: $e");
      emit(FileFailure("$e"));
    }
  }

  void _isFileUploaded(ChatMsgModel file) async {
    try {
      _socket.socket.on(
        SocketEvent.filesUploaded.event,
        (data) {
          debugPrint("$data");
          final SendFileModel fileModel = SendFileModel.fromJson(data);
          // emit(NewFileState(
          //   ChatMsgModel(
          //     id: data["messageID"] as int?,
          //     type: fileModel.type,
          //     file: fileModel.files,
          //     sender: fileModel.sender,
          //     receiver: fileModel.receiver,
          //     seenAt: "${DateTime.now()}",
          //   ),
          // ));
        },
      );
    } catch (e) {
      debugPrint("IS FILE UPLOADED ERROR: $e");
      emit(FileFailure("e"));
    }
  }

  void receiveFile() {
    try {
      _socket.socket.on(
        SocketEvent.file.event,
        (data) {
          debugPrint("$data");
          SendFileModel model = SendFileModel.fromJson(data);
          print(model.files);
          // emit(NewFileState(
          //   ChatMsgModel(
          //     type: data["type"] as String?,
          //     file: data["files"] as dynamic,
          //     sender: int.parse(data["sender"]),
          //     receiver: int.parse(data["receiver"]),
          //     seenAt: "${DateTime.now()}",
          //     id: data["messageID"],
          //   )..toString(),
          // ));
        },
      );
    } catch (e) {
      emit(FileFailure("$e"));
    }
  }

  void removeFile({required List<File> files, required int index}) {
    files.removeAt(index);
    emit(FilesPickedState(files));
    if (files.isEmpty) emit(FileInitialState());
  }

  void removeAll(List<File> files) {
    files.clear();
    emit(FileInitialState());
  }
}
