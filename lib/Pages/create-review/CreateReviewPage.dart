import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:pool_rides/bloc/reviews-bloc/reviews_bloc.dart';
import 'package:pool_rides/models/trip.dart';
import 'package:pool_rides/models/user.dart';
import 'package:pool_rides/widgets/route-locations/RouteLocations.dart';

class CreateReviewPage extends StatefulWidget {
  CreateReviewPage({Key key, @required this.trip, @required this.user})
      : super(key: key);
  final trip;
  final user;

  @override
  _CreateReviewPageState createState() => _CreateReviewPageState();
}

class _CreateReviewPageState extends State<CreateReviewPage> {
  final DateTime date = DateTime.now();
  DateFormat dateFormat;
  DateFormat timeFormat;
  String rating = "Excelente";
  TextEditingController _descriptionController = TextEditingController();
  User user;
  Trip trip;
  ReviewsBloc _bloc;
  @override
  void initState() {
    initializeDateFormatting();
    dateFormat = new DateFormat.yMMMMd('es');
    timeFormat = new DateFormat.Hm('es');
    this.trip = widget.trip as Trip;
    this.user = widget.user as User;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("Crear Reseña"),
          centerTitle: true,
        ),
        body: BlocProvider(
          create: (context) {
            _bloc = ReviewsBloc();
            return _bloc;
          },
          child: BlocConsumer<ReviewsBloc, ReviewsState>(
            listener: (context, state) {
              if (state is CreatedReviewState) {
                Navigator.of(context).pop(true);
              } else if (state is ErrorState) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text(state.error),
                      duration: Duration(seconds: 3),
                      behavior: SnackBarBehavior.floating,
                      action: SnackBarAction(
                        label: "Aceptar",
                        textColor: Colors.blue,
                        onPressed: () {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        },
                      ),
                    ),
                  );
              }
            },
            builder: (context, state) {
              if (state is LoadingState) {
                return Center(child: CircularProgressIndicator());
              }
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(32, 20, 32, 20),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                (user.image != null && user.image != '')
                                    ? NetworkImage(
                                        user.image,
                                      )
                                    : AssetImage(
                                        'assets/images/avatar_placeholder.png'),
                            radius: 36,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Text(
                              user.name,
                              style: Theme.of(context).textTheme.headline4,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "${(dateFormat != null) ? dateFormat.format(trip.departureDate) : ''} - ${(timeFormat != null) ? timeFormat.format(trip.departureDate) : ''}",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40, 20.0, 40, 20),
                      child: RouteLocations(
                        origin:
                            "${trip.origin.city ?? ''}, ${trip.origin.state}",
                        destination:
                            "${trip.destination.city ?? ''}, ${trip.destination.state}",
                        spacing: 20,
                      ),
                    ),
                    Text(
                      "¿Cómo calificarías tu experiencia?",
                      style: Theme.of(context).textTheme.headline6.copyWith(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                      child: DropdownButtonFormField(
                        value: rating,
                        items: [
                          DropdownMenuItem(
                            child: Text("Excelente"),
                            value: "Excelente",
                          ),
                          DropdownMenuItem(
                            child: Text("Muy bien"),
                            value: "Muy bien",
                          ),
                          DropdownMenuItem(
                            child: Text("Bien"),
                            value: "Bien",
                          ),
                          DropdownMenuItem(
                            child: Text("Mal"),
                            value: "Mal",
                          ),
                          DropdownMenuItem(
                            child: Text("Muy mal"),
                            value: "Muy mal",
                          ),
                        ],
                        onChanged: (val) {
                          setState(() {
                            rating = val;
                          });
                        },
                      ),
                    ),
                    Text(
                      "Describe tu experiencia",
                      style: Theme.of(context).textTheme.headline6.copyWith(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                      child: TextField(
                        controller: _descriptionController,
                        decoration: InputDecoration(
                          hintText: "Ingrese breve descripción",
                        ),
                        keyboardType: TextInputType.multiline,
                        minLines: 6,
                        maxLines: 10,
                        maxLength: 255,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 0, bottom: 25),
                      child: MaterialButton(
                        height: 50,
                        minWidth: 330,
                        onPressed: () {
                          if (rating != null &&
                              _descriptionController.text != "") {
                            _bloc.add(CreateReviewEvent(
                                rating: rating,
                                description: _descriptionController.text,
                                trip: trip,
                                reviewedUser: user));
                          } else {
                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(
                                SnackBar(
                                  content:
                                      Text("Por favor llene todos los datos."),
                                  duration: Duration(seconds: 3),
                                  behavior: SnackBarBehavior.floating,
                                  action: SnackBarAction(
                                    label: "Aceptar",
                                    textColor: Colors.blue,
                                    onPressed: () {
                                      ScaffoldMessenger.of(context)
                                          .hideCurrentSnackBar();
                                    },
                                  ),
                                ),
                              );
                          }
                        },
                        color: Theme.of(context).primaryColor,
                        child: Text(
                          "Reseñar",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ));
  }
}
