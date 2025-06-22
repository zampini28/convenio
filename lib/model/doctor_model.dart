import 'dart:convert';

import 'package:flutter/cupertino.dart';

class DoctorModel {
  String name;
  String type;
  String description;
  double rating;
  double goodReviews;
  double totalScore;
  double satisfaction;
  bool isfavourite;
  String image;
  String education;
  String location;
  String constFee;

  DoctorModel({
    required this.name,
    required this.type,
    required this.description,
    required this.rating,
    required this.goodReviews,
    required this.totalScore,
    required this.satisfaction,
    required this.isfavourite,
    required this.image,
    required this.education,
    required this.location,
    required this.constFee,
  });

  DoctorModel copyWith({
    required String name,
    required String type,
    required String description,
    required double rating,
    required double goodReviews,
    required double totalScore,
    required double satisfaction,
    required bool isfavourite,
    required String image,
    required String education,
    required String location,
    required String constFee,
  }) => DoctorModel(
    name: name ?? this.name,
    type: type ?? this.type,
    description: description ?? this.description,
    rating: rating ?? this.rating,
    goodReviews: goodReviews ?? this.goodReviews,
    totalScore: totalScore ?? this.totalScore,
    satisfaction: satisfaction ?? this.satisfaction,
    isfavourite: isfavourite ?? this.isfavourite,
    image: image ?? this.image,
    education: education ?? this.education,
    location: location ?? this.location,
    constFee: constFee ?? this.constFee,
  );

  factory DoctorModel.fromRawJson(String str) =>
      DoctorModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DoctorModel.fromJson(Map<String, dynamic> json) => DoctorModel(
    name: json["name"] == null ? null : json["name"],
    type: json["type"] == null ? null : json["type"],
    description: json["description"] == null ? null : json["description"],
    rating: json["rating"] == null ? null : json["rating"].toDouble(),
    goodReviews:
        json["goodReviews"] == null ? null : json["goodReviews"].toDouble(),
    totalScore:
        json["totalScore"] == null ? null : json["totalScore"].toDouble(),
    satisfaction:
        json["satisfaction"] == null ? null : json["satisfaction"].toDouble(),
    isfavourite: json["isfavourite"] == null ? null : json["isfavourite"],
    image: json["image"] == null ? null : json["image"],
    education: json["education"] == null ? null : json["education"],
    location: json["location"] == null ? null : json["location"],
    constFee: json["constFee"] == null ? null : json["constFee"],
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
    "type": type == null ? null : type,
    "description": description == null ? null : description,
    "rating": rating == null ? null : rating,
    "goodReviews": goodReviews == null ? null : goodReviews,
    "totalScore": totalScore == null ? null : totalScore,
    "satisfaction": satisfaction == null ? null : satisfaction,
    "isfavourite": isfavourite == null ? null : isfavourite,
    "image": image == null ? null : image,
    "education": education == null ? null : education,
    "location": location == null ? null : location,
    "constFee": constFee == null ? null : constFee,
  };
}
