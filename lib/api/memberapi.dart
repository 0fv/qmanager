import 'package:qmanager/api/api.dart';
import 'package:qmanager/modules/membermodule.dart';

class MemberApi {
  Api _api = Api();
  final _baseUri = "/member";
  String _gid;
  set setGid(String gid)=>this._gid=gid;
  MemberApi(this._gid);
  Future<dynamic> getData() async {
    return _api.getData(_baseUri + '/' + _gid);
  }

  Future<dynamic> addData(Member member) async {
    return _api.postData(_baseUri + '/' + _gid, member.toJson());
  }

  Future<dynamic> updateData(Member member ) async {
    return _api.updateData(_baseUri + '/' + _gid, member);
  }

  Future<dynamic> deleteData(String id) async {
    return _api.deleteData(_baseUri + '/' + _gid, id);
  }
}
