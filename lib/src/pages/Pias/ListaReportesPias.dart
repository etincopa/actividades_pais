import 'dart:async';
import 'package:flutter/material.dart';
import 'package:actividades_pais/src/datamodels/Clases/Pias/reportesPias.dart';
import 'package:actividades_pais/src/datamodels/Provider/Pias/ProviderDataJson.dart';
import 'package:actividades_pais/src/datamodels/Provider/Pias/ProviderServiciosRest.dart';
import 'package:actividades_pais/src/datamodels/Provider/Provider.dart';
import 'package:actividades_pais/src/datamodels/database/DatabasePias.dart';
import 'package:actividades_pais/src/pages/Intervenciones/Listas/Listas.dart';
import 'package:actividades_pais/src/pages/Intervenciones/util/utils.dart';
import 'package:actividades_pais/src/pages/Pias/ReporteDiario.dart';
import 'package:intl/intl.dart';
import 'package:actividades_pais/src/pages/Pias/Sincronizar/Sincronizar.dart';

import '../../../util/app-config.dart';

class ListaReportesPias extends StatefulWidget {
  String plataforma = "", unidadTeritorial = "";
  int idPlataforma = 0;
  String long = '';
  String lat = '';
  String campaniaCod = '';

  ListaReportesPias(
      {this.plataforma = "",
      this.unidadTeritorial = "",
      this.idPlataforma = 0,
      this.lat = '',
      this.long = '',
      this.campaniaCod = ''});

  @override
  _ListaReportesState createState() => _ListaReportesState();
}

class _ListaReportesState extends State<ListaReportesPias> {
  DateTime? nowfec = new DateTime.now();
  var formatter = new DateFormat('yyyy-MM-dd');
  var fechaselecc = '';
  Listas listas = Listas();

  String long = "";

  String lat = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    traerdato();
    cargarCombos();
  }

  traerdato() async {
    var art = await ProviderDatos().verificacionpesmiso();
    lat = art[0].latitude.toString();
    long = art[0].longitude.toString();
    setState(() {});
  }

  cargarCombos() async {
    await ProviderDataJson().getSaveClima();
    setState(() {});
  }

  Future refreshList() async {
    await DatabasePias.db.listaReportePias();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppConfig.primaryColor,
        onPressed: () async {
          final DateTime? picked = await showDatePicker(
            context: context,
            initialDate: nowfec!,
            firstDate: DateTime(2015, 8),
            lastDate: DateTime(2101),
          );

          if (picked != null) {
            final respuesta = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ReporteDiario(
                      plataforma: widget.plataforma,
                      unidadTeritorial: widget.unidadTeritorial,
                      idPlataforma: widget.idPlataforma,
                      idUnicoReporte: formatter.format(picked),
                      campaniaCod: widget.campaniaCod,
                      lat:lat,
                      long: long)),
            );
            if (respuesta == "OK") {
              refreshList();
              setState(() {});
            }
          }
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        leading: Util().iconbuton(()=> Navigator.of(context).pop()),
        title: Text("REPORTES PIAS", style: TextStyle(color: AppConfig.letrasColor),),
        backgroundColor:AppConfig.primaryColor,
        actions: [
          InkWell(
            child: Icon(Icons.cloud_upload),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SincronizarPage()),
              );
            },
          ),
          SizedBox(
            width: 10,
          ),
        /*  InkWell(
            child: Icon(Icons.cloud_download),
            onTap: () async {
         //     await DatabasePias.db.deletePuntoAtencionPias();
        //      await ProviderServiciosRest().listarPuntoAtencionPias(
          //        widget.campaniaCod, widget.idPlataforma, 0);
            },
          ),*/
          /*
            InkWell(
            child: Icon(Icons.cloud_upload),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SincronizarPage()),
              );
            },
          ),

          var rsp = await ProviderServiciosRest()
                                    .listarPuntoAtencionPias(
                                        codCampania.toString(), idTambo, 0);


                                        */
          SizedBox(
            width: 15,
          )
        ],
      ),
      body: FutureBuilder<List<ReportesPias>>(
        future: DatabasePias.db.listaReportePias(),
        builder:
            (BuildContext context, AsyncSnapshot<List<ReportesPias>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.hasData == false) {
              return Center(
                child: Text("¡No existen registros"),
              );
            } else {
              final listaPersonalAux = snapshot.data;

              if (listaPersonalAux!.length == 0) {
                return Center(
                  child: Text("No hay informacion"),
                );
              } else {
                //   return Container();
                return Container(
                  child: RefreshIndicator(
                      onRefresh: refreshList,
                      child: ListView.builder(
                        itemCount: listaPersonalAux.length,
                        itemBuilder: (context, i) => Dismissible(
                            key: UniqueKey(),
                            background: Util().buildSwipeActionLeft(),
                            secondaryBackground: Util().buildSwipeActionRigth(),
                            onDismissed: (direction) async {
                              switch (direction) {
                                case DismissDirection.endToStart:
                                  Util().showAlertDialogEliminar(
                                      'Reportes Pias!!', context, () async {
                                    await DatabasePias.db.eliminarReportePorId(
                                        listaPersonalAux[i].id);
                                    DatabasePias.db.eliminarReportePorIdru(
                                        listaPersonalAux[i].idUnicoReporte);
                                    setState(() {});
                                    await DatabasePias.db.listaReportePias();
                                    Navigator.pop(context);
                                  }, () async {
                                    setState(() {});
                                    await DatabasePias.db.listaReportePias();
                                    Navigator.pop(context);
                                  });

                                  break;
                                case DismissDirection.startToEnd:
                                  Util().showAlertDialogEliminar(
                                      'Reportes Pias!!', context, () async {
                                    await DatabasePias.db.eliminarReportePorId(
                                        listaPersonalAux[i].id);

                                    setState(() {});
                                    Navigator.pop(context);
                                  }, () async {
                                    setState(() {});
                                    Navigator.pop(context);
                                  });
                                  break;
                              }
                            },
                            child: listas.miCardLisReportPias(
                                listaPersonalAux[i], () async {
                              final respuesta = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ReporteDiario(
                                          plataforma: widget.plataforma,
                                          unidadTeritorial:
                                              widget.unidadTeritorial,
                                          idPlataforma: widget.idPlataforma,
                                          idUnicoReporte: listaPersonalAux[i]
                                              .fechaParteDiario,
                                          campaniaCod: widget.campaniaCod,
                                        )),
                              );
                               if (respuesta == "OK") {
                                refreshList();
                                setState(() {});
                              }
                            })),
                      )),
                );
              }
            }
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
