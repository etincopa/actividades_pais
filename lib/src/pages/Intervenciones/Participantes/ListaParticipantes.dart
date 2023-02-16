// ignore_for_file: must_be_immutable

import 'package:actividades_pais/src/datamodels/Provider/Provider.dart';
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
  ListaParticipantesVw(this.idProgramacion, this.snip);

  @override
  _ListaParticipantesVwState createState() => _ListaParticipantesVwState();
}

class _ListaParticipantesVwState extends State<ListaParticipantesVw> {
  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 0));
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
          child: Icon(
            Icons.person_add,
            color: Colors.white,
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0, // 1
          title: Center(
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
                  return Container(
                    child: RefreshIndicator(
                        child: ListView.builder(
                          itemCount: listaPersonalAux.length,
                          itemBuilder: (context, i) => Dismissible(
                              key: UniqueKey(),
                              child: Listas()
                                  .miCardParticipantes(listaPersonalAux[i]),
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
                                }
                              }),
                        ),
                        onRefresh: refreshList),
                  );
                }
              }
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
