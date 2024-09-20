import 'package:flutter/material.dart';

import './datas/data.dart' as data;
import './views/city/city_view.dart';
import './views/404_error/not_found.dart';
import './views/Home/home_view.dart';
import './views/trips/trips_view.dart';

import 'models/city_model.dart';
import 'models/trip_model.dart';

main() {
  runApp(DymaTrip());
}

class DymaTrip extends StatefulWidget {
  final List<City> cities = data.cities;

  DymaTrip({super.key});

  @override
  State<DymaTrip> createState() => _DymaTripState();
}

class _DymaTripState extends State<DymaTrip> {
  List<Trip> trips = [
    Trip(
      city: 'Abidjan',
      activities: [],
      date: DateTime.now().add(const Duration(days: 1)),
    ),
    Trip(
      city: 'Yamoussoukro',
      activities: [],
      date: DateTime.now().add(const Duration(days: 2)),
    ),
    Trip(
      city: 'Korhogo',
      activities: [],
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ];

  void addTrip(Trip trip) {
    setState(() {
      trips.add(trip);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepOrangeAccent,
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 23),
          iconTheme: IconThemeData(color: Colors.white),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: HomeView(cities: widget.cities),
      // routes: {
      //   '/city': (context) {
      //     return CityView();
      //   },
      // },
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case CityView.routeName:
            {
              return MaterialPageRoute(
                builder: (context) {
                  final City? city = settings.arguments as City?;
                  return CityView(
                    city: city,
                    addTrip: addTrip,
                  );
                },
              );
            }
          case TripsView.routeName:
            {
              return MaterialPageRoute(
                builder: (context) {
                  return TripsView(trips: trips);
                },
              );
            }
        }

        if (settings.name == '/city') {}
        return null;
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (context) {
          return const NotFound();
        });
      },
    );
  }
}
