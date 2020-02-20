import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:qmanager/api/questionnaireapi.dart';
import 'package:qmanager/modules/questioncellcollectionmodule.dart';
import 'package:qmanager/modules/questioncellmodule.dart';
import 'package:qmanager/modules/questiongroupmodule.dart';
import 'package:qmanager/modules/questionnairemodule.dart';
import 'package:qmanager/utils/adapterutil.dart';
import 'package:qmanager/widget/diolog/alertdiolog.dart';
import 'package:qmanager/widget/diolog/groupeditdiolog.dart';
import 'package:qmanager/widget/diolog/questioncellcollection.dart';
import 'package:qmanager/widget/diolog/questioncollectiontablediolog.dart';
import 'package:qmanager/widget/diolog/questiongroupcollectiontablediolog.dart';
import 'package:qmanager/widget/misc.dart' as Misc;
import 'package:qmanager/widget/misc.dart';
import 'package:qmanager/widget/table/questiontable.dart';
import 'package:uuid/uuid.dart';

class QuestionnaireEdit extends StatefulWidget {
  final arguments;
  QuestionnaireEdit({Key key, this.arguments}) : super(key: key);

  @override
  _QuestionnaireEditState createState() => _QuestionnaireEditState();
}

class _QuestionnaireEditState extends State<QuestionnaireEdit> {
  Questionnaire _questionnaire =
      Questionnaire(questionGroups: [], uuid: Uuid().v4());
  TextEditingController _name = TextEditingController();
  TextEditingController _introduce = TextEditingController();
  QuestionnaireApi _questionnaireApi = QuestionnaireApi();
  FocusNode _nfn = FocusNode();
  FocusNode _ifn = FocusNode();
  Set<int> isOpen = Set();

  @override
  void initState() {
    super.initState();
    this._nfn.addListener(() {
      if (!_nfn.hasFocus) {
        setState(() {
          this._questionnaire.name = _name.text;
        });
      }
    });
    this._ifn.addListener(() {
      if (!_ifn.hasFocus) {
        setState(() {
          this._questionnaire.introduce = _introduce.text;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.arguments != null) {
      setState(() {
        this._questionnaire = widget.arguments;
        this._name.text = widget.arguments.name;
        this._introduce.text = widget.arguments.introduce;
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("编辑问卷"),
        actions: <Widget>[
          Visibility(
            visible: widget.arguments!=null,
            child: FlatButton(
              child: Text(
                "标记为“已完成”",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                bool flag = await alertDialog("确认更改为已完成？更改后不能继续编辑", context);
                if (flag) {
                  try {
                    await _questionnaireApi
                        .changeToFinish(this._questionnaire.id);
                    popToast("修改成功", context);
                    Future.delayed(Duration(milliseconds: 300)).then((onValue) {
                      Navigator.of(context).pop(true);
                    });
                  } on DioError catch (error) {
                    var msg = error.message;
                    popToast(msg, context);
                  }
                }
              },
            ),
          ),
          FlatButton(
            child: Text(
              "取消",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {
              bool flag = await alertDialog("尚未保存，确定退出？", context);
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
                  await _questionnaireApi.addData(this._questionnaire);
                  popToast("创建成功", context);
                  Future.delayed(Duration(milliseconds: 400)).then((onValue) {
                    Navigator.pop(context, true);
                  });
                } on DioError catch (error) {
                  var msg = error.message;
                  popToast(msg, context);
                }
              } else {
                try {
                  await _questionnaireApi.updateData(this._questionnaire);
                  popToast("修改成功", context);
                  Future.delayed(Duration(milliseconds: 400)).then((onValue) {
                    Navigator.pop(context, true);
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
            Misc.input(
              context,
              "问卷标题",
              null,
              tec: this._name,
              fn: this._nfn,
              length: 50,
            ),
            Misc.input(
              context,
              "问卷介绍",
              null,
              tec: this._introduce,
              fn: this._ifn,
              length: 249,
            ),
            Container(
              child: Text("value:3${this._questionnaire.toJson()}"),
            ),
            Text("编辑"),
            FlatButton(
              child: Text("添加空白问题组"),
              onPressed: () {
                setState(() {
                  this._questionnaire.questionGroups.add(QuestionGroup(
                      title: "问题组" +
                          (this._questionnaire.questionGroups.length + 1)
                              .toString()));
                });
              },
            ),
            FlatButton(
              child: Text("添加现有问题组"),
              onPressed: () async {
                List<QuestionGroup> lqg =
                    await questionGroupCollectionTable(context);
                setState(() {
                  this._questionnaire.questionGroups.addAll(lqg);
                });
              },
            ),
            FlatButton(
              child: Text("收起全部问题组"),
              onPressed: () {
                setState(() {
                  this.isOpen.clear();
                });
              },
            ),
            FlatButton(
              child: Text("展开全部问题组"),
              onPressed: () {
                setState(() {
                  int l = this._questionnaire.questionGroups.length;
                  for (var i = 0; i < l; i++) {
                    this.isOpen.add(i);
                  }
                });
              },
            )
          ],
        );
      },
    );
  }

  Widget displayContainer(BuildContext context) {
    List<Widget> list = [
      Text(
        " 标题：" + this._name.text,
        textAlign: TextAlign.left,
        style: TextStyle(fontSize: 30),
      ),
      Text(
        " 介绍：" + this._introduce.text,
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
          children:
              List.generate(this._questionnaire.questionGroups.length, (index) {
            return questionGroupCard(
                this._questionnaire.questionGroups[index], context, index);
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
    if (oldIndex > this._questionnaire.questionGroups.length - 1) {
      oldIndex = this._questionnaire.questionGroups.length - 1;
    }
    if (newIndex > this._questionnaire.questionGroups.length - 1) {
      newIndex = this._questionnaire.questionGroups.length - 1;
    }
    var tmp = this._questionnaire.questionGroups[oldIndex];
    this._questionnaire.questionGroups[oldIndex] =
        this._questionnaire.questionGroups[newIndex];
    this._questionnaire.questionGroups[newIndex] = tmp;
    if (isOpen.remove(oldIndex)) {
      isOpen.add(newIndex);
    }
  }

  Widget questionGroupCard(
      QuestionGroup questionGroup, BuildContext context, int key) {
    String title = questionGroup.title;
    return Builder(
        key: ValueKey(key),
        builder: (context) {
          List list = <Widget>[];
          var opButton = Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Row(
              children: <Widget>[
                FlatButton(
                  child: Text("添加新问题"),
                  onPressed: () async {
                    QuestionCellCollection qcc =
                        await addQuestionDialog(context, collection: false);
                    QuestionCell qc = Adapterutil.getQuestion(qcc);
                    _addQuestionCell(qc, key);
                  },
                ),
                FlatButton(
                  child: Text("添加现有问题"),
                  onPressed: () async {
                    List<QuestionCell> lqc =
                        await questionCellCollectionTable(context);
                    _addQuestionCellList(lqc, key);
                  },
                )
              ],
            ),
          );
          var questions = this._questionnaire.questionGroups[key].questionCells;
          if (questions != null) {
            for (var i = 0; i < questions.length; i++) {
              list.add(Padding(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: view(context,
                          Adapterutil.getQuestionCellCollection(questions[i]),
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
                                  context,
                                  Adapterutil.getQuestionCellCollection(
                                      questions[i]),
                                  collection: false);
                              setState(() {
                                this
                                        ._questionnaire
                                        .questionGroups[key]
                                        .questionCells[i] =
                                    Adapterutil.getQuestion(qcc);
                              });
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.redAccent),
                            onPressed: () {
                              setState(() {
                                this
                                    ._questionnaire
                                    .questionGroups[key]
                                    .questionCells
                                    .removeAt(i);
                              });
                            },
                          ),
                          Text("必填"),
                          Switch(
                              onChanged: (v) {
                                int x = v ? 1 : 0;
                                setState(() {
                                  this
                                      ._questionnaire
                                      .questionGroups[key]
                                      .questionCells[i]
                                      .mustAnswer = x;
                                });
                              },
                              value: 1 ==
                                  this
                                      ._questionnaire
                                      .questionGroups[key]
                                      .questionCells[i]
                                      .mustAnswer),
                        ],
                      ),
                    )
                  ],
                ),
              ));
            }
          }
          list.add(opButton);
          return Card(
            child: ExpansionTile(
              initiallyExpanded: isOpen.contains(key),
              onExpansionChanged: (v) {
                if (v) {
                  isOpen.add(key);
                } else {
                  isOpen.remove(key);
                }
              },
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
                      String gname = await questionGroupEditDialog(context,
                          this._questionnaire.questionGroups[key].title);
                      if (gname != null && gname.isNotEmpty) {
                        setState(() {
                          this._questionnaire.questionGroups[key].title = gname;
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
                      bool b = await confirmDialog(context, "删除", "确认删除？");
                      if (b == true) {
                        setState(() {
                          this._questionnaire.questionGroups.removeAt(key);
                        });
                      }
                    },
                  )
                ]),
              ),
              children: list,
            ),
          );
        });
  }

  _addQuestionCell(QuestionCell qc, int key) {
    if (qc != null) {
      setState(() {
        if (this._questionnaire.questionGroups[key].questionCells == null) {
          this._questionnaire.questionGroups[key].questionCells =
              <QuestionCell>[qc];
        } else {
          this._questionnaire.questionGroups[key].questionCells.add(qc);
        }
      });
    }
  }

  _addQuestionCellList(List<QuestionCell> lqc, int key) {
    if (lqc != null) {
      setState(() {
        if (this._questionnaire.questionGroups[key].questionCells == null) {
          this._questionnaire.questionGroups[key].questionCells = lqc;
        } else {
          this._questionnaire.questionGroups[key].questionCells.addAll(lqc);
        }
      });
    }
  }
}
