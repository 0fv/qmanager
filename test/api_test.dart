
import 'package:dio/dio.dart';
import 'package:qmanager/api/userapi.dart';

void main() async {
  var y = await UserApi().getUserInfo();
  print(y);

}
