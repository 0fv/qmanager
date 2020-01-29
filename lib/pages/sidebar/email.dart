import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:qmanager/api/mailapi.dart';
import 'package:qmanager/api/urlapi.dart';
import 'package:qmanager/modules/emailmodule.dart';
import 'package:qmanager/widget/misc.dart';

class EmailSetting extends StatefulWidget {
  EmailSetting({Key key}) : super(key: key);

  @override
  _EmailSettingState createState() => _EmailSettingState();
}

class _EmailSettingState extends State<EmailSetting> {
  TextEditingController _host = TextEditingController();
  TextEditingController _port = TextEditingController();
  TextEditingController _from = TextEditingController();
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _subject = TextEditingController();
  TextEditingController _template = TextEditingController();
  TextEditingController _webHost = TextEditingController();
  final MailApi mailApi = MailApi();
  final UrlApi urlApi = UrlApi();
  String _t = "";
  Email _email = Email();
  Future<bool> _flag;
  @override
  void initState() {
    super.initState();
    this._flag = _getInfo();
  }

  Future<bool> _getInfo() async {
    var data1 = await mailApi.getData();
    var data2 = await urlApi.getData();
    _email = Email.fromJson(data1['data']);
    _webHost.text = data2['data']['url'];
    _host.text = _email.host;
    _port.text = _email.port.toString();
    _from.text = _email.from;
    _username.text = _email.username;
    _password.text = _email.password;
    _subject.text = _email.subject;
    _template.text = _email.template;
    setState(() {
      this._t = _email.template;
    });
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _flag,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == true) {
              return settings(context);
            }
          } else if (snapshot.hasError) {
            popToast(snapshot.error, context);
            return Container();
          }
          return settings(context);
        });
  }

  Widget settings(BuildContext context) => Container(
      padding: EdgeInsets.all(20),
      child: ListView(
        children: <Widget>[
          Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              webHostSetting(context),
              templateSetting(context),
              bottona(context)
            ],
          )
        ],
      ));

  Widget webHostSetting(BuildContext context) => Builder(
        builder: (context) {
          return Container(
            child: Wrap(
              direction: Axis.horizontal,
              alignment: WrapAlignment.start,
              children: <Widget>[
                input2(context, "主机地址", _webHost, tp: TextInputType.url),
                input2(context, "发送方", _from),
                input2(context, "stmp服务器地址", _host, tp: TextInputType.url),
                input2(context, "stmp服务器端口", _port,
                    tp: TextInputType.number,
                    wl: [WhitelistingTextInputFormatter.digitsOnly]),
                input2(context, "用户名", _username,
                    tp: TextInputType.emailAddress),
                input2(context, "密码", _password, obscureText: true),
                input2(context, "邮件标题", _subject)
              ],
            ),
          );
        },
      );
  Widget templateSetting(BuildContext context) => Builder(
        builder: (context) {
          return Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 10,
                child: template(context),
              ),
              Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("\${name}:被调查者姓名"),
                        Text("\${title}:调查问卷名"),
                        Text("\${from}:开始时间"),
                        Text("\${to}:结束时间"),
                        Text("\${url}:问卷链接")
                      ],
                    ),
                  )),
              Expanded(flex: 10, child: view(context)),
            ],
          );
        },
      );
  Widget template(BuildContext context) => Builder(builder: (context) {
        return Container(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("模板编辑"),
            Container(
                height: 500,
                width: 800,
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.all(20),
                child: TextField(
                  controller: _template,
                  decoration: InputDecoration(border: InputBorder.none),
                  minLines: 25,
                  maxLines: 25,
                  onChanged: (v) {
                    setState(() {
                      this._t = v;
                    });
                  },
                ),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black26, width: 1.0)))
          ],
        ));
      });
  Widget view(BuildContext context) => Builder(
        builder: (context) {
          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("预览"),
                Container(
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.all(20),
                    height: 500,
                    width: 800,
                    child: HtmlWidget(this._t),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black26, width: 1.0)))
              ],
            ),
          );
        },
      );
  Widget bottona(BuildContext context) => Builder(
      builder: (context) => Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                RaisedButton(
                    child: Row(
                      children: <Widget>[
                        Text("保存"),
                        Icon(
                          Icons.save,
                          color: Colors.red,
                        )
                      ],
                    ),
                    onPressed: () async {
                      _email.host = _host.text;
                      _email.port = int.parse(_port.text);
                      _email.from = _from.text;
                      _email.username = _username.text;
                      _email.password = _password.text;
                      _email.subject = _subject.text;
                      _email.template = _template.text;
                      try{
                         await mailApi.updateData(_email);
                         await urlApi.updateData(this._webHost.text);
                         popToast("保存成功", context);
                      }on DioError catch(e){
                        popToast(e.message, context);
                      }
                    }),
              ],
            ),
          ));
}
