import 'package:actividades_pais/src/datamodels/Clases/Intervenciones/DatosPlanMensual.dart';
import 'package:actividades_pais/src/datamodels/Clases/Intervenciones/HistorialObservaciones.dart';
import 'package:actividades_pais/src/datamodels/Provider/ProviderAprobacionPlanes.dart';
import 'package:actividades_pais/util/app-config.dart';
import 'package:flutter/material.dart';

class DetalleObservacion extends StatefulWidget {
  String idProgramacion="";
  DatosPlanMensual datosPlanMensual = DatosPlanMensual();
  DetalleObservacion(this.idProgramacion,{super.key, datosPlanMensual});
  @override
  _DetalleObservacionState createState() => _DetalleObservacionState();
}

class _DetalleObservacionState extends State<DetalleObservacion> {
  final List<bool> _isOpenList = [false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: AppConfig.primaryColor,title:const Text("DETALLES DE LA OBSERVACION / SUBSANACION", style: TextStyle(fontSize: 12),)),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: ListView(
          children: [
            ExpansionPanelList(
              expansionCallback: (index, isOpen) {
                setState(() {
                  _isOpenList[index] = !isOpen;
                });
              },
              children: [
                ExpansionPanel(
                  headerBuilder: (context, isOpen) {
                    return const ListTile(
                      title: Text('HISTORIAL DE OBSERVACION '),
                    );
                  },
                  body: ListTile(
                    title: FutureBuilder<List<Historialobservaciones>>(
                      future: ProviderAprobacionPlanes().ListarHistorialobservaciones(idProgramacion: widget.idProgramacion),
                      builder: (BuildContext context, AsyncSnapshot<List<Historialobservaciones>> snapshot) {
                        if (snapshot.hasData) {
                          final items = snapshot.data!;
                          return Column(
                            children: [

                              for (var nombre in items)
                                Card(
                                  child: ListTile(
                                    title: Text("${nombre.id} - ${nombre.observacion!} - (${nombre.fechaReg})"),
                                  ),
                                ),
                           ],
                          );

                        } else if (snapshot.hasError) {
                          return Text('Error al obtener datos de la API: ${snapshot.error}');
                        } else {
                          return const CircularProgressIndicator();
                        }
                      },
                    ),
                  ),
                  isExpanded: _isOpenList[0],
                ),
                ExpansionPanel(
                  headerBuilder: (context, isOpen) {
                    return const ListTile(
                        title: Text('HORIAL DE SUBSANACION'),
                    );
                  },
                  body: ListTile(
                    title:  FutureBuilder<List<Historialobservaciones>>(
                      future: ProviderAprobacionPlanes().ListarHistorialSubsanacion(idProgramacion: widget.idProgramacion),
                      builder: (BuildContext context, AsyncSnapshot<List<Historialobservaciones>> snapshot) {
                        if (snapshot.hasData) {
                          final items = snapshot.data!;
                          return Column(
                            children: [

                              for (var nombre in items)
                                Card(
                                  child: ListTile(
                                    title: Text("${nombre.id} - ${nombre.observacion!} - (${nombre.fechaReg})"),
                                  ),
                                ),
                            ],
                          );

                        } else if (snapshot.hasError) {
                          return Text('Error al obtener datos de la API: ${snapshot.error}');
                        } else {
                          return const CircularProgressIndicator();
                        }
                      },
                    ),
                  ),
                  isExpanded: _isOpenList[1],
                ),

              ],
            ),

          ],
        ),
      ),
    );
  }
}
