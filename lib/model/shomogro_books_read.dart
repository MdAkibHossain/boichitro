import 'package:flutter/material.dart';

class SomogroBooksRead {
  int? id;
  String? part_name;
  String? content;

  SomogroBooksRead({
    @required this.id,
    @required this.part_name,
    @required this.content,
  });

  factory SomogroBooksRead.fromJson(Map<String, dynamic> map) {
    return SomogroBooksRead(
      id: map['id'],
      part_name: map['part_name_bangla'],
      content: map['content'],
    );
  }
}
