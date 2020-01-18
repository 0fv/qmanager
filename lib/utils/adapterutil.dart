import 'package:qmanager/modules/questioncellcollectionmodule.dart';
import 'package:qmanager/modules/questioncellmodule.dart';

class Adapterutil {
  static QuestionCell getQuestion(QuestionCellCollection cellCollection) =>
      QuestionCell(
          title: cellCollection.title, answerCells: cellCollection.answerCells);
  static QuestionCellCollection getQuestionCellCollection(QuestionCell questionCell)=>
  QuestionCellCollection(title: questionCell.title,answerCells: questionCell.answerCells);
}
