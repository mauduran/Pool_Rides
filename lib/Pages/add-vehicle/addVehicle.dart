import 'package:flutter/material.dart';
import 'package:pool_rides/utils/lists.dart';

class AddVehiclePage extends StatefulWidget {
  AddVehiclePage({Key key}) : super(key: key);

  @override
  _AddVehiclePageState createState() => _AddVehiclePageState();
}

class _AddVehiclePageState extends State<AddVehiclePage> {
  var _marcaController = TextEditingController();
  var _modeloController = TextEditingController();
  var _placasController = TextEditingController();
  var _colorController = TextEditingController();
  var _yearController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25.0,
                vertical: 5,
              ),
              child: Text(
                "¿Cuál es la marca de tu vehículo?",
                style: Theme.of(context).textTheme.headline4,
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
                style: Theme.of(context).textTheme.headline4,
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
                style: Theme.of(context).textTheme.headline4,
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
              height: 15,
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
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20.0,
                          right: 20.0,
                          top: 10,
                        ),
                        child: TextField(
                          controller: _colorController,
                          decoration: InputDecoration(
                            labelText: 'Color',
                            hintText: "Ejemplo: Blanco",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                        ),
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
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20.0,
                          right: 20.0,
                          top: 10,
                        ),
                        child: TextField(
                          controller: _yearController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Año',
                            hintText: "Ejemplo: 2019",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              width: double.infinity,
              height: 90,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: ElevatedButton(
                  onPressed: () {
                    // Navigator.of(context).popUntil((route) => route.isFirst);
                    // BlocProvider.of<AuthBloc>(context).add(SignOutAuthEvent());
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
      ),
    );
  }
}
