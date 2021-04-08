import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pool_rides/bloc/vehicle-bloc/vehicle_bloc.dart';
import 'package:pool_rides/models/car.dart';

class AddVehiclePage extends StatefulWidget {
  AddVehiclePage({Key key}) : super(key: key);

  @override
  _AddVehiclePageState createState() => _AddVehiclePageState();
}

class _AddVehiclePageState extends State<AddVehiclePage> {
  VehicleBloc _vehicleBloc;
  File selectedImage;
  bool isNewImage;
  var _marcaController = TextEditingController();
  var _modeloController = TextEditingController();
  var _placasController = TextEditingController();

  List<DropdownMenuItem<ListItem>> _dropdownColors;
  ListItem _colorSelected;

  List<DropdownMenuItem<ListItem>> _dropdownYears;
  ListItem _yearSelected;

  List<DropdownMenuItem<ListItem>> buildColorDropdown() {
    List<DropdownMenuItem<ListItem>> items = [];
    List<String> colors = [
      "Blanco",
      "Negro",
      "Gris",
      "Plata",
      "Azul",
      "Beige",
      "Rojo",
      "Verde"
    ];

    for (int i = 0; i < colors.length; i++) {
      items.add(
        DropdownMenuItem(
          child: Text(colors[i]),
          value: ListItem(
            name: colors[i],
            value: i,
          ),
        ),
      );
    }
    return items;
  }

  List<DropdownMenuItem<ListItem>> buildYearDropdown() {
    List<DropdownMenuItem<ListItem>> items = [];

    String _currentYearStr = DateFormat('y').format(DateTime.now());
    int _currentYear = int.parse(_currentYearStr);

    for (int i = _currentYear - 6, j = 0; i < _currentYear + 1; i++, j++) {
      items.add(
        DropdownMenuItem(
          child: Text("$i"),
          value: ListItem(
            name: "$i",
            value: i,
          ),
        ),
      );
    }
    return items;
  }

  void initState() {
    super.initState();
    _dropdownColors = buildColorDropdown();
    _colorSelected = _dropdownColors[0].value;

    _dropdownYears = buildYearDropdown();
    _yearSelected = _dropdownYears[_dropdownYears.length - 1].value;
    isNewImage = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) {
          _vehicleBloc = VehicleBloc();
          return _vehicleBloc;
        },
        child: BlocConsumer<VehicleBloc, VehicleState>(
          listener: (context, state) {
            if (state is ErrorState) {
              showErrorDialog(context, state);
            } else if (state is UpdatedSuccesfully) {
              selectedImage = null;
              isNewImage = false;
              _marcaController.clear();
              _modeloController.clear();
              _placasController.clear();
              _colorSelected = _dropdownColors[0].value;
              _yearSelected = _dropdownYears[_dropdownYears.length - 1].value;
              showDialogCustomized(
                context,
                "Operación exitosa:",
                "Los datos fueron actualizados correctamente.",
                state.newCar,
              );
            } else if (state is NewImageState) {
              selectedImage = state.image;
              isNewImage = state.isNewImage;
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25.0,
                      vertical: 10,
                    ),
                    child: Text(
                      "¿Cuál es la marca de tu vehículo?",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                      right: 20.0,
                      top: 10,
                    ),
                    child: TextField(
                      controller: _marcaController,
                      decoration: InputDecoration(
                        labelText: 'Marca',
                        hintText: "Ejemplo: Chevrolet",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25.0,
                      vertical: 5,
                    ),
                    child: Text(
                      "¿Cuál es el modelo?",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                      right: 20.0,
                      top: 10,
                    ),
                    child: TextField(
                      controller: _modeloController,
                      decoration: InputDecoration(
                        labelText: 'Modelo',
                        hintText: "Ejemplo: Cruze",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25.0,
                      vertical: 5,
                    ),
                    child: Text(
                      "Ingresa las placas de tu vehiculo",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                      right: 20.0,
                      top: 10,
                    ),
                    child: TextField(
                      controller: _placasController,
                      decoration: InputDecoration(
                        labelText: 'Placas',
                        hintText: "Ejemplo: ABC - 00 - 00",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 25.0,
                                vertical: 5,
                              ),
                              child: Text(
                                "Color",
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 20.0,
                                      right: 20.0,
                                      top: 10,
                                    ),
                                    child: DropdownButton<ListItem>(
                                      items: _dropdownColors,
                                      value: _colorSelected,
                                      onChanged: (newValue) {
                                        _colorSelected = newValue;
                                        setState(() {});
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 25.0,
                                vertical: 5,
                              ),
                              child: Text(
                                "Año",
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 20.0,
                                      right: 20.0,
                                      top: 10,
                                    ),
                                    child: DropdownButton<ListItem>(
                                      items: _dropdownYears,
                                      value: _yearSelected,
                                      onChanged: (newValue) {
                                        _yearSelected = newValue;
                                        setState(() {});
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (isNewImage) carShower(selectedImage: selectedImage),
                  GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 30.0,
                        top: 20,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.car_rental,
                            size: 25,
                            color: Theme.of(context).primaryColor,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            isNewImage
                                ? "Cambiar foto de tu coche"
                                : "Añadir foto de tu coche",
                            style: TextStyle(
                              fontSize: 20,
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('Imagen de tu coche'),
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
                                        color:
                                            Color.fromARGB(255, 51, 174, 250),
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
                                              "¡Tomale una foto!",
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
                                          _vehicleBloc
                                              .add(ChangeImageByPhotoEvent());
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
                                          _vehicleBloc
                                              .add(ChangeImageByGalleryEvent());
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
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 90,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_marcaController.text != "" &&
                              _modeloController.text != "" &&
                              _placasController.text != "" &&
                              isNewImage == true) {
                            _vehicleBloc.add(
                              UpdatedVehicleInformation(
                                brand: _marcaController.text,
                                model: _modeloController.text,
                                plates: _placasController.text,
                                year: _yearSelected.value,
                                image: selectedImage,
                                color: _colorSelected.name,
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(
                                SnackBar(
                                  content: Text(
                                      "Por favor complete todos los campos"),
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
                        child: Text(
                          "Añadir Vehiculo",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget carShower({
    @required File selectedImage,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Container(
        height: 150.0,
        width: 300.0,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: FileImage(selectedImage),
            fit: BoxFit.fill,
          ),
          // shape: BoxShape.circle,
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

  Future showDialogCustomized(
    BuildContext context,
    String title,
    String content,
    Car carValue,
  ) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop([true, carValue]);
                },
                child: Text("Aceptar"),
              )
            ],
          );
        });
  }
}

class ListItem {
  final int value;
  final String name;

  ListItem({
    @required this.value,
    @required this.name,
  });
}
