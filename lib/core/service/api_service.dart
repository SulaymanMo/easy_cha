import 'package:dio/dio.dart';
import 'package:easy_cha/core/constant/const_string.dart';

final class ApiService {
  final Dio _dio;
  const ApiService(this._dio);

  Future<Map<String, dynamic>> postFormData({
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
    required String userid,
    required String token,
    required String endPoint,
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

  Future<void> download(String url, String savePath) async {
    await _dio.download(
      url,
      savePath,
      onReceiveProgress: (received, total) {
        if (total != -1) {
          // print("Downloading: ${(received / total * 100).toStringAsFixed(0)}%");
        }
      },
    );
  }
}
