import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:qmanager/api/questionnaireapi.dart';
import 'package:qmanager/modules/questionnairemodule.dart';

void main() async {
  var x = await Questionnaireapi().getQuestionnariePage();
  print(x);
}
