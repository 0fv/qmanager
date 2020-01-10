import 'package:dio/dio.dart';
import 'package:localstorage/localstorage.dart';
import 'package:qmanager/common/common.dart';

class Api {
  final LocalStorage storage = new LocalStorage('token');
  Dio _dio;
  Interceptor _tokenInterceptor;
  factory Api() => _getInstance();
  static Api get instance => _getInstance();
  static Api _instance;
  Api._internal() {
    this._dio = Dio();
    _setTokenInterceptor();
    this._dio.interceptors.add(InterceptorsWrapper(onRequest: (option) {
      option.baseUrl = server;
    }));
    this._dio.interceptors.add(this._tokenInterceptor);
  }
  static _getInstance() {
    if (_instance == null) {
      _instance = new Api._internal();
    }
    return _instance;
  }

  //token拦截器对象
  _setTokenInterceptor() {
    String token = storage.getItem("token");
    this._tokenInterceptor = InterceptorsWrapper(onRequest: (o) {
      print(o.path);
      o.headers["token"] = 
          "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE1Nzg2NzI4ODYsInVzZXJuYW1lIjoiYWRtaW4ifQ.Q8sIlvXhuxQHExLfN4NADctvtCir9lPqt1n30LYHgZk";
    });
  }

  //更新token拦截器对象
  updateToken(String token) {
    storage.setItem("token", token);
    this._dio.interceptors.remove(this._tokenInterceptor);
    this._tokenInterceptor = InterceptorsWrapper(onRequest: (o) {
      o.headers["token"] = token;
    });
    this._dio.interceptors.add(this._tokenInterceptor);
  }
  //错误纠正2

  Future<dynamic> getData(String uri, {Map<String, dynamic> param}) async {
    Response response = await this._dio.get(uri, queryParameters: param);
    return response.data;
  }
}
