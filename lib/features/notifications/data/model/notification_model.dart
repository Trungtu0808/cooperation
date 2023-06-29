import 'package:app_chat_firebase/features/notifications/domain/entity/notification_entity.dart';
import 'package:app_model/app_model_all_file.dart';

part 'notification_model.g.dart';
part 'notification_convert.dart';

@JsonSerializable()
class NotificationModel {

    NotificationModel({this.title, this.subTitle, this.actionTypes});

    final String? title;
    final String? subTitle;
    final String? actionTypes;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
    _$NotificationModelFromJson(json);

    Map<String, dynamic> toJson() =>
    _$NotificationModelToJson(this);
}