// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'permissionmodule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Permission _$PermissionFromJson(Map<String, dynamic> json) {
  return Permission()
    ..questionnaire = json['questionnaire'] as bool
    ..questionCells = json['question_cells'] as bool
    ..questionGroups = json['question_groups'] as bool
    ..inquiryCrew = json['inquiry_crew'] as bool
    ..inquiryConfig = json['inquiry_config'] as bool
    ..resultShow = json['result_show'] as bool
    ..tmeplateControl = json['template_control'] as bool
    ..accountManagement = json['account_management'] as bool;
}

Map<String, dynamic> _$PermissionToJson(Permission instance) =>
    <String, dynamic>{
      'questionnaire': instance.questionnaire,
      'question_cells': instance.questionCells,
      'question_groups': instance.questionGroups,
      'inquiry_crew': instance.inquiryCrew,
      'inquiry_config': instance.inquiryConfig,
      'result_show': instance.resultShow,
      'template_control': instance.tmeplateControl,
      'account_management': instance.accountManagement,
    };
