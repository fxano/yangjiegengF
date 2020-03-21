class JSON {
  String name;
  String userId;
  String msg;
  String fans;
  String follow;
  String auto;
  String url;
  JSON({this.name,this.msg,this.userId,this.auto,this.follow,this.fans,this.url});

  factory JSON.fromJson(Map<String,dynamic>json){
    return JSON(name:json["Name"],msg:json["Msg"],userId: json["UserId"]);
  }
  factory JSON.fromJsonInfo(Map<String,dynamic>json){
    return JSON(name:json["name"],auto:json["auto"],userId: json["userId"],fans: json["fans"],follow: json["follow"],url:json["url"]);
  }
}