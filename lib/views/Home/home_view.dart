import 'package:flutter/material.dart';
import 'package:projet_dyma_end/views/Home/widgets/city_card.dart';
import 'package:projet_dyma_end/widgets/dyma_drawer.dart';

import '../../models/city_model.dart';

class HomeView extends StatefulWidget {
  static const String routeName = '/';
  final List<City> cities;
  const HomeView({super.key, required this.cities});

  @override
  // ignore: library_private_types_in_public_api
  _HomeViewState createState() {
    return _HomeViewState();
  }
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dymatrip'),
        actions: const <Widget>[
          Icon(Icons.more_vert),
        ],
      ),
      drawer: const DymaDrawer(),
      body: Container(
        padding: const EdgeInsets.all(10.00),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ...widget.cities.map((city) {
              return CityCard(
                city: city,
              );
            })
          ],
        ),
      ),
    );
  }
}
