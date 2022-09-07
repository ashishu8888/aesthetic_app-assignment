import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class MovieModel {
  String movieName;
  String dirName;
  String images;
  String key;
  MovieModel({
    required this.movieName,
    required this.dirName,
    required this.images,
    required this.key,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'movieName': movieName,
      'dirName': dirName,
      'images': images,
      'key': key,
    };
  }

  factory MovieModel.fromMap(Map<String, dynamic> map) {
    return MovieModel(
      movieName: map['movieName'] as String,
      dirName: map['dirName'] as String,
      images: map['images'] as String,
      key: map['key'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MovieModel.fromJson(String source) =>
      MovieModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
