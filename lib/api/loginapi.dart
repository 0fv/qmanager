import 'package:qmanager/api/api.dart';

class LoginApi {
  Api _api = Api();
  String _baseUri = '/login';

  Future<dynamic> login(String username, String passwd) {
    return this
        ._api
        .postData(this._baseUri, {"username": username, "passwd": passwd});
  }

  Future<dynamic> tokenLogin(String token) {
    return this._api.postData(this._baseUri + "/token", {"token": token});
  }
}
