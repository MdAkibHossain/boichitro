import 'package:flutter/material.dart';

class AudioBooksRead {
  int? id;
  String? part;
  String? file;

  AudioBooksRead({
    @required this.id,
    @required this.part,
    @required this.file,
  });

  factory AudioBooksRead.fromJson(Map<String, dynamic> map) {
    return AudioBooksRead(
      id: map['id'],
      part: map['book'],
      file: map['audio_file'],
    );
  }
}
