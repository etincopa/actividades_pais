import 'dart:async';
import 'dart:io';

import 'package:actividades_pais/src/datamodels/Clases/AsistenciaModel.dart';
import 'package:actividades_pais/src/datamodels/Provider/Provider.dart';

import 'package:actividades_pais/src/datamodels/database/DatabasePr.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_3des/flutter_3des.dart';

//import 'package:sendsms/sendsms.dart';
import 'package:http/http.dart' as http;

///import 'package:imei_plugin/imei_plugin.dart';

///import 'package:sendsms/sendsms.dart';

class ListaasistenciaPage extends StatefulWidget {
  const ListaasistenciaPage({super.key});

  @override
  State<ListaasistenciaPage> createState() => _ListaasistenciaPageState();
}

class _ListaasistenciaPageState extends State<ListaasistenciaPage> {
  String _encryptHex = '';

  static const _key = "536f66747761726576616c7565656e637269707461646f73";
  static const _iv = "706572757465616d";

  List<AsistenciaModel> selectedContacts = [];

  //late StreamSubscription<ConnectivityResult> conexciosubscription;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription conexciosubscription;
  final ProviderDatos _provider = ProviderDatos();
  //final Connectivity _conct = new Connectivity();

  bool _isOnline = true;
  //var _conecstatus = 'ConnectivityResult.none';

  Future<void> _checkInternetConnection() async {
    setState(() {
      //Sendsms.hasPermission();
      //  Sendsms.onGetPermission();
    });

    try {
      await Future.delayed(const Duration(seconds: 1));
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        _isOnline = true;
      } else {
        _isOnline = false;
      }
    } on SocketException catch (_) {
      _isOnline = false;
    }
  }

  var datas = 0;
  Future<void> refreshList() async {
    await Future.delayed(const Duration(seconds: 1));
    var a = await DatabasePr.db.listaraEstado();
    setState(() {
      DatabasePr.db.listarasistencia();

      datas = a.length;
      //    otrovalido();
    });
  }

  @override
  void dispose() {
    conexciosubscription.cancel();
    super.dispose();
  }

/*  otrovalido() {
    conexciosubscription =
        _conct.onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() {
        _conecstatus = result.toString();
        //  print(_conecstatus);
      });
    });
  } */

  static Map<String, String> get headers {
    return {
      'Content-Type': 'application/json',
      // TODO: TOKEN DEL SQLITE
    };
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkInternetConnection();

    // otrovalido();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _checkInternetConnection();
      refreshList();
    });
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.indigo[900],
          title: const Text(
            'Sincronizar Registros',
            style: TextStyle(color: Colors.white),
          ),
          elevation: 1,
          actions: [
            if (_isOnline == true)
              InkWell(
                  onTap: () {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Alerta!!'),
                        content:
                            const Text('¿Estas seguro de sincronizar todo?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: null,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                InkWell(
                                  child: Text('Si',
                                      style:
                                          TextStyle(color: Colors.indigo[900])),
                                  onTap: () {
                                    setState(() {
                                      enviarTodo();
                                    });
                                    // refreshList();
                                    Navigator.pop(context);
                                  },
                                ),
                                InkWell(
                                  child: Text('No',
                                      style:
                                          TextStyle(color: Colors.indigo[900])),
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  child: const Icon(Icons.send_and_archive)),
            const SizedBox(
              width: 10,
            )
          ],
        ),
        body: FutureBuilder<List<AsistenciaModel>>(
          future: DatabasePr.db.listarasistencia(),
          builder: (BuildContext context,
              AsyncSnapshot<List<AsistenciaModel>> snapshot) {
            if (!snapshot.hasData) {
              if (snapshot.hasData == false) {
                return const Center(
                  child: Text("¡No existen registros!"),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }
            final listaPersonalAux = snapshot.data;

            if (listaPersonalAux!.isEmpty) {
              return const Center(
                child: Text("No hay informacion"),
              );
            } else {
              return Column(
                children: [
                  Container(
                      child: Expanded(
                    child: ListView.builder(
                      itemCount: listaPersonalAux.length,
                      itemBuilder: (context, i) {
                        return _banTitle(listaPersonalAux[i]);
                      },
                    ),
                  )),
                  /*  datas > 0
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 25,
                            vertical: 10,
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            child: RaisedButton(
                              color: Colors.green[700],
                              /* child: Text(
                                "Sincronizar (${datas})",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ), */
                              child: Text(
                                "Sincronizar",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                              onPressed: () {
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: const Text('Alerta!!'),
                                    content: const Text(
                                        '¿Estas seguro de sincronizar todo?'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: null,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            InkWell(
                                              child: Text(
                                                'Si',
                                                style: TextStyle(
                                                    color: Colors.blueAccent),
                                              ),
                                              onTap: () {
                                                setState(() {
                                                  enviarDato(
                                                    snip: listaPersonalAux![
                                                            datas - 1]
                                                        .snip,
                                                    tipoTrabajo:
                                                        listaPersonalAux[
                                                                datas - 1]
                                                            .tipoTrabajo,
                                                    idUnidadTerritorial:
                                                        listaPersonalAux[
                                                                datas - 1]
                                                            .idUnidadTerritorial,
                                                    dni: listaPersonalAux[
                                                            datas - 1]
                                                        .dni,
                                                    tipoCheck: listaPersonalAux[
                                                            datas - 1]
                                                        .tipoCheck,
                                                    latitud: listaPersonalAux[
                                                            datas - 1]
                                                        .latitud,
                                                    longitud: listaPersonalAux[
                                                            datas - 1]
                                                        .longitud,
                                                    fechaHora: listaPersonalAux[
                                                            datas - 1]
                                                        .fechaHora,
                                                    idLugarPrestacion:
                                                        listaPersonalAux[
                                                                datas - 1]
                                                            .idLugarPrestacion,
                                                    idUnidadOrganica:
                                                        listaPersonalAux[
                                                                datas - 1]
                                                            .idUnidadOrganica,
                                                    id: listaPersonalAux[
                                                            datas - 1]
                                                        .id,
                                                  );

                                                  print(listaPersonalAux[
                                                          datas - 1]
                                                      .tipohor);
                                                });
                                                // refreshList();
                                                Navigator.pop(context);
                                              },
                                            ),
                                            InkWell(
                                              child: Text('No'),
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                      : Container(), */
                ],
              );
            }
          },
        ));
  }

  Widget buildSwipeActionLeft() => Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      color: Colors.green,
      child: const Icon(
        Icons.check_box,
        color: Colors.white,
        size: 32,
      ));
  Widget buildSwipeActionRigth() => Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      color: Colors.red,
      child: const Icon(
        Icons.delete,
        color: Colors.white,
        size: 32,
      ));
  ListTile _banTitle(
    AsistenciaModel band,
  ) {
    bool vbans = false;
    if (band.isSelected == 0) {
      vbans = false;
    } else {
      vbans = true;
    }
    return ListTile(
      leading: const CircleAvatar(
        backgroundColor: Colors.white,
        child: Icon(Icons.calendar_today_outlined),
      ),
      title: Text('${band.tipoasistencia}->${band.fechaHora}',
          style: const TextStyle(fontSize: 12)),
      subtitle: Text('${band.tipohor} ${band.imei}',
          style: const TextStyle(fontSize: 13)),
      trailing: vbans
          ? Icon(
              Icons.settings_backup_restore,
              color: Colors.green[700],
            )
          : const Icon(
              Icons.settings_backup_restore,
              color: Colors.grey,
            ),
      onTap: () {
        setState(() {
          vbans = !vbans;
          if (vbans == true) {
            DatabasePr.db.updateAsistencia(
              1,
              band.id,
            );
            DatabasePr.db.updateAsistencias(
              0,
              band.id,
            );

            sendSms(
              snip: band.snip,
              tipoTrabajo: band.tipoTrabajo,
              idUnidadTerritorial: band.idUnidadTerritorial,
              dni: band.dni,
              tipoCheck: band.tipoCheck,
              latitud: band.latitud,
              longitud: band.longitud,
              fechaHora: band.fechaHora,
              idLugarPrestacion: band.idLugarPrestacion,
              idUnidadOrganica: band.idUnidadOrganica,
              id: band.id,
            );
            _provider.showMyDialog("Mensaje Enviado ", context);
            // selectedContacts.add(AsistenciaModel());
            refreshList();
          } else if (vbans == false) {
            print('false');
            DatabasePr.db.updateAsistencia(0, band.id);
            refreshList();

            selectedContacts.removeWhere(
                (element) => element.isSelected == band.isSelected);
          }
        });
      },
    );
  }

  Future traerNumerosTelf({encriptado, id}) async {
    var valor = false;
    /*  if (valor == false) {
      print('hola');
      CircularProgressIndicator(
        backgroundColor: Colors.red,
      );
    } */

    var abc = await DatabasePr.db.getAllNumerosTelf();
    var cantidad = abc.length;
    for (var i = 0; i < cantidad; i++) {
      /*  if (await Sendsms.hasPermission()) {
        valor = await Sendsms.onSendSMS(abc[i].numeroTelefono, encriptado);

        await DatabasePr.db.eliminarPorid(id);
        if (valor == true) {
          print('mensaje enviado');
        } else {
          CircularProgressIndicator(
            backgroundColor: Colors.red,
          );
        }

        refreshList();
      } */
      print(abc[i].numeroTelefono);
    }
  }

/*  send({encriptado, id}) async {
    String phoneNumber1 = "931687890";
    String phoneNumber2 = "954141302";
    String phoneNumber3 = "958045426";
    String phoneNumber5 = "951205740";
    String phoneNumber6 = "902132959";

    //‎+51 951 205 740

    String message = encriptado;

    if (await Sendsms.hasPermission()) {
      // await Sendsms.onSendSMS(phoneNumber1, message);
      await Sendsms.onSendSMS(phoneNumber2, message);
      await Sendsms.onSendSMS(phoneNumber3, message);
      await Sendsms.onSendSMS(phoneNumber5, message);

      print(await Sendsms.onSendSMS(phoneNumber6, message));
      await DatabasePr.db.eliminarPorid(id);
      refreshList();
      //eliminarPorid
    }
  }
 */
  Future<void> sendSms(
      {String nombrePersona = '',
      snip,
      tipoTrabajo,
      idUnidadTerritorial,
      dni,
      tipoCheck,
      latitud,
      longitud,
      fechaHora,
      idLugarPrestacion,
      idUnidadOrganica,
      id}) async {
    String text =
        "$snip/$tipoTrabajo/0/$dni/$tipoCheck/$latitud/$longitud/${DateTime.now()}/$idLugarPrestacion/$idUnidadOrganica";
    _encryptHex = await Flutter3des.encryptToHex(text, _key, iv: _iv);

    setState(() {
      traerNumerosTelf(encriptado: _encryptHex, id: id);
    });
  }

  Future enviarDato(
      {snip,
      tipoTrabajo,
      idUnidadTerritorial,
      dni,
      tipoCheck,
      latitud,
      longitud,
      fechaHora,
      idLugarPrestacion,
      idUnidadOrganica,
      id}) async {
    try {
      if (_isOnline == false) {
        sendSms(
            snip: snip,
            tipoTrabajo: tipoTrabajo,
            idUnidadTerritorial: idUnidadTerritorial,
            dni: dni,
            tipoCheck: tipoCheck,
            latitud: latitud,
            longitud: longitud,
            fechaHora: fechaHora,
            idLugarPrestacion: idLugarPrestacion,
            idUnidadOrganica: idUnidadOrganica,
            id: id);
        await DatabasePr.db.eliminarPorid(id);
      } else if (_isOnline == true) {
        http.Response response = await http.post(
            Uri.parse(
                'https://www.pais.gob.pe/backendsismonitor/public/gestionempleado/guardarasistencia'),
            headers: headers,
            body: '{  "snip" : $snip,'
                '"tipo_trabajo" : "$tipoTrabajo",'
                ' "id_unidad_territorial" : 0,'
                '  "dni" : "$dni",'
                '  "tipo_check" : "$tipoCheck",'
                '   "latitud" : "$latitud",'
                ' "longitud" : "$longitud",'
                '  "fecha_hora" : "$fechaHora",'
                ' "id_lugar_prestacion" : "$idLugarPrestacion",'
                ' "id_unidad_organica": "$idUnidadOrganica"'
                '}');

        await DatabasePr.db.eliminarPorid(id);
        refreshList();

        if (response.statusCode == 200) {
        } else if (response.statusCode == 500) {
          sendSms(
            snip: snip,
            tipoTrabajo: tipoTrabajo,
            idUnidadTerritorial: idUnidadTerritorial,
            dni: dni,
            tipoCheck: tipoCheck,
            latitud: latitud,
            longitud: longitud,
            fechaHora: fechaHora,
            idLugarPrestacion: idLugarPrestacion,
            idUnidadOrganica: idUnidadOrganica,
          );
        }
      }
    } on SocketException catch (_) {
      sendSms(
        snip: snip,
        tipoTrabajo: tipoTrabajo,
        idUnidadTerritorial: idUnidadTerritorial,
        dni: dni,
        tipoCheck: tipoCheck,
        latitud: latitud,
        longitud: longitud,
        fechaHora: fechaHora,
        idLugarPrestacion: idLugarPrestacion,
        idUnidadOrganica: idUnidadOrganica,
      );
    }
  }

  Future enviarTodo() async {
    var a = await DatabasePr.db.getDtjsGRC();
    for (var i = 0; i < a.length; i++) {
      print(a[i].snip);
      // ignore: unused_local_variable
      http.Response response = await http.post(
          Uri.parse(
              'https://www.pais.gob.pe/backendsismonitor/public/gestionempleado/guardarasistencia'),
          headers: headers,
          body: '{  "snip" : ${a[i].snip},'
              '"tipo_trabajo" : "${a[i].tipoTrabajo}",'
              ' "id_unidad_territorial" : 0,'
              '  "dni" : "${a[i].dni}",'
              '  "tipo_check" : "${a[i].tipoCheck}",'
              '   "latitud" : "${a[i].latitud}",'
              ' "longitud" : "${a[i].longitud}",'
              '  "fecha_hora" : "${a[i].fechaHora}",'
              ' "id_lugar_prestacion" : "${a[i].idLugarPrestacion}",'
              ' "id_unidad_organica": "${a[i].idUnidadOrganica}"'
              '}');
      print(response.statusCode);

      if (response.statusCode == 200) {
        print('{  "snip" : ${a[i].snip},'
            '"tipo_trabajo" : "${a[i].tipoTrabajo}",'
            ' "id_unidad_territorial" : 0,'
            '  "dni" : "${a[i].dni}",'
            '  "tipo_check" : "${a[i].tipoCheck}",'
            '   "latitud" : "${a[i].latitud}",'
            ' "longitud" : "${a[i].longitud}",'
            '  "fecha_hora" : "${a[i].fechaHora}",'
            ' "id_lugar_prestacion" : "${a[i].idLugarPrestacion}",'
            ' "id_unidad_organica": "${a[i].idUnidadOrganica}"'
            '}');
        DatabasePr.db.eliminarPorid(a[i].id);
      } else {
        print(response.statusCode);
      }
    }

    refreshList();
  }

  accionesEl(i) {
    return Material(
        elevation: 1.0,
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.red,
        child: SizedBox(
          height: 20.0,
          width: 20.0,
          child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            onPressed: () async {
              //   LoginUser(email.text, password.text);
            },
            child: Text("Eliminar",
                textAlign: TextAlign.center,
                style: const TextStyle(fontFamily: 'Montserrat', fontSize: 20.0)
                    .copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ));
  }
}
