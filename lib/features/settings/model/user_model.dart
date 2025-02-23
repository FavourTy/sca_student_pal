class UserModel {
  final String? name;
  final String? uid;
  final String? email;

  UserModel({
    this.name,
    this.uid,
    this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json["name"],
        uid: json["uid"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "uid": uid,
        "email": email,
      };
}
