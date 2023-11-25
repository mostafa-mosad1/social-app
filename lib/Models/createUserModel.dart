class CreateUserModel {
  String? uid;
  String? name;
  String? email;
  String? phone;
  String? img;
  String? cover;
  String? bio;

  CreateUserModel(
      {this.email,
      this.phone,
      this.img,
      this.name,
      this.bio,
      this.cover,
      this.uid});

  CreateUserModel.formJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json["email"];
    phone = json["phone"];
    img = json["img"];
    cover = json["cover"];
    bio = json["bio"];
    uid = json["uid"];
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "phone": phone,
      "img": img,
      "bio": bio,
      "cover": cover,
      "uid": uid
    };
  }
}
