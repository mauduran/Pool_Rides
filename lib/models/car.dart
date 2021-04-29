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
  String plates;
  @HiveField(3)
  String color;
  @HiveField(4)
  int year;
  String image;
  Car({
    this.brand,
    @required this.model,
    this.plates,
    @required this.color,
    @required this.year,
    this.image,
  });

  factory Car.fromJson(Map<String, dynamic> parsedJson) {
    return new Car(
      color: parsedJson['color'],
      image: parsedJson['image'] ??
          'http://firstchoiceautomarkham.com/images/car-placeholder.png',
      model: parsedJson['model'],
      brand: parsedJson['brand'],
      plates: parsedJson['plates'],
      year: parsedJson['year'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "color": color,
      "image": image ??
          'http://firstchoiceautomarkham.com/images/car-placeholder.png',
      "model": model,
      "brand": brand,
      "plates": plates,
      "year": year
    };
  }

  Car copyWith({
    String brand,
    String model,
    String plates,
    String color,
    int year,
    String image,
  }) {
    return Car(
      color: color ?? this.color,
      image: image ?? this.image,
      model: model ?? this.model,
      brand: brand ?? this.brand,
      plates: plates ?? this.plates,
      year: year ?? this.year,
    );
  }
}
