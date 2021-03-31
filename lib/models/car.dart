import 'package:flutter/foundation.dart';

class Car {
  String brand;
  String model;
  String plate;
  String color;
  int year;
  String image;
  Car({
    this.brand,
    @required this.model,
    this.plate,
    @required this.color,
    this.year,
    @required this.image,
  });
}
