import 'package:qmanager/api/api.dart';

class QuestionCollectionApi{
  Api _api = Api();
  final baseUri = "/questionCollection";

  Future<dynamic> getData() async{
    return _api.getData(baseUri);
  }
}