part of 'pick_file_cubit.dart';

sealed class PickFileState {}

final class PickFileInitial extends PickFileState {}

final class PickFileSuccess extends PickFileState {
  final List<File> files;
  PickFileSuccess(this.files);
}
