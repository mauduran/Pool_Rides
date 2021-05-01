// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my-trip.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MyTripAdapter extends TypeAdapter<MyTrip> {
  @override
  final int typeId = 10;

  @override
  MyTrip read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MyTrip(
      trip: fields[0] as Trip,
      distanceOrigin: fields[1] as double,
      distanceDestination: fields[2] as double,
      reviewedUsers: (fields[3] as List)?.cast<String>(),
      userUid: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MyTrip obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.trip)
      ..writeByte(1)
      ..write(obj.distanceOrigin)
      ..writeByte(2)
      ..write(obj.distanceDestination)
      ..writeByte(3)
      ..write(obj.reviewedUsers)
      ..writeByte(4)
      ..write(obj.userUid);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyTripAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
