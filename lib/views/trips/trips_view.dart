import 'package:flutter/material.dart';
import 'package:projet_dyma_end/views/trips/widgets/trips_list.dart';
import 'package:projet_dyma_end/widgets/dyma_drawer.dart';

import '../../models/trip_model.dart';

class TripsView extends StatefulWidget {
  static const String routeName = '/trips';
  final List<Trip> trips;

  const TripsView({super.key, required this.trips});

  @override
  State<TripsView> createState() => _TripsViewState();
}

class _TripsViewState extends State<TripsView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Mes voyages',
          ),
          bottom: TabBar(
            indicatorColor: Colors.deepOrangeAccent,
            indicatorSize: TabBarIndicatorSize.tab,
            unselectedLabelColor: Colors.orange[400],
            labelStyle: TextStyle(
              color: Colors.orange[100],
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            tabs: const [
              Tab(
                text: 'A venir',
              ),
              Tab(
                text: 'Passés',
              ),
            ],
          ),
        ),
        drawer: const DymaDrawer(),
        body: TabBarView(children: [
          TripsList(
            trips: widget.trips
                .where((trip) => DateTime.now().isBefore(trip.date!))
                .toList(),
          ),
          TripsList(
            trips: widget.trips
                .where((trip) => DateTime.now().isAfter(trip.date!))
                .toList(),
          ),
        ]),
      ),
    );
  }
}
