// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReviewAdapter extends TypeAdapter<Review> {
  @override
  final int typeId = 1;

  @override
  Review read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Review(
      reviewerName: fields[0] as String,
      description: fields[1] as String,
      rating: fields[2] as String,
      reviewerImage: fields[3] as String,
      date: fields[4] as DateTime,
      stars: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Review obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.reviewerName)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.rating)
      ..writeByte(3)
      ..write(obj.reviewerImage)
      ..writeByte(4)
      ..write(obj.date)
      ..writeByte(5)
      ..write(obj.stars);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReviewAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
