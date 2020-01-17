import 'package:qmanager/api/api.dart';
import 'package:qmanager/modules/questioncellcollectionmodule.dart';

class QuestionCollectionApi {
  Api _api = Api();
  final _baseUri = "/questionCollection";

  Future<dynamic> getData() async {
    return _api.getData(_baseUri);
  }

  Future<dynamic> addData(QuestionCellCollection questionCellCollection) async {
    return _api.postData(_baseUri, questionCellCollection.toJson());
  }

  Future<dynamic> getDataById(String id) async {
    return _api.getData(_baseUri + "/" + id);
  }

  Future<dynamic> updateData(
      QuestionCellCollection questionCellCollection) async {
    return _api.updateData(_baseUri, questionCellCollection);
  }

  Future<dynamic>deleteUser(String id) async{
    return _api.deleteData(_baseUri, id);
  }
}
