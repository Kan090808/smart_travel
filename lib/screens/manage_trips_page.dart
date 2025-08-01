import 'package:flutter/material.dart';
import '../models/trip.dart';
import 'trip_detail_page.dart';

class ManageTripsPage extends StatefulWidget {
  const ManageTripsPage({super.key});

  @override
  State<ManageTripsPage> createState() => _ManageTripsPageState();
}

class _ManageTripsPageState extends State<ManageTripsPage> {
  final List<Trip> _trips = [];

  void _createTrip() async {
    final nameController = TextEditingController();
    final result = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('New Trip'),
          content: TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Trip Name'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isNotEmpty) {
                  Navigator.pop(context, nameController.text);
                }
              },
              child: const Text('Create'),
            ),
          ],
        );
      },
    );

    if (result != null && result.isNotEmpty) {
      final trip = Trip(name: result, locations: []);
      final updatedTrip = await Navigator.push<Trip>(
        context,
        MaterialPageRoute(builder: (_) => TripDetailPage(trip: trip)),
      );
      if (updatedTrip != null) {
        setState(() {
          _trips.add(updatedTrip);
        });
      }
    }
  }

  void _editTrip(int index) async {
    final trip = _trips[index];
    final updatedTrip = await Navigator.push<Trip>(
      context,
      MaterialPageRoute(builder: (_) => TripDetailPage(trip: trip)),
    );
    if (updatedTrip != null) {
      setState(() {
        _trips[index] = updatedTrip;
      });
    }
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
