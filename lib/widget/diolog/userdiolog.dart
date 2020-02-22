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

  Widget _buildSetting(String permission, String title, ValueChanged<bool> f1,
      ValueChanged<bool> f2) {
    return Visibility(
      visible: _user.isSuper == 0,
      child: ListTile(
        title: Text(title),
        trailing: Container(
          width: 220,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text("查看"),
              Checkbox(
                  value: (permission == 'w' || permission == 'r'),
                  onChanged: f1),
              Text("修改"),
              Checkbox(value: permission == 'w', onChanged: f2),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _permissionList() {
    return <Widget>[
      SwitchListTile(
          value: _user.isSuper == 1,
          title: Text("管理员"),
          onChanged: (value) {
            if (value) {
              setState(() {
                _user.isSuper = 1;
              });
            } else {
              setState(() {
                _user.isSuper = 0;
              });
            }
          }),
      _buildSetting(
          _user.permission.inquiryConfig,
          "编辑管理",
          _user.permission.inquiryConfig == "w"
              ? null
              : (value) {
                  setState(() {
                    if (value) {
                      _user.permission.inquiryConfig = "r";
                    } else {
                      _user.permission.inquiryConfig = "";
                    }
                  });
                }, (value) {
        setState(() {
          if (value) {
            _user.permission.inquiryConfig = "w";
          } else {
            _user.permission.inquiryConfig = "";
          }
        });
      }),
      _buildSetting(
          _user.permission.templateControl,
          "已完成模板管理",
          _user.permission.templateControl == "w"
              ? null
              : (value) {
                  setState(() {
                    if (value) {
                      _user.permission.templateControl = "r";
                    } else {
                      _user.permission.templateControl = "";
                    }
                  });
                }, (value) {
        setState(() {
          if (value) {
            _user.permission.templateControl = "w";
          } else {
            _user.permission.templateControl = "";
          }
        });
      }),
      _buildSetting(
          _user.permission.questionnaire,
          "调查进行管理",
          _user.permission.questionnaire == "w"
              ? null
              : (value) {
                  setState(() {
                    if (value) {
                      _user.permission.questionnaire = "r";
                    } else {
                      _user.permission.questionnaire = "";
                    }
                  });
                }, (value) {
        setState(() {
          if (value) {
            _user.permission.questionnaire = "w";
          } else {
            _user.permission.questionnaire = "";
          }
        });
      }),
      _buildSetting(
          _user.permission.resultShow,
          "统计已完成管理",
          _user.permission.resultShow == "w"
              ? null
              : (value) {
                  setState(() {
                    if (value) {
                      _user.permission.resultShow = "r";
                    } else {
                      _user.permission.resultShow = "";
                    }
                  });
                }, (value) {
        setState(() {
          if (value) {
            _user.permission.resultShow = "w";
          } else {
            _user.permission.resultShow = "";
          }
        });
      }),
      _buildSetting(
          _user.permission.questionGroups,
          "问题组管理",
          _user.permission.questionGroups == "w"
              ? null
              : (value) {
                  setState(() {
                    if (value) {
                      _user.permission.questionGroups = "r";
                    } else {
                      _user.permission.questionGroups = "";
                    }
                  });
                }, (value) {
        setState(() {
          if (value) {
            _user.permission.questionGroups = "w";
          } else {
            _user.permission.questionGroups = "";
          }
        });
      }),
      _buildSetting(
          _user.permission.questionCells,
          "问题管理",
          _user.permission.questionCells == "w"
              ? null
              : (value) {
                  setState(() {
                    if (value) {
                      _user.permission.questionCells = "r";
                    } else {
                      _user.permission.questionCells = "";
                    }
                  });
                }, (value) {
        setState(() {
          if (value) {
            _user.permission.questionCells = "w";
          } else {
            _user.permission.questionCells = "";
          }
        });
      }),
      _buildSetting(
          _user.permission.inquiryCrew,
          "被调查人员组管理",
          _user.permission.inquiryCrew == "w"
              ? null
              : (value) {
                  setState(() {
                    if (value) {
                      _user.permission.inquiryCrew = "r";
                    } else {
                      _user.permission.inquiryCrew = "";
                    }
                  });
                }, (value) {
        setState(() {
          if (value) {
            _user.permission.inquiryCrew = "w";
          } else {
            _user.permission.inquiryCrew = "";
          }
        });
      }),
      _buildSetting(
          _user.permission.accountManagement,
          "权限管理",
          _user.permission.accountManagement == "w"
              ? null
              : (value) {
                  setState(() {
                    if (value) {
                      _user.permission.accountManagement = "r";
                    } else {
                      _user.permission.accountManagement = "";
                    }
                  });
                }, (value) {
        setState(() {
          if (value) {
            _user.permission.accountManagement = "w";
          } else {
            _user.permission.accountManagement = "";
          }
        });
      }),
      _buildSetting(
          _user.permission.mailManagement,
          "邮箱管理",
          _user.permission.mailManagement == "w"
              ? null
              : (value) {
                  setState(() {
                    if (value) {
                      _user.permission.mailManagement = "r";
                    } else {
                      _user.permission.mailManagement = "";
                    }
                  });
                }, (value) {
        setState(() {
          if (value) {
            _user.permission.mailManagement = "w";
          } else {
            _user.permission.mailManagement = "";
          }
        });
      }),
    ];
  }

  @override
  Widget build(BuildContext context) {
    _user = widget.user;

    return Container(
        height: 700,
        width: 500,
        child: Flex(
          direction: Axis.vertical,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 10, 0, 20),
                child: Text(
                  "用户：${_user.username}权限设置",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: ListView(
                children: _permissionList(),
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
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
              ),
            )
          ],
        ));
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
  User _user = User(isSuper: 0, permission: Permission());
  GlobalKey _formKey = new GlobalKey<FormState>();
  Widget _buildSetting(String permission, String title, ValueChanged<bool> f1,
      ValueChanged<bool> f2) {
    return Visibility(
      visible: _user.isSuper == 0,
      child: ListTile(
        title: Text(title),
        trailing: Container(
          width: 220,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text("查看"),
              Checkbox(
                  value: (permission == 'w' || permission == 'r'),
                  onChanged: f1),
              Text("修改"),
              Checkbox(value: permission == 'w', onChanged: f2),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _permissionList() {
    return <Widget>[
      SwitchListTile(
          value: _user.isSuper == 1,
          title: Text("是否为管理员"),
          onChanged: (value) {
            if (value) {
              setState(() {
                _user.isSuper = 1;
              });
            } else {
              setState(() {
                _user.isSuper = 0;
              });
            }
          }),
      _buildSetting(
          _user.permission.inquiryConfig,
          "编辑管理",
          _user.permission.inquiryConfig == "w"
              ? null
              : (value) {
                  setState(() {
                    if (value) {
                      _user.permission.inquiryConfig = "r";
                    } else {
                      _user.permission.inquiryConfig = "";
                    }
                  });
                }, (value) {
        setState(() {
          if (value) {
            _user.permission.inquiryConfig = "w";
          } else {
            _user.permission.inquiryConfig = "";
          }
        });
      }),
      _buildSetting(
          _user.permission.templateControl,
          "已完成模板管理",
          _user.permission.templateControl == "w"
              ? null
              : (value) {
                  setState(() {
                    if (value) {
                      _user.permission.templateControl = "r";
                    } else {
                      _user.permission.templateControl = "";
                    }
                  });
                }, (value) {
        setState(() {
          if (value) {
            _user.permission.templateControl = "w";
          } else {
            _user.permission.templateControl = "";
          }
        });
      }),
      _buildSetting(
          _user.permission.questionnaire,
          "调查进行管理",
          _user.permission.questionnaire == "w"
              ? null
              : (value) {
                  setState(() {
                    if (value) {
                      _user.permission.questionnaire = "r";
                    } else {
                      _user.permission.questionnaire = "";
                    }
                  });
                }, (value) {
        setState(() {
          if (value) {
            _user.permission.questionnaire = "w";
          } else {
            _user.permission.questionnaire = "";
          }
        });
      }),
      _buildSetting(
          _user.permission.resultShow,
          "统计已完成管理",
          _user.permission.resultShow == "w"
              ? null
              : (value) {
                  setState(() {
                    if (value) {
                      _user.permission.resultShow = "r";
                    } else {
                      _user.permission.resultShow = "";
                    }
                  });
                }, (value) {
        setState(() {
          if (value) {
            _user.permission.resultShow = "w";
          } else {
            _user.permission.resultShow = "";
          }
        });
      }),
      _buildSetting(
          _user.permission.questionGroups,
          "问题组管理",
          _user.permission.questionGroups == "w"
              ? null
              : (value) {
                  setState(() {
                    if (value) {
                      _user.permission.questionGroups = "r";
                    } else {
                      _user.permission.questionGroups = "";
                    }
                  });
                }, (value) {
        setState(() {
          if (value) {
            _user.permission.questionGroups = "w";
          } else {
            _user.permission.questionGroups = "";
          }
        });
      }),
      _buildSetting(
          _user.permission.questionCells,
          "问题管理",
          _user.permission.questionCells == "w"
              ? null
              : (value) {
                  setState(() {
                    if (value) {
                      _user.permission.questionCells = "r";
                    } else {
                      _user.permission.questionCells = "";
                    }
                  });
                }, (value) {
        setState(() {
          if (value) {
            _user.permission.questionCells = "w";
          } else {
            _user.permission.questionCells = "";
          }
        });
      }),
      _buildSetting(
          _user.permission.inquiryCrew,
          "被调查人员组管理",
          _user.permission.inquiryCrew == "w"
              ? null
              : (value) {
                  setState(() {
                    if (value) {
                      _user.permission.inquiryCrew = "r";
                    } else {
                      _user.permission.inquiryCrew = "";
                    }
                  });
                }, (value) {
        setState(() {
          if (value) {
            _user.permission.inquiryCrew = "w";
          } else {
            _user.permission.inquiryCrew = "";
          }
        });
      }),
      _buildSetting(
          _user.permission.accountManagement,
          "权限管理",
          _user.permission.accountManagement == "w"
              ? null
              : (value) {
                  setState(() {
                    if (value) {
                      _user.permission.accountManagement = "r";
                    } else {
                      _user.permission.accountManagement = "";
                    }
                  });
                }, (value) {
        setState(() {
          if (value) {
            _user.permission.accountManagement = "w";
          } else {
            _user.permission.accountManagement = "";
          }
        });
      }),
      _buildSetting(
          _user.permission.mailManagement,
          "邮箱管理",
          _user.permission.mailManagement == "w"
              ? null
              : (value) {
                  setState(() {
                    if (value) {
                      _user.permission.mailManagement = "r";
                    } else {
                      _user.permission.mailManagement = "";
                    }
                  });
                }, (value) {
        setState(() {
          if (value) {
            _user.permission.mailManagement = "w";
          } else {
            _user.permission.mailManagement = "";
          }
        });
      }),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
          padding: EdgeInsets.all(20),
          height: 700,
          width: 500,
          child: Flex(
            direction: Axis.vertical,
            children: [
              Expanded(
                flex: 9,
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
                      ListTile(
                        title: Text("权限控制"),
                      ),
                      SwitchListTile(
                          value: _user.isSuper == 1,
                          title: Text("管理员"),
                          onChanged: (value) {
                            if (value) {
                              setState(() {
                                _user.isSuper = 1;
                              });
                            } else {
                              setState(() {
                                _user.isSuper = 0;
                              });
                            }
                          }),
                      _buildSetting(
                          _user.permission.inquiryConfig,
                          "编辑管理",
                          _user.permission.inquiryConfig == "w"
                              ? null
                              : (value) {
                                  setState(() {
                                    if (value) {
                                      _user.permission.inquiryConfig = "r";
                                    } else {
                                      _user.permission.inquiryConfig = "";
                                    }
                                  });
                                }, (value) {
                        setState(() {
                          if (value) {
                            _user.permission.inquiryConfig = "w";
                          } else {
                            _user.permission.inquiryConfig = "";
                          }
                        });
                      }),
                      _buildSetting(
                          _user.permission.templateControl,
                          "已完成模板管理",
                          _user.permission.templateControl == "w"
                              ? null
                              : (value) {
                                  setState(() {
                                    if (value) {
                                      _user.permission.templateControl = "r";
                                    } else {
                                      _user.permission.templateControl = "";
                                    }
                                  });
                                }, (value) {
                        setState(() {
                          if (value) {
                            _user.permission.templateControl = "w";
                          } else {
                            _user.permission.templateControl = "";
                          }
                        });
                      }),
                      _buildSetting(
                          _user.permission.questionnaire,
                          "调查进行管理",
                          _user.permission.questionnaire == "w"
                              ? null
                              : (value) {
                                  setState(() {
                                    if (value) {
                                      _user.permission.questionnaire = "r";
                                    } else {
                                      _user.permission.questionnaire = "";
                                    }
                                  });
                                }, (value) {
                        setState(() {
                          if (value) {
                            _user.permission.questionnaire = "w";
                          } else {
                            _user.permission.questionnaire = "";
                          }
                        });
                      }),
                      _buildSetting(
                          _user.permission.resultShow,
                          "统计已完成管理",
                          _user.permission.resultShow == "w"
                              ? null
                              : (value) {
                                  setState(() {
                                    if (value) {
                                      _user.permission.resultShow = "r";
                                    } else {
                                      _user.permission.resultShow = "";
                                    }
                                  });
                                }, (value) {
                        setState(() {
                          if (value) {
                            _user.permission.resultShow = "w";
                          } else {
                            _user.permission.resultShow = "";
                          }
                        });
                      }),
                      _buildSetting(
                          _user.permission.questionGroups,
                          "问题组管理",
                          _user.permission.questionGroups == "w"
                              ? null
                              : (value) {
                                  setState(() {
                                    if (value) {
                                      _user.permission.questionGroups = "r";
                                    } else {
                                      _user.permission.questionGroups = "";
                                    }
                                  });
                                }, (value) {
                        setState(() {
                          if (value) {
                            _user.permission.questionGroups = "w";
                          } else {
                            _user.permission.questionGroups = "";
                          }
                        });
                      }),
                      _buildSetting(
                          _user.permission.questionCells,
                          "问题管理",
                          _user.permission.questionCells == "w"
                              ? null
                              : (value) {
                                  setState(() {
                                    if (value) {
                                      _user.permission.questionCells = "r";
                                    } else {
                                      _user.permission.questionCells = "";
                                    }
                                  });
                                }, (value) {
                        setState(() {
                          if (value) {
                            _user.permission.questionCells = "w";
                          } else {
                            _user.permission.questionCells = "";
                          }
                        });
                      }),
                      _buildSetting(
                          _user.permission.inquiryCrew,
                          "被调查人员组管理",
                          _user.permission.inquiryCrew == "w"
                              ? null
                              : (value) {
                                  setState(() {
                                    if (value) {
                                      _user.permission.inquiryCrew = "r";
                                    } else {
                                      _user.permission.inquiryCrew = "";
                                    }
                                  });
                                }, (value) {
                        setState(() {
                          if (value) {
                            _user.permission.inquiryCrew = "w";
                          } else {
                            _user.permission.inquiryCrew = "";
                          }
                        });
                      }),
                      _buildSetting(
                          _user.permission.accountManagement,
                          "权限管理",
                          _user.permission.accountManagement == "w"
                              ? null
                              : (value) {
                                  setState(() {
                                    if (value) {
                                      _user.permission.accountManagement = "r";
                                    } else {
                                      _user.permission.accountManagement = "";
                                    }
                                  });
                                }, (value) {
                        setState(() {
                          if (value) {
                            _user.permission.accountManagement = "w";
                          } else {
                            _user.permission.accountManagement = "";
                          }
                        });
                      }),
                      _buildSetting(
                          _user.permission.mailManagement,
                          "邮箱管理",
                          _user.permission.mailManagement == "w"
                              ? null
                              : (value) {
                                  setState(() {
                                    if (value) {
                                      _user.permission.mailManagement = "r";
                                    } else {
                                      _user.permission.mailManagement = "";
                                    }
                                  });
                                }, (value) {
                        setState(() {
                          if (value) {
                            _user.permission.mailManagement = "w";
                          } else {
                            _user.permission.mailManagement = "";
                          }
                        });
                      }),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
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
                            _user.username = name;
                            _user.passwd = passwd;
                            Navigator.of(context).pop(_user);
                          }
                        }),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
