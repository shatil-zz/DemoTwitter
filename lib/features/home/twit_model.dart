import 'package:json_annotation/json_annotation.dart';

part 'twit_model.g.dart';

@JsonSerializable()
class TwitModel {
  @JsonKey(ignore: true)
  String? id;

  String? twitBy;
  String? twit;
  dynamic createdAt;
  String? userId;

  TwitModel(this.twit, this.twitBy, this.createdAt, this.userId);

  factory TwitModel.fromJson(Map<String, dynamic> json) =>
      _$TwitModelFromJson(json);

  Map<String, dynamic> toJson() => _$TwitModelToJson(this);
}
