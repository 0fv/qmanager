import 'package:flutter/material.dart';
import 'package:qmanager/modules/answercellmodule.dart';
import 'package:qmanager/modules/choicemodule.dart';
import 'package:qmanager/modules/commentmodule.dart';
import 'package:qmanager/modules/inquirydatemodule.dart';
import 'package:qmanager/modules/questioncellmodule.dart';

Future<QuestionCell> answerCellDialog(BuildContext context) {
  QuestionCell _questionCell;
  return showDialog<QuestionCell>(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: TypeChoicer(
          onChanged: (value) {
            _questionCell = value;
            print(_questionCell.title);
          },
        ),
        actions: <Widget>[
          FlatButton(
            child: Text("取消"),
            onPressed: () => Navigator.of(context).pop(),
          ),
          FlatButton(
            child: Text("确定"),
            onPressed: () {
              Navigator.of(context).pop(_questionCell);
            },
          ),
        ],
      );
    },
  );
}

class TypeChoicer extends StatefulWidget {
  final ValueChanged<QuestionCell> onChanged;

  TypeChoicer({
    Key key,
    @required this.onChanged,
  }) : super(key: key);

  @override
  _TypeChoicerState createState() => _TypeChoicerState();
}

class _TypeChoicerState extends State<TypeChoicer> {
  List<String> _list = ["选择", "文本框", "日期框", "选择文本框"];
  List<List<AnswerCell>> _answerCellList = [
    [Choice()],
    [Comment()],
    [InquireDate()],
    [Choice(), Comment()]
  ];
  int _index = 0;
  QuestionCell _questionCell = QuestionCell();
  TextEditingController _tec = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
          width: 800,
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
                  child: _questionCellSetting(),
                ),
              )
            ],
          )),
    );
  }

  Widget _questionCellSetting() {
    return ListView(
      children: <Widget>[
        input("问题描述", (str) {
          this._questionCell.title = str;
          widget.onChanged(this._questionCell);
        }, _tec)
      ],
    );
  }

  Widget _choice() {
    return Column(
      children: <Widget>[
        FlatButton(child: Text("添加选项"),onPressed: (){
          
        },)
      ],
    );
  }
}

Widget input(
    String name, ValueChanged<String> onChange, TextEditingController tec,
    {int maxLines = 1, int maxLength}) {
  FocusNode focusNode = new FocusNode();
  Widget i = Container(
    child: TextField(
      focusNode: focusNode,
      minLines: 1,
      controller: tec,
      maxLines: maxLines,
      maxLength: maxLength,
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

  focusNode.addListener(() {
    if (!focusNode.hasFocus) {
      onChange(tec.text);
    }
  });
  return i;
}
