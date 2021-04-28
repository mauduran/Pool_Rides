import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pool_rides/bloc/auth-bloc/auth_bloc.dart';

class SignUp extends StatefulWidget {
  SignUp({Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var _emailController = TextEditingController();
  var _firstNameController = TextEditingController();
  var _lastNameController = TextEditingController();
  bool _obscureText = true;
  bool _obscureText2 = true;
  var _passwordController = TextEditingController();
  var _confirmPasswordController = TextEditingController();

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
                height: 15,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "¿Cómo te llamas?",
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
                      controller: _firstNameController,
                      decoration: InputDecoration(
                        labelText: 'Nombre(s)',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 30.0, right: 30, top: 25),
                    child: TextField(
                      controller: _lastNameController,
                      decoration: InputDecoration(
                        labelText: 'Apellido(s)',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
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
                        "¿Cuál es tu email?",
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
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        suffixIcon: Icon(
                          Icons.mail,
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
                height: 15,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 12.0,
                      ),
                      child: FloatingActionButton(
                        heroTag: "cancelRegister",
                        backgroundColor: Theme.of(context).primaryColor,
                        foregroundColor: Colors.white,
                        onPressed: () {
                          BlocProvider.of<AuthBloc>(context)
                              .add(CancelRegisterEvent());
                        },
                        child: Icon(
                          Icons.clear,
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
                        heroTag: "next",
                        backgroundColor: Theme.of(context).primaryColor,
                        foregroundColor: Colors.white,
                        onPressed: () {
                          BlocProvider.of<AuthBloc>(context).add(
                              ShowRegister2PageEvent(
                                  email: "email",
                                  password: "password",
                                  name: "name"));
                        },
                        child: Icon(
                          Icons.arrow_forward,
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
      ),
    );
  }
}
