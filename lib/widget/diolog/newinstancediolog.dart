import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qmanager/modules/membergroupmodule.dart';
import 'package:qmanager/utils/dateutil.dart';
import 'package:qmanager/widget/diolog/membergrouptablediolog.dart';
import 'package:qmanager/widget/misc.dart';

Future<bool> newInstancedialog(BuildContext context, var row) {
  return showDialog<bool>(
      context: context,
      builder: (context) => Dialog(child: NewInstanceForm(row: row)));
}

class NewInstanceForm extends StatefulWidget {
  final row;
  NewInstanceForm({Key key, this.row}) : super(key: key);

  @override
  _NewInstanceFormState createState() => _NewInstanceFormState();
}

class _NewInstanceFormState extends State<NewInstanceForm> {
  TextEditingController _name = TextEditingController();
  TextEditingController _pageSize = TextEditingController();
  bool _useMember = false;
  DateTime _mailSendingTime = DateTime.now();
  DateTime _from = DateUtil.getNow();
  DateTime _to = DateUtil.getNow();
  int _pageination = 0;
  Set<MemberGroup> _memberGroups = Set();
  @override
  void initState() {
    super.initState();
    _name.text = widget.row['name'];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 900,
        width: 600,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Text(
                  "建立新问卷实例",
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
              FlatButton(child: Text("确定"), onPressed: () async {
                Map<String,dynamic> map = {
                  "id": widget.row['id'],
                  "name": _name.text,
                  "is_anonymous": _useMember?1:0,
                  "member_id": _memberGroups.map((f)=>f.id).toList(),
                  "send_mail_time": _mailSendingTime.toIso8601String(),
                  "from": _from.toIso8601String(),
                  "to": _to.toIso8601String(),
                  "pageination": _pageination,
                  "page_size": _pageSize.text
                };
                popToast(map.toString(), context);
              }),
            ],
          ));

  content(BuildContext context) {
    List<Widget> list = [];
    this._memberGroups.forEach((v) {
      list.add(Chip(
        label: Text(v.groupName),
        deleteIcon: Icon(
          Icons.cancel,
          color: Colors.red,
        ),
        onDeleted: () {
          setState(() {
            this._memberGroups.remove(v);
          });
        },
      ));
    });
    var members = Wrap(
        spacing: 8.0,
        runSpacing: 4.0,
        alignment: WrapAlignment.start,
        children: list);
    return Builder(
      builder: (context) => Container(
        child: ListView(
          children: <Widget>[
            input2(
              context,
              "问卷名",
              _name,
            ),
            SwitchListTile(
              title: Text("实名调查"),
              onChanged: (v) {
                setState(() {
                  this._useMember = v;
                });
              },
              value: this._useMember,
            ),
            Visibility(
              visible: this._useMember,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  members,
                  ListTile(
                    leading: Icon(
                      Icons.add,
                      color: Colors.blue,
                    ),
                    title: Text("添加被调查成员组"),
                    onTap: () async {
                      List<MemberGroup> l =
                          await memberGroupTableDiolog(context);
                      setState(() {
                        if (l != null) {
                          this._memberGroups.addAll(l);
                        }
                      });
                    },
                  )
                ],
              ),
            ),
            Visibility(
              visible: this._useMember,
              child: ListTile(
                  title: Text(
                      "发送邮件通知时间：${DateUtil.format(this._mailSendingTime)}"),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.calendar_today,
                      color: Colors.blue,
                    ),
                    onPressed: () async {
                      DateTime ft = await showDatePicker(
                        context: context,
                        locale: Locale("zh"),
                        initialDate: this._mailSendingTime,
                        firstDate: DateTime.parse("2020-01-01"),
                        lastDate: DateTime.parse("2030-12-12"),
                      );
                      if (ft != null) {
                        TimeOfDay f = await showTimePicker(
                          context: context,
                          initialTime:
                              TimeOfDay.fromDateTime(this._mailSendingTime),
                        );
                        setState(() {
                          this._from = DateUtil.setTime(ft, f);
                        });
                      }
                    },
                  )),
            ),
            ListTile(
                title: Text("开始调查时间：${DateUtil.format(this._from)}"),
                trailing: IconButton(
                  icon: Icon(
                    Icons.calendar_today,
                    color: Colors.blue,
                  ),
                  onPressed: () async {
                    DateTime from = await showDatePicker(
                      context: context,
                      locale: Locale("zh"),
                      initialDate: this._from,
                      firstDate: DateTime.parse("2020-01-01"),
                      lastDate: DateTime.parse("2030-12-12"),
                    );
                    if (from != null) {
                      TimeOfDay f = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(this._from),
                      );
                      setState(() {
                        this._from = DateUtil.setTime(from, f);
                      });
                    }
                  },
                )),
            ListTile(
                title: Text("结束调查时间：${DateUtil.format(this._to)}"),
                trailing: IconButton(
                  icon: Icon(
                    Icons.calendar_today,
                    color: Colors.blue,
                  ),
                  onPressed: () async {
                    DateTime from = await showDatePicker(
                      context: context,
                      locale: Locale("zh"),
                      initialDate: this._to,
                      firstDate: DateTime.parse("2020-01-01"),
                      lastDate: DateTime.parse("2030-12-12"),
                    );
                    if (from != null) {
                      TimeOfDay f = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(this._to),
                      );
                      setState(() {
                        this._to = DateUtil.setTime(from, f);
                      });
                    }
                  },
                )),
            Text("分页设置"),
            RadioListTile(
              title: Text("不分页"),
              groupValue: this._pageination,
              onChanged: (value) {
                setState(() {
                  this._pageination = value;
                });
              },
              value: 0,
            ),
            RadioListTile(
              title: Text("按组分页"),
              groupValue: this._pageination,
              onChanged: (value) {
                setState(() {
                  this._pageination = value;
                });
              },
              value: 1,
            ),
            RadioListTile(
              title: Text("根据条数分页"),
              groupValue: this._pageination,
              onChanged: (value) {
                setState(() {
                  this._pageination = value;
                });
              },
              value: 2,
            ),
            Visibility(
              visible: this._pageination == 2,
              child: input2(context, "每页条数", _pageSize,
                  wl: [WhitelistingTextInputFormatter.digitsOnly]),
            )
          ],
        ),
      ),
    );
  }
}
