import 'package:flutter/material.dart';
import 'package:qmanager/modules/questionnairemodule.dart';
import 'package:qmanager/widget/table/questiontable.dart';

class QuestionnaireView extends StatelessWidget {
  final agruments;
  const QuestionnaireView({Key key, this.agruments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Questionnaire questionnaire = this.agruments as Questionnaire;
    List<Widget> list = [
      Container(child: Text(questionnaire.name,style: TextStyle(fontSize: 30),textAlign: TextAlign.center,),),
      Text(questionnaire.introduce)
    ];
    questionnaire.questionGroups?.forEach((qg) {
      list.add(Text(qg.title,style:TextStyle(fontWeight: FontWeight.w700),));
      qg.questionCells?.forEach((qc) {
        list.add(view2(context, qc, column: true, card: false));
      });
    });
    return Scaffold(
      appBar: AppBar(
        title: Text("预览"),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
        child: ListView(
          children: list,
        ),
      ),
    );
  }
}
