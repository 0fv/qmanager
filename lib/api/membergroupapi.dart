import 'package:qmanager/api/api.dart';
import 'package:qmanager/modules/membergroupmodule.dart';

class MemberGroupApi{
  Api _api = Api();
  final _baseUri = "/memberGroup";
  Future<dynamic> getData(){
    return _api.getData(_baseUri);
  }
  Future<dynamic> addData(MemberGroup memberGroup) async{
    return _api.postData(_baseUri, memberGroup.toJson());
  }
   Future<dynamic> updateData(
      MemberGroup memberGroup) async {
    return _api.updateData(_baseUri, memberGroup);
  }

  Future<dynamic>deleteData(String id) async{
    return _api.deleteData(_baseUri, id);
  }
}