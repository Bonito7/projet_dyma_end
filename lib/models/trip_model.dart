import 'package:flutter/material.dart';
import 'package:projet_dyma_end/models/activity_model.dart';

class Trip {
  String id;
  String? city;
  List<Activity> activities;
  DateTime? date;
  Trip({
    this.city,
    required this.activities,
    this.date,
  }) : id = UniqueKey().toString();
}
