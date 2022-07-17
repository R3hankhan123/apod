// To parse this JSON data, do
//
//     final apodData = apodDataFromJson(jsonString);

import 'dart:convert';

ApodData apodDataFromJson(String str) => ApodData.fromJson(json.decode(str));

String apodDataToJson(ApodData data) => json.encode(data.toJson());

class ApodData {
  ApodData({
    required this.date,
    required this.explanation,
    required this.hdurl,
    required this.mediaType,
    required this.serviceVersion,
    required this.title,
    required this.url,
  });

  DateTime date;
  String explanation;
  String hdurl;
  String mediaType;
  String serviceVersion;
  String title;
  String url;

  factory ApodData.fromJson(Map<String, dynamic> json) => ApodData(
        date: DateTime.parse(json["date"]),
        explanation: json["explanation"],
        hdurl: json["hdurl"],
        mediaType: json["media_type"],
        serviceVersion: json["service_version"],
        title: json["title"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "explanation": explanation,
        "hdurl": hdurl,
        "media_type": mediaType,
        "service_version": serviceVersion,
        "title": title,
        "url": url,
      };
}
