import 'package:flutter/foundation.dart';

import 'trip.dart';

class MyTrip {
  Trip trip;
  double distanceOrigin;
  double distanceDestination;
  List<String> reviewedUsers;
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
      trip: Trip.fromJson(parsedJson["trip"]),
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
    };
  }
}
