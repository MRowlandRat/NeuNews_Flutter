import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Club {
  @JsonKey(name: "club_inactive")
  String clubInactive;
  @JsonKey(name: "club_name")
  String clubName;
  @JsonKey(name: "club_image")
  String clubImage;
  @JsonKey(name: "club_description")
  String clubDescription;
  @JsonKey(name: "club_id")
  String clubId;
  @JsonKey(name: "club_approved")
  String clubApproved;

  Club({
    required this.clubInactive,
    required this.clubName,
    required this.clubImage,
    required this.clubDescription,
    required this.clubId,
    required this.clubApproved,
  });

  factory Club.fromJson(Map<String, dynamic> json) {
    return Club(
      clubInactive: json["club_inactive"],
      clubName: json["club_name"],
      clubImage: json["club_image"],
      clubDescription: json["club_description"],
      clubId: json["club_id"],
      clubApproved: json["club_approved"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "club_inactive": this.clubInactive,
      "club_name": this.clubName,
      "club_image": this.clubImage,
      "club_description": this.clubDescription,
      "club_id": this.clubId,
      "club_approved": this.clubApproved,
    };
  }
}
