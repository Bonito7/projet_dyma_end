import 'dart:collection';

import 'package:flutter/material.dart';
import '../models/city_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CityProvider with ChangeNotifier {
  final String host = 'http://10.0.2.2';
  List<City> _cities = [];
  bool isLoading = false;

  UnmodifiableListView<City> get cities => UnmodifiableListView(_cities);

  City getCityByName(String cityName) =>
      cities.firstWhere((city) => city.name == cityName);

  Future<void> fetchData() async {
    try {
      isLoading = true;
      final Uri url = Uri.parse('$host/api/cities');
      http.Response response = await http.get(url);
      print(json.decode(response.body));
      if (response.statusCode == 200) {
        _cities = (json.decode(response.body) as List)
            .map((cityJson) => City.fromJson(cityJson))
            .toList();
        isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      isLoading = false;
      rethrow;
    }
  }
}
