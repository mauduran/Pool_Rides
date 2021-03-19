extension MyDateUtils on DateTime {
  DateTime copyWith({
    int year,
    int month,
    int day,
    int hour,
    int minute,
  }) {
    return DateTime(
      year ?? this.year,
      month ?? this.month,
      day ?? this.day,
      hour ?? this.hour,
      minute ?? this.minute,
      0,
      0,
      0,
    );
  }
}
