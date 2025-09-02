import 'package:flutter/material.dart';

class Notes {
  int? id;
  String title;
  String content;

  Notes({this.id, required this.title, required this.content});

  Notes.FromMap(Map<String, dynamic> map)
    : id = map["id"],
      title = map["title"],
      content = map["content"];

  Map<String, dynamic> toMap() {
    return {"id": id, "title": title, "content": content};
  }
}
