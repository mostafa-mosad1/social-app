class LikesDataModel{
  bool? likes;

LikesDataModel({this.likes});

  LikesDataModel.FormJson(Map<String,dynamic>json){
    likes=json["likes"];}

  Map<String, dynamic> toMap() {
    return {
      "likes": likes,};
  }
}