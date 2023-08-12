import 'package:flutter/material.dart';
import 'package:actividades_pais/src/datamodels/Clases/actividadesPias.dart';
import 'package:actividades_pais/src/datamodels/database/DatabasePias.dart';
import 'package:actividades_pais/src/pages/Intervenciones/Listas/Listas.dart';
import 'package:actividades_pais/src/pages/Intervenciones/util/utils.dart';

import '../../../../util/app-config.dart';

class ListaActividades extends StatefulWidget {
  String idUnicoReporte = '';
  ListaActividades(this.idUnicoReporte, {super.key});
  @override
  State<ListaActividades> createState() => _ListaActividadesState();
}

class _ListaActividadesState extends State<ListaActividades> {
  TextEditingController controllerActividad = TextEditingController();
  ActividadesPias actividadesPias = ActividadesPias();
  var a = DatabasePias.db;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppConfig.primaryColor,
          onPressed: () async {
            Util().showAlertDialogAgregar('Agregar Actividad', context,
                () async {
              if (controllerActividad.text == "") {
                Util().showAlertDialog(
                    'Agregar Actividad', 'Ingresar detalle', context, () {
                  Navigator.pop(context);
                });
              } else {
                actividadesPias.descripcion = controllerActividad.text;
                actividadesPias.idUnicoReporte = widget.idUnicoReporte;
                a.insertActividadesPias(actividadesPias);
                await listarActividadesPias();
                Navigator.pop(context);
                controllerActividad.text = "";
              }
            }, () {
              Navigator.pop(context);
            }, controllerActividad);
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        appBar: AppBar(
          elevation: 0,
           backgroundColor: Colors.transparent,
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "ACTIVIDADES",
                style: TextStyle(
                  color: Colors.black, // 2
                ),
              ),
            ],
          ),
          automaticallyImplyLeading: false,
        ),
        body: FutureBuilder<List<ActividadesPias>>(
          future: a.listarActividadesPias(widget.idUnicoReporte),
          builder: (BuildContext context,
              AsyncSnapshot<List<ActividadesPias>> snapshot) {
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
                        onRefresh: listarActividadesPias,
                        child: ListView.builder(
                            itemCount: listaPersonalAux.length,
                            itemBuilder: (context, i) => Dismissible(
                                  key: UniqueKey(),
                                  background: Util().buildSwipeActionLeft(),
                                  secondaryBackground:
                                      Util().buildSwipeActionRigth(),
                                  onDismissed: (direction) async {
                                    switch (direction) {
                                      case DismissDirection.endToStart:
                                        Util().showAlertDialogEliminar(
                                            'Actividades!!', context, () async {
                                          await a.eliminarActividadesPiasid(
                                              listaPersonalAux[i].id);
                                          setState(() {});
                                          Navigator.pop(context);
                                        }, () async {
                                          await a.listarActividadesPias(
                                              widget.idUnicoReporte);
                                          setState(() {});
                                          Navigator.pop(context);
                                        });

                                        break;
                                      case DismissDirection.startToEnd:
                                        Util().showAlertDialogEliminar(
                                            'Actividades!!', context, () async {
                                          await a.eliminarActividadesPiasid(
                                              listaPersonalAux[i].id);
                                          setState(() {});
                                          Navigator.pop(context);
                                        }, () async {
                                          setState(() {});
                                          await a.listarActividadesPias(
                                              widget.idUnicoReporte);
                                          Navigator.pop(context);
                                        });
                                        break;
                                      default:
                                    }
                                  },
                                  child: Listas()
                                      .cardActividadesPias(listaPersonalAux[i]),
                                ))),
                  );
                }
              }
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  Future<void> listarActividadesPias() async {
    await Future.delayed(const Duration(seconds: 0));
    setState(() {
      a.listarActividadesPias(widget.idUnicoReporte);
    });
  }
}
