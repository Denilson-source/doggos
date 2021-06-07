import 'package:dio/dio.dart';
import 'package:get/get.dart';

const _baseUrl = 'https://dog.ceo/api';

class HttpService {
  static HttpService get to => Get.find();

  Dio _dio = Dio(BaseOptions(
    receiveDataWhenStatusError: true,
    baseUrl: _baseUrl,
    connectTimeout: 30000,
  ));

  Future<HttpResponse> get({
    required String path,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final res = await _dio.get(path, queryParameters: queryParams);
      return HttpResponse(
        data: res.data,
        status: res.statusCode,
      );
    } catch (e) {
      print(e);
      if (e is DioError && e.type == DioErrorType.other) {
        if (e.message.contains('SocketException')) {
          throw HttpGetError.noConnection;
        }
      }

      throw HttpGetError.unexpected;
    }
  }
}

class HttpResponse {
  dynamic data;
  int? status;

  HttpResponse({
    required this.data,
    this.status,
  });
}

enum HttpGetError { unexpected, noConnection }
