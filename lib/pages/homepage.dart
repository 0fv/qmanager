
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qmanager/modules/usermodule.dart';
import 'package:qmanager/pages/sidebar/complete.dart';
import 'package:qmanager/pages/sidebar/edit.dart';
import 'package:qmanager/pages/sidebar/email.dart';
import 'package:qmanager/pages/sidebar/finish.dart';
import 'package:qmanager/pages/sidebar/maillog.dart';
import 'package:qmanager/pages/sidebar/mailschedule.dart';
import 'package:qmanager/pages/sidebar/member.dart';
import 'package:qmanager/pages/sidebar/permission.dart';
import 'package:qmanager/pages/sidebar/process.dart';
import 'package:qmanager/pages/sidebar/question.dart';
import 'package:qmanager/pages/sidebar/questiongroup.dart';
import 'package:qmanager/provider/user.dart';
import 'package:qmanager/utils/dateutil.dart';
import 'package:qmanager/widget/diolog/alertdiolog.dart';

class HomePage extends StatefulWidget {
  final arguments;
  HomePage({this.arguments});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final MIN_M = 996;
  double _width = 4000;
  List<Widget> _pages = [
    Edit(),
    Complete(),
    Process(),
    Finish(),
    QuestionGroup(),
    Question(),
    Member(),
    Permission(),
    EmailSetting(),
    MailLogPage(),
    MailSchedulePage(),
  ];
  int _index = 0;
  List<Widget> _buildTitle() {
    User user = Provider.of<UserInfo>(context).user;
    if (user != null) {
      int isSuper = user.isSuper;
      String username = user.username;
      DateTime lastLogin = user.lastLogin;
      String date = "无";
      if (lastLogin != null) {
        date = DateUtil.format2(user.lastLogin);
      }
      return [
        Container(
          alignment: Alignment.center,
          child: Text(
            "${isSuper == 1 ? '管理员' : '用户'} $username 上次登陆：$date",
            style: TextStyle(color: Colors.white),
          ),
        ),
        FlatButton(
          child: Text(
            "退出登陆",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () async {
            bool flag = await alertDialog("确认退出登陆？", context);
            if (flag == true) {
              Provider.of<UserInfo>(context, listen: false).logout();
              Navigator.pushReplacementNamed(context, "/login");
            }
          },
        )
      ];
    } else {
      return <Widget>[];
    }
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserInfo>(context).user;
    if(user==null){
      return Container();
    }
    final width = MediaQuery.of(context).size.width;
    if (this._width != width) {
      setState(() {
        this._width = width;
      });
    }
    if (this._width < MIN_M) {
      return Scaffold(
        appBar: AppBar(
          title: Text("问题问卷管理"),
          actions: _buildTitle(),
        ),
        body: bodyLayoutB(context),
        drawer: getDrawer(context, true),
      );
    } else {
      return Scaffold(
          appBar: AppBar(
            title: Text("问题问卷管理"),
            actions: _buildTitle(),
            automaticallyImplyLeading: false,
          ),
          body: bodyLayoutA(context));
    }
  }

  Widget bodyLayoutA(BuildContext context) {
    return Builder(
      builder: (context) => Row(
        children: <Widget>[
          getDrawer(context, false),
          Expanded(
            child: _pages[_index],
          )
        ],
      ),
    );
  }

  Widget bodyLayoutB(BuildContext context) => Builder(
      builder: (context) => Row(children: <Widget>[
            Expanded(
              child: _pages[_index],
            )
          ]));

  void setIndex(int index, bool pop) {
    setState(() {
      this._index = index;
    });
    if (pop) {
      Navigator.of(context).pop();
    }
  }

  Widget getDrawer(BuildContext context, bool pop) => Builder(
        builder: (context) => Drawer(
            elevation: 0.3,
            child: ListView(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "  问卷管理",
                    style: TextStyle(color: Colors.grey, fontFamily: ""),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.edit),
                  title: Text("编辑中"),
                  selected: 0 == _index,
                  onTap: () {
                    setIndex(0, pop);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.assignment_turned_in),
                  title: Text("已完成模板"),
                  selected: 1 == _index,
                  onTap: () {
                    setIndex(1, pop);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.autorenew),
                  title: Text("正在运行的问卷实例"),
                  selected: 2 == _index,
                  onTap: () {
                    setIndex(2, pop);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.beenhere),
                  title: Text("已完成的问卷实例"),
                  selected: 3 == _index,
                  onTap: () {
                    setIndex(3, pop);
                  },
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "  通用集合管理",
                    style: TextStyle(color: Colors.grey, fontFamily: ""),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.group_work),
                  title: Text("问题组管理"),
                  selected: 4 == _index,
                  onTap: () {
                    setIndex(4, pop);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.question_answer),
                  title: Text("问题管理"),
                  selected: 5 == _index,
                  onTap: () {
                    setIndex(5, pop);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.group),
                  title: Text("被调查人员组管理"),
                  selected: 6 == _index,
                  onTap: () {
                    setIndex(6, pop);
                  },
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "  其他",
                    style: TextStyle(color: Colors.grey, fontFamily: ""),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.people),
                  title: Text("权限管理"),
                  selected: 7 == _index,
                  onTap: () {
                    setIndex(7, pop);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.email),
                  title: Text("邮箱设置"),
                  selected: 8 == _index,
                  onTap: () {
                    setIndex(8, pop);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.assignment),
                  title: Text("邮箱日志"),
                  selected: 9 == _index,
                  onTap: () {
                    setIndex(9, pop);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.schedule),
                  title: Text("未发送邮件"),
                  selected: 10 == _index,
                  onTap: () {
                    setIndex(10, pop);
                  },
                ),
              ],
            )),
      );
}
