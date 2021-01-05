import 'package:flutter/material.dart';
import 'package:guide_app/models/place_model.dart';
import 'package:guide_app/providers/places_provider.dart';
import 'package:guide_app/screens/add_place_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///AppBar
      appBar: AppBar(
        title: Text('Your Places'),
        actions: [
          ///add button
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
          ),
        ],
      ),

      ///body
      body: Consumer<PlacesProvider>(
        builder: (_, placesProvider, builderChild) {
          return placesProvider.items.length <= 0
              ? builderChild
              : ListView.builder(
                  itemCount: placesProvider.items.length,
                  itemBuilder: (_, index) {
                    PlaceModel placeModel = placesProvider.items[index];
                    return ListTile(
                      title: Text(placeModel.title),
                      leading: CircleAvatar(
                        backgroundImage: FileImage(placeModel.image),
                      ),
                      onTap: () {
                        //Go to place details screen
                      },
                    );
                  },
                );
        },
        child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Got no places yet, Start adding some...'),
            SizedBox(
              height: 15.0,
            ),
            Container(
              width: 200.0,
              child: RaisedButton.icon(
                label: Text('Add Place'),
                icon: Icon(Icons.add),
                color: Theme.of(context).accentColor,
                onPressed: () =>
                    Navigator.of(context).pushNamed(AddPlaceScreen.routeName),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
