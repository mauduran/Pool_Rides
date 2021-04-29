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
      image: fields[2] as String,
      phoneNumber: fields[5] as String,
      age: fields[6] as int,
      tripNumber: fields[7] as String,
      reviews: (fields[9] as List)?.cast<Review>(),
      car: fields[10] as Car,
      birthdate: fields[4] as DateTime,
      totalStars: fields[12] as int,
      totalReviews: fields[13] as int,
      uid: fields[11] as String,
      name: fields[0] as String,
      email: fields[3] as String,
      joined: fields[8] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.biography)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.birthdate)
      ..writeByte(5)
      ..write(obj.phoneNumber)
      ..writeByte(6)
      ..write(obj.age)
      ..writeByte(7)
      ..write(obj.tripNumber)
      ..writeByte(8)
      ..write(obj.joined)
      ..writeByte(9)
      ..write(obj.reviews)
      ..writeByte(10)
      ..write(obj.car)
      ..writeByte(11)
      ..write(obj.uid)
      ..writeByte(12)
      ..write(obj.totalStars)
      ..writeByte(13)
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
