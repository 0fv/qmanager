import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:qmanager/modules/answercellmodule.dart';
import 'package:qmanager/modules/choicemodule.dart';
import 'package:qmanager/modules/commentmodule.dart';
import 'package:qmanager/modules/inquirydatemodule.dart';
import 'package:qmanager/modules/questioncellcollectionmodule.dart';
import 'package:qmanager/widget/misc.dart';

Widget view(
    BuildContext context, QuestionCellCollection questionCellCollection,{colume=false}) {
  String title = questionCellCollection.title;
  List<Widget> list = <Widget>[
    Text(title == null ? "" : title,
        style: TextStyle(fontSize: 20, color: Colors.black87)),
  ];
  var type = questionCellCollection.answerCells[0].runtimeType;
  if (type == Choice) {
    if (questionCellCollection.answerCells.length == 1) {
      list.addAll(choiceRender(questionCellCollection.answerCells[0], context));
    } else {
      list.addAll(choiceRender(questionCellCollection.answerCells[0], context));
      list.add(commentRender(questionCellCollection.answerCells[1], context));
    }
  } else if (type == Comment) {
    list.add(commentRender(questionCellCollection.answerCells[0], context));
  } else if (type == InquireDate) {
    list.add(dateRender(questionCellCollection.answerCells[0], context));
  }
  if(colume){
    return Builder(
    builder: (context) {
      return Card(
          child: Container(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
        margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: list,
        ),
      ));
    },
  );
  }else{
    return Builder(
    builder: (context) {
      return Card(
          child: Container(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: ListView(
          children: list,
        ),
      ));
    },
  );
  }
}

List<Widget> choiceRender(AnswerCell answerCell, BuildContext context) {
  Choice choice = answerCell as Choice;
  bool isMult = choice.isMulti;
  if (choice.choice == null) {
    return [];
  }
  if (!isMult) {
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

Widget commentRender(AnswerCell answerCell, BuildContext context) {
  Comment comment = answerCell as Comment;
  return Builder(
    builder: (context) =>
        input(context, "", null, line: comment.line, length: comment.limit),
  );
}

Widget dateRender(AnswerCell answerCell, BuildContext context) {
  InquireDate date = answerCell as InquireDate;
  return Builder(builder: (context) {
    return Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              "请选择：",
              style: TextStyle(fontSize: 20),
            ),
            Visibility(
              visible: !date.vdate,
              child: Text(
                formatDate(DateTime.parse("2020-01-01 00:00:00"),
                    [yyyy, "-", mm, "-", "dd"]),
                style: TextStyle(fontSize: 20),
              ),
            ),
            Visibility(
              visible: !date.vtime,
              child: Text(
                formatDate(DateTime.parse("2020-01-01 00:00:00"),
                    [HH, ':', nn, ':', ss]),
                style: TextStyle(fontSize: 20),
              ),
            )
          ],
        ));
  });
}
