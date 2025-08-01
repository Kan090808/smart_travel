import 'package:flutter/material.dart';
import '../models/trip.dart';
import '../models/location.dart';

class TripDetailPage extends StatefulWidget {
  final Trip trip;
  const TripDetailPage({super.key, required this.trip});

  @override
  State<TripDetailPage> createState() => _TripDetailPageState();
}

class _TripDetailPageState extends State<TripDetailPage> {
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.trip.name);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _addLocation() {
    final nameController = TextEditingController();
    final latController = TextEditingController();
    final lngController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Location'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: latController,
                decoration: const InputDecoration(labelText: 'Latitude'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: lngController,
                decoration: const InputDecoration(labelText: 'Longitude'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final name = nameController.text;
                final lat = double.tryParse(latController.text);
                final lng = double.tryParse(lngController.text);
                if (name.isNotEmpty && lat != null && lng != null) {
                  setState(() {
                    widget.trip.locations.add(
                      Location(latitude: lat, longitude: lng, name: name),
                    );
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _deleteLocation(int index) {
    setState(() {
      widget.trip.locations.removeAt(index);
    });
  }

  void _save() {
    setState(() {
      widget.trip.name = _nameController.text;
    });
    Navigator.pop(context, widget.trip);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trip Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _save,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Trip Name'),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: widget.trip.locations.length,
                itemBuilder: (context, index) {
                  final loc = widget.trip.locations[index];
                  return ListTile(
                    title: Text(loc.name),
                    subtitle: Text('(${loc.latitude}, ${loc.longitude})'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _deleteLocation(index),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addLocation,
        child: const Icon(Icons.add_location),
      ),
    );
  }
}
