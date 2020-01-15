import 'package:flutter/material.dart';
import 'package:qmanager/pages/sidebar/complete.dart';
import 'package:qmanager/pages/sidebar/edit.dart';
import 'package:qmanager/pages/sidebar/finish.dart';
import 'package:qmanager/pages/sidebar/member.dart';
import 'package:qmanager/pages/sidebar/permission.dart';
import 'package:qmanager/pages/sidebar/process.dart';
import 'package:qmanager/pages/sidebar/question.dart';
import 'package:qmanager/pages/sidebar/questiongroup.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> _pages = [Edit(), Complete(),Process(),Finish(),QuestionGroup(),Question(),Member(),Permission()];
  int _index = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("问题问卷管理")),
      body: Row(
        children: <Widget>[
          Drawer(
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
                      setState(() {
                        this._index = 0;
                      });
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.assignment_turned_in),
                    title: Text("已完成模板"),
                    selected: 1 == _index,
                    onTap: () {
                      setState(() {
                        this._index = 1;
                      });
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.autorenew),
                    title: Text("正在进行"),
                    selected: 2 == _index,
                    onTap: () {
                      setState(() {
                        this._index = 2;
                      });
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.beenhere),
                    title: Text("调查已完成"),
                    selected: 3 == _index,
                    onTap: () {
                      setState(() {
                        this._index = 3;
                      });
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
                    leading: Icon(Icons.format_align_left),
                    title: Text("问题组管理"),
                    selected: 4 == _index,
                    onTap: () {
                      setState(() {
                        this._index = 4;
                      });
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.format_align_left),
                    title: Text("问题管理"),
                    selected: 5 == _index,
                    onTap: () {
                      setState(() {
                        this._index = 5;
                      });
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.format_align_left),
                    title: Text("被调查人员组管理"),
                    selected: 6 == _index,
                    onTap: () {
                      setState(() {
                        this._index = 6;
                      });
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
                      setState(() {
                        this._index = 7;
                      });
                    },
                  ),
                ],
              )),
          Expanded(
            child: _pages[_index],
          )
        ],
      ),
    );
  }
}
