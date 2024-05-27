import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class User {
  @JsonKey(name: "user_id")
  String userId;
  @JsonKey(name: "user_username")
  String username;
  @JsonKey(name: "user_email")
  String email;
  @JsonKey(name: "user_admin")
  String isAdmin;

  User({
    required this.userId,
    required this.username,
    required this.email,
    required this.isAdmin
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json["user_id"],
      username: json["user_username"],
      email: json["user_email"],
      isAdmin: json["user_admin"]
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "user_id": this.userId,
      "user_username": this.username,
      "user_email": this.email,
      "user_admin": this.isAdmin,
    };
  }
}
