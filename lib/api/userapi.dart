import 'package:qmanager/api/api.dart';
import 'package:qmanager/modules/usermodule.dart';

class UserApi{
  Api _api = Api();

  Future<dynamic> getUserInfo() async{
    return _api.getData("/user");
  }
  Future<dynamic> addUser(User user) async{
    return _api.postData("/user", user.toJson());
  }
  Future<dynamic> getUserById(String id) async{
    return _api.getData("/user/"+id);
  }
  Future<dynamic> updateUser(User user){
    return _api.updateData("/user", user.toJson());
  }

  Future<dynamic> deleteUser(String id) {
    return _api.deleteData("/user", id);
  }
}