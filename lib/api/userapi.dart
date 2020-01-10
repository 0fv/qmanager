import 'package:qmanager/api/api.dart';

class UserApi{
  Api _api = Api();

  Future<dynamic> getUserInfo() async{
    return _api.getData("/user");
  }
  
}