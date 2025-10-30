
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/trip_model.dart';

abstract class TripsLocalDataSource {
  Future<List<TripModel>> loadTrips();
}

class TripsLocalDataSourceImpl implements TripsLocalDataSource {
  final String assetPath;
  TripsLocalDataSourceImpl({this.assetPath = 'assets/data/trips_mock.json'});

  @override
  Future<List<TripModel>> loadTrips() async {
    final jsonStr = await rootBundle.loadString(assetPath);
    final Map<String, dynamic> map = json.decode(jsonStr) as Map<String, dynamic>;
    final list = (map['trips'] as List<dynamic>);
    return list.map((e) => TripModel.fromJson(e as Map<String, dynamic>)).toList();
  }
}
