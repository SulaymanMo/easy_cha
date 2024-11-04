import 'dart:io';
import 'dart:convert';
import '../../model/file_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constant/const_string.dart';
import '../../../home/manager/socket_manager/socket_cubit.dart';

part 'pick_file_state.dart';

class PickFileCubit extends Cubit<PickFileState> {
  final SocketCubit _socket;
  PickFileCubit(this._socket) : super(PickFileInitial());

  Future<void> pickFiles(FileType fileType) async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: fileType,
      allowMultiple: true,
    );
    if (result == null) return;
    List<File> files = result.paths.map((path) => File(path!)).toList();
    emit(PickFileSuccess(files));
  }

  void sendFiles(FileModel file) {
    _socket.socket.emit(
      SocketEvent.file.event,
      jsonEncode(
        FileModel(
          type: file.type,
          files: file.files,
          sender: _socket.user.id,
          receiver: file.receiver,
        ),
      ),
    );
  }
}
