// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 3;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      biography: fields[1] as String,
      phoneNumber: fields[4] as String,
      age: fields[5] as int,
      car: fields[7] as Car,
      birthdate: fields[3] as DateTime,
      totalStars: fields[9] as int,
      totalReviews: fields[10] as int,
      uid: fields[8] as String,
      name: fields[0] as String,
      email: fields[2] as String,
      joined: fields[6] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.biography)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.birthdate)
      ..writeByte(4)
      ..write(obj.phoneNumber)
      ..writeByte(5)
      ..write(obj.age)
      ..writeByte(6)
      ..write(obj.joined)
      ..writeByte(7)
      ..write(obj.car)
      ..writeByte(8)
      ..write(obj.uid)
      ..writeByte(9)
      ..write(obj.totalStars)
      ..writeByte(10)
      ..write(obj.totalReviews);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
