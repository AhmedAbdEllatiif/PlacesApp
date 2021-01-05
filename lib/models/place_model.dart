

import 'dart:io';

import 'package:flutter/material.dart';

class PlaceModel {
  final String id;
  final String title;
  final PlaceLocationModel location;
  final File image; //for images from local storage (onDevice)

  PlaceModel({
    required this.id,
    required this.title,
    required this.image,
    required this.location,
  });
}

class PlaceLocationModel {
  final double latitude;
  final double longitude;
  final String address;

  PlaceLocationModel({
    required this.latitude,
    required this.longitude,
    this.address = '',
  });
}
