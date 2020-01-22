import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:qmanager/api/questiongroupcollectionapi.dart';
import 'package:qmanager/modules/questioncellcollectionmodule.dart';
import 'package:qmanager/modules/questioncellmodule.dart';
import 'package:qmanager/modules/questiongroupcollectionmodule.dart';
import 'package:qmanager/utils/adapterutil.dart';
import 'package:qmanager/widget/diolog/alertdiolog.dart';
import 'package:qmanager/widget/diolog/questioncellcollection.dart';
import 'package:qmanager/widget/diolog/questioncollectiontablediolog.dart';
import 'package:qmanager/widget/misc.dart';
import 'package:qmanager/widget/table/questiontable.dart';

class QuestionGroupEdit extends StatefulWidget {
  final arguments;
  QuestionGroupEdit({Key key, this.arguments}) : super(key: key);

  @override
  _QuestionGroupEditState createState() => _QuestionGroupEditState();
}

class _QuestionGroupEditState extends State<QuestionGroupEdit> {
  TextEditingController _title = TextEditingController();
  TextEditingController _classification = TextEditingController();
  FocusNode _tfn = FocusNode();
  FocusNode _cfn = FocusNode();
  final QuestionGroupCollectionApi questionGroupCollectionApi =
      QuestionGroupCollectionApi();

  @override
  void initState() {
    super.initState();
    this._tfn.addListener(() {
      if (!_tfn.hasFocus) {
        setState(() {
          this._questionGroupCollection.title = _title.text;
        });
      }
    });
    this._cfn.addListener(() {
      if (!_cfn.hasFocus) {
        setState(() {
          this._questionGroupCollection.classification = _classification.text;
        });
      }
    });
  }

  QuestionGroupCollection _questionGroupCollection =
      QuestionGroupCollection(questionCells: []);
  @override
  Widget build(BuildContext context) {
    if (widget.arguments != null) {
      QuestionGroupCollection q = widget.arguments;
      setState(() {
        this._questionGroupCollection = q;
        this._classification.text = q.classification;
        this._title.text = q.title;
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("问题组编辑"),
        actions: <Widget>[
          FlatButton(
            child: Text(
              "取消",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {
              bool flag = await alertDialog("尚未保存，确认退出？", context);
              if (flag) {
                Navigator.of(context).pop();
              }
            },
          ),
          FlatButton(
            child: Text(
              "保存",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {
              if (widget.arguments == null) {
                try {
                  await questionGroupCollectionApi
                      .addData(this._questionGroupCollection);
                  popToast("创建成功", context);
                  Future.delayed(Duration(milliseconds: 200)).then((onValue) {
                    Navigator.pop(context,true);
                  });
                } on DioError catch (error) {
                  var msg = error.message;
                  popToast(msg, context);
                }
              }else{
                try {
                  await questionGroupCollectionApi
                      .updateData(this._questionGroupCollection);
                  popToast("修改成功", context);
                  Future.delayed(Duration(milliseconds: 200)).then((onValue) {
                    Navigator.pop(context,true);
                  });
                } on DioError catch (error) {
                  var msg = error.message;
                  popToast(msg, context);
                }
              }
            },
          ),
        ],
      ),
      body: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.grey[200],
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
    return Container(
      padding: EdgeInsets.all(20),
      child: ListView(
        children: <Widget>[
          input(
            context,
            "问题组标题",
            null,
            tec: this._title,
            fn: this._tfn,
            length: 50,
          ),
          input(context, "类型", null,
              tec: this._classification, fn: this._cfn, length: 10),
          Container(
            child: Text("value:3${_questionGroupCollection.toJson()}"),
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: Text("新建问题"),
            onTap: () async {
              QuestionCellCollection qcc =
                  await addQuestionDialog(context, collection: false);
              QuestionCell questionCell = Adapterutil.getQuestion(qcc);
              setState(() {
                this._questionGroupCollection.questionCells.add(questionCell);
              });
            },
          ),
          Divider(
            color: Colors.black,
            height: 3,
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: Text("添加已保存问题"),
            onTap: () async {
              List<QuestionCell> questionCells =
                  await questionCellCollectionTable(context);
              if (questionCells != null) {
                setState(() {
                  this
                      ._questionGroupCollection
                      .questionCells
                      .addAll(questionCells);
                });
              }
            },
          )
        ],
      ),
    );
  }

  displayContainer(BuildContext context) {
    List<Widget> list = [];
    list.add(
        Text("预览", style: TextStyle(color: Colors.blueGrey, fontSize: 20)));
    var q = this._questionGroupCollection.questionCells;
    for (var i = 0; i < q.length; i++) {
      list.add(Container(
        child: Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: view(context, Adapterutil.getQuestionCellCollection(q[i]),
                  colume: true),
              flex: 14,
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () async {
                      var qcc = await editQuestionDialog(
                          context, Adapterutil.getQuestionCellCollection(q[i]),
                          collection: false);
                      setState(() {
                        this._questionGroupCollection.questionCells[i] =
                            Adapterutil.getQuestion(qcc);
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.redAccent),
                    onPressed: () {
                      setState(() {
                        this._questionGroupCollection.questionCells.removeAt(i);
                      });
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ));
    }
    return Container(
      padding: EdgeInsets.fromLTRB(30, 10, 30, 0),
      child: ListView(
        children: list,
      ),
    );
  }
}
