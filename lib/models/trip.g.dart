// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TripAdapter extends TypeAdapter<Trip> {
  @override
  final int typeId = 9;

  @override
  Trip read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Trip(
      passengerCapacity: fields[7] as int,
      driver: fields[6] as User,
      passengers: (fields[8] as List)?.cast<User>(),
      origin: fields[1] as Place,
      destination: fields[2] as Place,
      departureDate: fields[5] as DateTime,
      startTime: fields[0] as String,
      arrivalTime: fields[3] as String,
      tripPrice: fields[4] as double,
      isCarSpecified: fields[10] as bool,
      car: fields[11] as Car,
    );
  }

  @override
  void write(BinaryWriter writer, Trip obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.startTime)
      ..writeByte(1)
      ..write(obj.origin)
      ..writeByte(2)
      ..write(obj.destination)
      ..writeByte(3)
      ..write(obj.arrivalTime)
      ..writeByte(4)
      ..write(obj.tripPrice)
      ..writeByte(5)
      ..write(obj.departureDate)
      ..writeByte(6)
      ..write(obj.driver)
      ..writeByte(7)
      ..write(obj.passengerCapacity)
      ..writeByte(8)
      ..write(obj.passengers)
      ..writeByte(10)
      ..write(obj.isCarSpecified)
      ..writeByte(11)
      ..write(obj.car);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TripAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
