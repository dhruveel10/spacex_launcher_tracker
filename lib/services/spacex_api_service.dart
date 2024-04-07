import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/launch.dart';

class SpaceXApiService extends ChangeNotifier {
  List<Launch> _launches = [];

  List<Launch> get launches => _launches;

  Future<void> fetchUpcomingLaunches() async {
    final url = Uri.parse('https://api.spacexdata.com/v4/launches/past/');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      _launches = data
          .map((launchData) => Launch.fromJson(launchData))
          .where((launch) =>
      launch.missionDetails !=
          'No details available') // Filter launches with mission details
          .toList();
      _launches = _launches.reversed.toList();
      notifyListeners();
    } else {
      throw Exception('Failed to fetch launches');
    }
  }
}