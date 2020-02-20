import 'package:qmanager/api/api.dart';

class ResultStatisticsApi{
  Api _api = Api();
  final _baseUri = "/statistic";

  Future<dynamic> getData(String id){
    return this._api.getData(this._baseUri+"/"+id);
  }
}