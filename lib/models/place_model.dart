

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:guide_app/helpers/utils.dart';

class PlaceModel {
  final String id;
  final String title;
  final PlaceLocationModel location;
  final File image; //for images from local storage (onDevice)

  PlaceModel({
    @required this.id,
    @required this.title,
    @required this.image,
    @required this.location,
  });


  Map<String,Object> get toMap {
    return {
      DBUtils.placeId: id,
      DBUtils.placeImage: image.path,
      DBUtils.placeTitle: title,
     // DBUtils.placeAddress: location.address,
     // DBUtils.placeLatitude: location.latitude,
     // DBUtils.placeLongitude: location.longitude,
    };
  }



}

class PlaceLocationModel {
  final double latitude;
  final double longitude;
  final String address;

  PlaceLocationModel({
    @required this.latitude,
    @required this.longitude,
    this.address = '',
  });
}
