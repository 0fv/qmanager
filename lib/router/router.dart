import 'package:flutter/material.dart';
import 'package:qmanager/pages/edit/membergroupedit.dart';
import 'package:qmanager/pages/edit/questiongroupedit.dart';
import 'package:qmanager/pages/edit/questionnaireedit.dart';
import 'package:qmanager/pages/homepage.dart';

final routes = {
  '/': (context, {arguments}) => HomePage(),
  '/questionnaireEdit': (context,{arguments}) => QuestionnaireEdit(arguments: arguments),
  '/questionGroupEdit': (context,{arguments}) => QuestionGroupEdit(arguments: arguments),
  '/memberGroupEdit': (context,{arguments})=>MemeberGroupEdit(argumemt: arguments),
};

Route renderPage(settings) {
  final String name = settings.name;
  final Function page = routes[name];
  if (page != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) => page(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route = MaterialPageRoute(
          builder: (context) => page(context));
      return route;
    }
  } else {
    final Route route = MaterialPageRoute(
        builder: (context) =>
            routes["/"](context));
    return route;
  }
}
