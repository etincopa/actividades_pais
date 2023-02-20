import 'package:actividades_pais/src/datamodels/Clases/Uti/FiltroListaEquipos.dart';
import 'package:actividades_pais/src/datamodels/Clases/Uti/ListaEquipoInformatico.dart';
import 'package:actividades_pais/src/datamodels/Clases/Uti/ListaMarca.dart';
import 'package:actividades_pais/src/datamodels/Clases/Uti/ListaModelo.dart';
import 'package:actividades_pais/src/datamodels/Clases/Uti/ListaUbicacion.dart';
import 'package:actividades_pais/src/datamodels/Provider/ProviderSeguimientoParqueInformatico.dart';
import 'package:actividades_pais/src/datamodels/Servicios/Servicios.dart';
import 'package:actividades_pais/src/pages/Intervenciones/Listas/Listas.dart';
import 'package:actividades_pais/src/pages/Intervenciones/util/utils.dart';
import 'package:actividades_pais/src/pages/SeguimientoParqueInform%C3%A1tico/CrudPaqueInformatico/EditarParqueInformatico.dart';
import 'package:actividades_pais/src/pages/SeguimientoParqueInform%C3%A1tico/DetalleEquipo/DetalleEquipoInformatico.dart';
import 'package:actividades_pais/src/pages/SeguimientoParqueInform%C3%A1tico/Reportes/ReporteEquipoInfomatico.dart';
import 'package:actividades_pais/util/app-config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class SeguimientoParqueInformatico extends StatefulWidget {
  const SeguimientoParqueInformatico({Key? key}) : super(key: key);

  @override
  State<SeguimientoParqueInformatico> createState() =>
      _SeguimientoParqueInformaticoState();
}

class _SeguimientoParqueInformaticoState
    extends State<SeguimientoParqueInformatico> {
  Listas listas = Listas();
  FiltroParqueInformatico filtroParqueInformatico = FiltroParqueInformatico();

  var seleccionarMarca = "Seleccionar Marca";
  var seleccionarModelo = "Seleccionar Modelo";
  var seleccionarUbicacion = "Seleccionar Ubicacion";
  var titulo = "PARQUE INFORMATICO";
  var pageIndex = 1;

  final controller = ScrollController();
  bool isLoading = false;
  ListaEquipoInformatico listaEquipoInformatico = ListaEquipoInformatico();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.addListener(_onlistener);
    filtroParqueInformatico.pageSize = 10;
    filtroParqueInformatico.pageIndex = pageIndex;
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
    return Scaffold(
      appBar: AppBar(centerTitle: true,
        backgroundColor: AppConfig.primaryColor,
        title: Text(
          titulo,
          style: const TextStyle(fontSize: 17),
        ),
        actions: [
          const SizedBox(width: 10),
          InkWell(
            child: const Icon(Icons.filter_list_rounded),
            onTap: () {
              resetlista();
              _showAddNoteDialog(context);
            },
          ),
          const SizedBox(width: 10),
          InkWell(
            child: const Icon(Icons.restart_alt_sharp),
            onTap: () async {
              setState(() {
                isLoading = true;
              });
              await resetlista();

              setState(() {
                isLoading = false;
              });
            },
          )
        ],
      ),
      body: FutureBuilder<List<ListaEquipoInformatico>>(
        future: ProviderSeguimientoParqueInformatico()
            .listaParqueInformatico(filtroParqueInformatico),
        builder: (BuildContext context,
            AsyncSnapshot<List<ListaEquipoInformatico>> snapshot) {
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
                            controller: controller,
                            itemCount: listaPersonalAux.length,
                            itemBuilder: (context, i) => Dismissible(
                                key: UniqueKey(),
                                background: buildSwipeActionLeft(),
                                secondaryBackground: buildSwipeActionRigth(),
                                onDismissed: (direction) async {
                                  switch (direction) {
                                    case DismissDirection.endToStart:
                                      Util().showAlertDialogokno(
                                          titulo, context, () async {
                                        await ProviderSeguimientoParqueInformatico()
                                            .EliminarEquipoInformatico(
                                                listaPersonalAux[i]);
                                        Navigator.pop(context);
                                        resetlista();
                                      }, () {
                                        Navigator.pop(context);
                                        resetlista();
                                      }, "Estas Seguro de Eliminar este equipo: ${listaPersonalAux[i].descripcionEquipoInformatico}");

                                      break;
                                    case DismissDirection.startToEnd:
                                      resetlista();
                                      final respt = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                EditarParqueInformatico(
                                                    listaEquipoInformatico:
                                                        listaPersonalAux[i],
                                                    titulo:
                                                        "EDITAR EQUIPO INFORMATICO",
                                                    tipo: 0),
                                          ));
                                      if (respt == 'OK') {
                                        resetlista();
                                      }
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
                                child: listas.cardParqueInformatico(
                                  listaPersonalAux[i],
                                  () async {
                                    await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DetalleEquipoInformatico(
                                                  listaPersonalAux[i]),
                                        ));
                                  },
                                )),
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
      floatingActionButton: SpeedDial(
        //Speed dial menu
        //marginBottom: 10, //margin bottom
        icon: Icons.menu,
        //icon on Floating action button|
        activeIcon: Icons.close,
        //icon when menu is expanded on button
        backgroundColor: Colors.green,
        //background color of button
        foregroundColor: Colors.white,
        //font color, icon color in button
        activeBackgroundColor: Colors.grey,
        //background color when menu is expanded
        activeForegroundColor: Colors.white,
        buttonSize: const Size(56.0, 56.0),
        //button size
        visible: true,
        closeManually: false,
        curve: Curves.bounceIn,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        onOpen: () => print('OPENING DIAL'),
        // action when menu opens
        onClose: () => print('DIAL CLOSED'),
        //action when menu closes

        elevation: 8.0,
        //shadow elevation of button
        shape: CircleBorder(),
        //shape of button

        children: [
          SpeedDialChild(
            child: Icon(Icons.airplay_sharp),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            label: 'REGISTRAR EQUIPO INFORMATICO',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () async {
              final respt = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditarParqueInformatico(
                        listaEquipoInformatico: listaEquipoInformatico,
                        titulo: "REGISTRAR EQUIPO INFORMATICO",
                        tipo: 1),
                  ));
              if (respt == 'OK') {
                resetlista();
              }
            },
            onLongPress: () => print('SECOND CHILD LONG PRESS'),
          ),
          SpeedDialChild(
            child: Icon(Icons.pie_chart),
            foregroundColor: Colors.white,
            backgroundColor: Colors.orangeAccent,
            label: 'REPORTE EQUIPO INFORMATICO',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () async {
              final respt = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReporteEquipoInformatico(),
                  ));
              if (respt == 'OK') {
                resetlista();
              }
            },
            onLongPress: () => print('THIRD CHILD LONG PRESS'),
          ),
        ],
      ),
    );
  }

  _showAddNoteDialog(BuildContext context) => showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("FILTRO"),
            content: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                          hintText: 'CODIGO PATRIMONIAL',
                          icon: Icon(Icons.note_add, size: 15)),
                      style: const TextStyle(fontSize: 10),
                      onChanged: (value) {
                        filtroParqueInformatico.codigoPatrimonial = value;
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                          hintText: 'DENOMINACION',
                          icon: Icon(Icons.note_add, size: 15)),
                      style: const TextStyle(fontSize: 10),
                      onChanged: (value) {
                        filtroParqueInformatico.denominacion = value;
                      },
                    ),

                    Container(
                      margin: const EdgeInsets.only(),
                      child: FutureBuilder<List<Marca>>(
                        future: ProviderSeguimientoParqueInformatico()
                            .listaMarcas(),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<Marca>> snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return CircularProgressIndicator(); // Muestra un indicador de carga mientras se carga la lista
                          } else if (snapshot.hasError) {
                            return Text('Error al cargar las opciones');
                          } else {
                            return Row(
                              children: [
                                const Icon(
                                    Icons.account_balance_wallet_outlined,
                                    size: 15,
                                    color: Colors.grey),
                                SizedBox(width: 13),
                                Expanded(
                                  child: Container(
                                    child: StatefulBuilder(builder:
                                        (BuildContext context,
                                        StateSetter dropDownState) {
                                      return DropdownButtonFormField<Marca>(
                                        isExpanded: true,
                                        items: snapshot.data?.map((user) {
                                          return new DropdownMenuItem<Marca>(
                                            value: user,
                                            child: new Text(
                                              user.descripcionMarca!,
                                              style:
                                              const TextStyle(fontSize: 10),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (Marca? value) {
                                          dropDownState(() {
                                            seleccionarMarca =
                                            value!.descripcionMarca!;
                                            filtroParqueInformatico.idMarca =
                                                value.idMarca.toString();
                                          });
                                        },
                                        hint: Text(
                                          seleccionarMarca,
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
                      child: FutureBuilder<List<Modelo>>(
                        future: ProviderSeguimientoParqueInformatico()
                            .listaModelos(),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<Modelo>> snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          final preguntas = snapshot.data;
                          if (preguntas!.length == 0) {
                            return const Center(
                              child: Text("sin dato"),
                            );
                          } else {
                            return Row(
                              children: [
                                const Icon(Icons.account_tree_rounded,
                                    size: 15, color: Colors.grey),
                                SizedBox(width: 13),
                                Expanded(
                                  child: Container(
                                    child: StatefulBuilder(builder:
                                        (BuildContext context,
                                            StateSetter dropDownState) {
                                      return DropdownButtonFormField<Modelo?>(
                                        isExpanded: true,
                                        //underline: Container(),
                                        items: snapshot.data?.map((user) {
                                          return new DropdownMenuItem<Modelo?>(
                                            value: user,
                                            child: new Text(
                                              user.descripcionModelo!,
                                              style:
                                                  const TextStyle(fontSize: 10),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (Modelo? value) {
                                          dropDownState(() {
                                            seleccionarModelo =
                                                value!.descripcionModelo!;
                                            filtroParqueInformatico.idModelo =
                                                value.idModelo.toString();
                                          });
                                        },
                                        hint: Text(
                                          seleccionarModelo,
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
                      child: FutureBuilder<List<Ubicacion>>(
                        future: ProviderSeguimientoParqueInformatico()
                            .listaUbicacion(),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<Ubicacion>> snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          final preguntas = snapshot.data;
                          if (preguntas!.length == 0) {
                            return const Center(
                              child: Text("sin dato"),
                            );
                          } else {
                            return Row(
                              children: [
                                const Icon(Icons.place,
                                    size: 15, color: Colors.grey),
                                const SizedBox(width: 13),
                                Expanded(child: StatefulBuilder(builder:
                                    (BuildContext context,
                                        StateSetter dropDownState) {
                                  return DropdownButtonFormField<Ubicacion>(
                                    isExpanded: true,
                                    items: preguntas.map((user) {
                                      return DropdownMenuItem<Ubicacion>(
                                        value: user,
                                        child:  Text(
                                          user.ubicacion!,
                                          style:
                                              const TextStyle(fontSize: 10),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (Ubicacion? value) {
                                      dropDownState(() {
                                        seleccionarUbicacion =
                                            value!.ubicacion!;
                                        filtroParqueInformatico.idUbicacion =
                                            value.idUbicacion.toString();
                                      });
                                    },
                                    hint: Text(
                                      seleccionarUbicacion,
                                      style: const TextStyle(fontSize: 10),
                                    ),
                                  );
                                }))
                              ],
                            );
                          }
                        },
                      ),
                    ),
                    TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                            hintText: 'RESPONSABLE ACTUAL',
                            icon: Icon(
                              Icons.note_add,
                              size: 15,
                            )),
                        style: const TextStyle(fontSize: 10)),
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
                      primary: Colors.blue[600],
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
        },
      );

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

  Future resetlista() async {
    seleccionarMarca = "Seleccionar Marca";
    seleccionarModelo = "Seleccionar Modelo";
    seleccionarUbicacion = "Seleccionar Ubicacion";
    pageIndex = 1;
    filtroParqueInformatico.codigoPatrimonial = '';
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
    });
  }

  Future<Null> traerPaguinado(pageSize, pageIndex) async {
    filtroParqueInformatico.pageSize = pageSize;
    filtroParqueInformatico.pageIndex = pageIndex;
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      ProviderSeguimientoParqueInformatico()
          .listaParqueInformatico(filtroParqueInformatico);
    });
  }
}
