import 'package:flutter/material.dart';

class MagazineInfo {
  int? id;
  String? magazine_file;
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

  MagazineInfo({
    required this.id,
    required this.magazine_file,
    required this.short_name,
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

  factory MagazineInfo.fromJson(Map<String, dynamic> map) {
    return MagazineInfo(
        id: map['id'],
        magazine_file: map['magazine_file'],
        short_name: map['book']['short_name'],
        bookname: map['book']['book_name'],
        cover_image: map['book']['cover_image'],
        rating: map['book']['rating'].toString(),
        description: map['book']['description'],
        edition: map['book']['edition'],
        isbn: map['book']['isbn'],
        author: map['book']['author']['name'],
        publisher: map['book']['publisher']['name'],
        is_paid: map['book']['is_paid'],
        cover_note: map['book']['cover_note']);
  }
}
