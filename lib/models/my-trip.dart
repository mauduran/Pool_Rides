import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import 'trip.dart';

part 'my-trip.g.dart';

@HiveType(typeId: 10, adapterName: "MyTripAdapter")
class MyTrip {
  @HiveField(0)
  Trip trip;
  @HiveField(1)
  double distanceOrigin;
  @HiveField(2)
  double distanceDestination;
  @HiveField(3)
  List<String> reviewedUsers;
  @HiveField(4)
  String userUid;
  MyTrip({
    this.trip,
    @required this.distanceOrigin,
    @required this.distanceDestination,
    @required this.reviewedUsers,
    @required this.userUid,
  });

  factory MyTrip.fromJson(Map<String, dynamic> parsedJson) {
    List<String> reviewedUsers = [];

    if (parsedJson.containsKey("reviewedUsers") &&
        parsedJson["reviewedUsers"].length > 0) {
      (parsedJson["reviewedUsers"])
          .forEach((element) => {reviewedUsers.add(element)});
    }

    return new MyTrip(
      distanceDestination: parsedJson["distanceDestination"],
      distanceOrigin: parsedJson["distanceOrigin"],
      trip: parsedJson["trip"],
      reviewedUsers: reviewedUsers,
      userUid: parsedJson["userUid"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "trip": trip?.toMap(),
      "distanceDestination": distanceDestination,
      "distanceOrigin": distanceOrigin,
      "reviewedUsers": reviewedUsers,
      "userUid": userUid,
      "trip": trip
    };
  }

  MyTrip copyWith({
    distanceOrigin,
    distanceDestination,
    reviewedUsers,
    userUid,
  }) {
    return MyTrip(
      distanceOrigin: distanceOrigin ?? this.distanceOrigin,
      distanceDestination: distanceDestination ?? this.distanceDestination,
      reviewedUsers: reviewedUsers ?? this.reviewedUsers,
      userUid: userUid ?? this.userUid,
    );
  }
}
