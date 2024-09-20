import '../models/activity_model.dart';
import '../models/city_model.dart';

List<City> cities = [
  City(
    name: 'Abidjan',
    image: 'assets/images/abidjan.jpeg',
    activities: [
      Activity(
          image: 'assets/images/activities/cathedrale.jpg',
          name: 'Cathedrale du plateau',
          id: 'a1',
          city: 'Abidjan',
          price: 12000.00),
      Activity(
          image: 'assets/images/activities/musee.jpeg',
          name: 'Le Musée des costumes',
          id: 'a2',
          city: 'Abidjan',
          price: 8000.00),
      Activity(
          image: 'assets/images/activities/pyramide.jpg',
          name: 'La Pyramide du plateau',
          id: 'a3',
          city: 'Abidjan',
          price: 3000.00),
      Activity(
          image: 'assets/images/activities/banco.jpg',
          name: 'La Forêt du Banco',
          id: 'a4',
          city: 'Abidjan',
          price: 20000.00),
      Activity(
          image: 'assets/images/activities/domaine_bini.jpeg',
          name: 'Domaine Bini',
          id: 'a5',
          city: 'Abidjan',
          price: 12000.00),
      Activity(
          image: 'assets/images/activities/paintball.jpeg',
          name: 'Ivoire Paintball',
          id: 'a6',
          city: 'Abidjan',
          price: 8000.00),
      Activity(
          image: 'assets/images/activities/parc_expositions.jpeg',
          name: 'Parc des expositions',
          id: 'a7',
          city: 'Abidjan',
          price: 3000.00),
      Activity(
          image: 'assets/images/activities/villa_aphro.jpeg',
          name: 'La Villa Aphro',
          id: 'a8',
          city: 'Abidjan',
          price: 20000.00),
    ],
  ),
  City(
    name: 'Yamoussoukro',
    image: 'assets/images/yamoussoukro.jpeg',
    activities: [
      Activity(
          image: 'assets/images/activities/basilique.jpeg',
          name: 'Basilique Notre Dame...',
          id: 'y1',
          city: 'Yamoussoukro',
          price: 12000.00),
      Activity(
          image: 'assets/images/activities/caiman.jpeg',
          name: 'Le lac au caiman',
          id: 'y2',
          city: 'Yamoussoukro',
          price: 8000.00),
      Activity(
          image: 'assets/images/activities/fondation.jpg',
          name: 'La Fondation FHB',
          id: 'y3',
          city: 'Yamoussoukro',
          price: 3000.00),
      Activity(
          image: 'assets/images/activities/parlementaire.jpeg',
          name: 'Hotel Parlementaire',
          id: 'y4',
          city: 'Yamoussoukro',
          price: 20000.00),
    ],
  ),
  City(
    name: 'Korhogo',
    image: 'assets/images/korhogo.jpeg',
    activities: [
      Activity(
          image: 'assets/images/activities/mont_korhogo.jpeg',
          name: 'Mont Korhogo',
          id: 'k1',
          city: 'Korhogo',
          price: 12000.00),
      Activity(
          image: 'assets/images/activities/waraniéré.jpeg',
          name: 'Village Waraniéné',
          id: 'k2',
          city: 'Korhogo',
          price: 8000.00),
      Activity(
          image: 'assets/images/activities/stade_korhogo.jpeg',
          name: 'Le stade de Footbal',
          id: 'k3',
          city: 'Korhogo',
          price: 3000.00),
      Activity(
          image: 'assets/images/activities/village_niofoin.jpeg',
          name: 'village Niofoin',
          id: 'k4',
          city: 'Korhogo',
          price: 20000.00),
    ],
  ),
];
