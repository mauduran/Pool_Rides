import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'latilong.g.dart';

@HiveType(typeId: 7, adapterName: "LatiLongAdapter")
class LatiLong {
  @HiveField(0)
  final double lat;
  @HiveField(1)
  final double long;

  LatiLong({
    @required this.lat,
    @required this.long,
  });

  factory LatiLong.fromJson(Map<String, dynamic> parsedJson) {
    return new LatiLong(
      long: parsedJson['longitude'],
      lat: parsedJson['latitude'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "latitude": lat,
      "longitude": long,
    };
  }
}
