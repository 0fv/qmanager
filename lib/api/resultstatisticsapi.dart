import 'package:qmanager/api/api.dart';
import 'dart:js' as js;

import 'package:qmanager/common/common.dart';

class ResultStatisticsApi{
  Api _api = Api();
  final _baseUri = "/statistic";

  Future<dynamic> getData(String id){
    return this._api.getData(this._baseUri+"/"+id);
  }

  export(String id){
    js.context.callMethod("open",[server+"/resultCollection"+"/export/"+id]);
  }
}