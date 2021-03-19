import 'package:pool_rides/models/user.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pool_rides/Pages/reviews/ReviewsPage.dart';
import 'package:intl/date_symbol_data_local.dart';

class UserProfile extends StatefulWidget {
  final User user;
  const UserProfile({Key key, @required this.user}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              CircleAvatar(
                backgroundImage: NetworkImage(
                  widget.user.image != ""
                      ? widget.user.image
                      : "https://www.freeiconspng.com/thumbs/driver-icon/driver-icon-14.png",
                ),
                maxRadius: 60.0,
                backgroundColor: Colors.grey[300],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Text(
                  "${widget.user.name}",
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  "${widget.user.age} años",
                  style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 30,
                ),
                child: Text(
                  "${widget.user.biography}",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  //TO DO: Ir hacia las reseñas de este usuario
                  print(widget.user.name);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ReviewsPage(),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.star,
                            color: Theme.of(context).primaryColor,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "${widget.user.stars.toString().substring(0, 4)}/5 - ${widget.user.reviewsNumber} reseña(s)", // To Do: agregar el atributo "No. de reseñas en conductor"
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 17.5,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.keyboard_arrow_right,
                        size: 25,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Divider(
                thickness: 5,
                color: Colors.grey[500],
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Row(
                  children: [
                    Text(
                      "Usuario desde ${DateFormat.yMMMM().format(widget.user.joined)}",
                      style: TextStyle(
                        fontSize: 17.5,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
