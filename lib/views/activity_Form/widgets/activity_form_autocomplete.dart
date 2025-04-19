import 'dart:async';

import 'package:flutter/material.dart';

import '../../../models/activity_model.dart';

Future<LocationActivity?> showInputAutocomplete(BuildContext context) {
  return showDialog(
    context: context,
    builder: (_) => const InputAdress(),
  );
}

class InputAdress extends StatefulWidget {
  const InputAdress({super.key});

  @override
  State<InputAdress> createState() => _InputAdressState();
}

class _InputAdressState extends State<InputAdress> {
  final List<dynamic> _places = [];
  Timer? _debounce;
  Future<void> _searchAddress(String value) async {
    if (_debounce?.isActive == true) _debounce?.cancel();
    _debounce = Timer(const Duration(seconds: 1), () {
      print(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              TextField(
                decoration: const InputDecoration(
                    labelText: 'Rechercher',
                    prefixIcon: Icon(
                      Icons.search,
                    )),
                onChanged: _searchAddress,
              ),
              Positioned(
                top: 5,
                right: 3,
                child: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
          // ListView.builder(itemCount: _places.length,
          // itemBuilder: (_, 1){
          //   var place = _places[i];
          //   return ListTile(leading: Icon(Icons.place), title: Text(place.name),)

          // },),
        ],
      ),
    );
  }
}
