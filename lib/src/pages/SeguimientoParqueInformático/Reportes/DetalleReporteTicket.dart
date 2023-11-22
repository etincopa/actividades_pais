import 'package:actividades_pais/src/datamodels/Clases/Uti/FiltroTicketEquipo.dart';
import 'package:actividades_pais/src/datamodels/Clases/Uti/ListaPersonalSoporte.dart';
import 'package:actividades_pais/src/datamodels/Clases/Uti/ListaTicketEquipos.dart';
import 'package:actividades_pais/src/datamodels/Clases/Uti/ListaTicketEstado.dart';
import 'package:actividades_pais/src/datamodels/Provider/ProviderSeguimientoParqueInformatico.dart';
import 'package:actividades_pais/src/datamodels/Servicios/Servicios.dart';
import 'package:actividades_pais/src/pages/Intervenciones/Listas/Listas.dart';
import 'package:flutter/material.dart';

class DetalleReporte extends StatefulWidget {

   String estado="";

  //FiltroTicketEquipo filtroTicketEquipo;

  DetalleReporte(this.estado, {super.key});

  @override
  State<DetalleReporte> createState() => _DetalleReporteState();
}

class _DetalleReporteState extends State<DetalleReporte> {
  final controller = ScrollController();
  Listas listas = Listas();
  bool isLoading = false;
  var pageIndex = 1;

  String seleccionarPersonal = "Seleccionar Personal";

  String seleccionarEstado = "Seleccionar Estado";
  FiltroTicketEquipo filtroTicketEquipo = FiltroTicketEquipo();

  @override
  void initState() {
    print("estado ${widget.estado}");
    // TODO: implement initState
    super.initState();
    controller.addListener(_onlistener);
    ///widget.filtroTicketEquipo.idEquipo = '6938';
    filtroTicketEquipo.pageSize = 10;
    filtroTicketEquipo.pageIndex = pageIndex;
    filtroTicketEquipo.estado = widget.estado;


  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.removeListener(_onlistener);
    super.dispose();

  }


  _onlistener() async {
    if ((controller.offset >= controller.position.maxScrollExtent)) {
      setState(() {
        isLoading = true;
        pageIndex = pageIndex + 1;
      });
      await traerPaguinado(10, pageIndex);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    /*
  const DetalleReporte({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title:Text( "DETALLE REPORTE TICKET"),centerTitle: true,),
      body: Container(),
      );
  }
}
*/
    return Scaffold(
        appBar: AppBar(title:Text( "TICKET ${widget.estado}"),centerTitle: true,) ,
     /* floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showAddNoteDialog(context);
          },
          child: InkWell(
            child: Icon(Icons.filter_alt_outlined),
          )),*/
      body: FutureBuilder<List<ListaEquiposInformaticosTicket>>(
        future: ProviderSeguimientoParqueInformatico()
            .ListaEstadosTickeDatos(
            filtroTicketEquipo: filtroTicketEquipo),
        builder: (BuildContext context,
            AsyncSnapshot<List<ListaEquiposInformaticosTicket>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.hasData == false) {
              return const Center(
                child: Text("¡No existen registros"),
              );
            } else {
              final listaPersonalAux = snapshot.data;
              if (listaPersonalAux!.isEmpty) {
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
                                controller: controller,
                                itemCount: listaPersonalAux.length,
                                itemBuilder: (context, i) => Dismissible(
                                    key: UniqueKey(),
                                    background: buildSwipeActionLeft(),
                                    secondaryBackground: buildSwipeActionRigth(),
                                    onDismissed: (direction) async {
                                      switch (direction) {
                                        case DismissDirection.endToStart:
                                          break;
                                        case DismissDirection.startToEnd:
                                          break;
                                        case DismissDirection.vertical:
                                        // TODO: Handle this case.
                                          break;
                                        case DismissDirection.horizontal:
                                        // TODO: Handle this case.
                                          break;
                                        case DismissDirection.up:
                                        // TODO: Handle this case.
                                          break;
                                        case DismissDirection.down:
                                        // TODO: Handle this case.
                                          break;
                                        case DismissDirection.none:
                                        // TODO: Handle this case.
                                          break;
                                      }
                                    },
                                    child: listas.cardParqueInformaticoTicket(
                                      listaPersonalAux[i],
                                          () async {
                                        /*  final respt = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  DetalleEquipoInformatico(listaPersonalAux[i]),
                                            ));
                                        if (respt == 'ok') {
                                          print("aqioioo");
                                          // refreshList();
                                        }*/
                                      },
                                    )),
                              )),
                        )),
                    if (isLoading == true)
                      const Center(
                        child: CircularProgressIndicator(),
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

  _showAddNoteDialog(BuildContext context) => showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("FILTRO"),
          content: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                        hintText: 'NUMERO TICKET',
                        icon: Icon(Icons.note_add, size: 15)),
                    style: const TextStyle(fontSize: 10),
                    onChanged: (value) {
                      // filtroTicketEquipo.numeroTkt = value;
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.only(),
                    child: FutureBuilder<List<ListaPersonalSoporte>>(
                      future: ProviderSeguimientoParqueInformatico()
                          .getListaPersonalSoporte(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<ListaPersonalSoporte>> snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        final preguntas = snapshot.data;
                        if (preguntas!.isEmpty) {
                          return const Center(
                            child: Text("sin dato"),
                          );
                        } else {
                          return Row(
                            children: [
                              const Icon(Icons.account_balance_wallet_outlined,
                                  size: 15, color: Colors.grey),
                              const SizedBox(width: 13),
                              Expanded(
                                child: Container(
                                  child: StatefulBuilder(builder:
                                      (BuildContext context,
                                      StateSetter dropDownState) {
                                    return DropdownButtonFormField<
                                        ListaPersonalSoporte>(
                                      isExpanded: true,
                                      items: snapshot.data?.map((user) {
                                        return DropdownMenuItem<
                                            ListaPersonalSoporte>(
                                          value: user,
                                          child: Text(
                                            user.nOMBREAPELLIDOS!,
                                            style:
                                            const TextStyle(fontSize: 10),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (ListaPersonalSoporte? value) {
                                        dropDownState(() {
                                          seleccionarPersonal =
                                          value!.nOMBREAPELLIDOS!;
                                       filtroTicketEquipo.asignado = value.idEmpleado;
                                        });
                                      },
                                      hint: Text(
                                        seleccionarPersonal,
                                        style: const TextStyle(fontSize: 10),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(),
                    child: FutureBuilder<List<ListaTicketEstado>>(
                      future: ProviderSeguimientoParqueInformatico()
                          .getListaTicketEstado(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<ListaTicketEstado>> snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        final preguntas = snapshot.data;
                        if (preguntas!.isEmpty) {
                          return const Center(
                            child: Text("sin dato"),
                          );
                        } else {
                          return Row(
                            children: [
                              const Icon(Icons.account_balance_wallet_outlined,
                                  size: 15, color: Colors.grey),
                              const SizedBox(width: 13),
                              Expanded(
                                child: Container(
                                  child: StatefulBuilder(builder:
                                      (BuildContext context,
                                      StateSetter dropDownState) {
                                    return DropdownButtonFormField<
                                        ListaTicketEstado>(
                                      isExpanded: true,
                                      items: snapshot.data?.map((user) {
                                        return DropdownMenuItem<
                                            ListaTicketEstado>(
                                          value: user,
                                          child: Text(
                                            user.nombre!,
                                            style:
                                            const TextStyle(fontSize: 10),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (ListaTicketEstado? value) {
                                        dropDownState(() {
                                          seleccionarEstado = value!.nombre!;
                                        });
                                      },
                                      hint: Text(
                                        seleccionarEstado,
                                        style: const TextStyle(fontSize: 10),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            Container(
                decoration: Servicios().myBoxDecoration(),
                margin: const EdgeInsets.only(right: 10, left: 10),
                height: 40.0,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[600],
                  ),
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    await traerPaguinado(10, 1);
                    Navigator.of(context).pop();

                    setState(() {
                      isLoading = false;
                    });
                  },
                  child: const Text("FILTRAR"),
                ))
          ],
        );
      });

  Widget buildSwipeActionRigth() => Container(
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

  Widget buildSwipeActionLeft() => Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      color: Colors.transparent,
      child: Row(
        children: [
          Text(
            "Editar",
            style: TextStyle(color: Colors.green[600]),
          ),
          Icon(
            Icons.edit,
            color: Colors.green[600],
            size: 32,
          )
        ],
      ));

  Future<void> resetlista() async {
    seleccionarPersonal = "Seleccionar Personal";
    seleccionarEstado = "Seleccionar Estado";
    pageIndex = 1;

    /*   filtroParqueInformatico.codigoPatrimonial = '';
    filtroParqueInformatico.denominacion = '';
    filtroParqueInformatico.idMarca = '';
    filtroParqueInformatico.idModelo = '';
    filtroParqueInformatico.idUbicacion = '';
    filtroParqueInformatico.responsableactual = '';
    filtroParqueInformatico.pageSize = 10;
    filtroParqueInformatico.pageIndex = pageIndex;
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      ProviderSeguimientoParqueInformatico()
          .listaParqueInformatico(filtroParqueInformatico);
    });*/
  }

  Future<void> traerPaguinado(pageSize, pageIndex) async {
    filtroTicketEquipo.pageSize = pageSize;
    filtroTicketEquipo.pageIndex = pageIndex;
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      ProviderSeguimientoParqueInformatico()
          .getListaEquiposInformaticosTicket(filtroTicketEquipo: filtroTicketEquipo);
    });
  }
}