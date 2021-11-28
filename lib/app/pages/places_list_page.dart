import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:great_places/app/constants/app_routes.dart';
import 'package:great_places/app/constants/app_string.dart';
import 'package:great_places/app/providers/great_places_provider.dart';

class PlacesListPage extends StatefulWidget {
  const PlacesListPage({Key? key}) : super(key: key);

  @override
  State<PlacesListPage> createState() => _PlacesListPageState();
}

class _PlacesListPageState extends State<PlacesListPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(AppString.myPlaces),
          actions: [
            IconButton(
              onPressed: () => Navigator.of(context).pushNamed(
                AppRoutes.PLACE_FORM,
              ),
              icon: const Icon(
                Icons.add,
              ),
            ),
          ],
        ),
        body: FutureBuilder(
          future: Provider.of<GreatPlacesProvider>(context, listen: false)
              .loadPlaces(),
          builder: (ctx, snapshot) => snapshot.connectionState ==
                  ConnectionState.waiting
              ? const Center(child: CircularProgressIndicator())
              : Consumer<GreatPlacesProvider>(
                  child: Center(
                    child: Text(AppString.emptyPlaces),
                  ),
                  builder: (ctx, greatePlaces, ch) => greatePlaces.itemsCount ==
                          0
                      ? ch!
                      : ListView.builder(
                          itemCount: greatePlaces.itemsCount,
                          itemBuilder: (ctx, index) => Dismissible(
                            key: Key(greatePlaces.getItem(index).id),
                            direction: DismissDirection.startToEnd,
                            background: Container(
                              color: Colors.red,
                              child: const Align(
                                alignment: Alignment(-0.9, 0.0),
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage: FileImage(
                                  greatePlaces.getItem(index).image,
                                ),
                              ),
                              title: Text(greatePlaces.getItem(index).title),
                              subtitle: Text(
                                greatePlaces.getItem(index).location!.address!,
                              ),
                              onTap: () => Navigator.of(context).pushNamed(
                                AppRoutes.PLACE_DETAIL,
                                arguments: greatePlaces.getItem(index),
                              ),
                            ),
                            onDismissed: (direction) => setState(
                              () {
                                greatePlaces.removePlace(
                                  greatePlaces.getItem(index).id,
                                );
                              },
                            ),
                          ),
                        ),
                ),
        ),
      );
}
