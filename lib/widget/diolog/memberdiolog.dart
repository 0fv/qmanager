import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qmanager/api/memberapi.dart';
import 'package:qmanager/modules/membermodule.dart';
import 'package:qmanager/widget/misc.dart';

Future<bool> memberEditdialog(BuildContext context, String gid,
    {Member member}) {
  return showDialog<bool>(
      context: context,
      builder: (context) => Dialog(
            child: MemberForm(gid, member: member),
          ));
}

class MemberForm extends StatefulWidget {
  final Member member;
  final String gid;
  MemberForm(this.gid, {Key key, this.member}) : super(key: key);

  @override
  _MemberFormState createState() => _MemberFormState();
}

class _MemberFormState extends State<MemberForm> {
  final TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _additionalInfo = TextEditingController();
  MemberApi memberApi;
  @override
  void initState() {
    super.initState();
    this.memberApi = MemberApi(widget.gid);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.member != null) {
      _name.text = widget.member.name;
      _email.text = widget.member.email;
      _additionalInfo.text = widget.member.additionalInfo;
    }

    return Container(
        child: Container(
      height: 400,
      width: 500,
      padding: EdgeInsets.all(20),
      child: Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Text(
              widget.member == null ? "新建" : "编辑",
              style: TextStyle(fontSize: 24),
            ),
          ),
          Expanded(flex: 9, child: content(context)),
          Expanded(
            flex: 1,
            child: bottona(context),
          )
        ],
      ),
    ));
  }

  Widget bottona(BuildContext context) => Builder(
      builder: (context) => Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FlatButton(
                child: Text("取消"),
                onPressed: () => Navigator.of(context).pop(),
              ),
              FlatButton(
                  child: Text("确定"),
                  onPressed: () async {
                    Member m = _getMember();
                    if (widget.member == null) {
                      try {
                        await memberApi.addData(m);
                        popToast("添加成功", context);
                        Navigator.of(context).pop(true);
                      } on DioError catch (e) {
                        popToast(e.message, context);
                      }
                    } else {
                      try {
                        await memberApi.updateData(m);
                        popToast("修改成功", context);
                        Navigator.of(context).pop(true);
                      } on DioError catch (e) {
                        popToast(e.message, context);
                      }
                    }
                  }),
            ],
          ));
  Widget content(BuildContext context) => Builder(
        builder: (context) => ListView(
          children: <Widget>[
            input(context, "姓名", null, tec: _name, length: 10),
            input(context, "邮箱", null, tec: _email, length: 30),
            input(context, "附加信息", null, tec: _additionalInfo, length: 50),
          ],
        ),
      );
  Member _getMember() {
    if (widget.member == null) {
      return Member(
          name: _name.text,
          email: _email.text,
          additionalInfo: _additionalInfo.text);
    } else {
      return Member(
          id: widget.member.id,
          name: _name.text,
          email: _email.text,
          additionalInfo: _additionalInfo.text);
    }
  }
}
