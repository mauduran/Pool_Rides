import 'package:flutter/material.dart';
import 'package:pool_rides/models/user.dart';

class ChangeDescription extends StatefulWidget {
  final User user;

  ChangeDescription({Key key, @required this.user}) : super(key: key);

  @override
  _ChangeDescriptionState createState() => _ChangeDescriptionState();
}

class _ChangeDescriptionState extends State<ChangeDescription> {
  var _biographyController = TextEditingController();
  void initState() {
    super.initState();
    _biographyController.text = widget.user.biography;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
            child: Text(
              "¿Qué te gustaría que supieran de ti los demás?",
              style: Theme.of(context).textTheme.headline5.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontSize: 27.5,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              child: TextField(
                maxLines: 8,
                controller: _biographyController,
                decoration: InputDecoration(
                  labelText: 'Biografía',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 125,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      height: 50,
                      color: Color.fromARGB(255, 51, 174, 250),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.done,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Cambiar",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 17.5,
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {
                        if (widget.user.biography !=
                            _biographyController.text) {
                          Navigator.of(context).pop({
                            "changed": true,
                            "newBiography": _biographyController.text,
                          });
                        } else {
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                              SnackBar(
                                content: Text(
                                    "Por favor ingrese una biografía nueva"),
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
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
