import 'package:flutter/material.dart';
import 'package:projet_dyma_end/providers/city_provider.dart';
import 'package:projet_dyma_end/views/Home/widgets/city_card.dart';
import 'package:projet_dyma_end/widgets/dyma_drawer.dart';
import 'package:provider/provider.dart';

import '../../models/city_model.dart';

class HomeView extends StatefulWidget {
  static const String routeName = '/';

  const HomeView({
    super.key,
  });

  @override
  // ignore: library_private_types_in_public_api
  _HomeViewState createState() {
    return _HomeViewState();
  }
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    List<City> cities = Provider.of<CityProvider>(context).cities;
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
            children: cities.map((city) {
              return CityCard(
                city: city,
              );
            }).toList()),
      ),
    );
  }
}
