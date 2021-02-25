import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class Principal extends StatefulWidget {
  Principal({Key key}) : super(key: key);

  @override
  _PrincipalState createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inicio"),
      ),
      body: Center(
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
                        color: Theme.of(context).primaryColor,
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
                        onPressed: () {},
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
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
              height: 15,
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
                        color: Color(0xFFf5f5e1),
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
                      fontWeight: FontWeight.bold,
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
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
