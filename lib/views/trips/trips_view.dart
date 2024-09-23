import 'package:flutter/material.dart';
import 'package:projet_dyma_end/models/trip_model.dart';
import 'package:projet_dyma_end/providers/trip_provider.dart';
import 'package:projet_dyma_end/views/trips/widgets/trips_list.dart';
import 'package:projet_dyma_end/widgets/dyma_drawer.dart';
import 'package:provider/provider.dart';

class TripsView extends StatelessWidget {
  static const String routeName = '/trips';

  const TripsView({super.key});

  @override
  Widget build(BuildContext context) {
    List<Trip> trips = Provider.of<TripProvider>(context).trips;
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
            trips: trips
                .where((trip) => DateTime.now().isBefore(trip.date!))
                .toList(),
          ),
          TripsList(
            trips: trips
                .where((trip) => DateTime.now().isAfter(trip.date!))
                .toList(),
          ),
        ]),
      ),
    );
  }
}
