import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/add_place_screen.dart';

import '../providers/great_places.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your places'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: Consumer<GreatPlaces>(
        builder: (ctx, greatPlaces, ch) => greatPlaces.items.length <= 0
            ? ch as Widget
            : ListView.builder(
                itemCount: greatPlaces.items.length,
                itemBuilder: (ctx, i) => ListTile(
                  leading: CircleAvatar(
                    backgroundImage: FileImage(
                      greatPlaces.items[i].image,
                    ),
                  ),
                  title: Text(greatPlaces.items[i].title),
                  onTap: () {},
                ),
              ),
        child: Center(
          child: Text('No places yet, start adding'),
        ),
      ),
    );
  }
}
