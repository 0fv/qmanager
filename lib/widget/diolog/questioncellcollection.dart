import 'package:flutter/material.dart';
import 'package:more/iterable.dart';
import 'package:qmanager/modules/answercellmodule.dart';
import 'package:qmanager/modules/choicemodule.dart';
import 'package:qmanager/modules/commentmodule.dart';
import 'package:qmanager/modules/inquirydatemodule.dart';
import 'package:qmanager/modules/questioncellcollectionmodule.dart';
import 'package:qmanager/widget/misc.dart';
import 'package:qmanager/widget/table/questiontable.dart';

Future<QuestionCellCollection> addQuestionDialog(BuildContext context,
    {bool collection = true}) {
  return showDialog<QuestionCellCollection>(
      context: context,
      builder: (context) {
        var child = QuestionCellForm(collection: collection);
        return Dialog(
          child: child,
        );
      });
}

Future<void> viewQuestionCell(
    BuildContext context, QuestionCellCollection questionCellCollection,) {
  return showDialog<void>(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            width: 600,
            height: 400,
            child: view(context, questionCellCollection),
            decoration: BoxDecoration(
                backgroundBlendMode: BlendMode.softLight,
                color: Color.fromRGBO(0, 0, 0, 100),
                border: Border.all(
                    color: Color.fromRGBO(0, 0, 0, 100),
                    width: 0,
                    style: BorderStyle.none)),
          ),
        );
      });
}

Future<QuestionCellCollection> editQuestionDialog(
    BuildContext context, QuestionCellCollection questionCellCollection,{bool collection = true}) {
  return showDialog<QuestionCellCollection>(
      context: context,
      builder: (context) {
        var child = QuestionCellForm(
          questionCellCollection: questionCellCollection,collection: collection,
        );
        return Dialog(
          child: child,
        );
      });
}

class QuestionCellForm extends StatefulWidget {
  final bool collection;
  final QuestionCellCollection questionCellCollection;
  QuestionCellForm({Key key, this.questionCellCollection, this.collection=true})
      : super(key: key);

  @override
  _QuestionCellFormState createState() => _QuestionCellFormState();
}

class _QuestionCellFormState extends State<QuestionCellForm> {
  List<String> _list = ["选择", "文本框", "日期框", "选择文本框"];
  List<List<AnswerCell>> _answerCellList = [
    [Choice()],
    [Comment()],
    [InquireDate()],
    [Choice(), Comment()]
  ];
  TextEditingController _title = TextEditingController();
  TextEditingController _classification = TextEditingController();
  FocusNode _tfn = FocusNode();
  FocusNode _cfn = FocusNode();
  int _index = 0;
  QuestionCellCollection _questionCell =
      QuestionCellCollection(answerCells: [Choice()]);
  @override
  void initState() {
    super.initState();
    this._tfn.addListener(() {
      if (!_tfn.hasFocus) {
        setState(() {
          this._questionCell.title = _title.text;
        });
      }
    });
    this._cfn.addListener(() {
      if (!_cfn.hasFocus) {
        setState(() {
          this._questionCell.classification = _classification.text;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.questionCellCollection != null) {
      setState(() {
        this._questionCell = widget.questionCellCollection;
        this._title.text = widget.questionCellCollection.title;
        this._classification.text =
            widget.questionCellCollection.classification;
        this._index = -1;
      });
    }
    return Container(
        height: 1000,
        width: 1000,
        padding: EdgeInsets.all(10),
        child: Container(
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              title(context),
              Expanded(child: content(context)),
              bottona(context)
            ],
          ),
        ));
  }

  Widget title(BuildContext context) => Text(
        "新建调查问题",
        textAlign: TextAlign.left,
        style: TextStyle(fontSize: 22),
      );
  Widget bottona(BuildContext context) => Builder(
      builder: (context) => Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FlatButton(
                child: Text("取消"),
                onPressed: () => Navigator.of(context).pop(),
              ),
              FlatButton(
                  child: Text("确定"),
                  onPressed: () {
                    print(this._questionCell.toJson());
                    Navigator.of(context).pop(this._questionCell);
                  }),
            ],
          ));
  Widget content(BuildContext context) => Builder(
      builder: (context) => ListView(
            children: <Widget>[
              Divider(
                height: 2,
              ),
              input(
                context,
                "问题标题",
                null,
                tec: this._title,
                fn: this._tfn,
                length: 50,
              ),
              Visibility(
                visible: widget.collection,
                child: input(context, "类型", null,
                    tec: this._classification, fn: this._cfn, length: 10),
              ),
              Container(
                  width: 1000,
                  height: 700,
                  child: Flex(
                    direction: Axis.horizontal,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: ListView(
                            children: List<Widget>.generate(this._list.length,
                                (index) {
                          return ListTile(
                            selected: index == _index,
                            title: Text(
                              this._list[index],
                            ),
                            onTap: () {
                              setState(() {
                                this._index = index;
                                this._questionCell.answerCells =
                                    this._answerCellList[this._index];
                              });
                            },
                          );
                        })),
                      ),
                      Expanded(
                        flex: 3,
                        child: Flex(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          direction: Axis.vertical,
                          children: <Widget>[
                            Text(
                              "预览:",
                              style:
                                  TextStyle(fontSize: 10, color: Colors.grey),
                              textAlign: TextAlign.left,
                            ),
                            Expanded(
                              flex: 3,
                              child: view(context, this._questionCell),
                            ),
                            Text(
                              "编辑:",
                              style:
                                  TextStyle(fontSize: 10, color: Colors.grey),
                              textAlign: TextAlign.left,
                            ),
                            Expanded(
                              flex: 4,
                              child: edit(context),
                            )
                          ],
                        ),
                      ),
                    ],
                  )),
            ],
          ));

  Widget edit(BuildContext context) {
    var type = this._questionCell.answerCells[0].runtimeType;
    if (type == Choice) {
      if (this._questionCell.answerCells.length == 1) {
        return choiceEdit(context);
      } else {
        return choiceCommetEdit(context);
      }
    } else if (type == Comment) {
      return commentEdit(context);
    } else if (type == InquireDate) {
      return dateEdit(context);
    }
  }

  Widget choiceEdit(BuildContext context) {
    Choice choice = this._questionCell.answerCells[0];
    List<Widget> list = [
      SwitchListTile(
        title: Text("是否多选"),
        value: choice.isMulti,
        onChanged: (bool value) {
          setState(() {
            Choice choice = this._questionCell.answerCells[0];
            choice.isMulti = value;
            this._questionCell.answerCells[0] = choice;
          });
        },
      ),
      ListTile(
        title: Text("添加选项"),
        onTap: () {
          setState(() {
            Choice choice = this._questionCell.answerCells[0];
            if (choice.choice == null) {
              choice.choice = List<String>();
            }
            choice.choice.add("选项");
            this._questionCell.answerCells[0] = choice;
          });
        },
      )
    ];
    if (choice.choice != null) {
      List<Widget> clist = indexed(choice.choice).map((f) {
        FocusNode fn = FocusNode();
        TextEditingController tec = TextEditingController(text: f.value);
        Widget w = Flex(
          direction: Axis.horizontal,
          children: <Widget>[
            Expanded(
              flex: 9,
              child: input(context, "选项", (v) {}, tec: tec, fn: fn),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.redAccent,
                ),
                onPressed: () {
                  setState(() {
                    Choice choice = this._questionCell.answerCells[0];
                    choice.choice.removeAt(f.index);
                    this._questionCell.answerCells[0] = choice;
                  });
                },
              ),
            )
          ],
        );
        fn.addListener(() {
          if (!fn.hasFocus) {
            setState(() {
              Choice choice = this._questionCell.answerCells[0];
              choice.choice[f.index] = tec.text;
              this._questionCell.answerCells[0] = choice;
            });
          }
        });
        return w;
      }).toList();
      list.insertAll(1, clist);
    }
    return Builder(
        builder: (context) => Container(
              padding: EdgeInsets.all(5),
              child: ListView(children: list),
            ));
  }

  Widget commentEdit(BuildContext context) {
    Comment comment = this._questionCell.answerCells[0];
    FocusNode fn1 = FocusNode();
    FocusNode fn2 = FocusNode();
    TextEditingController line =
        TextEditingController(text: comment.line.toString());
    TextEditingController limit =
        TextEditingController(text: comment.limit.toString());
    fn1.addListener(() {
      if (!fn1.hasFocus) {
        setState(() {
          comment.line = int.parse(line.text);
          this._questionCell.answerCells[0] = comment;
        });
      }
    });
    fn2.addListener(() {
      if (!fn2.hasFocus) {
        setState(() {
          comment.limit = int.parse(limit.text);
          this._questionCell.answerCells[0] = comment;
        });
      }
    });
    List<Widget> list = [
      ListTile(
        leading: Text("行数："),
        title: input(context, "请输入行数", null, tec: line, fn: fn1),
      ),
      ListTile(
        leading: Text("总字数限制："),
        title: input(context, "请输入字数限制", null, tec: limit, fn: fn2),
      )
    ];
    return Builder(
        builder: (context) => Container(
              padding: EdgeInsets.all(5),
              child: ListView(children: list),
            ));
  }

  Widget dateEdit(BuildContext context) {
    InquireDate date = this._questionCell.answerCells[0];

    List<Widget> list = [
      SwitchListTile(
        title: Text("隐藏日期"),
        value: date.vdate,
        onChanged: (bool value) {
          setState(() {
            if (value == false || date.vtime == false) {
              date.vdate = value;
              this._questionCell.answerCells[0] = date;
            }
          });
        },
      ),
      SwitchListTile(
        title: Text("隐藏时间"),
        value: date.vtime,
        onChanged: (bool value) {
          setState(() {
            if (value == false || date.vdate == false) {
              date.vtime = value;
              this._questionCell.answerCells[0] = date;
            }
          });
        },
      ),
    ];
    return Builder(
        builder: (context) => Container(
              padding: EdgeInsets.all(5),
              child: ListView(children: list),
            ));
  }

  Widget choiceCommetEdit(BuildContext context) {
    Comment comment = this._questionCell.answerCells[1];
    Choice choice = this._questionCell.answerCells[0];
    FocusNode fn1 = FocusNode();
    FocusNode fn2 = FocusNode();
    TextEditingController line =
        TextEditingController(text: comment.line.toString());
    TextEditingController limit =
        TextEditingController(text: comment.limit.toString());
    fn1.addListener(() {
      if (!fn1.hasFocus) {
        setState(() {
          comment.line = int.parse(line.text);
          this._questionCell.answerCells[1] = comment;
        });
      }
    });
    fn2.addListener(() {
      if (!fn2.hasFocus) {
        setState(() {
          comment.limit = int.parse(limit.text);
          this._questionCell.answerCells[1] = comment;
        });
      }
    });
    List<Widget> list = [
      // SwitchListTile(
      //   title: Text("文本可为空"),
      //   value: comment.empty,
      //   onChanged: (bool value) {
      //     setState(() {
      //       comment.empty = value;
      //       this._questionCell.answerCells[1] = comment;
      //     });
      //   },
      // ),
      ListTile(
        leading: Text("行数："),
        title: input(context, "请输入行数", null, tec: line, fn: fn1),
      ),
      ListTile(
        leading: Text("总字数限制："),
        title: input(context, "请输入字数限制", null, tec: limit, fn: fn2),
      ),
      SwitchListTile(
        title: Text("是否多选"),
        value: choice.isMulti,
        onChanged: (bool value) {
          setState(() {
            choice.isMulti = value;
            this._questionCell.answerCells[0] = choice;
          });
        },
      ),
      ListTile(
        title: Text("添加选项"),
        onTap: () {
          setState(() {
            if (choice.choice == null) {
              choice.choice = List<String>();
            }
            choice.choice.add("选项");
            this._questionCell.answerCells[0] = choice;
          });
        },
      )
    ];
    if (choice.choice != null) {
      List<Widget> clist = indexed(choice.choice).map((f) {
        FocusNode fn = FocusNode();
        TextEditingController tec = TextEditingController(text: f.value);
        Widget w = Flex(
          direction: Axis.horizontal,
          children: <Widget>[
            Expanded(
              flex: 9,
              child: input(context, "选项", (v) {}, tec: tec, fn: fn),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.redAccent,
                ),
                onPressed: () {
                  setState(() {
                    Choice choice = this._questionCell.answerCells[0];
                    choice.choice.removeAt(f.index);
                    this._questionCell.answerCells[0] = choice;
                  });
                },
              ),
            )
          ],
        );
        fn.addListener(() {
          if (!fn.hasFocus) {
            setState(() {
              Choice choice = this._questionCell.answerCells[0];
              choice.choice[f.index] = tec.text;
              this._questionCell.answerCells[0] = choice;
            });
          }
        });
        return w;
      }).toList();
      list.insertAll(4, clist);
    }
    return Builder(
        builder: (context) => Container(
              padding: EdgeInsets.all(5),
              child: ListView(children: list),
            ));
  }
}
