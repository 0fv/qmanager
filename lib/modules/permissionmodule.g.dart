// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'permissionmodule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Permission _$PermissionFromJson(Map<String, dynamic> json) {
  return Permission()
    ..questionnaire = json['questionnaire'] as String
    ..questionCells = json['question_cells'] as String
    ..questionGroups = json['question_groups'] as String
    ..inquiryCrew = json['inquiry_crew'] as String
    ..inquiryConfig = json['inquiry_config'] as String
    ..resultShow = json['result_show'] as String
    ..templateControl = json['template_control'] as String
    ..accountManagement = json['account_management'] as String
    ..mailManagement = json['mail_management'] as String;
}

Map<String, dynamic> _$PermissionToJson(Permission instance) =>
    <String, dynamic>{
      'questionnaire': instance.questionnaire,
      'question_cells': instance.questionCells,
      'question_groups': instance.questionGroups,
      'inquiry_crew': instance.inquiryCrew,
      'inquiry_config': instance.inquiryConfig,
      'result_show': instance.resultShow,
      'template_control': instance.templateControl,
      'account_management': instance.accountManagement,
      'mail_management': instance.mailManagement,
    };
