import 'dart:convert';
import 'dart:ui';

import 'package:actividades_pais/src/datamodels/Clases/ConfigInicio.dart';
import 'package:actividades_pais/src/datamodels/Clases/ConsultarTambosPiasxUnidadTerritorial.dart';
import 'package:actividades_pais/src/datamodels/Clases/Pias/Campania.dart';
import 'package:actividades_pais/src/datamodels/Clases/UnidadesTerritoriales.dart';
import 'package:actividades_pais/src/datamodels/Clases/tipoPlataforma.dart';
import 'package:actividades_pais/src/datamodels/Provider/Pias/ProviderServiciosRest.dart';
import 'package:actividades_pais/src/datamodels/Provider/ProviderConfiguracion.dart';
import 'package:actividades_pais/src/datamodels/Provider/ProviderServicios.dart';
import 'package:actividades_pais/src/datamodels/database/DatabasePr.dart';
import 'package:flutter/material.dart';
import 'package:actividades_pais/src/datamodels/Clases/Pias/Clima.dart';
import 'package:actividades_pais/src/datamodels/Clases/Pias/PuntoAtencionPias.dart';
import 'package:actividades_pais/src/datamodels/Clases/Pias/reportesPias.dart';
import 'package:intl/intl.dart';
import 'package:actividades_pais/src/datamodels/Provider/Pias/ProviderDataJson.dart';
import 'package:actividades_pais/src/datamodels/database/DatabasePias.dart';
import 'package:logger/logger.dart';

class Parte extends StatefulWidget {
  String plataforma, unidadTerritorial, idUnicoReporte;
  int idPlataforma;
  String long = '';
  String lat = '';
  String campaniaCod = '';

  Parte(
      {this.plataforma = "",
      this.unidadTerritorial = "",
      this.idPlataforma = 0,
      this.idUnicoReporte = '',
      this.long = '',
      this.lat = '',
      this.campaniaCod = ''});

  @override
  _ParteState createState() => _ParteState();
}

class _ParteState extends State<Parte> {
  var seleccionarUnidTerritoriales = "SELECCIONAR UNIDAD TERRITORIAL";
  var seleccionarPuntoAte = 'Seleccionar';
  var seleccionarClima = 'SELECCIONAR CLIMA';
  String seleccionarTablaPlataforma = "SELECCIONAR";
  String seleccionarCamapania = "SELECCIONAR";
  var idUnidTerritoriales = 0;
  final _focusNode = FocusNode();

  TextEditingController fecha = TextEditingController();
  DateTime? nowfec = new DateTime.now();
  var formatter = new DateFormat('yyyy-MM-dd');

  TextEditingController controllerfecha = TextEditingController();
  TextEditingController controllerDetalle = TextEditingController();
  TextEditingController controllerPersonal = TextEditingController();
  TextEditingController controllerestadosEquipos = TextEditingController();
  TextEditingController controllerSismonitor = TextEditingController();
  ReportesPias reportePias = ReportesPias();
  var acnuevo = 0;
  var contadorTextDetalle = 0;
  var seleccionarTpPla = "";

  int codCampania = 0;
  int contarPias = 0;
  int idtambo = 0;

  int idPlataforma = 0;

  @override
  void initState() {
    print("PARTE :::: widget.lat ${widget.lat}");
    print("PARTE widget.long ${widget.long}");
    super.initState();
    consultarTambo();
    traerUltimo();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
  consultarTambo() async {
    var abc = await DatabasePr.db.getAllTasksConfigInicio();
    setState(() {
      reportePias.unidadTerritorial = abc[0].unidTerritoriales;
      reportePias.idUnidadTerritorial = abc[0].idUnidTerritoriales;
    });
  }

  traerUltimo() async {
    var ar = await DatabasePias.db.traerUtlimoPorId(widget.idUnicoReporte);
    setState(() {
      if (ar.length == 0) {
        controllerfecha.text = widget.idUnicoReporte;
        reportePias.fechaParteDiario = controllerfecha.text;
        reportePias.idUnicoReporte = widget.idUnicoReporte;
        reportePias.longitud = widget.long;
        reportePias.latitud = widget.lat;
      } else if (ar.length > 0) {
        acnuevo = 1;
        controllerDetalle.text = ar[0].detallePuntoAtencion;
        controllerPersonal.text = ar[0].personal;
        controllerestadosEquipos.text = ar[0].estadoEquipos;
        controllerSismonitor.text = ar[0].sismonitor;
        seleccionarClima = ar[0].clima;

        seleccionarTablaPlataforma = ar[0].plataforma;
        seleccionarCamapania = ar[0].campania;
        controllerfecha.text = ar[0].fechaParteDiario;
        seleccionarPuntoAte = ar[0].puntoAtencion;

        reportePias.idUnicoReporte = ar[0].fechaParteDiario;
        controllerfecha.text = ar[0].fechaParteDiario;
        reportePias.fechaParteDiario = ar[0].fechaParteDiario;
        reportePias.detallePuntoAtencion = ar[0].detallePuntoAtencion;
        reportePias.personal = ar[0].personal;
        reportePias.idClima = ar[0].idClima;
        reportePias.idPlataforma = ar[0].idPlataforma;
        idPlataforma = int.parse(ar[0].idPlataforma);
        reportePias.plataforma = ar[0].plataforma;
        reportePias.puntoAtencion = ar[0].puntoAtencion;
        reportePias.campania = ar[0].campania;
        reportePias.estadoEquipos = ar[0].estadoEquipos;
        reportePias.sismonitor = ar[0].sismonitor;
        reportePias.clima = ar[0].clima;
        reportePias.codigoUbigeo = ar[0].codigoUbigeo;
        reportePias.longitud = widget.long;
        reportePias.latitud = widget.lat;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      body: ListView(
        children: [
          SizedBox(
            width: 330,
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.save,
                    color: Colors.blue[800],
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'GUARDAR',
                    style: TextStyle(color: Colors.blue[800]),
                  ),
                ],
              ),
              onPressed: () async {
                if (acnuevo == 0) {

                  jsonEncode(reportePias);
                  await DatabasePias.db.insertReportePias(reportePias);
                  acnuevo = 1;
                  traerUltimo();
                } else {
                  await DatabasePias.db.updateTask(reportePias);
                }
              },
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Text("Unidad Territorial: "),
                  (widget.unidadTerritorial == '')
                      ? Container(
                          child: SizedBox(
                            width: 200.0,
                            child: Container(
                              child: FutureBuilder<List<UnidadesTerritoriales>>(
                                future: ProviderServicios().getUnidadesTerr(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<List<UnidadesTerritoriales>>
                                        snapshot) {
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
                                        child: DropdownButton<
                                            UnidadesTerritoriales>(
                                      underline:
                                          ProviderServicios().underline(),
                                      isExpanded: true,
                                      items: snapshot.data
                                          ?.map((user) => DropdownMenuItem<
                                                  UnidadesTerritoriales>(
                                                child: Text(
                                                    user.unidadTerritorial),
                                                value: user,
                                              ))
                                          .toList(),
                                      onChanged:
                                          (UnidadesTerritoriales? newVal) {
                                        setState(() {
                                          seleccionarUnidTerritoriales =
                                              newVal!.unidadTerritorial;
                                          reportePias.idUnidadTerritorial =
                                              newVal.id_UnidadesTerritoriales;

                                          DatabasePr.db.getporidUnidadTeritoria(
                                              int.parse(reportePias
                                                  .idUnidadTerritorial
                                                  .toString()));
                                        });
                                      },
                                      hint: Text(
                                          "$seleccionarUnidTerritoriales",
                                          style:
                                              TextStyle(color: Colors.black)),
                                    ));
                                  }
                                },
                              ),
                            ),
                          ),
                        )
                      : SizedBox(
                          width: 200.0,
                          child: Text("${reportePias.unidadTerritorial}"),
                        ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Text("Plataforma: "),
                  (widget.unidadTerritorial == '')
                      ? Container(
                          child: SizedBox(
                              width: 200.0,
                              child: Container(
                                child: FutureBuilder<
                                    List<RspoTambosPiasxUnidadTerritorial>?>(
                                  future: ProviderConfiguracion()
                                      .listaTambosPiasxUnidadTerritorial('PIAS',
                                          reportePias.idUnidadTerritorial),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<
                                              List<
                                                  RspoTambosPiasxUnidadTerritorial>?>
                                          snapshot) {
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
                                          child: DropdownButton<
                                              RspoTambosPiasxUnidadTerritorial>(
                                        underline:
                                            ProviderServicios().underline(),
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
                                            seleccionarCamapania =
                                                "SELECCIONAR CAMPAÑA";
                                            seleccionarTablaPlataforma =
                                                newVal!.nombreTambo!;
                                            reportePias.plataforma =
                                                newVal.nombreTambo!;
                                            reportePias.idPlataforma =
                                                newVal.idPlataforma as String;
                                            idPlataforma = newVal.idPlataforma!;
                                          });
                                        },
                                        hint: Text(seleccionarTablaPlataforma,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 15.0)),
                                      ));
                                    }
                                  },
                                ),
                              )))
                      : SizedBox(
                          width: 200.0,
                          child: SizedBox(
                              width: 200.0,
                              child: Container(
                                child: FutureBuilder<List<ConfigInicio>?>(
                                  future:
                                      DatabasePr.db.getAllTasksConfigInicio(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<List<ConfigInicio>?>
                                          snapshot) {
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
                                          child: DropdownButton<ConfigInicio>(
                                        underline: SizedBox(),
                                        isExpanded: true,
                                        items: snapshot.data
                                            ?.map((user) =>
                                                DropdownMenuItem<ConfigInicio>(
                                                  child: Text(user.nombreTambo),
                                                  value: user,
                                                ))
                                            .toList(),
                                        onChanged: (ConfigInicio? newVal) {
                                          setState(() {
                                            seleccionarCamapania =
                                                "SELECCIONAL CAMPAÑA";
                                            seleccionarTablaPlataforma =
                                                newVal!.nombreTambo;
                                            reportePias.idPlataforma =
                                                newVal.idTambo.toString();
                                            reportePias.plataforma =
                                                newVal.nombreTambo;
                                            idPlataforma = newVal.idTambo;
                                          });
                                        },
                                        hint: Text(
                                            "$seleccionarTablaPlataforma",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15.0)),
                                      ));
                                    }
                                  },
                                ),
                              )),
                        ),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                SizedBox(
                  width: 10,
                ),
                Text("Campaña: "),
                SizedBox(
                  width: 200.0,
                  child: Container(
                    child: FutureBuilder<List<Campania>>(
                      future: ProviderDataJson().getCamapanias(),
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
                              child: DropdownButton<Campania>(
                            underline: SizedBox(),
                            isExpanded: true,
                            items: snapshot.data
                                ?.map((user) => DropdownMenuItem<Campania>(
                                      child: Text(user.descripcion),
                                      value: user,
                                    ))
                                .toList(),
                            onChanged: (Campania? newVal) {
                              setState(() {
                                depatalits = newVal!;
                                seleccionarCamapania = newVal.descripcion;
                                codCampania = int.parse(newVal.cod);
                                reportePias.campania = newVal.cod;

                                seleccionarPuntoAte =
                                    'SELECCIONAR PUNTO ATENCION';
                              });
                            },
                            value: depatalits,
                            hint: Text("$seleccionarCamapania",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15.0)),
                          ));
                        }
                      },
                    ),
                  ),
                )
              ]),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Text("Punto de Atencion: "),
                  (widget.unidadTerritorial == '')
                      ? SizedBox(
                          width: 200.0,
                          child: Container(
                            child: FutureBuilder<List<PuntoAtencionPias>>(
                              future: ProviderServiciosRest()
                                  .listarPuntoAtencionPias(
                                      codCampania.toString(), idtambo, 0),
                              builder: (BuildContext context,
                                  AsyncSnapshot<List<PuntoAtencionPias>>
                                      snapshot) {
                                if (snapshot.hasData) {
                                  return Container(
                                      child: DropdownButton<PuntoAtencionPias>(
                                    underline: SizedBox(),
                                    isExpanded: true,
                                    items: snapshot.data
                                        ?.map((user) =>
                                            DropdownMenuItem<PuntoAtencionPias>(
                                              child: Text(user.puntoAtencion!),
                                              value: user,
                                            ))
                                        .toList(),
                                    onChanged: (PuntoAtencionPias? newVal) {
                                      setState(() {
                                        seleccionarPuntoAte =
                                            newVal!.puntoAtencion!;
                                        reportePias.puntoAtencion =
                                            seleccionarPuntoAte;

                                        reportePias.codigoUbigeo =
                                            newVal.codigoUbigeo!;
                                      });
                                    },
                                    hint: Text("$seleccionarPuntoAte",
                                        style: TextStyle(color: Colors.black)),
                                  ));
                                }
                                return SizedBox();
                              },
                            ),
                          ),
                        )
                      : SizedBox(
                          width: 200.0,
                          child: Container(
                            child: FutureBuilder<List<PuntoAtencionPias>>(
                              future: DatabasePias.db.ListarPuntoAtencionPias(
                                  codCampania, idPlataforma),
                              builder: (BuildContext context,
                                  AsyncSnapshot<List<PuntoAtencionPias>>
                                      snapshot) {
                                if (snapshot.hasData) {
                                  return Container(
                                      child: DropdownButton<PuntoAtencionPias>(
                                    underline: SizedBox(),
                                    isExpanded: true,
                                    items: snapshot.data
                                        ?.map((user) =>
                                            DropdownMenuItem<PuntoAtencionPias>(
                                              child: Text(user.puntoAtencion!),
                                              value: user,
                                            ))
                                        .toList(),
                                    onChanged: (PuntoAtencionPias? newVal) {
                                      setState(() {
                                        seleccionarPuntoAte =
                                            newVal!.puntoAtencion!;
                                        reportePias.puntoAtencion =
                                            newVal.puntoAtencion!;
                                        reportePias.codigoUbigeo =
                                            newVal.codigoUbigeo!;
                                      });
                                    },
                                    hint: Text("$seleccionarPuntoAte",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15.0)),
                                  ));
                                }
                                return SizedBox();
                              },
                            ),
                          ),
                        ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Text("Fecha: "),
                  SizedBox(
                      width: 200.0, child: Text("${controllerfecha.text}")),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Text('Clima'),
                  SizedBox(
                      width: 200.0,
                      child: Container(
                        child: FutureBuilder<List<CLima>>(
                          future: ProviderDataJson().getSaveClima(),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<CLima>> snapshot) {
                            CLima? depatalits;
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
                                  child: DropdownButton<CLima>(
                                underline: SizedBox(),
                                isExpanded: true,
                                items: snapshot.data
                                    ?.map((user) => DropdownMenuItem<CLima>(
                                          child: Text(user.descripcion),
                                          value: user,
                                        ))
                                    .toList(),
                                onChanged: (CLima? newVal) {
                                  setState(() {
                                    depatalits = newVal!;
                                    seleccionarClima = newVal.descripcion;
                                    reportePias.idClima = newVal.cod;
                                    reportePias.clima = seleccionarClima;
                                  });
                                },
                                value: depatalits,
                                hint: Text("$seleccionarClima "),
                              ));
                            }
                          },
                        ),
                      )),
                ],
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                child: Card(
                    color: Colors.grey[200],
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextField(
                        textCapitalization: TextCapitalization.sentences,
                        controller: controllerDetalle,
                        onChanged: (value) {
                          reportePias.detallePuntoAtencion = value;
                        },
                        maxLength: 200,
                        maxLines: 5,
                        decoration:
                            InputDecoration.collapsed(hintText: "Detalle"),
                      ),
                    )),
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                child: Card(
                    color: Colors.grey[200],
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextField(
                        textCapitalization: TextCapitalization.sentences,
                        controller: controllerPersonal,
                        onChanged: (value) {
                          reportePias.personal = value;
                        },
                        maxLines: 1,
                        maxLength: 100,
                        //or null
                        decoration: InputDecoration(
                          labelText: 'Personal:',
                        ),
                      ),
                    )),
              ),
              // _lineas(),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                child: Card(
                    color: Colors.grey[200],
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextField(
                        maxLength: 100,
                        textCapitalization: TextCapitalization.sentences,
                        controller: controllerestadosEquipos,
                        onChanged: (value) {
                          reportePias.estadoEquipos = value;
                        },
                        maxLines: 1,
                        //or null
                        decoration: InputDecoration(
                          labelText: 'Estados de los Equipos: ',
                        ),
                      ),
                    )),
              ),
              // _lineas(),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                child: Card(
                    color: Colors.grey[200],
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextField(
                        focusNode: _focusNode,
                        textCapitalization: TextCapitalization.sentences,
                        controller: controllerSismonitor,
                        onChanged: (value) {
                          reportePias.sismonitor = value;
                        },
                        decoration: InputDecoration(
                          labelText: 'Sismonitor:',
                        ),
                        maxLength: 100,
                      ),
                    )),
              ),
              //_lineas(),
              SizedBox(
                height: 10,
              ),
            ],
          ),
          SizedBox(
            width: 350,
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.save,
                    color: Colors.blue[800],
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'GUARDAR',
                    style: TextStyle(color: Colors.blue[800]),
                  ),
                ],
              ),
              onPressed: () async {
                _focusNode.unfocus();
                if (acnuevo == 0) {
                  await DatabasePias.db.insertReportePias(reportePias);
                  traerUltimo();
                  acnuevo = 1;
                } else {
                  await DatabasePias.db.updateTask(reportePias);
                }
                _displaySnackBar(context, "Se registro el parte, por favor de seguir registrando");
              },
            ),
          ),
        ],
      ),
    ));
  }
  _displaySnackBar(BuildContext context, mensaje, {call}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$mensaje'),
        /* action: SnackBarAction(
          label: 'Action',
          onPressed: call,
        ),*/
      ),
    );
  }
}
