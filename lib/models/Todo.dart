// To parse this JSON data, do
//
//     final todo = todoFromJson(jsonString);

import 'dart:convert';

List<Todo> todoFromJson(String str) => List<Todo>.from(json.decode(str).map((x) => Todo.fromJson(x)));

String todoToJson(List<Todo> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Todo {
  Todo({
    this.id,
    this.title,
    this.description,
    this.isDone,
  });

  int id;
  String title;
  String description;
  bool isDone;

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
    id: json["id"] == null ? null : json["id"],
    title: json["title"] == null ? null : json["title"],
    description: json["description"] == null ? null : json["description"],
    isDone: json["isDone"] == null ? null : json["isDone"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "title": title == null ? null : title,
    "description": description == null ? null : description,
    "isDone": isDone == null ? null : isDone,
  };
}
