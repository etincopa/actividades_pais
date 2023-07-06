import 'package:actividades_pais/main.dart';
import 'package:actividades_pais/src/datamodels/Clases/ConfigPersonal.dart';
import 'package:actividades_pais/src/datamodels/Formulario/FormularioReq.dart';
import 'package:actividades_pais/src/datamodels/Servicios/Servicios.dart';
import 'package:actividades_pais/src/datamodels/database/DatabasePr.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../datamodels/Provider/ProviderConfiguracion.dart';

class ConfiguracionPersonal extends StatefulWidget {
  String unidad = '';

  ConfiguracionPersonal({super.key, 
    this.unidad = '',
  });

  @override
  _ConfiguracionPersonal createState() => _ConfiguracionPersonal();
}

class _ConfiguracionPersonal extends State<ConfiguracionPersonal> {
  final TextEditingController _controllerNDocumento = TextEditingController();
  final TextEditingController _controllerApPaterno = TextEditingController();
  final TextEditingController _controllerApMaterno = TextEditingController();
  final TextEditingController _controllerNombres = TextEditingController();
  final TextEditingController _controllerContrasenia = TextEditingController();
  final TextEditingController _controllerfecha = TextEditingController();
  var formatter = DateFormat('yyyy-MM-dd');
  DateTime? nowfec = DateTime.now();
  Servicios servicios = Servicios();
  var _isloading = false;
  var _isloadingSave = false;
  var espacio = const SizedBox(height: 10.0);

  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {});
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.blue[800],
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("CONFIGURACION PERSONAL"),
              ],
            )),
        body: SingleChildScrollView(
          child: Container(
              margin: const EdgeInsets.all(25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FormularioReq().textinputdet(
                      "NUMERO DNI",
                      _controllerNDocumento,
                      TextCapitalization.words,
                      TextInputType.number, true),
                  espacio,
                  Container(
                    decoration: servicios.myBoxDecoration(),
                    margin: const EdgeInsets.only(right: 0, left: 0),
                    height: 40.0,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[600],
                        ),
                        child: _isloading
                            ? const Row(
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 24,
                            ),
                            Text(
                              '...!!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.white),
                            )
                          ],
                        )
                            :const Text(
                          'Consultar',
                          style: TextStyle(
                              fontSize: 19,
                              color: Colors.white),
                        ),
                        onPressed: () async {
                          setState(() {
                            _isloading = true;
                          });
                          setState(() {
                            _controllerNombres.clear();
                            _controllerApPaterno.clear();
                            _controllerApMaterno.clear();
                            _controllerfecha.clear();
                          });

                          var usuario =
                          await ProviderConfiguracion()
                              .buscarUsuarioDni(
                              _controllerNDocumento.text);
                          print(usuario.primerNombre);
                          if(!usuario.isNull){
                            _controllerNombres.text="${usuario.primerNombre} ${usuario.segundoNombre}";
                            _controllerApPaterno.text=usuario.apellidoPaterno.toString();
                            _controllerApMaterno.text=usuario.apellidoMaterno.toString();
                            _controllerfecha.text=usuario.fechaNacimiento.toString();
                          }
                          setState(() {
                            _isloading = false;
                          });
                        }),
                  ),
                  FormularioReq().textinputdet("NOMBRES", _controllerNombres,
                      TextCapitalization.words, TextInputType.text, true),
                  FormularioReq().textinputdet(
                      " APELLIDO PATERNO",
                      _controllerApPaterno,
                      TextCapitalization.words,
                      TextInputType.text, true),
                  FormularioReq().textinputdet(
                      " APELLIDO MATERNO",
                      _controllerApMaterno,
                      TextCapitalization.words,
                      TextInputType.text, true),
                  Container(
                    //  decoration: servicios.myBoxDecoration(),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Por favor ingrese dato.';
                        }
                        return null;
                      },
                      onTap: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: nowfec!,
                          firstDate: DateTime(2015, 8),
                          lastDate: DateTime(2101),
                        );

                        if (picked != null) {
                          setState(() {
                            _controllerfecha.text
                                .replaceAll('', formatter.format(picked));
                            _controllerfecha.text = formatter.format(picked);
                          });
                        }
                      },
                      textAlign: TextAlign.justify,
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.words,
                      controller: _controllerfecha,
                      enabled: true,
                      decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF0EA1E8)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF0EA1E8)),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF0EA1E8)),
                          ),
                          labelText: "Fecha Nacimiento"),
                    ),
                  ),
                  FormularioReq().textinputdet(
                      " CONTRASEÑA",
                      _controllerContrasenia,
                      TextCapitalization.words,
                      TextInputType.text, true),
                  espacio,
                  Container(
                    decoration: servicios.myBoxDecoration(),
                    height: 40,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[600],
                        ),
                        child: _isloadingSave
                            ? const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 24,
                                  ),
                                  Text(
                                    'Registrando...',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 17, color: Colors.white),
                                  )
                                ],
                              )
                            : const Text(
                                'Guardar',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 19, color: Colors.white),
                              ),
                        onPressed: () async {
                          if (_controllerNombres.text == "" ||
                              _controllerApPaterno.text == "" ||
                              _controllerApMaterno.text == "" ||
                              _controllerContrasenia.text == "" ||
                              _controllerNDocumento.text == "") {
                            Fluttertoast.showToast(
                                msg: "Ingresar Datos",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.grey,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          } else {
                            if (_isloadingSave) return;
                            setState(() {
                              _isloadingSave = true;
                            });

                            var r = ConfigPersonal(
                                unidad: widget.unidad,
                                nombres: _controllerNombres.text,
                                apellidoMaterno: _controllerApMaterno.text,
                                apellidoPaterno: _controllerApPaterno.text,
                                contrasenia: _controllerContrasenia.text,
                                fechaNacimento: _controllerfecha.text,
                                numeroDni:
                                    int.parse(_controllerNDocumento.text));

                            await DatabasePr.db.insertConfigPersonal(r);
                            await Future.delayed(const Duration(seconds: 2));

                            setState(() {
                              _isloadingSave = false;
                            });
                            if (_isloadingSave == false) {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (_) => const LoadingScreen()));
                            }
                          }
                        }),
                  )
                ],
              )),
        ));
  }
}
