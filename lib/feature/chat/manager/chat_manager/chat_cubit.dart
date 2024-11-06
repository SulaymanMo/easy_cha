import 'package:dio/dio.dart';
import 'package:easy_cha/core/constant/const_string.dart';
import '../../../../core/helper/failure.dart';
import '../../../auth/manager/auth_cubit.dart';
import '../../../auth/model/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/service/api_service.dart';
import '../../model/chat_msg_model.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  late UserModel _user;
  final ApiService _apiService;
  List<ChatMsgModel> msgs = [];
  ChatCubit(this._apiService, AuthCubit cubit) : super(ChatInitial()) {
    _user = cubit.user!;
  }

  Future<void> getMsgs(int? id) async {
    try {
      if (id == null) return;
      emit(ChatLoading());
      final result = await _apiService.get(
        userid: "${_user.id}",
        token: _user.token,
        endPoint: "${ConstString.chat}$id",
      );
      // print(result); SENDER AND RECEIVER HERE ARE INT
      // ChatModel chatModel = ChatModel.fromJson(result);
      final List messages = result["data"]?["messages"];
      if (result["status"] == true) {
        for (var msg in messages) {
          final model = ChatMsgModel.fromJson(msg);
          if (['files', 'images'].contains(msg['type'])) {
            final splitted = model.text?.split(",");
            for (String file in splitted!) {
              // Create a new instance for each file to avoid reference duplication
              final newModel = ChatMsgModel.fromJson(msg);
              newModel.text = "${ConstString.path}${model.type}/$file";
              msgs.add(newModel);
            }
          } else {
            msgs.add(model);
          }
        }
        emit(ChatSuccess());
      } else {
        emit(ChatFailure("Oops... Status returned with false!"));
      }
    } on DioException catch (dioexp) {
      emit(ChatFailure(DioFailure(dioexp).error));
    } catch (e) {
      emit(ChatFailure("Unexpected error occurred, Please try again later."));
    }
  }
}
