import 'package:qmanager/api/api.dart';

class Questionnaireapi {
  Api _api = Api();

  Future<dynamic> getQuestionnariePage(
      {int page, int pageSize, int isEdit = -1}) async {
    Map<String, dynamic> param = {
      "page": page,
      "pageSize": pageSize,
      "isEdit": isEdit
    };
    return _api.getData("/questionnaire", param: param);
  }
}
