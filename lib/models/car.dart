import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'car.g.dart';

@HiveType(typeId: 2, adapterName: "CarAdapter")
class Car {
  @HiveField(0)
  String brand;
  @HiveField(1)
  String model;
  @HiveField(2)
  String plate;
  @HiveField(3)
  String color;
  @HiveField(4)
  int year;
  @HiveField(5)
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
