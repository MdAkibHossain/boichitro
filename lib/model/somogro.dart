import 'package:flutter/material.dart';

class SomogroInfo {
  int? pk;
  String? rating;
  String? slug;
  String? keywords;
  String? bookname;
  String? cover_image;
  String? description;
  String? edition;
  String? cover_note;
  String? author;
  String? publisher;
  bool? is_paid;
  String? isbn;

  SomogroInfo({
    @required this.is_paid,
    @required this.isbn,
    @required this.pk,
    @required this.rating,
    @required this.slug,
    @required this.keywords,
    @required this.bookname,
    @required this.cover_image,
    @required this.description,
    @required this.edition,
    @required this.cover_note,
    @required this.author,
    @required this.publisher,
  });

  factory SomogroInfo.fromJson(Map<String, dynamic> map) {
    return SomogroInfo(
      isbn: map['isbn'],
      is_paid: map['is_paid'],
      pk: map['id'],
      slug: map['slug'],
      bookname: map['shomgro_bangla_names'],
      keywords: map['keywords'],
      rating: map['rating'],
      cover_image: map['shomgro_image'],
      description: map['description'],
      edition: map['edition'],
      author: map['author_name'],
      publisher: map['publisher_name'],
      cover_note: map['cover_note'],
    );
  }
}
