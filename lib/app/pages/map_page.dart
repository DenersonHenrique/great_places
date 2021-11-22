import 'package:flutter/material.dart';
import 'package:great_places/app/models/place_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  final bool isReadonly;
  final PlaceLocationModel initialLocation;

  const MapPage({
    Key? key,
    this.initialLocation = const PlaceLocationModel(
      latitude: 37.419857,
      longitude: -122.078827,
    ),
    this.isReadonly = false,
  }) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  LatLng? _pickedPosition;

  void _selectPosition(LatLng position) {
    setState(() {
      _pickedPosition = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecione'),
        actions: <Widget>[
          if (!widget.isReadonly)
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: _pickedPosition == null
                  ? null
                  : () {
                      Navigator.of(context).pop(_pickedPosition);
                    },
            ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.initialLocation.latitude,
            widget.initialLocation.longitude,
          ),
          zoom: 12,
        ),
        onTap: widget.isReadonly ? null : _selectPosition,
        markers: _pickedPosition == null
            ? Set()
            : {
                Marker(
                  markerId: const MarkerId('pos1'),
                  position: _pickedPosition!,
                ),
              },
      ),
    );
  }
}
