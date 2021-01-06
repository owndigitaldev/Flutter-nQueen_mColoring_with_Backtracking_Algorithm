import "package:flutter/material.dart";

class Vertex {
  Vertex({
    this.name,
    this.color,
    this.val,
  });

  String name;
  Color color;
  List<int> val;

  factory Vertex.fromJson(Map<String, dynamic> json) => Vertex(
        name: json["name"],
        color: json["color"],
        val: json["val"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "color": color.toString(),
        "link": List<dynamic>.from(val.map((x) => x)),
      };
}
