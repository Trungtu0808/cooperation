import 'package:base_component/import_all.dart';

part 'app_config_model.g.dart';

@HiveType(typeId: 1)
@JsonSerializable(ignoreUnannotated: false)
class AppConfigModel{
  @JsonKey(name: 'openCount')
  @HiveField(0)
  int openCount;

  AppConfigModel({this.openCount = 0});

  factory AppConfigModel.fromJson(Map<String, dynamic> json) => _$AppConfigModelFromJson(json);
  Map<String, dynamic> toJson() => _$AppConfigModelToJson(this);

  AppConfigModel copyWith({
    int? openCount,
  }) {
    return AppConfigModel(
      openCount: openCount ?? this.openCount,
    );
  }
}
