import 'package:flutter/material.dart';
import '../../../models/city_model.dart';

class CityCard extends StatelessWidget {
  final City city;
  const CityCard({
    super.key,
    required this.city,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: SizedBox(
        height: 150,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Ink.image(
              image: NetworkImage(city.image),
              fit: BoxFit.fill,
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/city',
                    arguments: city.name,
                  );
                },
              ),
            ),
            Positioned(
                top: 10,
                left: 10,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  color: const Color.fromARGB(180, 76, 175, 79),
                  child: Text(
                    city.name,
                    style: const TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
