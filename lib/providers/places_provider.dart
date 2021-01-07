import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:guide_app/helpers/db_helper.dart';
import 'package:guide_app/models/place_model.dart';

class PlacesProvider with ChangeNotifier {

  List<PlaceModel> _items = [];


  List<PlaceModel> get items{
    return [..._items];
  }


  Future<void> addPlace(String pickedTitle,File pickedImage) async {
    final newPlace = PlaceModel(
        id: DateTime.now().toString(),
        title: pickedTitle,
        image: pickedImage,
        location: PlaceLocationModel(
            latitude: 0.0,
            longitude: 0.0
        ));

    _items.add(newPlace);
    await DBHelper.insertPlace(newPlace);
    notifyListeners();
  }

  Future<void> fetchAndSetPlaces() async {
    List<PlaceModel> places = await fetchDataFromLocalDataBase;
    _items = [...places];
    notifyListeners();
  }


  Future<List<PlaceModel>> get fetchDataFromLocalDataBase async {
    return await DBHelper.fetchPlaces();
  }




}
