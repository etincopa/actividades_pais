import 'package:actividades_pais/src/Utils/utils.dart';
import 'package:actividades_pais/src/datamodels/Clases/EquipoMantenimiento.dart';
import 'package:actividades_pais/src/datamodels/Clases/Uti/FiltroTicketEquipo.dart';
import 'package:actividades_pais/src/datamodels/Clases/Uti/ListaEquipoInformatico.dart';
import 'package:actividades_pais/src/pages/Intervenciones/Listas/Listas.dart';
import 'package:actividades_pais/src/pages/SeguimientoParqueInform%C3%A1tico/DetalleEquipo/CrearMantenimiento.dart';
import 'package:actividades_pais/src/pages/SeguimientoParqueInform%C3%A1tico/DetalleEquipo/informe.dart';
import 'package:actividades_pais/src/pages/SeguimientoParqueInform%C3%A1tico/DetalleEquipo/verPdf.dart';
import 'package:flutter/material.dart';

import '../../../datamodels/Clases/Uti/ListaTicketEquipos.dart';
import '../../../datamodels/Provider/ProviderSeguimientoParqueInformatico.dart';

class Mantenimiento extends StatefulWidget {
  FiltroTicketEquipo filtroTicketEquipo;

  Mantenimiento(this.filtroTicketEquipo);

  @override
  State<Mantenimiento> createState() => _MantenimientoState();
}

class _MantenimientoState extends State<Mantenimiento> {
  Listas listas = Listas();
  EquipoMantenimiento equipoMantenimiento = EquipoMantenimiento();
  TextEditingController controlller = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    equipoMantenimiento.pageIndex = '1';
    equipoMantenimiento.pageSize = '10';
    equipoMantenimiento.id_equipo = widget.filtroTicketEquipo.idEquipo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final respt = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CrearMantenimiento(
                      int.parse(widget.filtroTicketEquipo.idEquipo!)),
                ));
            if (respt == 'OK') {
              resetlista();
            }

            /// _showAddNoteDialog(context);
          },
          child: InkWell(
            child: Icon(Icons.plus_one),
          )),
      body: FutureBuilder<List<EquipoMantenimiento>>(
        future: ProviderSeguimientoParqueInformatico()
            .ListaEquipoMantenimiento(equipoManto: equipoMantenimiento),
        builder: (BuildContext context,
            AsyncSnapshot<List<EquipoMantenimiento>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.hasData == false) {
              return const Center(
                child: Text("¡No existen registros"),
              );
            } else {
              final listaPersonalAux = snapshot.data;
              if (listaPersonalAux!.length == 0) {
                return const Center(
                  child: Text(
                    'No hay informacion',
                    style: TextStyle(fontSize: 19),
                  ),
                );
              } else {
                return Column(
                  children: [
                    Expanded(
                        child: Container(
                      child: RefreshIndicator(
                          onRefresh: resetlista,
                          child: ListView.builder(
                            //  controller: controller,
                            itemCount: listaPersonalAux.length,
                            itemBuilder: (context, i) => listas
                                .cardEquipoMantenimiento(listaPersonalAux[i],
                                    delete: () {
                              utils().showAlertDialogAprobar(
                                  "Eliminar!", context, () async {
                                await ProviderSeguimientoParqueInformatico()
                                    .EliminarEquipoInformaticoMantenimiento(
                                        listaPersonalAux[i]
                                            .idEquipoInformaticoMantenimiento);
                                Navigator.pop(context);
                                setState(() {

                                });
                              }, () {
                                Navigator.pop(context);
                              }, "Usted Desea Eliminar el item seleccionado.?");
                            }, descarga: () async {
                              final respt = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Informe(
                                        listaPersonalAux[i]
                                            .rutaInformeTecnico!),
                                  ));
                              if (respt == 'OK') {
                                resetlista();
                              }
                            }, descargarPdf: () async {
                              final respt = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => VerPdf(
                                        listaPersonalAux[i]
                                            .idEquipoInformaticoMantenimiento!),
                                  ));
                              if (respt == 'OK') {
                                resetlista();
                              }
                            }, editar: () {}),
                          )),
                    )),
                    if (isLoading == true)
                      new Center(
                        child: const CircularProgressIndicator(),
                      )
                  ],
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

  Widget buildSwipeActionRigth(
          ListaEquiposInformaticosTicket informaticosTicket) =>
      Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("Eliminar", style: TextStyle(color: Colors.red[600])),
              Icon(
                Icons.delete,
                color: Colors.red[600],
                size: 32,
              )
            ],
          ));

  Widget buildSwipeActionLeft(
          ListaEquiposInformaticosTicket informaticosTicket) =>
      Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          color: Colors.transparent,
          child: Row(
            children: [
              if (informaticosTicket.estado == "EN COLA") ...[
                Icon(
                  Icons.cached_sharp,
                  color: Colors.green[600],
                  size: 32,
                ),
                Text(
                  "Reasignar!",
                  style: TextStyle(color: Colors.green[600], fontSize: 10),
                ),
              ] else ...[
                Icon(
                  Icons.build,
                  color: Colors.green[600],
                  size: 32,
                ),
                Text(
                  "MATE/REPUESTO",
                  style: TextStyle(color: Colors.green[600], fontSize: 10),
                ),
              ],
            ],
          ));

  Future<Null> resetlista() async {
    setState(() {});
  }

  Future<Null> traerPaguinado(pageSize, pageIndex) async {
    widget.filtroTicketEquipo.pageSize = pageSize;
    widget.filtroTicketEquipo.pageIndex = pageIndex;
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      ProviderSeguimientoParqueInformatico().getListaEquiposInformaticosTicket(
          filtroTicketEquipo: widget.filtroTicketEquipo);
    });
  }
}
