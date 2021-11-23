import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:great_places/app/utils/app_routes.dart';
import 'package:great_places/app/pages/place_form_page.dart';
import 'package:great_places/app/pages/places_list_page.dart';
import 'package:great_places/app/pages/place_detail_page.dart';
import 'package:great_places/app/providers/great_places_provider.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  _AppWidgetState createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  Widget build(BuildContext context) {
    final ThemeData _themeData = ThemeData();

    return ChangeNotifierProvider(
      create: (ctx) => GreatPlacesProvider(),
      child: MaterialApp(
        title: 'Great Places',
        theme: _themeData.copyWith(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          colorScheme: _themeData.colorScheme.copyWith(
            primary: Colors.indigo,
            secondary: Colors.amber,
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: const PlacesListPage(),
        routes: {
          AppRoutes.PLACE_FORM: (ctx) => const PlaceFormPage(),
          AppRoutes.PLACE_DETAIL: (ctx) => const PlaceDetailPage(),
        },
      ),
    );
  }
}
