import 'package:qmanager/modules/answercellmodule.dart';

class Choice implements AnswerCell{
  final String type = "choice";
  Map<String, bool> choice;
  bool isMulti;
  Choice({this.choice, this.isMulti});
  
}
