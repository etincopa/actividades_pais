import 'dart:math';

import 'package:actividades_pais/src/datamodels/Clases/UserLocation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
//import 'package:sendsms/sendsms.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController controlerNombre = TextEditingController();
  // LoginDatdb _datdb = LoginDatdb();
  @override
  void initState() {
    //  getUsers();

    //  _datdb.initDB();
    setState(() {
      //  mostrarDatos();
    });

    super.initState();
  }

  /*void mostrarDatos() async {
    var abc = await _datdb.getAllTasks();
    var cantidad = abc.length;

    print(cantidad);
  }
 */

  bool loading = true;

  var tamboSnip;
  var tamboNombre;

  /*  userLocation = Provider.of<UserLocation>(context);
    send(titulo) async {
      String phoneNumber = "996095011";
      String phoneNumber2 = "958045426";
      String message =
          "$titulo / ${userLocation.latitude = 0.0} / ${userLocation.longitude = 0.0}";
      print(phoneNumber + message);

      if (await Sendsms.hasPermission()) {
        await Sendsms.onSendSMS(phoneNumber, message);

        await Sendsms.onSendSMS(phoneNumber2, message);
      }
    }  */

  final cajaRosa = Transform.rotate(
      angle: -pi / 5.0,
      child: Container(
        height: 360.0,
        width: 360.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(80.0),
            gradient:
                const LinearGradient(colors: [Color(0xFF3949AB), Color(0xFF3949AB)])),
      ));
  @override
  Widget build(BuildContext context) {
    var userLocation = Provider.of<UserLocation>(context);
    return SafeArea(
      child: Scaffold(
          backgroundColor: const Color(0xFF3949AB),
          body: SingleChildScrollView(
            child: Stack(children: [
              //  cajaRosa,
              Column(children: [
                Container(
                    margin: const EdgeInsets.only(
                        top: 50.0, left: 20, right: 20, bottom: 20),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Bienvenido ",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "APP OFLINE PAIS",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25),
                            ),
                          ],
                        )
                      ],
                    )),
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.only(
                        top: 35.0, left: 30, right: 30, bottom: 40),
                    child: Column(
                      children: [
                        card(),
                      ],
                    )),
              ]),
            ]),
          )),
    );
  }

  Widget card() {
    return Card(
      elevation: 19.0,
      color: Colors.white,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //  Image.asset(imagen, height: 90.0, width: 80.0),

            Column(
              children: [
                const SizedBox(
                  width: 10,
                  height: 20,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 10,
                      height: 20,
                    ),
                    Expanded(
                      child: SizedBox(
                        width: 290,
                        child: Text(
                            "Para registrar su asistencia seleccione el tambo a donde pertenece y de click en el boton guardar.",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 30,
                  height: 50,
                ),
                /*   Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 30),
                      child: Text("Seleccione TAMBO"),
                    )
                  ],
                ), */
                const SizedBox(
                  width: 10,
                  height: 20,
                ),
                /*   Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 5, right: 5),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xFF3949AB),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      width: 290,
                      child: textField,
                    )
                  ],
                ), */
                const SizedBox(
                  width: 10,
                  height: 20,
                ),
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 5, right: 5),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xFF3949AB),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      width: 290,
                      child: TextField(
                        controller: controlerNombre,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Ingrese su nombre completo'),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  width: 10,
                  height: 20,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF3949AB)),
                    child: const Text(
                      "Registrar",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      // Sendsms.onGetPermission();
                      if (controlerNombre.text == "" || tamboNombre == null) {
                        Fluttertoast.showToast(
                            msg: "Ingresar nombre o selecciona el tambo",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.grey,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      } else {
                        /*       var r = ConfigPersonal(
                          nombres: controlerNombre.text,
                          //    apellidoMaterno:con
                        );
                        //        _datdb.insert(r);
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (_) => asistencia())); */
                      }
                    }),
                const SizedBox(
                  width: 10,
                  height: 20,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
