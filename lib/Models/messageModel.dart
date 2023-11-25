class MessageModel{
  String? text;
  String ?date;
  String ?uid;
  String ?receiverId;



  MessageModel({
  this.text  ,
  this.date,
  this.uid  ,
  this.receiverId,
  });

  MessageModel.FormJson(Map<String,dynamic>json){
    uid=json["uid"];
    receiverId=json["receiverId"];
    date=json["date"];
    text=json["text"];

  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "receiverId": receiverId,
      "date": date,
      "text": text,

    };
  }
}