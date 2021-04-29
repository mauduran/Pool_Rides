import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pool_rides/bloc/auth-bloc/auth_bloc.dart';

class SignUp2 extends StatefulWidget {
  SignUp2({
    Key key,
  }) : super(key: key);

  @override
  _SignUp2State createState() => _SignUp2State();
}

class _SignUp2State extends State<SignUp2> {
  int _radioButtonValue = 3;

  List<String> _formasTratamiento = [
    "Sra./Srta.",
    "Sr.",
    "Prefiero no decirlo",
  ];

  DateTime _date = DateTime.now().subtract(Duration(days: 365 * 18 + 5));

  var _phoneController = TextEditingController();

  void _selectDate() async {
    final DateTime newDate = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(1921, 1),
      lastDate: _date,
      helpText: 'Select a date',
    );

    if (newDate != null) {
      setState(() {
        _date = newDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, Object> receiveData =
        ModalRoute.of(context).settings.arguments;
    print(receiveData);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Registro",
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: 25,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "¿Qué forma de tratamiento te agrada más?",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22.5,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
                for (int count = 0; count < _formasTratamiento.length; count++)
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: Text(
                            '${_formasTratamiento[count]}',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          trailing: Radio(
                            value: count,
                            groupValue: _radioButtonValue,
                            onChanged: (newValue) {
                              setState(() {
                                _radioButtonValue = newValue;
                              });
                            },
                          ),
                          onTap: () {
                            setState(() {
                              _radioButtonValue = count;
                            });
                          },
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  right: 30.0,
                                  left: 15.0,
                                ),
                                child: Divider(
                                  color: Colors.black,
                                  thickness: 1.1,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "¿Cuál tu fecha de nacimiento?",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22.5,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: _selectDate,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Selecciona tu fecha'),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.date_range_outlined)
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Teléfono",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22.5,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 30.0, right: 30, top: 20),
                  child: TextField(
                    controller: _phoneController,
                    // cursorColor: Colors.red,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'Número móvil',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      suffixIcon: Icon(
                        Icons.phone,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 25),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 12.0,
                    ),
                    child: FloatingActionButton(
                      heroTag: "goBack",
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                      onPressed: () {
                        BlocProvider.of<AuthBloc>(context)
                            .add(ShowRegisterPageEvent());
                      },
                      child: Icon(
                        Icons.arrow_back,
                        size: 37,
                      ),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 12.0,
                    ),
                    child: FloatingActionButton(
                      heroTag: "register",
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                      onPressed: () {
                        var next =
                            _formasTratamiento[_radioButtonValue] != "" &&
                                _date.year > 0 &&
                                _phoneController.text != "";
                        if (next) {
                          BlocProvider.of<AuthBloc>(context)
                              .add(RegisterWithEmailEvent(
                            birthdate: _date,
                            phone: _phoneController.text,
                            title: _formasTratamiento[_radioButtonValue],
                          ));
                        } else {
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                              SnackBar(
                                content:
                                    Text("Por favor complete todos los campos"),
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
                      child: Icon(
                        Icons.check,
                        size: 37,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
