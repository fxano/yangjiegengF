class LibraryJson {
  String browse;
  String comment;
  String content;
  String group;
  String name;
  String support;
  String userId;
  String userName;

  LibraryJson({this.browse,
    this.comment,
    this.content,
    this.group,
    this.name,
    this.support,
    this.userId,
    this.userName});

  LibraryJson.fromJson(Map<dynamic, dynamic> json) {
    browse = json['browse'];
    comment = json['comment'];
    content = json['content'];
    group = json['group'];
    name = json['name'];
    support = json['support'];
    userId = json['userId'];
    userName = json['userName'];
  }
}