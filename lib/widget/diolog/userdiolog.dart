import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:qmanager/api/userapi.dart';
import 'package:qmanager/modules/permissionmodule.dart';
import 'package:qmanager/modules/usermodule.dart';
import 'package:qmanager/widget/misc.dart';

Future<User> addUserDialog(BuildContext context) {
  return showDialog<User>(
      context: context,
      builder: (context) {
        var child = UserForm();
        return Dialog(
          child: child,
        );
      });
}

Future<void> updateUserPasswordDialog(BuildContext context, String id) {
  return showDialog<void>(
      context: context,
      builder: (context) {
        var child = UserPasswordForm(
          id: id,
        );
        return Dialog(
          child: child,
        );
      });
}

Future<void> updateUserPermission(BuildContext context, User user) {
  return showDialog<void>(
      context: context,
      builder: (context) {
        var child = UserPermissionForm(user: user);
        return Dialog(
          child: child,
        );
      });
}

class UserPermissionForm extends StatefulWidget {
  final User user;
  UserPermissionForm({Key key, this.user}) : super(key: key);

  @override
  _UserPermissionFormState createState() => _UserPermissionFormState();
}

class _UserPermissionFormState extends State<UserPermissionForm> {
  User _user;
  final UserApi _userApi = UserApi();
  @override
  Widget build(BuildContext context) {
    _user = widget.user;

    return Container(
      height: 600,
      width: 500,
      child: ListView(
        children: <Widget>[
          Container(
            color: Colors.redAccent,
            padding: EdgeInsets.fromLTRB(10, 10, 0, 20),
            child: Text(
              "用户：${_user.username}权限设置",
              style: TextStyle(fontSize: 20),
            ),
          ),
          ListTile(
            leading: Checkbox(
                value: _user.permission.inquiryConfig,
                onChanged: (value) {
                  setState(() {
                    _user.permission.inquiryConfig = value;
                  });
                }),
            title: Text("编辑管理"),
          ),
          ListTile(
            leading: Checkbox(
                value: _user.permission.tmeplateControl,
                onChanged: (value) {
                  setState(() {
                    _user.permission.tmeplateControl = value;
                  });
                }),
            title: Text("已完成模板管理"),
          ),
          ListTile(
            leading: Checkbox(
                value: _user.permission.questionnaire,
                onChanged: (value) {
                  setState(() {
                    _user.permission.questionnaire = value;
                  });
                }),
            title: Text("调查进行中管理"),
          ),
          ListTile(
            leading: Checkbox(
                value: _user.permission.resultShow,
                onChanged: (value) {
                  setState(() {
                    _user.permission.resultShow = value;
                  });
                }),
            title: Text("统计已完成管理"),
          ),
          ListTile(
            leading: Checkbox(
                value: _user.permission.questionGroups,
                onChanged: (value) {
                  setState(() {
                    _user.permission.questionGroups = value;
                  });
                }),
            title: Text("问题组管理"),
          ),
          ListTile(
            leading: Checkbox(
                value: _user.permission.questionCells,
                onChanged: (value) {
                  setState(() {
                    _user.permission.questionCells = value;
                  });
                }),
            title: Text("问题管理"),
          ),
          ListTile(
            leading: Checkbox(
                value: _user.permission.inquiryCrew,
                onChanged: (value) {
                  setState(() {
                    _user.permission.inquiryCrew = value;
                  });
                }),
            title: Text("被调查人员组管理"),
          ),
          ListTile(
            leading: Checkbox(
                value: _user.permission.accountManagement,
                onChanged: (value) {
                  setState(() {
                    _user.permission.accountManagement = value;
                  });
                }),
            title: Text("权限管理"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FlatButton(
                child: Text("取消"),
                onPressed: () => Navigator.of(context).pop(),
              ),
              FlatButton(
                  child: Text("确定"),
                  onPressed: () async {
                    try {
                      await _userApi.updatePermission(this._user);
                      popToast("修改成功", context);
                    } on DioError catch (error) {
                      var msg = error.message;
                      popToast(msg, context);
                    }
                    Navigator.of(context).pop();
                  }),
            ],
          )
        ],
      ),
    );
  }
}

class UserPasswordForm extends StatefulWidget {
  final String id;
  UserPasswordForm({Key key, this.id}) : super(key: key);

  @override
  _UserPasswordFormState createState() => _UserPasswordFormState();
}

class _UserPasswordFormState extends State<UserPasswordForm> {
  TextEditingController _password1 = TextEditingController();
  TextEditingController _password2 = TextEditingController();
  GlobalKey _formKey = new GlobalKey<FormState>();
  final UserApi _userApi = UserApi();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      height: 300,
      width: 500,
      child: Form(
        key: _formKey,
        autovalidate: false,
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 0, 20),
              child: Text(
                "重置密码",
                style: TextStyle(fontSize: 20),
              ),
            ),
            TextFormField(
              autofocus: false,
              controller: _password1,
              decoration: InputDecoration(labelText: "密码"),
              validator: (v) {
                return v.length >= 8 ? null : "长度需要大于等于8";
              },
              obscureText: true,
            ),
            TextFormField(
              autofocus: false,
              controller: _password2,
              decoration: InputDecoration(labelText: "密码确认"),
              validator: (v) {
                return v == _password1.text ? null : "两次输入的不相同，请再次确认";
              },
              obscureText: true,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                  child: Text("取消"),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                FlatButton(
                    child: Text("确定"),
                    onPressed: () async {
                      if ((_formKey.currentState as FormState).validate()) {
                        String passwd = _password2.text;
                        User user = User(
                          id: widget.id,
                          passwd: passwd,
                        );
                        try {
                          await _userApi.updatePassword(user);
                          Navigator.of(context).pop();
                          popToast("修改成功", context);
                        } on DioError catch (error) {
                          var msg = error.message;
                          popToast(msg, context);
                        }
                      }
                    }),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class UserForm extends StatefulWidget {
  UserForm({Key key}) : super(key: key);

  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();
  Permission _permission = Permission();
  GlobalKey _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        padding: EdgeInsets.all(20),
        height: 700,
        width: 500,
        child: Form(
          key: _formKey,
          autovalidate: false,
          child: ListView(
            children: <Widget>[
              TextFormField(
                  autofocus: true,
                  controller: _username,
                  decoration: InputDecoration(labelText: "用户名"),
                  validator: (v) {
                    return v.length >= 4 ? null : "长度需要大于等于4";
                  }),
              TextFormField(
                autofocus: false,
                controller: _password,
                decoration: InputDecoration(labelText: "密码"),
                validator: (v) {
                  return v.length > 4 ? null : "长度需要大于8";
                },
                obscureText: true,
              ),
              Text("权限控制"),
              ListTile(
                leading: Checkbox(
                    value: _permission.inquiryConfig,
                    onChanged: (value) {
                      setState(() {
                        _permission.inquiryConfig = value;
                      });
                    }),
                title: Text("编辑管理"),
              ),
              ListTile(
                leading: Checkbox(
                    value: _permission.tmeplateControl,
                    onChanged: (value) {
                      setState(() {
                        _permission.tmeplateControl = value;
                      });
                    }),
                title: Text("已完成模板管理"),
              ),
              ListTile(
                leading: Checkbox(
                    value: _permission.questionnaire,
                    onChanged: (value) {
                      setState(() {
                        _permission.questionnaire = value;
                      });
                    }),
                title: Text("调查进行中管理"),
              ),
              ListTile(
                leading: Checkbox(
                    value: _permission.resultShow,
                    onChanged: (value) {
                      setState(() {
                        _permission.resultShow = value;
                      });
                    }),
                title: Text("统计已完成管理"),
              ),
              ListTile(
                leading: Checkbox(
                    value: _permission.questionGroups,
                    onChanged: (value) {
                      setState(() {
                        _permission.questionGroups = value;
                      });
                    }),
                title: Text("问题组管理"),
              ),
              ListTile(
                leading: Checkbox(
                    value: _permission.questionCells,
                    onChanged: (value) {
                      setState(() {
                        _permission.questionCells = value;
                      });
                    }),
                title: Text("问题管理"),
              ),
              ListTile(
                leading: Checkbox(
                    value: _permission.inquiryCrew,
                    onChanged: (value) {
                      setState(() {
                        _permission.inquiryCrew = value;
                      });
                    }),
                title: Text("被调查人员组管理"),
              ),
              ListTile(
                leading: Checkbox(
                    value: _permission.accountManagement,
                    onChanged: (value) {
                      setState(() {
                        _permission.accountManagement = value;
                      });
                    }),
                title: Text("权限管理"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  FlatButton(
                    child: Text("取消"),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  FlatButton(
                      child: Text("确定"),
                      onPressed: () {
                        if ((_formKey.currentState as FormState).validate()) {
                          String name = _username.text;
                          String passwd = _password.text;
                          User user = User(
                              username: name,
                              passwd: passwd,
                              permission: _permission);
                          Navigator.of(context).pop(user);
                        }
                      }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
