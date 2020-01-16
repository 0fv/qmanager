import 'package:flutter/material.dart';
import 'package:more/iterable.dart';
import 'package:qmanager/modules/answercellmodule.dart';
import 'package:qmanager/modules/choicemodule.dart';
import 'package:qmanager/modules/commentmodule.dart';
import 'package:qmanager/modules/inquirydatemodule.dart';
import 'package:qmanager/modules/questioncellcollectionmodule.dart';

Future<QuestionCellCollection> addQuestionDialog(BuildContext context) {
  return showDialog<QuestionCellCollection>(
      context: context,
      builder: (context) {
        var child = QuestionCellForm();
        return Dialog(
          child: child,
        );
      });
}

class QuestionCellForm extends StatefulWidget {
  QuestionCellForm({Key key}) : super(key: key);

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
  int _index = 0;
  QuestionCellCollection _questionCell =
      QuestionCellCollection(answerCells: [Choice()]);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 1000,
        width: 1000,
        padding: EdgeInsets.all(10),
        child: Container(
          alignment: Alignment.centerLeft,
          child: Column(
            children: <Widget>[
              title(context),
              Expanded(child: content(context)),
              bottona(context)
            ],
          ),
        ));
  }

  Widget _input(
    BuildContext context,
    String name,
    ValueChanged<String> vc, {
    int length = 100,
    TextEditingController tec,
    FocusNode fn,
  }) =>
      Builder(
        builder: (context) => Container(
          child: TextField(
            focusNode: fn,
            minLines: 1,
            maxLines: 1,
            maxLength: length,
            controller: tec,
            decoration: InputDecoration(
              hintText: name,
            ),
            onChanged: vc,
          ),
        ),
      );

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
              _input(
                context,
                "问题标题",
                (v) {
                  setState(() {
                    this._questionCell.title = v;
                  });
                },
                length: 50,
              ),
              _input(context, "类型", (v) {
                setState(() {
                  this._questionCell.classification = v;
                });
              }, length: 10),
              Container(
                  width: 1000,
                  height: 750,
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
                          direction: Axis.vertical,
                          children: <Widget>[
                            Expanded(
                              flex: 3,
                              child: view(context, this._questionCell),
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
  Widget view(
      BuildContext context, QuestionCellCollection questionCellCollection) {
    String title = questionCellCollection.title;
    List<Widget> list = <Widget>[
      Text(
        "预览:",
        style: TextStyle(fontSize: 10, color: Colors.grey),
        textAlign: TextAlign.left,
      ),
      Text(title == null ? "" : title,
          style: TextStyle(fontSize: 20, color: Colors.black87)),
    ];
    var type = questionCellCollection.answerCells[0].runtimeType;
    if (type == Choice) {
      if (questionCellCollection.answerCells.length == 1) {
        list.addAll(choiceRender(this._questionCell.answerCells[0], context));
      }
    }
    return Builder(
      builder: (context) {
        return Card(
            child: Container(
          padding: EdgeInsets.all(5),
          child: ListView(
            children: list,
          ),
        ));
      },
    );
  }

  List<Widget> choiceRender(AnswerCell answerCell, BuildContext context) {
    Choice choice = answerCell as Choice;
    bool isMult = choice.isMulti;
    if (choice.choice == null) {
      return [];
    }
    if (isMult) {
      return choice.choice
          .map((f) => Builder(
                builder: (context) => RadioListTile(
                  dense: false,
                  value: f,
                  title: Text(f),
                  onChanged: (v) {},
                  groupValue: null,
                ),
              ))
          .toList();
    } else {
      return choice.choice
          .map((f) => Builder(
                builder: (context) => CheckboxListTile(
                  value: false,
                  title: Text(f),
                  onChanged: (bool value) {},
                ),
              ))
          .toList();
    }
  }

  Widget edit(BuildContext context) {
    var type = this._questionCell.answerCells[0].runtimeType;
    if (type == Choice) {
      if (this._questionCell.answerCells.length == 1) {
        return choiceEdit(context);
      }
    }
  }

  Widget choiceEdit(BuildContext context) {
    Choice choice = this._questionCell.answerCells[0];
    print(choice.toJson());
    List<Widget> list = [
      Text(
        "编辑:",
        style: TextStyle(fontSize: 10, color: Colors.grey),
        textAlign: TextAlign.left,
      ),
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
              child: _input(context, "选项", (v) {}, tec: tec, fn: fn),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                icon: Icon(Icons.delete,color: Colors.redAccent,),
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
            print("zhahuish");
            setState(() {
              Choice choice = this._questionCell.answerCells[0];
              choice.choice[f.index] = tec.text;
              this._questionCell.answerCells[0] = choice;
            });
          }
        });
        return w;
      }).toList();
      list.insertAll(2, clist);
    }
    return Builder(
        builder: (context) => Container(
              padding: EdgeInsets.all(5),
              child: ListView(children: list),
            ));
  }
}
