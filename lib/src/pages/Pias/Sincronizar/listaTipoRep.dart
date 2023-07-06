import 'package:actividades_pais/util/app-config.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:actividades_pais/src/datamodels/Clases/Pias/PorcentajesEnvioPias.dart';
import 'package:actividades_pais/src/datamodels/Clases/Pias/reportesPias.dart';
import 'package:actividades_pais/src/datamodels/Provider/Pias/ProviderServiciosRest.dart';
import 'package:actividades_pais/src/datamodels/database/DatabasePias.dart';
import 'package:actividades_pais/src/pages/Intervenciones/util/utils.dart';

class ListaTipoRep extends StatefulWidget {
  ReportesPias reportesPias;

  ListaTipoRep(this.reportesPias, {super.key});

  @override
  State<ListaTipoRep> createState() => _ListaTipoRepState();
}

class _ListaTipoRepState extends State<ListaTipoRep> {
  var cantidadNacidos = 0,
      cantidadActividades = 0,
      cantidadAtenciones = 0,
      cantidadIncidentes = 0,
      cantidadEvidencias = 0;
  var sincronizadoActividades = 0.0;
  var sincronizadoAtenciones = 0.0;
  var sincronizadoIncidentes = 0.0;
  var sincronizadoNacidos = 0.0;
  var sincronizadoEvidencias = 0.0;
  var respuestaCierre = 0;
  List<int> listActividades = [];
  List<int> listAtenciones = [];
  List<int> listIncidentes = [];
  List<int> listNacidos = [];
  List<int> listEvidencias = [];
  bool _isloading = false;

  bool envioActiv = false;
  bool envioAtenciones = false;
  bool envioIncidentes = false;
  bool envioNacidos = false;
  bool envioEvidencias = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cargarListas();
    cargarPorcentajes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(67.0),
        child: AppBar(
          leading: Util().iconbuton(() => Navigator.of(context).pop()),
          title: Text(
            '\n${widget.reportesPias.plataforma}\n${widget.reportesPias.fechaParteDiario}',
            style: const TextStyle(fontSize: 15),
          ),
          backgroundColor: AppConfig.primaryColor,
        ),
      ),
      body: Center(
        child: ListView(
          children: [
            Center(
                child: Container(
                    margin: const EdgeInsets.only(left: 10, top: 10),
                    child: const Text(
                      "Antes de sincronizar asegurar de tener toda la información registrada.",
                      style: TextStyle(color: Colors.black),
                    ))),
            const SizedBox(
              height: 5,
            ),
            Card(
                child: Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          '\n Listas de Actividades \n \n  Cantidad:   $cantidadActividades \n'),
                      envioActiv
                          ? InkWell(
                              child: Icon(
                                Icons.send,
                                color: Colors.blue[900],
                              ),
                              onTap: () {
                                cargarListas();
                                if (cantidadActividades > 0) {
                                  Util().showAlertDialogokno(
                                      'Actividades', context, () async {
                                    await EnvioActividades();
                                  }, () {
                                    Navigator.pop(context);
                                  }, 'Estas seguro de sincronizar las Actividades');
                                }
                              },
                            )
                          : Container()
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: LinearPercentIndicator(
                      width: MediaQuery.of(context).size.width - 60,
                      animation: true,
                      lineHeight: 20.0,
                      animationDuration: 2500,
                      percent: sincronizadoActividades,
                      center: Text(
                          "Sincronizado ${sincronizadoActividades * 100}%"),
                      linearStrokeCap: LinearStrokeCap.roundAll,
                      progressColor: Colors.green,
                    ),
                  ),
                ],
              ),
            )),
            const SizedBox(
              height: 5,
            ),
            Card(
              child: Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            '\n  Listas de Atenciones \n \n  Cantidad:  $cantidadAtenciones \n '),
                        envioAtenciones
                            ? InkWell(
                                child: Icon(
                                  Icons.send,
                                  color: Colors.blue[900],
                                ),
                                onTap: () {
                                  cargarListas();
                                  if (cantidadAtenciones > 0) {
                                    Util().showAlertDialogokno(
                                        'Funcionarios', context, () async {
                                      EnvioAtenciones();
                                      Navigator.pop(context);
                                    }, () {
                                      Navigator.pop(context);
                                    }, 'Estas seguro de sincronizar Atenciones');
                                  }
                                },
                              )
                            : Container()
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: LinearPercentIndicator(
                        width: MediaQuery.of(context).size.width - 60,
                        animation: true,
                        lineHeight: 20.0,
                        animationDuration: 2500,
                        percent: sincronizadoAtenciones,
                        center: Text(
                            "Sincronizado ${sincronizadoAtenciones * 100}%"),
                        linearStrokeCap: LinearStrokeCap.roundAll,
                        progressColor: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Card(
              child: Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          '\n  Listas de Incidentes/Novedades \n \n  Cantidad:  $cantidadIncidentes \n '),
                      envioIncidentes
                          ? InkWell(
                              child: Icon(
                                Icons.send,
                                color: Colors.blue[900],
                              ),
                              onTap: () async {
                                cargarListas();
                                if (cantidadIncidentes > 0) {
                                  Util().showAlertDialogokno(
                                      'Participantes', context, () async {
                                    EnvioIncidente();
                                    Navigator.pop(context);
                                  }, () {
                                    Navigator.pop(context);
                                  }, 'Estas seguro de sincronizar Participantes');
                                }
                              },
                            )
                          : Container(),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: LinearPercentIndicator(
                      width: MediaQuery.of(context).size.width - 60,
                      animation: true,
                      lineHeight: 20.0,
                      animationDuration: 2500,
                      percent: sincronizadoIncidentes,
                      center:
                          Text("Sincronizado ${sincronizadoIncidentes * 100}%"),
                      linearStrokeCap: LinearStrokeCap.roundAll,
                      progressColor: Colors.green,
                    ),
                  ),
                ]),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Card(
                child: Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          '\n Listas de Evidencias \n \n  Cantidad:   $cantidadEvidencias \n'),
                      envioEvidencias
                          ? InkWell(
                              child: Icon(
                                Icons.send,
                                color: Colors.blue[900],
                              ),
                              onTap: () {
                                cargarListas();
                                if (cantidadEvidencias > 0) {
                                  Util().showAlertDialogokno(
                                      'Evidencias', context, () async {
                                    await EnvioEvidencias();
                                    Navigator.pop(context);
                                  }, () {
                                    Navigator.pop(context);
                                  }, 'Estas seguro de sincronizar las Evidencias');
                                }
                              },
                            )
                          : Container()
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: LinearPercentIndicator(
                      width: MediaQuery.of(context).size.width - 60,
                      animation: true,
                      lineHeight: 20.0,
                      animationDuration: 2500,
                      percent: sincronizadoEvidencias,
                      center:
                          Text("Sincronizado ${sincronizadoEvidencias * 100}%"),
                      linearStrokeCap: LinearStrokeCap.roundAll,
                      progressColor: Colors.green,
                    ),
                  ),
                ],
              ),
            )),
            const SizedBox(
              height: 5,
            ),
            Card(
              child: Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            '\n Listas de Nacidos \n \n  Cantidad:  $cantidadNacidos \n '),
                        envioNacidos
                            ? InkWell(
                                child: Icon(
                                  Icons.send,
                                  color: Colors.blue[900],
                                ),
                                onTap: () {
                                  cargarListas();

                                  if (cantidadNacidos > 0) {
                                    Util().showAlertDialogokno(
                                        'Participantes Extranjeros', context,
                                        () async {
                                      EnvioNacidos();
                                      Navigator.pop(context);
                                    }, () {
                                      Navigator.pop(context);
                                    }, 'Estas seguro de sincronizar Extranjeros');
                                  }
                                },
                              )
                            : Container()
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: LinearPercentIndicator(
                        width: MediaQuery.of(context).size.width - 60,
                        animation: true,
                        lineHeight: 20.0,
                        animationDuration: 2500,
                        percent: sincronizadoNacidos,
                        center:
                            Text("Sincronizado ${sincronizadoNacidos * 100}%"),
                        linearStrokeCap: LinearStrokeCap.roundAll,
                        progressColor: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(24),
                height: 38,
                //left: 10, right: 10, top: 10
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[800],
                      //   shadowColor:
                      textStyle: const TextStyle(fontSize: 24),
                      minimumSize: const Size.fromHeight(72),
                      shape: const StadiumBorder()),
                  onPressed: () async {
                    Util().showAlertDialogokno('Pendientes Envio', context,
                        () async {
                      print("swwws");
                      Navigator.pop(context);
                      await EnvioParte();
                    }, () {
                      Navigator.pop(context);
                    }, 'Estas seguro de guardar');
                  },
                  child: _isloading
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
                              'Espere...',
                              style: TextStyle(fontSize: 17),
                            )
                          ],
                        )
                      : const Text(
                          'Guardar',
                          style: TextStyle(fontSize: 19),
                        ),
                )),
          ],
        ),
      ),
    );
  }

  void cargarListas() async {
    var listaAct = await DatabasePias.db
        .listarActividadesPias(widget.reportesPias.idUnicoReporte);
    cantidadActividades = listaAct.length;
    setState(() {});

    var listasAte = await DatabasePias.db
        .listarAtencion(widget.reportesPias.idUnicoReporte);
    cantidadAtenciones = listasAte.length;

    setState(() {});

    var listasInc = await DatabasePias.db
        .ListarIncidentesNovedadesPiasT(widget.reportesPias.idUnicoReporte);
    cantidadIncidentes = listasInc.length;
    setState(() {});

    var nacidos = await DatabasePias.db
        .ListarNacimientoPias(widget.reportesPias.idUnicoReporte);
    cantidadNacidos = nacidos.length;
    setState(() {});

    var evidencias = await DatabasePias.db
        .listarArchivosUnico(widget.reportesPias.idUnicoReporte);
    cantidadEvidencias = evidencias.length;
    setState(() {});
  }

  Future EnvioActividades() async {
    var listaParticipantes = await DatabasePias.db
        .listarActividadesPias(widget.reportesPias.idUnicoReporte);
    for (var i = 0; i < listaParticipantes.length; i++) {
      var resp = await ProviderServiciosRest()
          .guardarActividades(listaParticipantes[i]);

      if (resp == 200) {
        listActividades.add(resp);
        sincronizadoActividades = double.parse(
            ((((listActividades.length) * 100) / listaParticipantes.length) /
                    100)
                .toString());
        await DatabasePias.db
            .eliminarActividadesPiasid(listaParticipantes[i].id);
        cargarListas();
        setState(() {});
      }
    }

    PorcentajesEnvioPias penv = PorcentajesEnvioPias();
    penv.idUnicoReporte = widget.reportesPias.idUnicoReporte;
    penv.porcentaje = sincronizadoActividades;
    penv.tipo = 1;
    DatabasePias.db.insertPorcentajesEnvio(penv);
  }

  Future EnvioAtenciones() async {
    var listaParticipantes = await DatabasePias.db
        .listarAtencion(widget.reportesPias.idUnicoReporte);

    for (var i = 0; i < listaParticipantes.length; i++) {
      var resp = await ProviderServiciosRest()
          .guardarAtenciones(listaParticipantes[i]);
      listAtenciones.add(resp);
      sincronizadoAtenciones = double.parse(
          ((((listAtenciones.length) * 100) / listaParticipantes.length) / 100)
              .toString());
      if (resp == 200) {
        await DatabasePias.db.eliminarAtencionid(listaParticipantes[i].id);
        cargarListas();
        setState(() {});
      }
    }
    PorcentajesEnvioPias penv = PorcentajesEnvioPias();
    penv.idUnicoReporte = widget.reportesPias.idUnicoReporte;
    penv.porcentaje = sincronizadoActividades;
    penv.tipo = 2;
    DatabasePias.db.insertPorcentajesEnvio(penv);
  }

  Future EnvioParte() async {
    print("1::${widget.reportesPias.idUnicoReporte}");
    if (_isloading) return;
    setState(() {
      _isloading = true;
    });

    var listaParticipantes =
        await DatabasePias.db.reportePias(widget.reportesPias.idUnicoReporte);

    if (listaParticipantes[0].idParteDiario > 0) {
      print("ebvio1");
      await EnvioNacidos();
      await EnvioEvidencias();
      await EnvioActividades();
      await EnvioAtenciones();
      await EnvioIncidente();

      await Future.delayed(const Duration(seconds: 5));
      cargarListas();
      _isloading = false;
      if (cantidadActividades == 0 &&
          cantidadAtenciones == 0 &&
          cantidadIncidentes == 0) {
        await DatabasePias.db
            .borrarPorcentajes(widget.reportesPias.idUnicoReporte);
        await DatabasePias.db
            .eliminarReportePorIdru(listaParticipantes[0].idUnicoReporte);
        _isloading = false;
        Navigator.pop(context);
      }
      Navigator.pop(context);
      Navigator.pop(context);
      setState(() {});
    }
    if (listaParticipantes[0].idParteDiario <= 0) {
      var resp = await ProviderServiciosRest().guardar(listaParticipantes[0]);
      respuestaCierre = resp;

      if (resp == 200) {
        cargarListas();
        await EnvioNacidos();
        await EnvioEvidencias();
        await EnvioActividades();
        await EnvioAtenciones();
        await EnvioIncidente();

        await Future.delayed(const Duration(seconds: 5));
        if (cantidadActividades == 0 &&
            cantidadAtenciones == 0 &&
            cantidadIncidentes == 0) {
          await DatabasePias.db
              .borrarPorcentajes(widget.reportesPias.idUnicoReporte);
          await DatabasePias.db
              .eliminarReportePorIdru(listaParticipantes[0].idUnicoReporte);
          _isloading = false;
          Navigator.pop(context);
        }
        Navigator.pop(context);
        Navigator.pop(context);
        setState(() {});
      }
    }
  }

  Future EnvioIncidente() async {
    var listaParticipantes = await DatabasePias.db
        .ListarIncidentesNovedadesPiasT(widget.reportesPias.idUnicoReporte);

    for (var i = 0; i < listaParticipantes.length; i++) {
      var resp = await ProviderServiciosRest()
          .guardarIncidentes(listaParticipantes[i]);
      listIncidentes.add(resp);
      sincronizadoIncidentes = double.parse(
          ((((listIncidentes.length) * 100) / listaParticipantes.length) / 100)
              .toString());
      if (resp == 200) {
        await DatabasePias.db
            .eliminarIncidentesNovedadesPiasid(listaParticipantes[i].id);
        cargarListas();
        setState(() {});
      }
    }
    PorcentajesEnvioPias penv = PorcentajesEnvioPias();
    penv.idUnicoReporte = widget.reportesPias.idUnicoReporte;
    penv.porcentaje = sincronizadoActividades;
    penv.tipo = 3;
    DatabasePias.db.insertPorcentajesEnvio(penv);
  }

  Future EnvioNacidos() async {
    var listaParticipantes = await DatabasePias.db
        .ListarNacimientoPias(widget.reportesPias.idUnicoReporte);

    for (var i = 0; i < listaParticipantes.length; i++) {
      var resp = await ProviderServiciosRest()
          .guardarNacimientos(listaParticipantes[i]);
      listNacidos.add(resp!);
      sincronizadoNacidos = double.parse(
          ((((listNacidos.length) * 100) / listaParticipantes.length) / 100)
              .toString());
      cargarListas();
      setState(() {});
      if (resp == 200) {
        /// await DatabasePias.db.eliminarNacidos(listaParticipantes[i].id);
        cargarListas();
        setState(() {});
      }
    }
    PorcentajesEnvioPias penv = PorcentajesEnvioPias();
    penv.idUnicoReporte = widget.reportesPias.idUnicoReporte;
    penv.porcentaje = sincronizadoNacidos;
    penv.tipo = 4;
    DatabasePias.db.insertPorcentajesEnvio(penv);
  }

  Future EnvioEvidencias() async {
    print("1 ev");
    var listaParticipantes = await DatabasePias.db
        .listarArchivosUnico(widget.reportesPias.idUnicoReporte);

    for (var i = 0; i < listaParticipantes.length; i++) {
      var resp = await ProviderServiciosRest()
          .guardarEvidencias(listaParticipantes[i]);
      listEvidencias.add(resp);
      sincronizadoEvidencias = double.parse(
          ((((listEvidencias.length) * 100) / listaParticipantes.length) / 100)
              .toString());
      print("resp:::: $resp");
      if (resp == 200) {
        await DatabasePias.db
            .eliminarArchivoEvPorId(listaParticipantes[i].file);
        cargarListas();
        setState(() {});
      }
    }
    PorcentajesEnvioPias penv = PorcentajesEnvioPias();
    penv.idUnicoReporte = widget.reportesPias.idUnicoReporte;
    penv.porcentaje = sincronizadoEvidencias;
    penv.tipo = 5;
    DatabasePias.db.insertPorcentajesEnvio(penv);
  }

  cargarPorcentajes() async {
    var res = await DatabasePias.db
        .listarPorcentajes(widget.reportesPias.idUnicoReporte, 1);
    if (res.isNotEmpty) {
      sincronizadoActividades = res[0].porcentaje!;
      if (sincronizadoActividades < 1.0) {
        envioActiv = true;
      }
    }
    var res2 = await DatabasePias.db
        .listarPorcentajes(widget.reportesPias.idUnicoReporte, 2);
    if (res2.isNotEmpty) {
      sincronizadoAtenciones = res2[0].porcentaje!;
      if (sincronizadoAtenciones < 1.0) {
        envioAtenciones = true;
      }
    }
    var res3 = await DatabasePias.db
        .listarPorcentajes(widget.reportesPias.idUnicoReporte, 3);
    if (res3.isNotEmpty) {
      sincronizadoIncidentes = res3[0].porcentaje!;
      if (sincronizadoIncidentes < 1.0) {
        envioIncidentes = true;
      }
    }
    var res4 = await DatabasePias.db
        .listarPorcentajes(widget.reportesPias.idUnicoReporte, 4);
    if (res4.isNotEmpty) {
      sincronizadoNacidos = res4[0].porcentaje!;
      if (sincronizadoNacidos < 1.0) {
        envioNacidos = true;
      }
    }
    var res5 = await DatabasePias.db
        .listarPorcentajes(widget.reportesPias.idUnicoReporte, 5);
    if (res5.isNotEmpty) {
      sincronizadoEvidencias = res5[0].porcentaje!;
      if (sincronizadoEvidencias < 1.0) {
        envioEvidencias = true;
      }
    }
  }
}
