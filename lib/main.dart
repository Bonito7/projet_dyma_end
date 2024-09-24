import 'package:flutter/material.dart';
import 'package:projet_dyma_end/providers/city_provider.dart';
import 'package:projet_dyma_end/providers/trip_provider.dart';
import 'package:projet_dyma_end/views/trip/trip_view.dart';
import 'package:projet_dyma_end/views/trips/trips_view.dart';

import 'package:provider/provider.dart';

import './views/city/city_view.dart';
import 'views/not-found/not_found.dart';
import './views/Home/home_view.dart';

main() {
  runApp(const DymaTrip());
}

class DymaTrip extends StatefulWidget {
  // final List<City> cities = data.cities;

  const DymaTrip({super.key});

  @override
  State<DymaTrip> createState() => _DymaTripState();
}

class _DymaTripState extends State<DymaTrip> {
  final CityProvider cityProvider = CityProvider();
  final TripProvider tripProvider = TripProvider();

  @override
  void initState() {
    cityProvider.fetchData();
    tripProvider.fetchData();
    super.initState();
  }
  // void addTrip(Trip trip) {
  //   setState(() {
  //     trips.add(trip);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: cityProvider,
        ),
        ChangeNotifierProvider.value(
          value: tripProvider,
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.deepOrangeAccent,
            titleTextStyle: TextStyle(color: Colors.white, fontSize: 23),
            iconTheme: IconThemeData(color: Colors.white),
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: const HomeView(),
        routes: {
          CityView.routeName: (_) => const CityView(),
          TripsView.routeName: (_) => const TripsView(),
          TripView.routeName: (_) => const TripView(),
        },
        onUnknownRoute: (_) {
          return MaterialPageRoute(builder: (_) {
            return const NotFound();
          });
        },
      ),
    );
  }
}
