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
        }, onResponse: (o) {
          var data = o.data;
          if (200 != data["code"]) {
            throw data["msg"];
          }
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
      o.headers["token"] =
          "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE1ODA1MjIxNTAsInVzZXJuYW1lIjoiYWRtaW4ifQ.6sMHAfPvjMdfV7yuQ9X09V6UieQ3BqoeT17yY1XdJg0";
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

  Future<dynamic> postData(String uri, var param) async {
    Response response = await this._dio.post(uri, data: param);
    return response.data;
  }

  Future<dynamic> updateData(String uri, var param) async {
    Response response = await this._dio.put(uri, data: param);
    return response.data;
  }

  Future<dynamic> deleteData(String uri, var param) async {
    Response response = await this._dio.delete(uri + "/" + param);
    return response.data;
  }
}
