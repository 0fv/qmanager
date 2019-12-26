import 'package:qmanager/modules/jsonserializable.dart';

class Questionnaire implements JsonSerializable {
  final String id;
  final String name;
  final String introduce;
  final DateTime createdTime;
  final DateTime modifyTime;
  Questionnaire(
      {this.id, this.name, this.introduce, this.createdTime, this.modifyTime});

  Questionnaire.fromJson(Map<String, dynamic> json)
      : id = json["_id"],
        name = json["name"],
        introduce = json["introduce"],
        createdTime = DateTime.parse(json["created_time"]),
        modifyTime = json["modify_time"]!=null?DateTime.parse(json["modify_time"]):DateTime.parse("1970-01-01");
        
  @override
  Map<String, String> toJson() => {
        '_id': id,
        'name': name,
        'introduce': introduce,
        'created_time': createdTime.toString(),
        'modify_time': modifyTime.toString()
      };
      @override
  Map<String, dynamic> toMap() => {
        '_id': id,
        'name': name,
        'introduce': introduce,
        'created_time': createdTime,
        'modify_time': modifyTime
      };
}
