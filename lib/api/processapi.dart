import 'package:qmanager/api/api.dart';

class ProcessApi{
  Api _api = Api();
  final _baseUri = "/questionnaireEntity";

  Future<dynamic> getData({isFinish=0}){
    return this._api.getData(_baseUri,param: {
      "isFinish": isFinish
    });
  }
  Future<dynamic> updateToFinish(String id){
    return this._api.updateData(_baseUri+"/toFinish/"+id,null);
  }
  Future<dynamic> updateDate(Map map){
    return this._api.updateData(_baseUri+"/delay", map);
  }
}