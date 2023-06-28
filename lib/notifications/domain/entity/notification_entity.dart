import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notification_entity.g.dart';

@JsonSerializable()
@CopyWith()
class NotificationEntity {
  NotificationEntity({this.title, this.subtitle, this.actionTypes});

  final String? title;
  final String? subtitle;
  final String? actionTypes;

    factory NotificationEntity.fromJson(Map<String, dynamic> json) =>
    _$NotificationEntityFromJson(json);

    Map<String, dynamic> toJson() =>
    _$NotificationEntityToJson(this);

}