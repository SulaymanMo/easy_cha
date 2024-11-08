import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:easy_cha/core/service/api_service.dart';

final class FileDownloader {
  final ApiService _service;
  const FileDownloader(this._service);

  // ? Method to download the file
  Future<void> downloadFile(String url, String fileName) async {
    try {
      // ! Get the application documents directory
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String savePath = "${appDocDir.path}/$fileName";

      // ! Start downloading the file
      await _service.download(url, savePath);

      // ! Open the file after downloading
      await openFile(savePath);
    } catch (e) {
      debugPrint("Error downloading file: $e");
    }
  }

  // ? Method to open the downloaded file
  Future<void> openFile(String filePath) async {
    final OpenResult result = await OpenFile.open(filePath);
    if (result.type != ResultType.done) {
      debugPrint("Error opening file: ${result.message}");
    }
  }
}
