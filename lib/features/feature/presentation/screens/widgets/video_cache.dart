import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';

class VideoCacheManager {
  final Dio _dio = Dio();

  Future<String> downloadAndCacheVideo(String url) async {
    final cacheDir = await getTemporaryDirectory();
    final fileName = url.split('/').last;
    final filePath = '${cacheDir.path}/$fileName';

    if (await File(filePath).exists()) {
      return filePath;
    }

    final response = await _dio.download(url, filePath);
    if (response.statusCode == 200) {
      return filePath;
    } else {
      throw Exception('Failed to download video');
    }
  }

  Future<String> getAdaptiveVideoUrl(String baseUrl) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    String resolution = '480p'; // Default resolution

    if (connectivityResult == ConnectivityResult.mobile) {
      resolution = '240p';
    } else if (connectivityResult == ConnectivityResult.wifi) {
      resolution = '720p';
    }

    return '$baseUrl/$resolution.mp4';
  }
}