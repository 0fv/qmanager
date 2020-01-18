
import 'package:qmanager/api/api.dart';
import 'package:qmanager/modules/questiongroupcollectionmodule.dart';

class QuestionGroupCollectionApi {
  Api _api = Api();
  final _baseUri = "/questionGroupCollection";

  Future<dynamic> getData() async {
    return _api.getData(_baseUri);
  }

  Future<dynamic> addData(QuestionGroupCollection questionGroupCollection) async {
    return _api.postData(_baseUri, questionGroupCollection.toJson());
  }

  Future<dynamic> getDataById(String id) async {
    return _api.getData(_baseUri + "/" + id);
  }

  Future<dynamic> updateData(
      QuestionGroupCollection questionGroupCollection) async {
    return _api.updateData(_baseUri, questionGroupCollection.toJson());
  }

  Future<dynamic>deleteUser(String id) async{
    return _api.deleteData(_baseUri, id);
  }
}
