import 'package:flutter/material.dart';
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
    TextEditingController _title = TextEditingController();
    TextEditingController _classification = TextEditingController();
  List<List<AnswerCell>> _answerCellList = [
    [Choice()],
    [Comment()],
    [InquireDate()],
    [Choice(), Comment()]
  ];
  int _index = 0;
  QuestionCellCollection _questionCell = QuestionCellCollection();

  @override
  Widget build(BuildContext context) {
   return Container(
     height: 800,
     width: 1000,
     padding: EdgeInsets.all(10),
      child:Column(children: <Widget>[
         _input("问题：", _title),
         _input("类型", _classification),
         Container(
          width: 1000,
          height: 500,
          child: Flex(
            direction: Axis.horizontal,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: ListView(
                    children: List<Widget>.generate(this._list.length, (index) {
                  return ListTile(
                    selected: index == _index,
                    title: Text(
                      this._list[index],
                    ),
                    onTap: () {
                      setState(() {
                        this._index = index;
                      });
                    },
                  );
                })),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  child: Container(),
                ),
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
                    _questionCell.title = this._title.text;
                    _questionCell.classification = this._classification.text;
                    _questionCell.answerCells = this._answerCellList[this._index];
                    Navigator.of(context).pop(this._questionCell);
                  }),
            ],
          )
            ],
          )),
      ],)
    );
  }
  Widget _input(String name ,TextEditingController tec){
      return Container(
    child: TextField(
      minLines: 1,
      controller: tec,
      maxLines: 1,
      maxLength: 100,
      decoration: InputDecoration(
        hintText: name,
        border: InputBorder.none,
      ),
    ),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(1)),
        border: Border.all(color: Colors.black12, width: 2)),
  );
  }
}