import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pool_rides/Pages/add-vehicle/addVehicle.dart';
import 'package:pool_rides/Pages/change-description/ChangeDescription.dart';
import 'package:pool_rides/Pages/change-phone-number/ChangePhoneNumber.dart';
import 'package:pool_rides/bloc/auth-bloc/auth_bloc.dart';
import 'package:pool_rides/bloc/user-bloc/user_bloc.dart';
import 'package:pool_rides/models/car.dart';
import 'package:pool_rides/models/user.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pool_rides/Pages/reviews/ReviewsPage.dart';
import 'package:intl/date_symbol_data_local.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  UserBloc _userBloc;
  File userImage;
  bool existCar;
  Car userCar;

  double averageRating = 0;
  int numOfReviews = 0;
  @override
  void initState() {
    super.initState();

    initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) {
          _userBloc = UserBloc()..add(GetUserEvent());
          return _userBloc;
        },
        child: BlocConsumer<UserBloc, UserState>(
          listener: (context, state) {
            if (state is ErrorState) {
              showErrorDialog(context, state);
            }
          },
          builder: (context, state) {
            if (state is UserFoundState) {
              return RefreshIndicator(
                onRefresh: () async {
                  _userBloc.add(GetUserEvent(update: true));
                  return;
                },
                child: _userWidget(
                  userBloc: _userBloc,
                  userImage: state.currentUser.image,
                  user: state.currentUser,
                  userCar: state.currentUser.car,
                ),
              );
            } else
              return Center(
                child: CircularProgressIndicator(),
              );
          },
        ),
      ),
    );
  }

  Future showErrorDialog(BuildContext context, ErrorState state) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Parece que algo ha salido mal: '),
            content: Text('${state.errorEasy}'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Aceptar"),
              )
            ],
          );
        });
  }

  Widget carInformation({
    @required Car car,
  }) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 30.0,
        right: 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    car.model ?? "Modelo no especificado",
                    style: TextStyle(
                      fontSize: 17.5,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "${car.color ?? 'Color no especificado'}", // To Do: agregar el atributo "No. de reseñas en conductor"
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  )
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                        car.image != ""
                            ? car.image
                            : "https://i.pinimg.com/originals/c0/0b/69/c00b692e9820c3970e907eae9bf2be25.png",
                      ),
                      maxRadius: 22.5,
                      backgroundColor: Colors.grey[300],
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_right,
                    size: 27.5,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 5,
          )
        ],
      ),
    );
  }

  Widget _userWidget({
    @required UserBloc userBloc,
    @required String userImage,
    @required User user,
    @required Car userCar,
  }) {
    numOfReviews = user.totalReviews;
    averageRating = user.totalStars / numOfReviews;

    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 25,
            ),
            CircleAvatar(
              backgroundImage: NetworkImage(
                userImage,
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
                "${user.age ?? 18} años",
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
                "${user.biography}",
                style: TextStyle(
                  fontSize: 17.5,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 30,
                right: 30,
              ),
              child: Text(
                "${user.phoneNumber ?? "Sin número"}",
                style: TextStyle(
                  fontSize: 17.5,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Cambia tu imagen de perfil'),
                            SizedBox(
                              height: 10,
                            ),
                            Divider(
                              thickness: 1.5,
                              color: Theme.of(context).primaryColor,
                            ),
                          ],
                        ),
                        titlePadding: EdgeInsets.only(
                          top: 20.0,
                        ),
                        content: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: MaterialButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(100.0)),
                                  height: 50,
                                  color: Color.fromARGB(255, 51, 174, 250),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Icon(
                                        Icons.camera_alt,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "¡Tomate una foto!",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                  onPressed: () {
                                    //bloc
                                    _userBloc
                                        .add(ChangeAccountImageByPhotoEvent());
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: MaterialButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(100.0)),
                                  height: 50,
                                  color: Theme.of(context).primaryColor,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Icon(
                                        Icons.camera,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Selecciona una foto",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                  onPressed: () {
                                    //_userBloc
                                    _userBloc.add(
                                        ChangeAccountImageByGalleryEvent());
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              "Aceptar",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      );
                    });
              },
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 30.0,
                  top: 20,
                  bottom: 10,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.face,
                      size: 25,
                      color: Theme.of(context).primaryColor,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Editar foto de perfil",
                      style: TextStyle(
                        fontSize: 17.5,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                Map<String, dynamic> result = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ChangePhoneNumber(user: user),
                  ),
                );

                if (result != null) {
                  _userBloc.add(
                    ChangePhoneNumberEvent(
                      phoneNumber: result["newPhoneNumber"],
                    ),
                  );
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 30.0,
                  top: 5,
                  bottom: 5,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.phone,
                      size: 25,
                      color: Theme.of(context).primaryColor,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      user.phoneNumber != null
                          ? "Editar telefono"
                          : "Agregar telefono",
                      style: TextStyle(
                        fontSize: 17.5,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                Map<String, dynamic> result = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ChangeDescription(user: user),
                  ),
                );

                if (result != null) {
                  _userBloc.add(
                    ChangeBiographyEvent(newBiography: result["newBiography"]),
                  );
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 30.0,
                  top: 10,
                  bottom: 15,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.description,
                      size: 25,
                      color: Theme.of(context).primaryColor,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Editar biografía",
                      style: TextStyle(
                        fontSize: 17.5,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ReviewsPage(
                      uid: user.uid,
                    ),
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
                              ? "No hay reseñas aún"
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
            if (userCar != null) carInformation(car: userCar),
            GestureDetector(
              onTap: () async {
                var result = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AddVehiclePage(),
                  ),
                );
                if (result != null) {
                  userBloc.add(LoadCarEvent());
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 30.0,
                  top: 10,
                  bottom: 10,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.car_repair,
                      size: 22.5,
                      color: Theme.of(context).primaryColor,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      userCar != null ? "Cambiar auto" : "Añadir auto",
                      style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
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
              width: double.infinity,
              height: 90,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                    BlocProvider.of<AuthBloc>(context).add(SignOutAuthEvent());
                  },
                  child: Text(
                    "Cerrar Sesión",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
