import 'package:flutter/material.dart';
import '../models/trip.dart';

class ManageTripsPage extends StatefulWidget {
  const ManageTripsPage({super.key});

  @override
  State<ManageTripsPage> createState() => _ManageTripsPageState();
}

class _ManageTripsPageState extends State<ManageTripsPage> {
  final List<Trip> _trips = [];

  void _createTrip() {
    // TODO: collect trip details from user
    setState(() {
      _trips.add(Trip(name: 'New Trip', locations: []));
    });
  }

  void _editTrip(int index) {
    // TODO: implement edit functionality
  }

  void _deleteTrip(int index) {
    setState(() {
      _trips.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manage Trips')),
      body: ListView.builder(
        itemCount: _trips.length,
        itemBuilder: (context, index) {
          final trip = _trips[index];
          return ListTile(
            title: Text(trip.name),
            onTap: () => _editTrip(index),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _deleteTrip(index),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createTrip,
        child: const Icon(Icons.add),
      ),
    );
  }
}
