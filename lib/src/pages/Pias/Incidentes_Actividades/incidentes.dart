// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:actividades_pais/src/datamodels/Clases/IncidentesNovedadesPias.dart';
import 'package:actividades_pais/src/datamodels/database/DatabasePias.dart';
import 'package:actividades_pais/src/pages/Intervenciones/Listas/Listas.dart';
import 'package:actividades_pais/src/pages/Intervenciones/util/utils.dart';

import '../../../../util/app-config.dart';

class Incidentes extends StatefulWidget {
  String  idUnicoReporte='';
  Incidentes(this.idUnicoReporte, {super.key});
  @override
  State<Incidentes> createState() => _IncidentesState();
}

class _IncidentesState extends State<Incidentes> {
  TextEditingController controllerIncidentes = TextEditingController();

  IncidentesNovedadesPias actividadesPias = IncidentesNovedadesPias();
/*  DateTime? nowfec = new DateTime.now();
  var formatter = new DateFormat('yyyy-MM-dd');*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppConfig.primaryColor,
          onPressed: () async {
            var a = DatabasePias.db;
            showAlertDialogAgregar(context, titulo: 'Agregar Incidente',
                controllerIncidentes: controllerIncidentes,
                presse: () {
                  if (controllerIncidentes.text == "") {
                    Util().showAlertDialog(
                        'Incidentes', 'Ingresar detalle', context, () {
                      Navigator.pop(context);
                    });
                  } else {
                    actividadesPias.incidentes = controllerIncidentes.text;
                    actividadesPias.idUnicoReporte = widget.idUnicoReporte;
                    actividadesPias.tipo = 1;
                    a.insertIncidentesNovedadesPias(actividadesPias);
                    listarIncidentes();
                    Navigator.pop(context);
                    controllerIncidentes.text = "";
                  }
                },
                pressno: () {
                  Navigator.pop(context);
                });
          },
          child: const Icon(Icons.plus_one),
        ),
        body: FutureBuilder<List<IncidentesNovedadesPias>>(
          future: DatabasePias.db.ListarIncidentesNovedadesPias(widget.idUnicoReporte, 1),
          builder: (BuildContext context,
              AsyncSnapshot<List<IncidentesNovedadesPias>> snapshot) {
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
                        onRefresh: listarIncidentes,
                        child: ListView.builder(
                            itemCount: listaPersonalAux.length,
                            itemBuilder: (context, i) =>
                                Dismissible(
                                  key: UniqueKey(),
                                  background: Util().buildSwipeActionLeft(),
                                  secondaryBackground:
                                  Util().buildSwipeActionRigth(),
                                  onDismissed: (direction) async {
                                    switch (direction) {
                                      case DismissDirection.endToStart:
                                        Util().showAlertDialogEliminar(
                                            'Incidentes!!', context,
                                                () async {
                                              await DatabasePias.db
                                                  .eliminarIncidentesNovedadesPiasid(
                                                  listaPersonalAux[i].id);
                                              setState(() {});
                                              Navigator.pop(context);
                                            }, () async {
                                          await DatabasePias.db
                                              .ListarIncidentesNovedadesPias(widget.idUnicoReporte, 1);
                                          setState(() {});
                                          Navigator.pop(context);
                                        });

                                        break;
                                      case DismissDirection.startToEnd:
                                        Util().showAlertDialogEliminar(
                                            'Incidentes!!', context,
                                                () async {
                                              await DatabasePias.db
                                                  .eliminarIncidentesNovedadesPiasid(
                                                  listaPersonalAux[i].id);
                                              setState(() {});
                                              Navigator.pop(context);
                                            }, () async {
                                          setState(() {});
                                          await DatabasePias.db
                                              .ListarIncidentesNovedadesPias(widget.idUnicoReporte, 1);
                                          Navigator.pop(context);
                                        });
                                        break;
                                      default:
                                    }
                                  },
                                  child: Listas()
                                      .cardIncidentesPias(listaPersonalAux[i]),
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
    );
  }

  Future<void> listarIncidentes() async {
    await Future.delayed(const Duration(seconds: 0));
    setState(() {
      DatabasePias.db.ListarIncidentesNovedadesPias(widget.idUnicoReporte, 1);
    });
  }

  showAlertDialogAgregar(BuildContext context,
      {titulo, presse, pressno, controllerIncidentes}) {
    Widget okButton = TextButton(onPressed: presse, child: const Text("Guardar"));
    Widget moButton = TextButton(onPressed: pressno, child: const Text("Cancelar"));
    AlertDialog alert = AlertDialog(
      title: Text(titulo),
      content: TextField(
        textCapitalization: TextCapitalization.sentences,
        controller: controllerIncidentes,
        maxLines: 5, //or null
        decoration: const InputDecoration.collapsed(hintText: "Insertar detalle"),
      ),
      actions: [okButton, moButton],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
