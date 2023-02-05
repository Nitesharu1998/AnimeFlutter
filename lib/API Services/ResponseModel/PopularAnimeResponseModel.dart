// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<PopularAnimeResponseModel> popularAnimeFromJson(String str) =>
    List<PopularAnimeResponseModel>.from(
        json.decode(str).map((x) => PopularAnimeResponseModel.fromJson(x)));

String popularAnimeToJson(List<PopularAnimeResponseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PopularAnimeResponseModel {
  PopularAnimeResponseModel({
    required this.animeId,
    required this.animeTitle,
    required this.animeImg,
    required this.releasedDate,
    required this.animeUrl,
  });

  String animeId;
  String animeTitle;
  String animeImg;
  String releasedDate;
  String animeUrl;

  factory PopularAnimeResponseModel.fromJson(Map<String, dynamic> json) =>
      PopularAnimeResponseModel(
        animeId: json["animeId"],
        animeTitle: json["animeTitle"],
        animeImg: json["animeImg"],
        releasedDate: json["releasedDate"],
        animeUrl: json["animeUrl"],
      );

  Map<String, dynamic> toJson() => {
        "animeId": animeId,
        "animeTitle": animeTitle,
        "animeImg": animeImg,
        "releasedDate": releasedDate,
        "animeUrl": animeUrl,
      };
}
