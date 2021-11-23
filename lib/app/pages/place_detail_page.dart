import 'package:flutter/material.dart';
import 'package:great_places/app/pages/map_page.dart';
import 'package:great_places/app/models/place_model.dart';

class PlaceDetailPage extends StatelessWidget {
  const PlaceDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PlaceModel placeModel =
        ModalRoute.of(context)!.settings.arguments as PlaceModel;
    return Scaffold(
      appBar: AppBar(
        title: Text(placeModel.title),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 250,
            width: double.infinity,
            child: Image.file(
              placeModel.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              placeModel.location!.address as String,
              style: const TextStyle(
                fontSize: 20.0,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(height: 10),
          TextButton.icon(
            icon: const Icon(Icons.map),
            label: const Text('Ver no mapa.'),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                fullscreenDialog: true,
                builder: (ctx) => MapPage(
                  isReadonly: true,
                  initialLocation: placeModel.location!,
                ),
              ));
            },
          ),
        ],
      ),
    );
  }
}
