import 'dart:io';

import 'package:actividades_pais/util/app-config.dart';
import 'package:flutter/material.dart';
import 'package:actividades_pais/src/Utils/utils.dart';
import 'package:actividades_pais/src/datamodels/Clases/Pias/reportesPias.dart';
import 'package:actividades_pais/src/datamodels/database/DatabasePias.dart';
import 'package:actividades_pais/src/pages/Intervenciones/Listas/Listas.dart';
import 'package:actividades_pais/src/pages/Pias/Sincronizar/listaTipoRep.dart';

class SincronizarPage extends StatefulWidget {
  const SincronizarPage({Key? key}) : super(key: key);

  @override
  State<SincronizarPage> createState() => _SincronizarPageState();
}

class _SincronizarPageState extends State<SincronizarPage> {
  bool status = false;
  bool _isOnline = true;

  Future<void> _checkInternetConnection() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      setState(() {});

      final result = await InternetAddress.lookup('www.google.com');

      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        _isOnline = true;
      } else {
        _isOnline = false;
      }
    } on SocketException catch (_) {
      _isOnline = false;
    }
  }

  Future refreshList() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Sincronizar"), actions: const [],  backgroundColor: AppConfig.primaryColor,),
        body: FutureBuilder<List<ReportesPias>>(
          future: DatabasePias.db.listaReportePias(),
          builder: (BuildContext context,
              AsyncSnapshot<List<ReportesPias>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.hasData == false) {
                return const Center(
                  child: Text("¡No existen registros"),
                );
              } else {
                final listaAteDiarias = snapshot.data;
                if (listaAteDiarias!.isEmpty) {
                  return const Center(
                    child: Text("No hay informacion"),
                  );
                } else {
                  return Container(
                    child: RefreshIndicator(
                        onRefresh: refreshList,
                        child: ListView.builder(
                          itemCount: listaAteDiarias.length,
                          itemBuilder: (context, i) => Dismissible(
                              key: UniqueKey(),
                              background: utils().buildSwipeActionLeft(),
                              secondaryBackground:
                                  utils().buildSwipeActionRigth(),
                              onDismissed: (direction) async {
                                /* switch (direction) {
                                    case DismissDirection.endToStart:
                                await DatabasePr.db
                                    .eliminarTramaIntervencionesUsPorid(
                                    listaPersonalAux[i]
                                        .codigoIntervencion);

                                break;
                              case DismissDirection.startToEnd:
                                await DatabasePr.db
                                    .eliminarTramaIntervencionesUsPorid(
                                    listaPersonalAux[i]
                                        .codigoIntervencion);
                                break;
                                }*/
                              },
                              //listaAteDiarias[i]
                              //                               .codigoIntervencion
                              //                               .toString()
                              child: Listas().cardSincronizarPias(
                                listaAteDiarias[i],
                                () async {
                                  _checkInternetConnection();
                                  if (_isOnline == false) {
                                    utils().showAlertDialog(
                                        'Pendientes Envio',
                                        'No tiene red de internet para sincronizar estos registros.',
                                        context, () {
                                      Navigator.pop(context);
                                    });
                                  } else {
                                    final respt = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ListaTipoRep( listaAteDiarias[i])),
                                    );
                                    if (respt == 'ok') {
                                      refreshList();
                                    }
                                    /*   final respt = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ListasParaEnvio(
                                          listaPersonalAux[i]
                                              .codigoIntervencion
                                              .toString(),
                                          listaPersonalAux[i]
                                              .tambo
                                              .toString())),
                                );
                                if (respt == 'ok') {
                                  refreshList();
                                }*/
                                  }
                                },
                              )),
                          /*itemBuilder: (context, i) =>
                              _banTitle(listaPersonalAux[i]), */
                        )),
                  );
                }
              }
            }
            return const Center(
              child: Text("¡No existen registros"),
            );
          },
        ));
  }
}
