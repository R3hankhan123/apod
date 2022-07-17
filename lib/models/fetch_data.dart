// ignore_for_file: unused_local_variable
import 'dart:convert';
import 'package:apod/models/store_data.dart';
import 'package:http/http.dart' as http;

class FetchData {
  String apiKey = 'VSKfAQ5V2krZdsm514dgPYA7faQAsFrZVkIR8BGa';
  Future<List<ApodData>> getDataCnt(String count) async {
    List<ApodData>? apodData;
    Uri uri = Uri.parse(
        'https://api.nasa.gov/planetary/apod?api_key=$apiKey&count=$count');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return apodData = (json.decode(response.body) as List)
          .map<ApodData>((json) => ApodData.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<List<ApodData>> getDataStartDate(String date) async {
    List<ApodData>? apodData;
    Uri uri = Uri.parse(
        'https://api.nasa.gov/planetary/apod?api_key=$apiKey&start_date=$date');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return apodData = (json.decode(response.body) as List)
          .map<ApodData>((json) => ApodData.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load album');
    }
  }
}
