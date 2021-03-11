import 'package:pool_rides/models/user.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserDetail extends StatelessWidget {
  final User user;
  const UserDetail({Key key, @required this.user}) : super(key: key);

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
                  user.image != ""
                      ? user.image
                      : "https://www.freeiconspng.com/thumbs/driver-icon/driver-icon-14.png",
                ),
                maxRadius: 60.0,
                backgroundColor: Colors.grey[300],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Text(
                  "${user.name}",
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  "${user.age} años",
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
                  "${user.biography}",
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
                  print(user.name);
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
                            "${user.stars.toString().substring(0, 4)}/5 - ${user.reviewsNumber} reseña(s)", // To Do: agregar el atributo "No. de reseñas en conductor"
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
                      "Usuario desde ${DateFormat.yMMMM().format(user.joined)}",
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
