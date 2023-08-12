import 'package:actividades_pais/src/pages/Login/Login.dart';
import 'package:actividades_pais/util/Constants.dart';
import 'package:actividades_pais/util/alert_question.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: use_key_in_widget_constructors
class AppBarPais extends StatefulWidget {
  String datoUt = "", nombre = "", plataforma;
  int snip;
  AppBarPais(
      {super.key,
      this.datoUt = "",
      this.nombre = "",
      this.snip = 0,
      this.plataforma = ''});
  @override
  _AppBarPaisState createState() => _AppBarPaisState();
}

class _AppBarPaisState extends State<AppBarPais> {
  SharedPreferences? _prefs;
  Future<void> loadPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Widget text() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            children: [
              const SizedBox(height: 15.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 70.0,
                    height: 70.0,
                    child: CircleAvatar(
                      backgroundColor: Colors.white.withOpacity(0.1),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          'assets/icons/icons8-male-user-100.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      if (widget.datoUt != "") ...[
                        SizedBox(
                          width: 200,
                          child: Text(
                            "UT : ${widget.datoUt}",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: Text(
                            "PLATAFORMA : ${widget.plataforma}",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ],
                      if (widget.nombre != "") ...[
                        SizedBox(
                          width: 200,
                          child: Text(
                            "USUARIO: ${widget.nombre ?? 'USUARIO INVITADO'}",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ]
                    ],
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.power_settings_new,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      final alert = AlertQuestion(
                        title: "Alerta!",
                        message: "¿Está seguro que desea cerrar la sesión?",
                        onNegativePressed: () async {
                          SharedPreferences preferences =
                              await SharedPreferences.getInstance();
                          await preferences.clear();
                          Navigator.of(context).pop();
                        },
                        onPostivePressed: () async {
                          await loadPreferences();
                          if (_prefs != null) {
                            _prefs!.setString("clave", "");
                            _prefs!.setString("nombres", "");
                            _prefs!.setString("codigo", "");
                            _prefs!.setString("rol", "");
                          }

                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const LoginPage()),
                            (route) => false,
                          );
                        },
                      );

                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return alert;
                        },
                      );
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double dRadiusTop = 0; //50;
    double dHeight = 300;
    double dTop = 150;

    Color bgColor = Colors.white;

    double z = dHeight - dTop;
    return Scaffold(
      backgroundColor: bgColor,
      body: Container(
        height: dHeight,
        color: rojo,
        child: Stack(
          children: [
            if (text() != null) text(),
            Column(
              children: [
                Container(
                  height: z,
                  margin: EdgeInsets.only(top: dTop),
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(dRadiusTop)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 5,
                        spreadRadius: 0.2,
                        offset:
                            const Offset(0.5, -8), // changes position of shadow
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
