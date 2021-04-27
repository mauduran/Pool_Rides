// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlaceAdapter extends TypeAdapter<Place> {
  @override
  final int typeId = 8;

  @override
  Place read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Place(
      streetNumber: fields[0] as String,
      street: fields[1] as String,
      city: fields[2] as String,
      zipCode: fields[5] as String,
      state: fields[3] as String,
      country: fields[4] as String,
      coordinates: fields[7] as LatiLong,
      placeId: fields[8] as String,
      description: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Place obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.streetNumber)
      ..writeByte(1)
      ..write(obj.street)
      ..writeByte(2)
      ..write(obj.city)
      ..writeByte(3)
      ..write(obj.state)
      ..writeByte(4)
      ..write(obj.country)
      ..writeByte(5)
      ..write(obj.zipCode)
      ..writeByte(6)
      ..write(obj.description)
      ..writeByte(7)
      ..write(obj.coordinates)
      ..writeByte(8)
      ..write(obj.placeId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlaceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
