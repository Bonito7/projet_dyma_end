import 'dart:collection';

import 'package:flutter/material.dart';

import '../models/activity_model.dart';
import '../models/trip_model.dart';
import '../datas/data.dart' as data;

class TripProvider with ChangeNotifier {
  final List<Trip> _trips = data.trips;

  UnmodifiableListView<Trip> get trips => UnmodifiableListView(_trips);

  void addTrip(Trip trip) {
    _trips.add(trip);
    notifyListeners();
  }

  Trip getTripById(String tripId) {
    return trips.firstWhere((trip) => trip.id == tripId);
  }

  setActivityToDone(Activity activity) {
    activity.status = ActivityStatus.done;
    notifyListeners();
  }
}
