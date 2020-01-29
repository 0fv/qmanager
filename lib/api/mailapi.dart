import 'package:qmanager/api/api.dart';
import 'package:qmanager/modules/emailmodule.dart';

class MailApi {
  Api _api = Api();
  String _baseUri='/mail';
  Future<dynamic> getData(){
    return this._api.getData(_baseUri);
  }
  Future<dynamic> updateData(Email email){
    return this._api.updateData(_baseUri, email.toJson());
  }
}