import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:great_places/app/pages/map_page.dart';
import 'package:great_places/app/utils/location_util.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationInputWidget extends StatefulWidget {
  final Function onSelectPosition;

  const LocationInputWidget(this.onSelectPosition, {Key? key})
      : super(key: key);

  @override
  _LocationInputWidgetState createState() => _LocationInputWidgetState();
}

class _LocationInputWidgetState extends State<LocationInputWidget> {
  String? _previewImageUrl;

  Future<void> _generateImagePreview(
      double? latitude, double? longitude) async {
    final staticMapImageUrl = LocationUtil.generateLocationPreviewImage(
      latitude: latitude,
      longitude: longitude,
    );

    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
  }

  Future<void> _getCurrentUserLocation() async {
    final locationData = await Location().getLocation();
    _generateImagePreview(locationData.latitude, locationData.longitude);
    widget.onSelectPosition(
      LatLng(
        locationData.latitude!,
        locationData.longitude!,
      ),
    );
  }

  Future<void> _selectOnMap() async {
    final LatLng? selectedPosition = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const MapPage(),
      ),
    );

    if (selectedPosition == null) return;
    _generateImagePreview(
      selectedPosition.latitude,
      selectedPosition.longitude,
    );
    widget.onSelectPosition(selectedPosition);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 200,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: const Color(0xFF909497),
            ),
          ),
          child: _previewImageUrl == null
              ? const Text('Localização não informada')
              : Image.network(
                  _previewImageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton.icon(
              onPressed: _getCurrentUserLocation,
              icon: const Icon(Icons.location_on),
              label: const Text('Localização atual'),
            ),
            TextButton.icon(
              onPressed: _selectOnMap,
              icon: const Icon(Icons.map),
              label: const Text('Selecione no mapa'),
            ),
          ],
        ),
      ],
    );
  }
}
