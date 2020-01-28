import 'dart:html' as html;
import 'dart:js' as js;
import 'dart:typed_data';
import 'dart:ui';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/cupertino.dart';
import 'package:qmanager/api/api.dart';
import 'package:qmanager/common/common.dart';
import 'package:qmanager/modules/membermodule.dart';
import 'package:qmanager/widget/misc.dart';

class MemberApi {
  Api _api = Api();
  final _baseUri = "/member";
  String _gid;
  set setGid(String gid) => this._gid = gid;
  MemberApi(this._gid);
  Future<dynamic> getData() async {
    return _api.getData(_baseUri + '/' + _gid);
  }

  Future<dynamic> addData(Member member) async {
    return _api.postData(_baseUri + '/' + _gid, member.toJson());
  }

  Future<dynamic> updateData(Member member) async {
    return _api.updateData(_baseUri + '/' + _gid, member);
  }

  Future<dynamic> deleteData(String id) async {
    return _api.deleteData(_baseUri + '/' + _gid, id);
  }

  template() {
    js.context.callMethod("open", [server + _baseUri + "/template"]);
  }

  Future<dynamic> uploadData(String gid, VoidCallback refresh,BuildContext context) async {
    html.InputElement uploadInput = html.FileUploadInputElement();
    uploadInput.multiple = false;
    uploadInput.click();
    uploadInput.onChange.listen((f) {
      final files = uploadInput.files;
      if (files.length == 1) {
        html.File file = files[0];
        final r = new html.FileReader();
        r.readAsArrayBuffer(file);
        r.onLoadEnd.listen((l) async {
          Uint8List data = r.result;
          dio.FormData formData = new dio.FormData.fromMap({
            "file":
                dio.MultipartFile.fromBytes(data.toList(), filename: file.name)
          });
          try {
            await _api.postData(_baseUri + '/upload/' + gid, formData);
            popToast("导入成功", context);
            refresh();
          } on dio.DioError catch (e) {
            popToast(e.message, context);
          }
        });
      }
    });
  }

  export(String gid) {
    js.context.callMethod("open", [server + _baseUri + "/export/"+gid]);
  }
}
