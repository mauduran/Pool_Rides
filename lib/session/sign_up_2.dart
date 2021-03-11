import 'package:flutter/material.dart';

class SignUp2 extends StatefulWidget {
  SignUp2({Key key}) : super(key: key);

  @override
  _SignUp2State createState() => _SignUp2State();
}

class _SignUp2State extends State<SignUp2> {
  bool _obscureText = true;
  bool _obscureText2 = true;
  int _radioButtonValue = 3;
  var _passwordController = TextEditingController();
  var _confirmPasswordController = TextEditingController();
  List<String> _formasTratamiento = [
    "Sra./Srta.",
    "Sr.",
    "Prefiero no decirlo",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Registro",
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
                  for (int count = 0;
                      count < _formasTratamiento.length;
                      count++)
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
                        "Necesitas una contraseña",
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
                      controller: _passwordController,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        labelText: 'Contraseña (mínimo 8 carácteres)',
                        // errorText: 'Error message',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.remove_red_eye),
                          color: Theme.of(context).primaryColor,
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                      ),
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
                        "Confirmar contraseña",
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
                      controller: _confirmPasswordController,
                      keyboardType: TextInputType.phone,
                      obscureText: _obscureText2,
                      decoration: InputDecoration(
                        labelText: 'Contraseña (mínimo 8 carácteres)',
                        // errorText: 'Error message',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.remove_red_eye),
                          color: Theme.of(context).primaryColor,
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText2;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: 12.0,
                    top: 6,
                  ),
                  child: FloatingActionButton(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                    onPressed: () {
                      // Respond to button press
                      // Navigator.pushAndRemoveUntil()  ----> Podría ser útil esto.
                      // Navigator.of(context).pushNamed("/home");
                      // Navigator.of(context).popAndPushNamed(
                      //   '/home',
                      // );

                      Navigator.of(context).pushNamedAndRemoveUntil(
                          "/home", ModalRoute.withName("/"));
                    },
                    child: Icon(
                      Icons.arrow_forward,
                      size: 37,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
