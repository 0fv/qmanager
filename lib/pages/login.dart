import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';
import 'package:qmanager/api/api.dart';
import 'package:qmanager/api/loginapi.dart';
import 'package:qmanager/modules/usermodule.dart';
import 'package:qmanager/pages/homepage.dart';
import 'package:qmanager/provider/user.dart';
import 'package:qmanager/widget/misc.dart';

class Login extends StatefulWidget {
  final arguments;
  Login({Key key, this.arguments}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final LocalStorage ls = LocalStorage("token");
  final LoginApi _loginApi = LoginApi();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final Api _api = Api();

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserInfo>(context).user;
    if (user == null) {
      return _loginBuild(context);
    }else{
      return HomePage(arguments: true,);
    }
  }

  Widget _loginBuild(BuildContext context) {
    return Material(
        color: Colors.blueAccent,
        child: Center(
          child: Container(
            width: 450,
            height: 300,
            child: Card(
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Flex(
                  direction: Axis.vertical,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "问卷管理系统",
                        style: TextStyle(fontSize: 20),
                      ),
                      flex: 1,
                    ),
                    Expanded(
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              input2(context, "用户名", _username),
                              input2(context, "密码", _password,
                                  obscureText: true),
                            ],
                          ),
                        ),
                        flex: 5),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: FlatButton(
                          child: Text("登陆"),
                          onPressed: () async {
                            var username = _username.text;
                            var password = _password.text;
                            try {
                              var d = await _loginApi.login(username, password);
                              _api.updateToken(d['data']['token']);
                              Provider.of<UserInfo>(context, listen: false)
                                  .user = User.fromJson(d['data']['user']);
                              popToast("登陆成功", context);
                              Navigator.pushNamed(context, '/');
                            } on DioError catch (e) {
                              popToast(e.error, context);
                            }
                          },
                        ),
                      ),
                      flex: 1,
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

