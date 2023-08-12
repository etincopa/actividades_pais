/*import 'package:actividades_pais/main.dart';
import 'package:actividades_pais/src/datamodels/Clases/ConfigPersonal.dart';
import 'package:actividades_pais/src/datamodels/Clases/ConsultarTambosPiasxUnidadTerritorial.dart';
import 'package:actividades_pais/src/datamodels/Clases/Pias/Campania.dart';
import 'package:actividades_pais/src/datamodels/Clases/tipoPlataforma.dart';
import 'package:actividades_pais/src/datamodels/Provider/Pias/ProviderDataJson.dart';
import 'package:actividades_pais/src/datamodels/Provider/Pias/ProviderServiciosRest.dart';
import 'package:actividades_pais/src/datamodels/Provider/Provider.dart';
import 'package:actividades_pais/src/datamodels/Provider/ProviderConfiguracion.dart';
import 'package:actividades_pais/src/datamodels/Provider/ProviderServicios.dart';
import 'package:actividades_pais/src/datamodels/Servicios/Servicios.dart';
import 'package:actividades_pais/src/datamodels/Clases/ConfigInicio.dart';
import 'package:actividades_pais/src/datamodels/Clases/LugarPrestacion.dart';
import 'package:actividades_pais/src/datamodels/Clases/Puesto.dart';
import 'package:actividades_pais/src/datamodels/Clases/UnidadesOrganicas.dart';
import 'package:actividades_pais/src/datamodels/Clases/UnidadesTerritoriales.dart';
import 'package:actividades_pais/src/datamodels/database/DatabasePias.dart';
import 'package:actividades_pais/src/datamodels/database/DatabasePr.dart';
import 'package:actividades_pais/src/pages/Login/Login.dart';
import 'package:actividades_pais/src/pages/configuracion/pantallainicio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:actividades_pais/src/pages/Intervenciones/util/utils.dart';
import 'package:actividades_pais/src/pages/configuracion/ConfiguracionPersonal.dart';

import '../../datamodels/Clases/Unidad.dart';
import '../../datamodels/Formulario/FormularioReq.dart';
import 'dart:ui';
import 'package:intl/intl.dart';

class ConfiguracionInicial extends StatefulWidget {
  @override
  _ConfiguracionInicial createState() => _ConfiguracionInicial();
}

class _ConfiguracionInicial extends State<ConfiguracionInicial> {
  List data = []; //edited line
  List tablaPlataforma = []; //edited line
  List unidadesOrganicas = []; //edited line
  List unidadesTerritoriales = []; //edited line
  var userLocation;

  Servicios servicios = new Servicios();
  ProviderServicios providerServicios = new ProviderServicios();

  var now = new DateTime.now();

  Color primaryColor = const Color(0xFFFFD428);

  var tamboSnip;
  var tamboNombre;

  var variable1;
  var nmbrevaeuable;

  var puestoId;
  var puestoNombre;

  var utId;
  var utNombre;

  var seleccionarUnidad = "SELECCIONAR UNIDAD";
  var seleccionarUnidOrganicas = "SELECCIONAR UNIDAD ORGANICA";

  var seleccionarUnidTerritoriales = "SELECCIONAR UNIDAD TERRITORIAL";
  var seleccionarTpPla = "SELECCIONAR TIPO PLATAFORMA";

  var seleccionarTablaPlataforma = "SELECIONAR PLATAFORMA";

  var seleccionarLugarPrestacion = "SELECIONAR LUGAR PRESTACION";

  var seleccionarPuesto = "SELECIONAR PUESTO";

  var seleccionarCamapania = "SELECIONAR CAMPAÑA";

  var tablaid = 1;
  var codCampania = 0;
  var campania = '';

  var idseleccionarLugarPrestacion = 1;
  var tamanio2 = 0.0;
  var tamanioboton = 0.0;
  var tamanio3 = 0.0;
  var tamaniopuesto = 0.0;

  var idLugarPrestacion = 0;
  var idPuesto = 0;
  var idTambo = 0;

  var idUnidTerritoriales = 0;
  var idUnidadesOrganicas = 0;

  var lugarPrestacion = "";
  var nombrePuesto = "";
  var nombreTambo = "";
  var nombreUnidTerritoriales = "";
  var nombreUnnidadesOrganicas = "";
  var snip = 0;

  var tamanioCampania = 0.0;
  var nombreUt = '';
  var modalidad = '';

  var _isloading = false;
  var _istrue = false;
  var _istrueUps = false;
  var _isActive = false;
  TextEditingController _controllerContrasenia = TextEditingController();
  TextEditingController _controllerUsuario = TextEditingController();
  TextEditingController _controllerCodPersonal = TextEditingController();
  TextEditingController _controllerNombres = TextEditingController();
  TextEditingController _controllerRol = TextEditingController();
  TextEditingController _controllerfecha = TextEditingController();

  var underlineCbo = Container(
    height: 1,
    color: Color(0xFF1E88E5),
  );
  DateTime? nowfec = new DateTime.now();
  var formatter = new DateFormat('yyyy-MM-dd');
  final _formKeyUps = GlobalKey<FormState>();

  @override
  void initState() {
    ProviderDatos().verificacionpesmiso();
    providerServicios.requestSqlData();
    providerServicios.getTipoDocumento();
    setState(() {});
    super.initState();
    ProviderDataJson().getCamapanias();
  }

  var tamanio = 0.0;

  @override
  Widget build(BuildContext context) {
    setState(() {});
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.blue[600],
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("CONFIGURACION INICIAL"),
              ],
            )),
        body: SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 50.0,
                    child: Container(
                      margin: EdgeInsets.only(),
                      child: FutureBuilder<List<Unidad>>(
                        future: ProviderServicios().getUnidad(),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<Unidad>> snapshot) {
                          Unidad depatalits;
                          if (!snapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          final preguntas = snapshot.data;
                          if (preguntas!.length == 0) {
                            return Center(
                              child: Text("sin dato"),
                            );
                          } else {
                            return Container(
                                // decoration: servicios.myBoxDecoration(),
                                child: DropdownButton<Unidad>(
                              underline: underlineCbo,
                              isExpanded: true,
                              items: snapshot.data
                                  ?.map((user) => DropdownMenuItem<Unidad>(
                                        child: Text(user.descripcion),
                                        value: user,
                                      ))
                                  .toList(),
                              onChanged: (Unidad? newVal) {
                                setState(() {
                                  depatalits = newVal!;
                                  seleccionarUnidad = newVal.descripcion;
                                  if (newVal.descripcion == 'UPS') {
                                    _istrue = false;
                                    _istrueUps = true;
                                  } else if (newVal.descripcion == 'UAGS') {
                                    _istrue = true;
                                    _istrueUps = false;
                                  }
                                });
                              },
                              hint: Row(children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Text("$seleccionarUnidad",
                                    style: TextStyle(color: Colors.black))
                              ]),
                            ));
                          }
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  (_istrue == true)
                      ? Column(
                          children: [
                            Container(
                              child: FutureBuilder<List<LugarPrestacion>>(
                                future: DatabasePr.db.getTodosLugarPrestacion(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<List<LugarPrestacion>>
                                        snapshot) {
                                  LugarPrestacion depatalits;

                                  if (!snapshot.hasData) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  final preguntas = snapshot.data;

                                  if (preguntas!.length == 0) {
                                    return Center(
                                      child: Text("sin dato"),
                                    );
                                  } else {
                                    return Container(
                                        //decoration: servicios.myBoxDecoration(),
                                        child: DropdownButton<LugarPrestacion>(
                                      underline: underlineCbo,
                                      isExpanded: true,
                                      items: snapshot.data
                                          ?.map((user) =>
                                              DropdownMenuItem<LugarPrestacion>(
                                                child: Text(
                                                  user.nombreLugarPrestacion,
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                                value: user,
                                              ))
                                          .toList(),
                                      onChanged: (LugarPrestacion? newVal) {
                                        setState(() {
                                          depatalits = newVal!;
                                          seleccionarLugarPrestacion =
                                              newVal.nombreLugarPrestacion;
                                          lugarPrestacion =
                                              newVal.nombreLugarPrestacion;

                                          idseleccionarLugarPrestacion =
                                              newVal.idLugarPrestacion;
                                          idLugarPrestacion =
                                              newVal.idLugarPrestacion;
                                          DatabasePr.db
                                              .getporidUnidadTeritoria(tablaid);

                                          if (idseleccionarLugarPrestacion ==
                                              1) {
                                            tamanio = 50;
                                            tamanio2 = 0;
                                            tamanio3 = 0;
                                            tamanioboton = 0;
                                          } else if (idseleccionarLugarPrestacion ==
                                              2) {
                                            tamanio2 = 50;
                                            tamanio = 0;
                                            tamanioboton = 0;
                                          }
                                        });
                                      },
                                      hint: Text(
                                          "   $seleccionarLugarPrestacion",
                                          style:
                                              TextStyle(color: Colors.black)),
                                    ));
                                  }
                                },
                              ),
                            ),
                            SizedBox(height: 10),
                           SizedBox(
                              height: tamanio,
                              child: Container(
                                margin: EdgeInsets.only(),
                                child: FutureBuilder<List<UnidadesOrganicas>>(
                                  future:
                                      DatabasePr.db.getTodosUnidadesOrganicas(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<List<UnidadesOrganicas>>
                                          snapshot) {
                                    UnidadesOrganicas depatalits;
                                    if (!snapshot.hasData) {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                    final preguntas = snapshot.data;

                                    if (preguntas!.length == 0) {
                                      return Center(
                                        child: Text("sin dato"),
                                      );
                                    } else {
                                      return Container(
                                          decoration:
                                              servicios.myBoxDecoration(),
                                          child:
                                              DropdownButton<UnidadesOrganicas>(
                                            underline: SizedBox(),
                                            isExpanded: true,
                                            items: snapshot.data
                                                ?.map((user) =>
                                                    DropdownMenuItem<
                                                        UnidadesOrganicas>(
                                                      child: Text(
                                                          user.UNIDAD_ORGANICA),
                                                      value: user,
                                                    ))
                                                .toList(),
                                            onChanged:
                                                (UnidadesOrganicas? newVal) {
                                              setState(() {
                                                depatalits = newVal!;
                                                seleccionarUnidOrganicas =
                                                    newVal.UNIDAD_ORGANICA;
                                                idUnidadesOrganicas =
                                                    newVal.IDUO;
                                                nombreUnnidadesOrganicas =
                                                    newVal.UNIDAD_ORGANICA;
                                                if (newVal.IDUO >= 1) {
                                                  tamaniopuesto = 50.0;
                                                } else {
                                                  tamanioboton = 0;
                                                }
                                              });
                                            },
                                            hint: Row(children: [
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text("$seleccionarUnidOrganicas",
                                                  style: TextStyle(
                                                      color: Colors.black))
                                            ]),
                                          ));
                                    }
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              height: tamanio2,
                              child: Container(
                                child:
                                    FutureBuilder<List<UnidadesTerritoriales>>(
                                  future: DatabasePr.db
                                      .getAllTasksUnidadesTerritoriales(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<List<UnidadesTerritoriales>>
                                          snapshot) {
                                    UnidadesTerritoriales depatalits;
                                    if (!snapshot.hasData) {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                    final preguntas = snapshot.data;

                                    if (preguntas!.length == 0) {
                                      return Center(
                                        child: Text("sin dato"),
                                      );
                                    } else {
                                      return Container(
                                          //decoration:   servicios.myBoxDecoration(),
                                          child: DropdownButton<
                                                  UnidadesTerritoriales>(
                                              underline: underlineCbo,
                                              isExpanded: true,
                                              items: snapshot.data
                                                  ?.map((user) =>
                                                      DropdownMenuItem<
                                                          UnidadesTerritoriales>(
                                                        child: Text(user
                                                            .unidadTerritorial),
                                                        value: user,
                                                      ))
                                                  .toList(),
                                              onChanged: (UnidadesTerritoriales?
                                                  newVal) {
                                                setState(() {
                                                  nombreUnidTerritoriales =
                                                      newVal!.unidadTerritorial;
                                                  depatalits = newVal;
                                                  seleccionarUnidTerritoriales =
                                                      newVal.unidadTerritorial;
                                                  tablaid = newVal
                                                      .id_UnidadesTerritoriales;
                                                  idUnidTerritoriales = newVal
                                                      .id_UnidadesTerritoriales;
                                                  DatabasePr.db
                                                      .getporidUnidadTeritoria(
                                                          tablaid);

                                                  if (newVal
                                                          .id_UnidadesTerritoriales >=
                                                      1) {
                                                    tamanio3 = 50.0;
                                                  } else {
                                                    tamanioboton = 0;
                                                  }
                                                });
                                              },
                                              hint: Row(
                                                children: [
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                      "$seleccionarUnidTerritoriales",
                                                      style: TextStyle(
                                                          color: Colors.black)),
                                                ],
                                              )
                                              //     hint: Text("   $data_depara"),
                                              ));
                                    }
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              height: tamanio2,
                              child: FutureBuilder<List<TipoPlataforma>>(
                                future: DatabasePr.db.getAllTipoPlataforma(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<List<TipoPlataforma>>
                                        snapshot) {
                                  TipoPlataforma depatalits;
                                  if (!snapshot.hasData) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  final preguntas = snapshot.data;

                                  if (preguntas!.length == 0) {
                                    return Center(
                                      child: Text("sin dato"),
                                    );
                                  } else {
                                    return Container(
                                        //  decoration: servicios.myBoxDecoration(),
                                        child: DropdownButton<TipoPlataforma>(
                                      underline: underlineCbo,
                                      isExpanded: true,
                                      items: snapshot.data
                                          ?.map((user) =>
                                              DropdownMenuItem<TipoPlataforma>(
                                                child: Text(user.descripcion!),
                                                value: user,
                                              ))
                                          .toList(),
                                      onChanged: (TipoPlataforma? newVal) {
                                        seleccionarTpPla = newVal!.descripcion!;
                                        ProviderConfiguracion()
                                            .listaTambosPiasxUnidadTerritorial(
                                                seleccionarTpPla, tablaid);
                                        if (newVal.id! >= 1) {
                                          tamanio3 = 50.0;
                                        } else {
                                          tamanioboton = 0;
                                        }
                                        if (newVal.descripcion == 'PIAS') {
                                          tamanioCampania = 50.0;
                                        } else {
                                          tamanioCampania = 0.0;
                                        }
                                        setState(() {});
                                      },
                                      hint: Row(
                                        children: [
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text("$seleccionarTpPla",
                                              style: TextStyle(
                                                  color: Colors.black))
                                        ],
                                      ),
                                    ));
                                  }
                                },
                              ),
                            ),
                            SizedBox(height: 10),
                            SizedBox(
                              height: tamanio3,
                              child: Container(
                                child: FutureBuilder<
                                    List<RspoTambosPiasxUnidadTerritorial>?>(
                                  future: ProviderConfiguracion()
                                      .listaTambosPiasxUnidadTerritorial(
                                          seleccionarTpPla, tablaid),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<
                                              List<
                                                  RspoTambosPiasxUnidadTerritorial>?>
                                          snapshot) {
                                    RspoTambosPiasxUnidadTerritorial?
                                        depatalits;
                                    if (!snapshot.hasData) {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                    final preguntas = snapshot.data;

                                    if (preguntas!.length == 0) {
                                      return Center(
                                        child: Text("sin dato"),
                                      );
                                    } else {
                                      return Container(
                                          // decoration: servicios.myBoxDecoration(),
                                          child: DropdownButton<
                                              RspoTambosPiasxUnidadTerritorial>(
                                        underline: underlineCbo,
                                        isExpanded: true,
                                        items: snapshot.data
                                            ?.map((user) => DropdownMenuItem<
                                                    RspoTambosPiasxUnidadTerritorial>(
                                                  child:
                                                      Text(user.nombreTambo!),
                                                  value: user,
                                                ))
                                            .toList(),
                                        onChanged:
                                            (RspoTambosPiasxUnidadTerritorial?
                                                newVal) {
                                          setState(() {
                                            depatalits = newVal!;

                                            seleccionarTablaPlataforma =
                                                newVal.nombreTambo!;
                                            idTambo = newVal.idPlataforma!;
                                            snip = newVal.snip!;
                                            nombreTambo = newVal.nombreTambo!;

                                            modalidad = newVal.modalidad!;

                                            if (seleccionarTablaPlataforma
                                                    .length >
                                                0) {
                                              tamaniopuesto = 50.0;
                                            }
                                          });
                                        },
                                        value: depatalits,
                                        hint: Text(
                                            "   $seleccionarTablaPlataforma",
                                            style:
                                                TextStyle(color: Colors.black)),
                                      ));
                                    }
                                  },
                                ),

                                ///getporidUnidadTeritoria
                              ),
                            ),
                            SizedBox(height: 10),
                            SizedBox(
                              height: tamanioCampania,
                              child: Container(
                                child: FutureBuilder<List<Campania>>(
                                  future: DatabasePias.db.getCampanias(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<List<Campania>> snapshot) {
                                    Campania? depatalits;
                                    if (!snapshot.hasData) {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                    final preguntas = snapshot.data;

                                    if (preguntas!.length == 0) {
                                      return Center(
                                        child: Text("sin dato"),
                                      );
                                    } else {
                                      return Container(
                                          //  decoration:
                                          //    servicios.myBoxDecoration(),
                                          child: DropdownButton<Campania>(
                                        underline: underlineCbo,
                                        isExpanded: true,
                                        items: snapshot.data
                                            ?.map((user) =>
                                                DropdownMenuItem<Campania>(
                                                  child: Text(user.descripcion),
                                                  value: user,
                                                ))
                                            .toList(),
                                        onChanged: (Campania? newVal) {
                                          setState(() {
                                            depatalits = newVal!;
                                            seleccionarCamapania =
                                                newVal.descripcion;
                                            campania = newVal.descripcion;
                                            codCampania = int.parse(newVal.cod);
                                          });
                                        },
                                        value: depatalits,
                                        hint: Text("   $seleccionarCamapania",
                                            style:
                                                TextStyle(color: Colors.black)),
                                      ));
                                    }
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            SizedBox(
                              height: tamaniopuesto,
                              child: Container(
                                child: FutureBuilder<List<Puesto>>(
                                  future: DatPuesto.db.getTodosPuesto(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<List<Puesto>> snapshot) {
                                    Puesto? depatalits;
                                    if (!snapshot.hasData) {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                    final preguntas = snapshot.data;
                                    if (preguntas!.length == 0) {
                                      return Center(
                                        child: Text("sin dato"),
                                      );
                                    } else {
                                      return Container(
                                          //decoration:
                                          //  servicios.myBoxDecoration(),
                                          child: DropdownButton<Puesto>(
                                        underline: underlineCbo,
                                        isExpanded: true,
                                        items: snapshot.data
                                            ?.map((user) =>
                                                DropdownMenuItem<Puesto>(
                                                  child:
                                                      Text(user.nombrePuesto),
                                                  value: user,
                                                ))
                                            .toList(),
                                        onChanged: (Puesto? newVal) {
                                          setState(() {
                                            depatalits = newVal!;
                                            seleccionarPuesto =
                                                newVal.nombrePuesto;
                                            idPuesto = newVal.idPuesto;
                                            nombrePuesto = newVal.nombrePuesto;
                                            if (newVal.idPuesto >= 1) {
                                              tamanioboton = 40.0;
                                            }
                                          });
                                        },
                                        value: depatalits,
                                        hint: Text("$seleccionarPuesto",
                                            style:
                                                TextStyle(color: Colors.black)),
                                      ));
                                    }
                                  },
                                ),

                                ///getporidUnidadTeritoria
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Container(
                              decoration: servicios.myBoxDecoration(),
                              margin: EdgeInsets.only(right: 0, left: 0),
                              height: tamanioboton,
                              width: MediaQuery.of(context).size.width,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.blue[600],
                                  ),
                                  child: _isloading
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            CircularProgressIndicator(
                                              color: Colors.white,
                                            ),
                                            const SizedBox(
                                              width: 24,
                                            ),
                                            Text(
                                              'Descargando...!!',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.white),
                                            )
                                          ],
                                        )
                                      : Text(
                                          'Guardar',
                                          style: TextStyle(
                                              fontSize: 19,
                                              color: Colors.white),
                                        ),
                                  onPressed: () async {
                                    if (seleccionarUnidOrganicas ==
                                            "SELECCIONAR UNIDADES ORGANICAS" &&
                                        seleccionarLugarPrestacion ==
                                            "SELECIONAR LUGAR PRESTACION") {
                                      Fluttertoast.showToast(
                                          msg: "SELLECCIONAR",
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

                                      if (seleccionarTpPla == "PIAS") {
                                        if (codCampania != 0) {
                                          var rsp =
                                              await ProviderServiciosRest()
                                                  .listarPuntoAtencionPias(
                                                      codCampania.toString(),
                                                      idTambo,
                                                      0);
                                          if (rsp.isEmpty) {
                                            Util().showAlertDialog(
                                                "PIAS",
                                                "No cuenta con datos para esta campaña o pia",
                                                context, () {
                                              Navigator.pop(context);
                                            });
                                            setState(() {
                                              _isloading = false;
                                            });
                                          } else {
                                            var r = ConfigInicio(
                                                modalidad: modalidad,
                                                idLugarPrestacion:
                                                    idLugarPrestacion,
                                                idPuesto: idPuesto,
                                                idTambo: idTambo,
                                                idUnidTerritoriales:
                                                    idUnidTerritoriales,
                                                idUnidadesOrganicas:
                                                    idUnidadesOrganicas,
                                                lugarPrestacion:
                                                    lugarPrestacion,
                                                nombreTambo: nombreTambo,
                                                puesto: nombrePuesto,
                                                unidTerritoriales:
                                                    nombreUnidTerritoriales,
                                                unidadesOrganicas:
                                                    nombreUnnidadesOrganicas,
                                                snip: snip,
                                                tipoPlataforma:
                                                    seleccionarTpPla,
                                                campania: campania,
                                                codCampania:
                                                    codCampania.toString());
                                            await DatabasePr.db
                                                .insertConfigInicio(r);

                                            setState(() {
                                              _isloading = false;
                                            });
                                            Navigator.of(context).pushReplacement(
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        ConfiguracionPersonal(
                                                          unidad:
                                                              seleccionarUnidad,
                                                        )));
                                          }
                                        } else {
                                          Util().showAlertDialog(
                                              "PIAS",
                                              "Seleccionar alguna campaña",
                                              context, () {
                                            Navigator.pop(context);
                                          });
                                          setState(() {
                                            _isloading = false;
                                          });
                                        }
                                      } else if (seleccionarTpPla == "TAMBO") {
                                        if (seleccionarUnidTerritoriales !=
                                            "SELECCIONAR UNIDADES TERRITORIALES") {
                                          await ProviderDatos()
                                              .getInsertParticipantesIntervencionesMovil(
                                                  seleccionarUnidTerritoriales);
                                        }
                                        var r = ConfigInicio(
                                            idLugarPrestacion:
                                                idLugarPrestacion,
                                            idPuesto: idPuesto,
                                            idTambo: idTambo,
                                            idUnidTerritoriales:
                                                idUnidTerritoriales,
                                            idUnidadesOrganicas:
                                                idUnidadesOrganicas,
                                            lugarPrestacion: lugarPrestacion,
                                            nombreTambo: nombreTambo,
                                            puesto: nombrePuesto,
                                            unidTerritoriales:
                                                nombreUnidTerritoriales,
                                            unidadesOrganicas:
                                                nombreUnnidadesOrganicas,
                                            snip: snip,
                                            tipoPlataforma: seleccionarTpPla,
                                            campania: campania,
                                            codCampania:
                                                codCampania.toString());
                                        await DatabasePr.db
                                            .insertConfigInicio(r);

                                        setState(() {
                                          _isloading = false;
                                        });
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    ConfiguracionPersonal(
                                                        unidad:
                                                            seleccionarUnidad)));
                                      } else {
                                        var r = ConfigInicio(
                                            idLugarPrestacion:
                                                idLugarPrestacion,
                                            idPuesto: idPuesto,
                                            idTambo: idTambo,
                                            idUnidTerritoriales:
                                                idUnidTerritoriales,
                                            idUnidadesOrganicas:
                                                idUnidadesOrganicas,
                                            lugarPrestacion: lugarPrestacion,
                                            nombreTambo: nombreTambo,
                                            puesto: nombrePuesto,
                                            unidTerritoriales:
                                                nombreUnidTerritoriales,
                                            unidadesOrganicas:
                                                nombreUnnidadesOrganicas,
                                            snip: snip,
                                            tipoPlataforma: seleccionarTpPla,
                                            campania: campania,
                                            codCampania:
                                                codCampania.toString());
                                        await DatabasePr.db
                                            .insertConfigInicio(r);

                                        setState(() {
                                          _isloading = false;
                                        });
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    ConfiguracionPersonal(
                                                      unidad: seleccionarUnidad,
                                                    )));
                                      }
                                    }
                                  }),
                            )
                          ],
                        )
                      : new Container(),
                  (_istrueUps == true)
                      ? Form(
                          key: _formKeyUps,
                          child: Column(
                            children: [
                              FormularioReq().textinputdet(
                                  "Codigo Personal",
                                  _controllerCodPersonal,
                                  TextCapitalization.words,
                                  TextInputType.text,
                                  true),
                              SizedBox(height: 10.0),
                              Container(
                                decoration: servicios.myBoxDecoration(),
                                margin: EdgeInsets.only(right: 0, left: 0),
                                height: 40.0,
                                width: MediaQuery.of(context).size.width,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.blue[600],
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
                                                '...!!',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    color: Colors.white),
                                              )
                                            ],
                                          )
                                        : const Text(
                                            'Consultar',
                                            style: TextStyle(
                                                fontSize: 19,
                                                color: Colors.white),
                                          ),
                                    onPressed: () async {
                                      if (_controllerCodPersonal
                                          .text.isNotEmpty) {
                                        setState(() {
                                          _isloading = true;
                                        });
                                        setState(() {
                                          _controllerNombres.clear();
                                          _controllerRol.clear();
                                           _controllerfecha.clear();
                                          _controllerUsuario.clear();
                                          _controllerContrasenia.clear();
                                        });

                                        var usuario =
                                            await ProviderConfiguracion()
                                                .buscarUsuarioApp(
                                                    _controllerCodPersonal
                                                        .text);
                                        if (usuario.nombres != "") {
                                          _isActive = true;
                                          _controllerNombres.text =
                                              usuario.nombres;
                                          _controllerRol.text = usuario.rol;
                                        } else {
                                          _controllerNombres.text = "";
                                          _controllerRol.text = "";
                                          _isActive = false;
                                        }
                                        setState(() {
                                          _isloading = false;
                                        });
                                      } else {
                                        _controllerNombres.text = "";
                                        _controllerRol.text = "";
                                        setState(() {
                                          _isActive = false;
                                        });
                                      }
                                    }),
                              ),
                              SizedBox(height: 10.0),
                              FormularioReq().textinputdet(
                                  "Nombres",
                                  _controllerNombres,
                                  TextCapitalization.words,
                                  TextInputType.text,
                                  false),
                              SizedBox(height: 10.0),
                              FormularioReq().textinputdet(
                                  "Rol",
                                  _controllerRol,
                                  TextCapitalization.words,
                                  TextInputType.text,
                                  false),
                              SizedBox(height: 10.0),
                              Container(
                                // decoration: servicios.myBoxDecoration(),
                                //  decoration: FormularioReq().myBoxDecoration(),
                                child: TextFormField(
                                  textAlign: TextAlign.justify,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Por favor ingrese dato.';
                                    }
                                  },
                                  onTap: () async {
                                    var fecha2 = DateTime.now();
                                    DateTime date = fecha2;

                                    final DateTime? picked =
                                        await showDatePicker(
                                      context: context,
                                      initialDate: nowfec!,
                                      firstDate: DateTime(1800, 8),
                                      lastDate: DateTime(
                                          date.year, date.month, date.day),
                                    );

                                    if (picked != null) {
                                      setState(() {
                                        _controllerfecha.text.replaceAll(
                                            '', formatter.format(picked!));
                                        _controllerfecha.text =
                                            formatter.format(picked!);
                                      });
                                    }
                                  },
                                  keyboardType: TextInputType.text,
                                  textCapitalization: TextCapitalization.words,
                                  controller: _controllerfecha,
                                  enabled: _isActive,
                                  decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xFF0EA1E8)),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xFF0EA1E8)),
                                    ),
                                    border: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xFF0EA1E8)),
                                    ),
                                    labelText: "Fecha Nacimiento",

                                    //   suffixIcon: Icon(Icons.https, color: primaryColor)
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.0),
                              FormularioReq().textIngresoDc(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Por favor ingrese datos.';
                                    }
                                  },
                                  enabled: _isActive,
                                  controllerNDocumento: _controllerUsuario,
                                  maxLengthDOC: 8,
                                  labelText: "DNI",
                                  onChanged: (value) {
                                    var contar = value.toString();
                                  }),
                              SizedBox(height: 10.0),
                              FormularioReq().textinputdet(
                                  "Contraseña ",
                                  _controllerContrasenia,
                                  TextCapitalization.words,
                                  TextInputType.number,
                                  _isActive, validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Por favor ingrese datos.';
                                }
                              },),
                              SizedBox(height: 10.0),
                              Container(
                                decoration: servicios.myBoxDecoration(),
                                margin: EdgeInsets.only(right: 0, left: 0),
                                height: 40.0,
                                width: MediaQuery.of(context).size.width,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.blue[600],
                                    ),
                                    child: Text(
                                      'Guardar',
                                      style: TextStyle(
                                          fontSize: 19, color: Colors.white),
                                    ),
                                    onPressed: () async {
                                      if (_formKeyUps.currentState!
                                          .validate()) {
                                        Util().showAlertDialogokno(
                                            'Guardar configuracion inical',
                                            context, () async {
                                          var r = ConfigPersonal(
                                              unidad: seleccionarUnidad,
                                              nombres: _controllerNombres.text,
                                              codigo: _controllerCodPersonal.text,
                                              rol: _controllerRol.text,
                                              fechaNacimento:
                                              _controllerfecha.text,
                                              contrasenia:
                                              _controllerContrasenia.text,
                                              numeroDni: int.parse(
                                                  _controllerUsuario.text));
                                          await Future.delayed(
                                              Duration(seconds: 1));
                                          var res = await DatabasePr.db
                                              .insertConfigPersonal(r);
                                          if (res >= 0) {
                                            Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (_) => LoginPage()),
                                            );
                                          }
                                        }, () {
                                          print("NO");
                                          Navigator.pop(context);
                                        }, '¿Estas seguro de guardar el registro?');

                                      }
                                    }),
                              )
                            ],
                          ),
                        )
                      : new Container(),
                ],
              )),
        ));
  }
}
*/