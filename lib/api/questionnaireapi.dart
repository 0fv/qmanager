import 'package:qmanager/api/api.dart';
import 'package:qmanager/modules/questionnairemodule.dart';

class QuestionnaireApi {
  Api _api = Api();
  final String _baseUri = "/questionnaire";
  Future<dynamic> getQuestionnarie({int isEdit}) async {
    if (isEdit != null) {
      Map<String, String> m = {"isEdit": isEdit.toString()};
      return _api.getData(_baseUri, param: m);
    }
    return _api.getData(_baseUri);
  }

  Future<dynamic> addData(Questionnaire questionnaire) async {
    return _api.postData(_baseUri, questionnaire.toJson());
  }

  Future<dynamic> updateData(Questionnaire questionnaire) {
    return _api.updateData(_baseUri, questionnaire.toJson());
  }

  Future<dynamic> getDataById(String id) {
    return _api.getData(_baseUri + "/" + id);
  }

  Future<dynamic> getFinishDataById(String id) {
    return _api.getData(_baseUri + "/" + id, param: {"finish": 1});
  }

  Future<dynamic> deleteData(String id) {
    return _api.deleteData(_baseUri, id);
  }

  Future<dynamic> changeEditStatus(String id, int isEdit) {
    Map<String, String> m = {"id": id, "isEdit": isEdit.toString()};
    return _api.getData(_baseUri + "/edit", param: m);
  }

  Future<dynamic> changeToFinish(String id) {
    return changeEditStatus(id, 1);
  }
  Future<dynamic> createNewInstance(Map<String,dynamic> map){
    return _api.postData(_baseUri+"/create", map);
  }
}
