import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class PrincipalSignUp extends StatefulWidget {
  PrincipalSignUp({Key key}) : super(key: key);

  @override
  _PrincipalSignUpState createState() => _PrincipalSignUpState();
}

class _PrincipalSignUpState extends State<PrincipalSignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Pool Rides"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Color(0xff303e50),
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Container(
                  height: 175,
                  width: 175,
                  child: Image(
                    image: AssetImage("assets/images/car_icon.png"),
                  ),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0, top: 5),
                    child: Text(
                      "¿Cómo quieres registrarte?",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 27.5,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 45,
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100.0)),
                          height: 50,
                          // color: Color(0xff0066ff),
                          // color: Colors.blue[600],
                          color: Color.fromARGB(255, 51, 174, 250),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 70,
                              ),
                              Icon(
                                Icons.email_outlined,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Regístrate con tu e-mail",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                          onPressed: () {
                            Navigator.of(context).pushNamed("/SignUp");
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
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100.0)),
                          height: 50,
                          color: Color(0xFF3b5998),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 60,
                              ),
                              SvgPicture.asset(
                                "assets/images/icon_Facebook.svg",
                                color: Colors.white,
                              ),
                              Text(
                                "Continuar con Facebook",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100.0)),
                          height: 50,
                          color: Colors.white,
                          // color: Color(0xFFf5f5e1),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 70,
                              ),
                              SvgPicture.asset(
                                "assets/images/icon_google.svg",
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Continuar con Google",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 45,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0, top: 5),
                    child: Text(
                      "¿Ya tienes una cuenta?",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontSize: 22.5,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: InkWell(
                      child: new Text(
                        'Inciar Sesión',
                        style: TextStyle(
                          color: Color(0xffe0e6eb),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).pushNamed("/PrincipalSignIn");
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
