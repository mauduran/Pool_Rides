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
}
