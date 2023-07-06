import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:actividades_pais/src/datamodels/Clases/TramaIntervencion.dart';
import 'package:actividades_pais/src/datamodels/Provider/Provider.dart';
import 'package:actividades_pais/src/datamodels/Provider/connection_status_model.dart';
import 'package:actividades_pais/src/datamodels/database/DatabasePr.dart';
import 'package:actividades_pais/src/pages/Intervenciones/Intervenciones.dart';
import 'package:actividades_pais/src/pages/Intervenciones/Listas/Listas.dart';
import 'package:actividades_pais/src/pages/Intervenciones/listaParaSincronizar/listasParaEnvio.dart';
import 'package:actividades_pais/src/pages/Intervenciones/util/utils.dart';

import '../../../../util/app-config.dart';

class PendienteSincronizar extends StatefulWidget {
  const PendienteSincronizar({super.key});

 // int snip;
 // PendienteSincronizar(this.snip);
  @override
  State<PendienteSincronizar> createState() => _PendienteSincronizarState();
}

class _PendienteSincronizarState extends State<PendienteSincronizar> {
  ProviderDatos provider = ProviderDatos();
  late FToast fToast;
  bool status = false;
  bool _isOnline = true;
  final Connectivity _connectivity = Connectivity();
  Listas listas = Listas();
  @override
  void initState() {
    super.initState();
    _checkInternetConnection();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

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

  Future<void> refreshList() async {
    await Future.delayed(const Duration(seconds: 0));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      // _checkInternetConnection();
    });

    return WillPopScope(
      onWillPop: systemBackButtonPressed,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppConfig.primaryColor,
          title: const Text("Pendientes Envio"),
          leading: Util().iconbuton(() => Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (context) => Intervenciones( '')),
              )),
          actions: [
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              if (_isOnline == true) ...[
                const Icon(
                  Icons.wifi,
                  color: Colors.green,
                ),
              ] else ...[
                (Icon(Icons.wifi_off, color: Colors.red[900]))
              ]
            ]),
            const SizedBox(
              width: 15,
            )
          ],
        ),
        body: FutureBuilder<List<TramaIntervencion>>(
          future: DatabasePr.db.listarIntervencionesPs(),
          builder: (BuildContext context,
              AsyncSnapshot<List<TramaIntervencion>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.hasData == false) {
                return const Center(
                  child: Text("¡No existen registros"),
                );
              } else {
                final listaPersonalAux = snapshot.data;

                if (listaPersonalAux!.isEmpty) {
                  return const Center(
                    child: Text("No hay informacion"),
                  );
                } else {
                  return Container(
                    child: RefreshIndicator(
                        onRefresh: refreshList,
                        child: ListView.builder(
                          itemCount: listaPersonalAux.length,
                          itemBuilder: (context, i) => Dismissible(
                              key: Key(listaPersonalAux[i]
                                  .codigoIntervencion
                                  .toString()),
                              background: buildSwipeActionLeft(),
                              secondaryBackground: buildSwipeActionRigth(),
                              onDismissed: (direction) async {
                                switch (direction) {
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
                                  default:
                                }
                              },
                              child: listas.cardIntervenciones(
                                listaPersonalAux[i],
                                () async {
                                  _checkInternetConnection();
                                  if (_isOnline == false) {
                                    Util().showAlertDialog(
                                        'Pendientes Envio',
                                        'No tiene red de internet para sincronizar estos registros.',
                                        context, () {
                                      Navigator.pop(context);
                                    });
                                  } else {
                                    final respt = await Navigator.push(
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
                                    }
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
        ),
      ),
    );
  }

  Widget buildSwipeActionLeft() => Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      color: Colors.transparent,
      child: Icon(
        Icons.settings_backup_restore_rounded,
        color: Colors.red[600],
        size: 32,
      ));
  Widget buildSwipeActionRigth() => Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      color: Colors.transparent,
      child: Icon(
        Icons.settings_backup_restore_rounded,
        color: Colors.red[600],
        size: 32,
      ));
  ListTile _banTitle(TramaIntervencion band) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blue[800],
        child: Text(
          '${band.estado?.substring(0, 1)}',
          style: const TextStyle(color: Colors.white),
        ),
      ),
      title: Text('${band.tambo}', style: const TextStyle(fontSize: 13)),
      subtitle:
          Text('${band.tipoGobierno}', style: const TextStyle(fontSize: 10)),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 70,
            child: Text(
              ' ${band.fecha}',
              style: const TextStyle(fontSize: 10),
            ),
          ),
          const SizedBox(
            width: 70,
            child: Text(
              ' ',
              style: TextStyle(fontSize: 10),
            ),
          ),
          Text(
            ' ${band.estado}',
            style: const TextStyle(fontSize: 10),
          ),
        ],
      ),
      onTap: () async {
        status = ConnectionStatusModel().isOnline;
        fToast.showToast(
          toastDuration: const Duration(milliseconds: 500),
          child: Material(
            color: Colors.white,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.wifi),
                Text(
                  " Alert! $status",
                  style: const TextStyle(color: Colors.black87, fontSize: 16.0),
                )
              ],
            ),
          ),
          gravity: ToastGravity.CENTER,
        );
      },
    );
  }

  Future<bool> systemBackButtonPressed() async {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => Intervenciones('')));
    return true;
  }
}
