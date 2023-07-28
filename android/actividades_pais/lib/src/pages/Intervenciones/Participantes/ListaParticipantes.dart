// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:actividades_pais/src/datamodels/Clases/Participantes.dart';
import 'package:actividades_pais/src/datamodels/database/DatabasePr.dart';
import 'package:actividades_pais/src/pages/Intervenciones/Listas/Listas.dart';
import 'package:actividades_pais/src/pages/Intervenciones/Participantes/Participantes.dart';
import 'package:actividades_pais/src/pages/Intervenciones/util/utils.dart';

import '../../../../util/app-config.dart';

class ListaParticipantesVw extends StatefulWidget {
  int idProgramacion;
  int snip;
  ListaParticipantesVw(this.idProgramacion, this.snip, {super.key});

  @override
  _ListaParticipantesVwState createState() => _ListaParticipantesVwState();
}

class _ListaParticipantesVwState extends State<ListaParticipantesVw> {
  Future<void> refreshList() async {
    await Future.delayed(const Duration(seconds: 0));
    await DatabasePr.db.listarFuncionarios(widget.idProgramacion);
    await DatabasePr.db
        .listarParticipantes(widget.idProgramacion, 'participantes');
    await DatabasePr.db.listarPartExtrangeros(widget.idProgramacion);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor:AppConfig.primaryColor,
          onPressed: () async {
            final respuesta = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ParticipantesPage(
                        idProgramacion: widget.idProgramacion,
                        snip: widget.snip,
                      )),
            );
            if (respuesta.toString() == 'participantes') {
              await refreshList();
              setState(() {});
            }
          },
          child: const Icon(
            Icons.person_add,
            color: Colors.white,
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0, // 1
          title: const Center(
            child: Text(
              "Participantes",
              style: TextStyle(
                color: Colors.black, // 2
              ),
            ),
          ),
          automaticallyImplyLeading: false,
          /*   actions: [
            InkWell(
              child: Icon(
                Icons.person_add,
                color: const Color(0xFF78b8cd),
              ),
              onTap: () async {},
            ),
            SizedBox(
              width: 10,
            )
          ], */
        ),
        body: FutureBuilder<List<Participantes>>(
          future: DatabasePr.db
              .listarParticipantes(widget.idProgramacion, 'participantes'),
          builder: (BuildContext context,
              AsyncSnapshot<List<Participantes>> snapshot) {
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
                              key: UniqueKey(),
                              background: Util().buildSwipeActionLeft(),
                              secondaryBackground:
                                  Util().buildSwipeActionRigth(),
                              onDismissed: (direction) async {
                                switch (direction) {
                                  case DismissDirection.endToStart:
                                    Util().showAlertDialogEliminar(
                                        'Participantes!!', context, () async {
                                      await DatabasePr.db
                                          .eliminarParticipantesPorid(
                                              listaPersonalAux[i].id);

                                      setState(() {});
                                      await DatabasePr.db.listarParticipantes(
                                          widget.idProgramacion,
                                          'participantes');
                                      Navigator.pop(context);
                                    }, () async {
                                      setState(() {});
                                      await DatabasePr.db.listarParticipantes(
                                          widget.idProgramacion,
                                          'participantes');
                                      Navigator.pop(context);
                                    });

                                    break;
                                  case DismissDirection.startToEnd:
                                    Util().showAlertDialogEliminar(
                                        'Participantes!!', context, () async {
                                      await DatabasePr.db
                                          .eliminarParticipantesPorid(
                                              listaPersonalAux[i].id);

                                      setState(() {});
                                      Navigator.pop(context);
                                    }, () async {
                                      setState(() {});
                                      Navigator.pop(context);
                                    });
                                    break;
                                  default:
                                }
                              },
                              child: Listas()
                                  .miCardParticipantes(listaPersonalAux[i])),
                        )),
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
}
