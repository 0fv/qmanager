
import 'package:qmanager/api/api.dart';

class UrlApi{
  Api _api = Api();
  String _baseUri='/url';
  Future<dynamic> getData() async{
    return this._api.getData(_baseUri);
  }
  Future<dynamic> updateData(String url) async{
    return this._api.updateData(_baseUri, {"url":url});
  }
}