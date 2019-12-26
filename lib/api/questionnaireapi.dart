import 'package:dio/dio.dart';
import 'package:qmanager/common/common.dart';

class Questionnaireapi {
  Dio _dio = Dio();
  Future<dynamic> _getData(
      String uri, Map<String, dynamic> param) async {
    String addr = server + uri;
    Response response = await this._dio.get(addr, queryParameters: param);
    return response.data;
  }

  Future<dynamic> getQuestionnariePage(
      {int page = 1, int pageSize = 10, int isEdit = -1}) async {
    Map<String,dynamic> param = {"page": page, "pageSize": pageSize, "isEdit": isEdit};
    return _getData("/questionnaire", param);
  }
}
