class Post {
  String postId;
  String postTitle;
  String postDescription;
  String postLocation;
  String postTime;
  String postImage;
  String postInactive;

  Post({
    required this.postId,
    required this.postTitle,
    required this.postDescription,
    required this.postLocation,
    required this.postTime,
    required this.postImage,
    required this.postInactive,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      postId: json["post_id"].toString(),
      postTitle: json["post_title"].toString(),
      postDescription: json["post_description"].toString(),
      postLocation: json["post_location"].toString(),
      postTime: json["post_time"].toString(),
      postImage: json["post_image"].toString(),
      postInactive: json["post_inactive"].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "post_id": this.postId,
      "post_title": this.postTitle,
      "post_description": this.postDescription,
      "post_location": this.postLocation,
      "post_time": this.postTime,
      "post_image": this.postImage,
      "post_inactive": this.postInactive,
    };
  }

//
}
