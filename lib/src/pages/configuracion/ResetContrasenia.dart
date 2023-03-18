import 'package:actividades_pais/main.dart';
import 'package:actividades_pais/src/datamodels/Clases/ConfigPersonal.dart';
import 'package:actividades_pais/src/datamodels/Provider/PorviderLogin.dart';
import 'package:actividades_pais/src/datamodels/Servicios/Servicios.dart';
import 'package:actividades_pais/src/datamodels/database/DatabasePr.dart';
import 'package:actividades_pais/src/pages/Login/Login.dart';
import 'package:actividades_pais/util/app-config.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../datamodels/Formulario/FormularioReq.dart';
import 'package:intl/intl.dart';

class ResetContrasenia extends StatefulWidget {
  @override
  State<ResetContrasenia> createState() => _ResetContraseniaState();
}

class _ResetContraseniaState extends State<ResetContrasenia> {
  /// const ResetContrasenia({Key? key}) : super(key: key);
  TextEditingController _controllerCorreoElectronico = TextEditingController();

  Servicios servicios = new Servicios();
  var formatter = new DateFormat('yyyy-MM-dd');
  DateTime? nowfec = new DateTime.now();

  var _isloading = false;
  var _mostrar = true;
  var idUsuario;

  String nombresUsuario = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text(
              "Olvido su contraseña",
              style: TextStyle(fontSize: 20),
            ),
            centerTitle: true,
            backgroundColor: AppConfig.primaryColor),
        body: SingleChildScrollView(
          child: Container(
              margin: const EdgeInsets.all(25),
              child: Column(
                children: [
                  (_mostrar == true)
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const SizedBox(
                              height: 15.0,
                            ),
                            FormularioReq().textinputdet(
                                "Correo Electronico",
                                _controllerCorreoElectronico,
                                TextCapitalization.words,
                                TextInputType.emailAddress,
                                true),
                            const SizedBox(height: 20.0),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 2.0, color: AppConfig.primaryColor),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(
                                        11) //                 <--- border radius here
                                    ),
                              ),
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: AppConfig.primaryColor,
                                  ),
                                  child: _isloading
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            CircularProgressIndicator(
                                              color: Colors.white,
                                            ),
                                            SizedBox(
                                              width: 24,
                                            ),
                                            Text(
                                              '...',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.white),
                                            )
                                          ],
                                        )
                                      : const Text(
                                          'ENVIAR LINK',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 19,
                                              color: Colors.white),
                                        ),
                                  onPressed: () async {
                                    if (_controllerCorreoElectronico.text == "") {
                                      Fluttertoast.showToast(
                                          msg: "Ingresar un correo electronico valido",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.grey,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    } else {
                                      if (_isloading) return;
                                      setState(() {
                                        _isloading = true;
                                      });

                                      var reponse = await ProviderLogin()
                                          .forgotPassword(
                                          _controllerCorreoElectronico.text);
                                      if (reponse == true) {
                                         setState(() {
                                          _mostrar = false;
                                          _isloading = false;
                                        });
                                      }

                                    }
                                  }),
                            )
                          ],
                        )
                      : new Container(),
                  (_mostrar == false)
                      ? Column(children: const [
                          Text("Ya falta poco!",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold)),
                          SizedBox(height: 20.0),
                          Text(
                              textAlign: TextAlign.center,
                              "Revise su correo electrónico para obtener un enlace\npara restablecer su contraseña. Si no aparece en\n unos pocos minutos, verifique su carpeta de correo\n no deseado.\n Este correo no tendra valor dentro de una hora."),
                          SizedBox(height: 20.0),
                        ])
                      : new Container(),
                  const SizedBox(height: 20.0),
                  InkWell(
                    child: const Text("Volver al Inicio de sesión",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue)),
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => LoginPage()),
                      );
                    },
                  )
                ],
              )),
        ));
  }
}
