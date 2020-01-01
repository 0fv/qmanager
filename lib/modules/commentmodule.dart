import 'package:qmanager/modules/answercellmodule.dart';

class Comment implements AnswerCell {
  final String type = "comment";
  String comment;
  Comment({this.comment});
}
