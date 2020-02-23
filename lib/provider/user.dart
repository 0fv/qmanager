import 'package:flutter/cupertino.dart';
import 'package:localstorage/localstorage.dart';
import 'package:qmanager/api/api.dart';
import 'package:qmanager/api/loginapi.dart';
import 'package:qmanager/modules/usermodule.dart';

class UserInfo extends ChangeNotifier {
  final LocalStorage ls = LocalStorage("token");
  final LoginApi _loginApi = LoginApi();
  Api _api = Api();
  User _user;
  String _token;
  UserInfo() {
    ls.ready.then((value) {
      String token = ls.getItem("token");
      if (token != null) {
        _loginApi.tokenLogin(token).then((value) {
          this._user = User.fromJson(value['data']['user']);
          this._token = token;
          _api.updateToken(token);
          notifyListeners();
        });
      }
    });
  }
  get user => this._user;
  get token => this._token;
  set user(User user) {
    this._user = user;
    notifyListeners();
  }

  set token(String token) {
    this._token = token;
    ls.setItem("token", token);
    notifyListeners();
  }

  logout() {
    this._api.deleteToken();
    this._token = null;
    this._user = null;
    ls.ready.then((value) {
      ls.deleteItem("token");
      notifyListeners();
    });
  }
}
