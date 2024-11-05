part of 'file_cubit.dart';

sealed class FileState {}

final class FileInitialState extends FileState {}

final class FilesPickedState extends FileState {
  final List<File> files;
  FilesPickedState(this.files);
}

final class FileFailure extends FileState {
  final String error;
  FileFailure(this.error);
}

// final class SendFileSuccess extends FileState {
//   final HomeMsgModel file;
//   SendFileSuccess(this.file);
// }

final class NewFileState extends FileState {
  final ChatMsgModel fileMsg;
  NewFileState(this.fileMsg);
}
