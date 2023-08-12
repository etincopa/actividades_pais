// ignore_for_file: unused_local_variable, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:actividades_pais/src/datamodels/Clases/ArchivoTramaIntervencion.dart';
import 'package:actividades_pais/src/datamodels/Clases/Funcionarios.dart';
import 'package:actividades_pais/src/datamodels/Clases/Participantes.dart';
import 'package:actividades_pais/src/datamodels/Clases/porcentajesEnvio.dart';
import 'package:actividades_pais/src/datamodels/Provider/Provider.dart';
import 'package:actividades_pais/src/datamodels/database/DatabasePr.dart';
import 'package:actividades_pais/src/pages/Intervenciones/listaParaSincronizar/pendienteSincronizar.dart';
import 'package:actividades_pais/src/pages/Intervenciones/util/utils.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../../util/app-config.dart';

class ListasParaEnvio extends StatefulWidget {
  String codigoIntervencion;
  String tambo;

  ListasParaEnvio(this.codigoIntervencion, this.tambo, {super.key});

  @override
  State<ListasParaEnvio> createState() => _ListasParaEnvioState();
}

class _ListasParaEnvioState extends State<ListasParaEnvio> {
  Participantes participantes = Participantes();
  Funcionarios funcionarios = Funcionarios();
  ArchivoTramaIntervencion archivoTramaIntervencion =
      ArchivoTramaIntervencion();
  var cantidadImg,
      cantidadFuncionarios,
      cantidadParticipantes,
      cantidadPartExtranjeros;
  var sincronizadoArchivos = 0.0;
  var sincronizadoFuncionario = 0.0;
  var sincronizadoParticipante = 0.0;
  var sincronizadoExtrangeros = 0.0;
  var respuestaCierre = 0;
  List<int> listaArchivo = [];
  List<int> listafnscr = [];
  List<int> listaParticipante = [];
  List<int> listaParticipanteEx = [];
  bool _isloading = false;

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    cargarPorcentajes();
    cargarListas();
  }

  cargarListas() {
    cargarCantidadFotos();
    cargarCantidadFuncionarios();
    cargarCantidadParticipantes();
    cargarCantidadExtrangeros();
  }

  cargarPorcentajes() async {
    var res =
        await DatabasePr.db.listarPorcentajes(widget.codigoIntervencion, 1);
    if (res.isNotEmpty) {
      sincronizadoArchivos = res[0].porcentaje!;
    }
    var res2 =
        await DatabasePr.db.listarPorcentajes(widget.codigoIntervencion, 2);
    if (res2.isNotEmpty) {
      sincronizadoFuncionario = res2[0].porcentaje!;
    }
    var res3 =
        await DatabasePr.db.listarPorcentajes(widget.codigoIntervencion, 3);
    if (res3.isNotEmpty) {
      sincronizadoParticipante = res3[0].porcentaje!;
    }
    var res4 =
        await DatabasePr.db.listarPorcentajes(widget.codigoIntervencion, 4);
    if (res4.isNotEmpty) {
      sincronizadoExtrangeros = res4[0].porcentaje!;
    }
  }

  cargarCantidadFotos() async {
    var listaImg =
        await DatabasePr.db.listarImagenesDB(widget.codigoIntervencion);

    setState(() {});
    cantidadImg = listaImg.length;
  }

  cargarCantidadFuncionarios() async {
    var listaFunciorarios =
        await DatabasePr.db.listarFuncionariosDB(widget.codigoIntervencion);
    setState(() {});
    cantidadFuncionarios = listaFunciorarios.length;
  }

  cargarCantidadParticipantes() async {
    var listaParticipantes = await DatabasePr.db
        .listarParticipantes(widget.codigoIntervencion, 'participantes');

    setState(() {});
    cantidadParticipantes = listaParticipantes.length;
  }

  cargarCantidadExtrangeros() async {
    var listaParticipantesEx = await DatabasePr.db
        .listarParticipantes(widget.codigoIntervencion, 'extrangeros');
    setState(() {});
    cantidadPartExtranjeros = listaParticipantesEx.length;
  }

///////////////////////////////////////////////////////////////////////
  EnvioArchivos() async {
    var listaParticipantes =
        await DatabasePr.db.listarImagenesDB(widget.codigoIntervencion);
    archivoTramaIntervencion = listaParticipantes[0];
    setState(() {});
    var resp;
    for (var i = 0; i < listaParticipantes.length; i++) {
      //  resp = await ProviderDatos().subirArchivos(listaParticipantes[i]);
      resp = await ProviderDatos().subirArchissvsos(listaParticipantes[i]);
      listaArchivo.add(resp);

      sincronizadoArchivos = double.parse(
          ((((listaArchivo.length) * 100) / listaParticipantes.length) / 100)
              .toString());
      print(resp);
      if (resp == 200) {
        await DatabasePr.db.eliminarArchivoPorid(listaParticipantes[i].id);
        //  listaArchivo = [];
      }
    }
    cargarCantidadFotos();
    cargarCantidadFuncionarios();
    PorcentajesEnvio penv = PorcentajesEnvio();
    penv.codigoIntervencion = widget.codigoIntervencion;
    penv.porcentaje = sincronizadoArchivos;
    penv.tipo = 1;
    DatabasePr.db.insertPorcentajesEnvio(penv);
  }

  EnvioFuncionarios() async {
    var listaParticipantes =
        await DatabasePr.db.listarFuncionariosDB(widget.codigoIntervencion);
    funcionarios = listaParticipantes[0];
    setState(() {});
    int resp;
    for (var i = 0; i < listaParticipantes.length; i++) {
      resp = await ProviderDatos().subirFuncionarios(listaParticipantes[i]);
      listafnscr.add(resp);

      sincronizadoFuncionario = double.parse(
          ((((listafnscr.length) * 100) / listaParticipantes.length) / 100)
              .toString());
      if (resp == 200) {
        await DatabasePr.db.eliminarFuncionarioPorid(listaParticipantes[i].id);
        //  listafnscr = [];
      }
    }
    cargarCantidadFuncionarios();
    PorcentajesEnvio penv = PorcentajesEnvio();
    penv.codigoIntervencion = widget.codigoIntervencion;
    penv.porcentaje = sincronizadoFuncionario;
    penv.tipo = 2;
    DatabasePr.db.insertPorcentajesEnvio(penv);
  }

  EnvioParticipantes() async {
    var listaParticipantes = await DatabasePr.db
        .listarParticipantes(widget.codigoIntervencion, 'participantes');
    if(listaParticipante.isNotEmpty){
      participantes = listaParticipantes[0];
      setState(() {});
    }

    int resp;
    for (var i = 0; i < listaParticipantes.length; i++) {
      resp = await ProviderDatos().subirParticipantes(listaParticipantes[i]);
      listaParticipante.add(resp);
      sincronizadoParticipante = double.parse(
          ((((listaParticipante.length) * 100) / listaParticipantes.length) /
                  100)
              .toString());
      if (resp == 200) {
        await DatabasePr.db
            .eliminarParticipantesPorid(listaParticipantes[i].id);
       }
    }
    cargarCantidadParticipantes();

    PorcentajesEnvio penv = PorcentajesEnvio();
    penv.codigoIntervencion = widget.codigoIntervencion;
    penv.porcentaje = sincronizadoParticipante;
    penv.tipo = 3;
    DatabasePr.db.insertPorcentajesEnvio(penv);
  }

  EnvioExtrangeros() async {
    var listaParticipantes = await DatabasePr.db
        .listarParticipantes(widget.codigoIntervencion, 'extrangeros');
    participantes = listaParticipantes[0];
    setState(() {});
    int resp;
    for (var i = 0; i < listaParticipantes.length; i++) {
      resp = await ProviderDatos().subirParticipantes(listaParticipantes[i]);
      listaParticipanteEx.add(resp);

      sincronizadoExtrangeros = double.parse(
          ((((listaParticipanteEx.length) * 100) / listaParticipantes.length) /
                  100)
              .toString());
      if (resp == 200) {
        await DatabasePr.db
            .eliminarParticipantesPorid(listaParticipantes[i].id);
        //listaParticipanteEx = [];
      }
    }
    cargarCantidadExtrangeros();
    PorcentajesEnvio penv = PorcentajesEnvio();
    penv.codigoIntervencion = widget.codigoIntervencion;
    penv.porcentaje = sincronizadoExtrangeros;
    penv.tipo = 4;
    DatabasePr.db.insertPorcentajesEnvio(penv);
  }

  EnvioCierre() async {
    /*   if (cantidadImg > 0) {
      Util().showAlertDialog(
          "Alerta!!", "Tiene Imagenes por sincronizar", context, () {
        Navigator.pop(context);
      });
    } else if (cantidadFuncionarios > 0) {
      Util().showAlertDialog(
          "Alerta!!", "Tiene Funcionarios por sincronizar", context, () {
        Navigator.pop(context);
      });
    } else if (cantidadParticipantes > 0) {
      Util().showAlertDialog(
          "Alerta!!", "Tiene Participantes por sincronizar", context, () {
        Navigator.pop(context);
      });
    } else if (cantidadPartExtranjeros > 0) {
      Util().showAlertDialog("Alerta!!",
          "Tiene Participantes Extrangeros por sincronizar", context, () {
        Navigator.pop(context);
      });
    } else {*/
    if (_isloading) return;
    setState(() {
      _isloading = true;
    });


    if (cantidadImg > 0) {
      await EnvioArchivos();
    }
    if (cantidadFuncionarios > 0) {
      await EnvioFuncionarios();
    }
    if (cantidadParticipantes > 0) {
      await EnvioParticipantes();
    }
    if (cantidadPartExtranjeros > 0) {
      await EnvioExtrangeros();
    }
    cargarListas();
    var listaParticipantes =
        await DatabasePr.db.cierreTRama(widget.codigoIntervencion);
    //participantes = listaParticipantes[0];

    int resp;

    resp = await ProviderDatos().subirCierre(listaParticipantes[0]);
    respuestaCierre = resp;
    print(resp);

    if (resp == 200) {
      Navigator.pop(context);
      await DatabasePr.db.eliminarTramaIntervencionesUsPorid(
          listaParticipantes[0].codigoIntervencion);
      await DatabasePr.db.eliminarTramaIntervencionesPorid(
          listaParticipantes[0].codigoIntervencion);
      await DatabasePr.db.eliminarTPorcentajesEnvioPorid(
          listaParticipantes[0].codigoIntervencion);
      await ProviderDatos().subirIntentosFallecidos();

      _isloading = false;

      await  Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) =>
                const PendienteSincronizar()),
      );
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(67.0),
        child: AppBar(
          leading: Util().iconbuton(() => Navigator.of(context).pop()),
          title: Text(
            '${widget.tambo}\n${widget.codigoIntervencion}',
            style: const TextStyle(fontSize: 15),
          ),
          backgroundColor: const Color(0xFF78b8cd),
        ),
      ),
      body: Center(
        child: ListView(
          children: [
            Center(
                child: Container(
                    margin: const EdgeInsets.only(left: 10, top: 10),
                    child: const Text(
                      " Antes de sincronizar asegurar de tener toda la información registrada.",
                      style: TextStyle(color: Colors.red),
                    ))),
            const SizedBox(
              height: 20,
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
                          '\n Listas de Fotos \n \n  Cantidad:   $cantidadImg \n'),
                      InkWell(
                        child: const Icon(
                          Icons.send,
                          color: Color(0xFF78b8cd),
                        ),
                        onTap: () {
                          cargarListas();
                          if (cantidadImg > 0) {
                            Util().showAlertDialogokno('Imagenes', context,
                                () async {
                              EnvioArchivos();

                              Navigator.pop(context);
                            }, () {
                              Navigator.pop(context);
                            }, 'Estas seguro de sincronizar las Imagenes');
                          }
                        },
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: LinearPercentIndicator(
                      width: MediaQuery.of(context).size.width - 60,
                      animation: true,
                      lineHeight: 20.0,
                      animationDuration: 2500,
                      percent: sincronizadoArchivos,
                      center:
                          Text("Sincronizado ${sincronizadoArchivos * 100}%"),
                      linearStrokeCap: LinearStrokeCap.roundAll,
                      progressColor: Colors.green,
                    ),
                  ),
                ],
              ),
            )),
            const SizedBox(
              height: 10,
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
                            '\n  Listas de Funcionarios \n \n  Cantidad:  $cantidadFuncionarios \n '),
                        InkWell(
                          child: Icon(
                            Icons.send,
                            color: AppConfig.primaryColor,
                          ),
                          onTap: () {
                          cargarListas();
                            if (cantidadFuncionarios > 0) {
                              Util().showAlertDialogokno(
                                  'Funcionarios', context, () async {
                                EnvioFuncionarios();
                                Navigator.pop(context);
                              }, () {
                                Navigator.pop(context);
                              }, 'Estas seguro de sincronizar Funcionarios');
                            }
                          },
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: LinearPercentIndicator(
                        width: MediaQuery.of(context).size.width - 60,
                        animation: true,
                        lineHeight: 20.0,
                        animationDuration: 2500,
                        percent: sincronizadoFuncionario,
                        center: Text(
                            "Sincronizado ${sincronizadoFuncionario * 100}%"),
                        linearStrokeCap: LinearStrokeCap.roundAll,
                        progressColor: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Card(
              child: Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          '\n  Listas de Participantes \n \n  Cantidad:  $cantidadParticipantes \n '),
                      InkWell(
                        child: const Icon(
                          Icons.send,
                          color: Color(0xFF78b8cd),
                        ),
                        onTap: () async {
                          cargarListas();
                          if (cantidadParticipantes > 0) {
                            Util().showAlertDialogokno('Participantes', context,
                                () async {
                              EnvioParticipantes();
                              Navigator.pop(context);
                            }, () {
                              Navigator.pop(context);
                            }, 'Estas seguro de sincronizar Participantes');
                          }
                        },
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: LinearPercentIndicator(
                      width: MediaQuery.of(context).size.width - 60,
                      animation: true,
                      lineHeight: 20.0,
                      animationDuration: 2500,
                      percent: sincronizadoParticipante,
                      center: Text(
                          "Sincronizado ${sincronizadoParticipante * 100}%"),
                      linearStrokeCap: LinearStrokeCap.roundAll,
                      progressColor: Colors.green,
                    ),
                  ),
                ]),
              ),
            ),
            const SizedBox(
              height: 10,
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
                            '\n  Listas de Extranjeros \n \n  Cantidad:  $cantidadPartExtranjeros \n '),
                        InkWell(
                          child: const Icon(
                            Icons.send,
                            color: Color(0xFF78b8cd),
                          ),
                          onTap: () {
                             cargarListas();
                            if (cantidadPartExtranjeros > 0) {
                              Util().showAlertDialogokno(
                                  'Participantes Extranjeros', context,
                                  () async {
                                EnvioExtrangeros();
                                Navigator.pop(context);
                              }, () {
                                Navigator.pop(context);
                              }, 'Estas seguro de sincronizar Extranjeros');
                            }
                          },
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: LinearPercentIndicator(
                        width: MediaQuery.of(context).size.width - 60,
                        animation: true,
                        lineHeight: 20.0,
                        animationDuration: 2500,
                        percent: sincronizadoExtrangeros,
                        center: Text(
                            "Sincronizado ${sincronizadoExtrangeros * 100}%"),
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
                margin: const EdgeInsets.all(25),
                height: 38,
                //left: 10, right: 10, top: 10
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppConfig.primaryColor,
                      //   shadowColor:
                      textStyle: const TextStyle(fontSize: 24),
                      minimumSize: const Size.fromHeight(72),
                      shape: const StadiumBorder()),
                  onPressed: () async {
                    Util().showAlertDialogokno('Pendientes Envio', context, () {
                      Navigator.pop(context);
                      EnvioCierre();
                    }, () {
                      Navigator.pop(context);
                    }, 'Estas seguro de cerrar');
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
}
