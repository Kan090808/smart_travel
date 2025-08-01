import 'location.dart';

class Trip {
  String name;
  final List<Location> locations;
  List<String> transportation;

  Trip({required this.name, required this.locations, this.transportation = const []});
}
