class MyData {
  final String name;
  final String description;
  final bool isInactive;

  MyData({
    required this.name,
    required this.description,
    required this.isInactive,
  });

  factory MyData.fromJson(Map<String, dynamic> json) {
    return MyData(
      name: json['name'],
      description: json['description'],
      isInactive: json['isInactive'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'isInactive': isInactive,
    };
  }
}