import 'package:flutter/material.dart';
import 'package:qmanager/common/common.dart';
import 'package:qmanager/modules/questioncellmodule.dart';
import 'package:qmanager/modules/questiongroupmodule.dart';
import 'package:qmanager/widget/diolog/groupeditdiolog.dart';

class QuestionnaireEdit extends StatefulWidget {
  final arguments;
  QuestionnaireEdit({Key key, this.arguments}) : super(key: key);

  @override
  _QuestionnaireEditState createState() => _QuestionnaireEditState();
}

class _QuestionnaireEditState extends State<QuestionnaireEdit> {
  String _name = '';
  String _introduce = '';
  List<QuestionGroup> _questionGroupList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("编辑问卷"),
        actions: <Widget>[
          FlatButton(
            child: Text(
              "保存",
              style: TextStyle(color: Colors.white),
            ),
          ),
          FlatButton(
            child: Text(
              "取消",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      body: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.grey[100],
              child: sideContainer(context),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.white,
              child: displayContainer(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget sideContainer(BuildContext context) {
    return Builder(
      builder: (context) {
        return ListView(
          controller: ScrollController(),
          padding: EdgeInsets.all(20),
          children: <Widget>[
            Text("基本信息"),
            _input("调查问卷名", (str) {
              setState(() {
                this._name = str;
              });
            }),
            _input("简介", (str) {
              setState(() {
                this._introduce = str;
              });
            }, maxLines: 10, maxLength: 500),
            Text("questionGroupDisplay"),
            Text(this
                ._questionGroupList
                .map((f) => f.toJson())
                .toList()
                .toString()),
            Text("编辑"),
            groupAddWidget(),
          ],
        );
      },
    );
  }

  Widget _input(String name, SetValue setValue,
      {int maxLines = 1, int maxLength}) {
    return Container(
      child: TextField(
          minLines: 1,
          maxLines: maxLines,
          maxLength: maxLength,
          decoration: InputDecoration(
            hintText: name,
            border: InputBorder.none,
          ),
          onChanged: setValue),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8)),
          border: Border.all(color: Colors.black12, width: 2)),
    );
  }

  Widget displayContainer(BuildContext context) {
    List<Widget> list = [
      Text(
        " 标题：" + this._name,
        textAlign: TextAlign.left,
        style: TextStyle(fontSize: 30),
      ),
      Text(
        " 介绍：" + this._introduce,
        textAlign: TextAlign.left,
        style: TextStyle(fontSize: 15),
      ),
      Divider(
        height: 10.0,
        indent: 0.0,
        color: Colors.white,
      ),
    ];

    return Builder(builder: (context) {
      return Container(
        padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
        child: ReorderableListView(
          header: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: list,
            ),
          ),
          children: List.generate(this._questionGroupList.length, (index) {
            return questionGroupCard(
                this._questionGroupList[index], context, index);
          }),
          onReorder: (i1, i2) {
            setState(() {
              _swap(i1, i2);
            });
          },
        ),
      );
    });
  }

  _swap(int oldIndex, int newIndex) {
    if (oldIndex > this._questionGroupList.length - 1) {
      oldIndex = this._questionGroupList.length - 1;
    }
    if (newIndex > this._questionGroupList.length - 1) {
      newIndex = this._questionGroupList.length - 1;
    }
    var tmp = this._questionGroupList[oldIndex];
    this._questionGroupList[oldIndex] = this._questionGroupList[newIndex];
    this._questionGroupList[newIndex] = tmp;
  }

  Widget groupAddWidget() {
    return Row(
      children: <Widget>[
        FlatButton(
          child: Text("添加空白问题组"),
          onPressed: () {
            setState(() {
              this._questionGroupList.add(QuestionGroup(
                  title:
                      "问题组" + (this._questionGroupList.length + 1).toString()));
            });
          },
        ),
        FlatButton(
          child: Text("添加现有问题组"),
          onPressed: () {},
        )
      ],
    );
  }

  Widget questionGroupCard(
      QuestionGroup questionGroup, BuildContext context, int key) {
    String title = questionGroup.title;

    List<QuestionCell> questionCells = questionGroup.questionCells;
    return Builder(
        key: ValueKey(key),
        builder: (context) {
          return Card(
            child: ExpansionTile(
              title: Text(title),
              leading: Text(
                (key + 1).toString() + ".",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              trailing: Container(
                width: 100,
                child: Row(children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () async {
                      String gname = await questionGroupEditDialog(
                          context, this._questionGroupList[key].title);
                      if (gname != null && gname.isNotEmpty) {
                        setState(() {
                          this._questionGroupList[key].title = gname;
                        });
                      }
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () async {
                      bool b = await questionGroupDeleteDialog(context);
                      if (b == true) {
                        setState(() {
                          this._questionGroupList.removeAt(key);
                        });
                      }
                    },
                  )
                ]),
              ),
              children: <Widget>[Text("sfsf")],
            ),
          );
        });
  }
}
