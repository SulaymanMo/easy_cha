import 'package:dio/dio.dart';
import 'package:easy_cha/core/constant/const_string.dart';

final class ApiService {
  final Dio _dio;
  const ApiService(this._dio);

  Future<Map<String, dynamic>> post({
    required String endPoint,
    required Map<String, dynamic> formData,
  }) async {
    Response<dynamic> response = await _dio.post(
      "${ConstString.baseUrl}/$endPoint",
      data: FormData.fromMap(formData),
      options: Options(
        headers: {"Authorization": "Bearer ${ConstString.bearerToken}"},
      ),
    );
    return response.data as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> get({
    required String endPoint,
    required String userid,
    required String token,
  }) async {
    Response<Map<String, dynamic>> response = await _dio.get(
      "${ConstString.baseUrl}/$endPoint",
      options: Options(
        headers: {
          "userid": userid,
          "token": token,
          "Authorization": "Bearer ${ConstString.bearerToken}",
        },
      ),
    );
    return response.data as Map<String, dynamic>;
  }
}
