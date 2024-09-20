import 'package:flutter/material.dart';
import 'package:projet_dyma_end/views/Home/home_view.dart';

import '../../widgets/dyma_drawer.dart';
import './widgets/trip_activity_list.dart';
import './widgets/activity_list.dart';
import './widgets/trip_overview.dart';

import '../../models/city_model.dart';
import '../../models/trip_model.dart';
import '../../models/activity_model.dart';

class CityView extends StatefulWidget {
  static const String routeName = '/city';
  final City? city;
  final Function addTrip;

  List<Activity> get activities {
    return city?.activities ?? [];
  }

  showContext({BuildContext? context, List<Widget>? children}) {
    var orientation = MediaQuery.of(context!).orientation;
    if (orientation == Orientation.landscape) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children!,
      );
    } else {
      return Column(
        children: children!,
      );
    }
  }

  const CityView({super.key, this.city, required this.addTrip});

  @override
  State<CityView> createState() => _CityViewState();
}

class _CityViewState extends State<CityView> with WidgetsBindingObserver {
  late Trip mytrip;
  late int index;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    mytrip = Trip(activities: [], city: 'Abidjan', date: null);
    index = 0;
  }

  List<Activity> get tripActivities {
    return widget.activities.where((activity) {
      return mytrip.activities.contains(activity.id);
    }).toList();
  }

  double get amount {
    return mytrip.activities.fold(0.00, (prev, element) {
      var activity =
          widget.activities.firstWhere((activity) => activity.id == element);
      return prev + activity.price;
    });
  }

  void setDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime(2026),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.orange, // Change primary color here
              onPrimary: Colors.white, // Text color on primary elements
              onSurface: Colors.black, // Text color on the calendar
            ),
            dialogBackgroundColor:
                Colors.white, // Background color of the dialog
          ),
          child: child!,
        );
      },
    ).then(
      (newDate) {
        if (newDate != null) {
          // Handle the new date
          setState(() {
            mytrip.date = newDate;
          });
        }
      },
    );
  }

  void switchIndex(newIndex) {
    setState(() {
      index = newIndex;
    });
  }

  void toggleActivity(String id) {
    setState(() {
      mytrip.activities.contains(id)
          ? mytrip.activities.remove(id)
          : mytrip.activities.add(id);
    });
  }

  void deleteTripActivity(String id) {
    setState(() {
      mytrip.activities.remove(id);
    });
  }

  void saveTrip() async {
    final result = await showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('Voulez vous sauvegarder ?'),
          contentPadding: const EdgeInsets.all(20),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, 'cancel');
                  },
                  child: const Text(
                    'Annuler',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.orangeAccent,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all(Colors.orangeAccent),
                  ),
                  onPressed: () {
                    Navigator.pop(context, 'save');
                  },
                  child: const Text(
                    'Sauvegarder',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
    if (result == 'save') {
      widget.addTrip(mytrip);
      Navigator.pushNamed(context, HomeView.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Organisation du voyage'),
        actions: const [
          Icon(Icons.more_vert),
        ],
      ),
      drawer: const DymaDrawer(),
      body: Container(
        padding: const EdgeInsets.all(2),
        child: widget.showContext(
          context: context,
          children: [
            TripOverview(
              cityName: widget.city?.name,
              setDate: setDate,
              trip: mytrip,
              amount: amount,
            ),
            Expanded(
              child: index == 0
                  ? ActivityList(
                      activities: widget.activities,
                      selectedActivities: mytrip.activities,
                      toggleActivity: toggleActivity,
                    )
                  : TripActivityList(
                      activities: tripActivities,
                      deleteTripActivity: deleteTripActivity,
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrangeAccent,
        onPressed: saveTrip,
        child: const Icon(
          Icons.forward,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        fixedColor: Colors.green[700],
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Decouverte',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.stars),
            label: 'Mes activités',
          ),
        ],
        onTap: switchIndex,
      ),
    );
  }
}
