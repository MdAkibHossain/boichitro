import 'package:flutter/material.dart';

class AudioBooksRead {
  int? id;
  String? part;
  String? file;
  String? url;

  AudioBooksRead({
    @required this.id,
    @required this.part,
    @required this.file,
    @required this.url,
  });

  factory AudioBooksRead.fromJson(Map<String, dynamic> map) {
    return AudioBooksRead(
      id: map['id'],
      part: map['book'],
      file: map['audio_file'],
      url: map['audi_link'],
    );
  }
}
