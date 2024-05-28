import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Suggestion {
  @JsonKey(name: "suggestion_id")
  String suggestionId;
  @JsonKey(name: "suggestion_title")
  String suggestionTitle;
  @JsonKey(name: "suggestion_description")
  String suggestionDescription;
  @JsonKey(name: "suggestion_inactive")
  String suggestionInactive;
  @JsonKey(name: "suggestion_completed")
  String suggestionCompleted;

  Suggestion({
    required this.suggestionId,
    required this.suggestionTitle,
    required this.suggestionDescription,
    required this.suggestionInactive,
    required this.suggestionCompleted,
  });

  factory Suggestion.fromJson(Map<String, dynamic> json) {
    return Suggestion(
      suggestionId: json["suggestion_id"],
      suggestionTitle: json["suggestion_title"],
      suggestionDescription: json["suggestion_description"],
      suggestionInactive: json["suggestion_inactive"],
      suggestionCompleted: json["suggestion_completed"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.suggestionId,
      "title": this.suggestionTitle,
      "description": this.suggestionDescription,
      "inactive": this.suggestionInactive,
      "completed": this.suggestionCompleted,
    };
  }
}
