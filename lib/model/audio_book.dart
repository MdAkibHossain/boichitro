import 'package:flutter/material.dart';

class AudioBookModel {
  int? id;
  String? audio_file;
  String? audio_link;
  String? short_name;
  String? rating;
  String? bookname;
  String? cover_image;
  String? description;
  String? edition;
  String? isbn;
  String? cover_note;
  String? author;
  String? publisher;
  bool? is_paid;

  AudioBookModel({
    required this.id,
    required this.audio_file,
    required this.short_name,
    required this.audio_link,
    required this.rating,
    required this.bookname,
    required this.cover_image,
    required this.description,
    required this.edition,
    required this.cover_note,
    required this.isbn,
    required this.author,
    required this.publisher,
    required this.is_paid,
  });

  factory AudioBookModel.fromJson(Map<String, dynamic> map) {
    return AudioBookModel(
        id: map['pk'],
        audio_file: map['audio_file'],
        short_name: map['book_name'],
        bookname: map['book_name'],
        cover_image: map['cover_image'],
        rating: map['rating'].toString(),
        description: map['description'],
        edition: map['edition'],
        isbn: map['isbn'],
        author: map['author_name'],
        publisher: map['publisher_name'],
        is_paid: map['is_paid'],
        audio_link: map['audi_link'],
        cover_note: map['cover_note']);
  }
}
