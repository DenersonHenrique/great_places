import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:great_places/app/widgets/image_input.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/app/widgets/location_input.dart';
import 'package:great_places/app/providers/great_places_provider.dart';

class PlaceFormPage extends StatefulWidget {
  const PlaceFormPage({Key? key}) : super(key: key);

  @override
  _PlaceFormPageState createState() => _PlaceFormPageState();
}

class _PlaceFormPageState extends State<PlaceFormPage> {
  final TextEditingController _titleController = TextEditingController();
  late File _pickedImage;
  late LatLng _pickedPosition;

  void _selectImage(File pickedImage) => setState(
        () {
          _pickedImage = pickedImage;
        },
      );

  void _selectPosition(LatLng position) => setState(
        () {
          _pickedPosition = position;
        },
      );

  bool _isValidForm() => _titleController.text.isNotEmpty;

  void _submit() {
    if (!_isValidForm()) return;

    Provider.of<GreatPlacesProvider>(context, listen: false).addPlace(
      _titleController.text,
      _pickedImage,
      _pickedPosition,
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Lugar'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        labelText: 'Título',
                      ),
                      onChanged: (text) {
                        setState(() {});
                      },
                    ),
                    const SizedBox(height: 10.0),
                    ImageInputWidget(_selectImage),
                    const SizedBox(height: 10.0),
                    LocationInputWidget(_selectPosition),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: _isValidForm() ? _submit : null,
            icon: const Icon(Icons.add),
            label: const Text('Adicionar'),
            style: ElevatedButton.styleFrom(
              textStyle: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
              elevation: 0,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              primary: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ],
      ),
    );
  }
}
