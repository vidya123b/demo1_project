import 'package:demo_project/service/constants.dart';
import 'package:dio/dio.dart';

class API {
  late Dio dio;
  static final API api = API.init();

  API.init() {
    initDio();
  }

  factory API() {
    return api;
  }

  initDio() {
    try {
      dio = Dio(BaseOptions(
        baseUrl: ApiUrls.baseURI,
        connectTimeout: 180000,
        receiveTimeout: 600000,
      ));
      if (dio.interceptors.isEmpty) {
        dio.interceptors.addAll([
          InterceptorsWrapper(
            onRequest: (options, handler) async {
              return handler.next(options);
            },
            onResponse: (response, handler) {
              return handler.next(response);
            },
            onError: (e, handler) async {
              switch (e.type) {
                case DioErrorType.connectTimeout:
                case DioErrorType.other:
                case DioErrorType.sendTimeout:
                  return handler.resolve(e.response!);
                case DioErrorType.response:
                  return handler.resolve(e.response!);
                case DioErrorType.receiveTimeout:
                  break;
                case DioErrorType.cancel:
                  break;
              }
            },
          )
        ]);
      }
    } catch (e) {
      //print(e);
    }
  }

  Future getListOfQuestions() async {
    try {
      return await dio.get('https://api.toppersnotes.com/api/get/mock/questions');
    } catch (e) {
      //print(e);
    }
    return null;
  }
}
