class IndexJson {
  INFO jj;
  Map <String,dynamic> infoMap=Map<String,dynamic>();
  IndexJson({this.infoMap});
  IndexJson.fromJson(Map<String, dynamic> json) {
    for(var i=0;i<json.length;i++){
      jj = json['$i'] != null ? INFO.fromJson(json['$i']) : null;
      infoMap['$i']=jj.item;
    }
  }
}
class INFO {
  Map <String,dynamic> item=Map<String,dynamic>();
  INFO({this.item});
  INFO.fromJson(Map<String, dynamic> json) {
    item["browse"] = json['browse'];
    item["group"] = json['group'];
    item["name"] = json['name'];
    item["support"] = json['support'];
    item["time"] = json['time'];
    item["url"] = json['url'];
    item["objectId"]=json['objectId'];
    item["browse1"] = json['browse1'];
    item["group1"] = json['group1'];
    item["name1"] = json['name1'];
    item["support1"] = json['support1'];
    item["time1"] = json['time1'];
    item["url1"] = json['url1'];
    item["objectId1"]=json['objectId1'];
  }
}
