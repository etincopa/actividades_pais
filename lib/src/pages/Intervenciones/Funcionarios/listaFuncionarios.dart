import 'package:flutter/material.dart';
import 'package:actividades_pais/src/datamodels/Clases/Funcionarios.dart';
import 'package:actividades_pais/src/datamodels/Clases/TramaIntervencion.dart';
import 'package:actividades_pais/src/datamodels/database/DatabasePr.dart';
import 'package:actividades_pais/src/pages/Intervenciones/Funcionarios/Funcionarios.dart';
import 'package:actividades_pais/src/pages/Intervenciones/Listas/Listas.dart';
import 'package:actividades_pais/src/pages/Intervenciones/util/utils.dart';

import '../../../../util/app-config.dart';

class ListaFuncionariosVw extends StatefulWidget {
  TramaIntervencion tramaIntervencion;

  ListaFuncionariosVw(this.tramaIntervencion, {super.key});

  @override
  _ListaFuncionariosVwState createState() => _ListaFuncionariosVwState();
}

class _ListaFuncionariosVwState extends State<ListaFuncionariosVw> {
  Future<void> refreshList() async {
    await Future.delayed(const Duration(seconds: 0));
    await DatabasePr.db
        .listarFuncionarios(widget.tramaIntervencion.codigoIntervencion);
    // await DatabasePr.db.listarParticipantes(widget.idProgramacion);
    //  await DatabasePr.db.listarPartExtrangeros(widget.idProgramacion);
  }

  Future<void> listaFuniconario() async {
    await Future.delayed(const Duration(seconds: 0));
    setState(() {
      DatabasePr.db
          .listarFuncionarios(widget.tramaIntervencion.codigoIntervencion);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor:   AppConfig.primaryColor,
          onPressed: () async {
            final respuesta = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => FuncionariosPage(
                      idProgramacion: int.parse(
                          widget.tramaIntervencion.codigoIntervencion!),
                      programa: widget.tramaIntervencion.programa!)),
            );

            if (respuesta.toString() == 'funcionarios') {
              refreshList();
              listaFuniconario();
            }
          },
          child: const Icon(
            Icons.person_add,
            color: Colors.white,
          ),
        ),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: const Center(
              child: Text(
            "Funcionarios",
            style: TextStyle(
              color: Colors.black, // 2
            ),
          )),
          /* actions: [
            InkWell(
              child: Icon(
                Icons.person_add,
                color: Colors.green[600],
              ),
              onTap: () async {},
            ),
            SizedBox(
              width: 10,
            )
          ], */
          automaticallyImplyLeading: false,
        ),
        body: FutureBuilder<List<Funcionarios>>(
          future: DatabasePr.db
              .listarFuncionarios(widget.tramaIntervencion.codigoIntervencion),
          builder: (BuildContext context,
              AsyncSnapshot<List<Funcionarios>> snapshot) {
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
                        onRefresh: listaFuniconario,
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
                                            'Funcionarios!!', context,
                                            () async {
                                          await DatabasePr.db
                                              .eliminarFuncionarioPorid(
                                                  listaPersonalAux[i].id);
                                          setState(() {});
                                          Navigator.pop(context);
                                        }, () async {
                                          await DatabasePr.db
                                              .listarFuncionarios(widget
                                                  .tramaIntervencion
                                                  .codigoIntervencion);
                                          setState(() {});
                                          Navigator.pop(context);
                                        });

                                        break;
                                      case DismissDirection.startToEnd:
                                        Util().showAlertDialogEliminar(
                                            'Funcionarios!!', context,
                                            () async {
                                          await DatabasePr.db
                                              .eliminarFuncionarioPorid(
                                                  listaPersonalAux[i].id);
                                          setState(() {});
                                          Navigator.pop(context);
                                        }, () async {
                                          setState(() {});
                                          await DatabasePr.db
                                              .listarFuncionarios(widget
                                                  .tramaIntervencion
                                                  .codigoIntervencion);

                                          Navigator.pop(context);
                                        });
                                        break;
                                      default:
                                    }
                                  },
                                  child: Listas()
                                      .cardFuncionarios(listaPersonalAux[i]),
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
}
