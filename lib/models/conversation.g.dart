// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ConversationAdapter extends TypeAdapter<Conversation> {
  @override
  final int typeId = 6;

  @override
  Conversation read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Conversation(
      conversationId: fields[0] as String,
      members: (fields[1] as List)?.cast<ConversationUser>(),
      originCity: fields[2] as String,
      destinationCity: fields[3] as String,
      dateOfCreation: fields[4] as DateTime,
      tripId: fields[6] as String,
      lastMessage: fields[5] as ChatMessage,
    );
  }

  @override
  void write(BinaryWriter writer, Conversation obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.conversationId)
      ..writeByte(1)
      ..write(obj.members)
      ..writeByte(2)
      ..write(obj.originCity)
      ..writeByte(3)
      ..write(obj.destinationCity)
      ..writeByte(4)
      ..write(obj.dateOfCreation)
      ..writeByte(5)
      ..write(obj.lastMessage)
      ..writeByte(6)
      ..write(obj.tripId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConversationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
