import 'package:pool_rides/Pages/reviews/ReviewsPage.dart';
import 'package:pool_rides/models/user.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:url_launcher/url_launcher.dart';

class PassengerDetail extends StatefulWidget {
  final User user;
  const PassengerDetail({Key key, @required this.user}) : super(key: key);

  @override
  _PassengerDetailState createState() => _PassengerDetailState();
}

class _PassengerDetailState extends State<PassengerDetail> {
  double averageRating = 0;
  int numOfReviews = 0;

  @override
  void initState() {
    super.initState();
    numOfReviews = widget.user.totalReviews;
    averageRating = widget.user.totalStars / numOfReviews;
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
                backgroundImage:
                    (widget.user.image != "" && widget.user.image != null)
                        ? NetworkImage(
                            widget.user.image,
                          )
                        : AssetImage('assets/images/avatar_placeholder.png'),
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
              if (widget.user.birthdate != null)
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    "${(DateTime.now().difference(widget.user.birthdate).inDays / 365.25).floor()} años",
                    style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  left: 30,
                  right: 30,
                  bottom: 10,
                ),
                child: Text(
                  "${widget.user.biography ?? "Sin biografia"}",
                  style: TextStyle(
                    fontSize: 17.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              InkWell(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 30,
                    right: 30,
                  ),
                  child: Text(
                    "Llamar",
                    style: TextStyle(
                      fontSize: 17.5,
                      color: (widget.user.phoneNumber != null)
                          ? Colors.blue[900]
                          : Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                onTap: () async {
                  if (widget.user.phoneNumber != null &&
                      widget.user.phoneNumber !=
                          "") if (await canLaunch(
                      "tel:${widget.user.phoneNumber}"))
                    await launch(("tel:${widget.user.phoneNumber}"));
                },
              ),
              SizedBox(
                height: 5,
              ),
              GestureDetector(
                onTap: () {
                  if (numOfReviews != 0.0)
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ReviewsPage(uid: widget.user.uid),
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
                            numOfReviews == 0
                                ? "0 reseñas"
                                : "${averageRating.toStringAsFixed(1)}/5 - $numOfReviews reseña(s)", // To Do: agregar el atributo "No. de reseñas en conductor"
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
