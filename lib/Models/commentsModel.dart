

class CommentsModel{
  String? uid;
  String? name;
  String? img;
  String? date;
  String? text;
  String? imgPost;

  CommentsModel({
    this.uid,
    this.name,
    this.img,
    this.date,
    this.text,
    this.imgPost,
  });
  CommentsModel.FormJson(Map<String,dynamic>json){
    uid=json["uid"];
    name=json["name"];
    img=json["img"];
    date=json["date"];
    text=json["text"];
    imgPost=json["imgPost"];
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "name":name,
      "img": img,
      "date": date,
      "text": text,
      "imgPost":imgPost
    };
  }
}