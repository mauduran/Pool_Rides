// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation-user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ConversationUserAdapter extends TypeAdapter<ConversationUser> {
  @override
  final int typeId = 4;

  @override
  ConversationUser read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ConversationUser(
      userId: fields[0] as String,
      name: fields[1] as String,
      email: fields[2] as String,
      phoneNumber: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ConversationUser obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.phoneNumber);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConversationUserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
