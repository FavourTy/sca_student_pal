class CourseModel {
  int? id;
  String? title;
  String? code;
  int? color;

  CourseModel({
    this.id,
    this.title,
    this.code,
    this.color,
  });
  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json["id"],
      title: json["title"],
      code: json["code"],
      color: json["color"],
    );
  }
  Map<String, dynamic> toJson() {
    return {"id": id, "title": title, "code": code, "color": color};
  }
}
