import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PrincipalSignIn extends StatefulWidget {
  PrincipalSignIn({Key key}) : super(key: key);

  @override
  _PrincipalSignInState createState() => _PrincipalSignInState();
}

class _PrincipalSignInState extends State<PrincipalSignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Color(0xff303e50),
        child: Center(
          child: Column(
            children: [
              Container(
                  child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                    Color(0xFF4C5256).withOpacity(0.3), BlendMode.srcOver),
                child: Image(
                  image: AssetImage(
                    "assets/images/Car_Pool-min.jpeg",
                  ),
                ),
              )),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Theme.of(context).primaryColorDark,
                        Color(0xFF4C5256),
                      ],
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Pool Rides",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Text(
                          "¿Cómo quieres iniciar sesión?",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                          textAlign: TextAlign.justify,
                        ),
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
                                      borderRadius:
                                          BorderRadius.circular(100.0)),
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
                                        "Continuar con tu e-mail",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pushNamed("/SignIn");
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
                                      borderRadius:
                                          BorderRadius.circular(100.0)),
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
                                      borderRadius:
                                          BorderRadius.circular(100.0)),
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
                              "¿Todavía no tienes una cuenta?",
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
                                'Registrate',
                                style: TextStyle(
                                  color: Color(0xffe0e6eb),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              onTap: () {
                                Navigator.of(context).pushNamed("/SignUp");
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
