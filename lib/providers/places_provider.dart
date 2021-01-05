import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:guide_app/models/place_model.dart';

class PlacesProvider with ChangeNotifier {

  List<PlaceModel> _items = [];


  List<PlaceModel> get items{
    return [..._items];
  }


  void addPlace(String pickedTitle,File pickedImage){
      final newPlace = PlaceModel(
          id: DateTime.now().toString(),
          title: pickedTitle,
          image: pickedImage,
          location: PlaceLocationModel(
            latitude: 0.0,
            longitude: 0.0
          ));

      _items.add(newPlace);
      notifyListeners();
  }



}
