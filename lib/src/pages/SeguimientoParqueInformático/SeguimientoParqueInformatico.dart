import 'dart:convert';

import 'package:actividades_pais/src/datamodels/Clases/Uti/FiltroListaEquipos.dart';
import 'package:actividades_pais/src/datamodels/Clases/Uti/ListaEquipoInformatico.dart';
import 'package:actividades_pais/src/datamodels/Clases/Uti/ListaMarca.dart';
import 'package:actividades_pais/src/datamodels/Clases/Uti/ListaModelo.dart';
import 'package:actividades_pais/src/datamodels/Provider/ProviderSeguimientoParqueInformatico.dart';
import 'package:actividades_pais/src/datamodels/Servicios/Servicios.dart';
import 'package:actividades_pais/src/pages/Intervenciones/Listas/Listas.dart';
import 'package:actividades_pais/src/pages/Intervenciones/util/utils.dart';
import 'package:actividades_pais/src/pages/SeguimientoParqueInform%C3%A1tico/CrudPaqueInformatico/EditarParqueInformatico.dart';
import 'package:actividades_pais/src/pages/SeguimientoParqueInform%C3%A1tico/DetalleEquipo/DetalleEquipoInformatico.dart';
import 'package:actividades_pais/src/pages/SeguimientoParqueInform%C3%A1tico/Reportes/ReporteEquipoInfomatico.dart';
import 'package:actividades_pais/util/app-config.dart';
import 'package:backdrop/backdrop.dart';
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
  TextEditingController controladorCodPatrimonial = TextEditingController();
  TextEditingController controladorDenominacion = TextEditingController();
  TextEditingController controladorCodInventario = TextEditingController();
  var seleccionarMarca = "Seleccionar Marca";
  var seleccionarModelo = "Seleccionar Modelo";
  var seleccionarUbicacion = "Seleccionar Ubicacion";
  var titulo = "PARQUE INFORMATICO";
  var pageIndex = 1;
  List<Modelo> listaModelos = [];

  final controller = ScrollController();
  bool isLoading = false;
  ListaEquipoInformatico listaEquipoInformatico = ListaEquipoInformatico();

  bool activar = false;

  @override
  void initState() {
    cargarAnios();
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

  final GlobalKey<BackdropScaffoldState> _backdropKey = GlobalKey();

  var listaAnios = [];
  String? selectedAnio;
  cargarAnios() {
    selectedAnio = "TODOS";
    listaAnios = [];
    listaAnios = [
      {"anio": "TODOS"},
      {"anio": "2024"},
      {"anio": "2023"},
      {"anio": "2019"},
      {"anio": "2018"},
      {"anio": "2017"}
    ];
  }
  // Variable para almacenar el año seleccionado

  @override
  Widget build(BuildContext context) {
    return BackdropScaffold(
      key: _backdropKey,

      appBar: BackdropAppBar(
        backgroundColor: AppConfig.primaryColor,
        elevation: 0.0,
        leading: Util().iconbuton(() {
          Navigator.pop(context);
        }),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          titulo,
          style: const TextStyle(fontSize: 17),
        ),
        actions: <Widget>[
          const BackdropToggleButton(
            color: Colors.black,
            icon: AnimatedIcons.ellipsis_search,
          ),
          InkWell(
            child: const Icon(
              Icons.restart_alt_sharp,
              color: Colors.black,
            ),
            onTap: () async {
              setState(() {
                isLoading = true;
              });
              await resetlista();

              setState(() {
                isLoading = false;
              });

              //  BusyIndicator.show(context);

              //  BusyIndicator.hide(context);
            },
          )
        ],
      ),
      /*AppBar(centerTitle: true,
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
      ),*/
      //frontLayerBackgroundColor: Colors.black,
      backLayerBackgroundColor: Colors.white,
      backLayer: Container(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(20),
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                _buildTextFormField(
                  controlador: controladorCodPatrimonial,
                  labelText: 'CODIGO PATRIMONIAL',
                  icon: const Icon(Icons.note_add, size: 15),
                  onChanged: (value) {
                    filtroParqueInformatico.codigoPatrimonial = value;
                  },
                ),
                _buildTextFormField(
                  controlador: controladorDenominacion,
                  labelText: 'DENOMINACION',
                  icon: const Icon(Icons.note_add, size: 15),
                  onChanged: (value) {
                    filtroParqueInformatico.denominacion = value;
                  },
                ),
                FutureBuilder<List<Marca>>(
                  future: ProviderSeguimientoParqueInformatico().listaMarcas(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Marca>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return const Text('Error al cargar las opciones');
                    } else {
                      return Row(
                        children: [
                          const Icon(Icons.account_balance_wallet_outlined,
                              size: 15, color: Colors.grey),
                          const SizedBox(width: 13),
                          Expanded(
                            child: DropdownButtonFormField<Marca>(
                              isExpanded: true,
                              items: snapshot.data?.map((user) {
                                return DropdownMenuItem<Marca>(
                                  value: user,
                                  child: Text(
                                    user.descripcionMarca!,
                                    style: const TextStyle(fontSize: 10),
                                  ),
                                );
                              }).toList(),
                              onChanged: (Marca? value) {
                                setState(() {
                                  seleccionarModelo = "Seleccionar Modelo";
                                  seleccionarMarca = '';
                                  activar = false;

                                  seleccionarMarca = value!.descripcionMarca!;
                                  filtroParqueInformatico.idMarca =
                                      value.idMarca.toString();
                                  // Llamada al método para obtener los modelos
                                  obtenerModelos(
                                      filtroParqueInformatico.idMarca!);
                                });
                              },
                              hint: Text(
                                seleccionarMarca,
                                style: const TextStyle(fontSize: 10),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
                activar == true
                    ? Container(
                        child: (listaModelos.isNotEmpty)
                            ? buildModeloDropdown(listaModelos)
                            : const Center(
                                child: Text("------Sin dato------"),
                              ),
                      )
                    : Container(),

                Row(
                  children: [
                    const Icon(Icons.account_balance_wallet_outlined,
                        size: 15, color: Colors.grey),
                    const SizedBox(width: 13),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: selectedAnio,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedAnio = newValue!;
                            filtroParqueInformatico.anio = selectedAnio;
                          });
                        },
                        decoration: const InputDecoration(
                          labelText: 'Año',
                        ),
                        items: listaAnios.map<DropdownMenuItem<String>>((item) {
                          return DropdownMenuItem<String>(
                            value: item["anio"],
                            child: Text(
                              item["anio"]!,
                              style: const TextStyle(fontSize: 10),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),

                _buildTextFormField(
                  labelText: 'CODIGO INVENTARIO',
                  controlador: controladorCodInventario,
                  icon: const Icon(Icons.note_add, size: 15),
                  onChanged: (value) {
                    filtroParqueInformatico.codInventario = value;
                  },
                ),

                //codInventario

                Container(
                  decoration: Servicios().myBoxDecoration(),
                  margin: const EdgeInsets.only(right: 10, left: 10, top: 10),
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
                      _backdropKey.currentState!.fling();
                      setState(() {
                        isLoading = false;
                      });
                    },
                    child: const Text("FILTRAR"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      frontLayer: FutureBuilder<List<ListaEquipoInformatico>>(
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
        shape: const CircleBorder(),
        //shape of button

        children: [
          SpeedDialChild(
            child: const Icon(Icons.airplay_sharp),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            label: 'REGISTRAR EQUIPO INFORMATICO',
            labelStyle: const TextStyle(fontSize: 18.0),
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
            child: const Icon(Icons.pie_chart),
            foregroundColor: Colors.white,
            backgroundColor: Colors.orangeAccent,
            label: 'REPORTE EQUIPO INFORMATICO',
            labelStyle: const TextStyle(fontSize: 18.0),
            onTap: () async {
              final respt = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ReporteEquipoInformatico(),
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

  Future<List<Modelo>> obtenerModelos(String idMarca) async {
    listaModelos = [];
    activar = false;
    List<Modelo> modelos = [];
    try {
      modelos =
          await ProviderSeguimientoParqueInformatico().listaModelos(idMarca);
      print(jsonEncode(modelos));
    } catch (error) {
      // Manejar el error de manera apropiada
    }
    listaModelos = modelos;
    setState(() {
      if (listaModelos.isNotEmpty) {
        activar = true;
      } else {
        activar = false;
      }
    });

    return modelos;
  }

  Widget buildModeloDropdown(List<Modelo> modelos) {
    return Row(
      children: [
        const Icon(Icons.account_tree_rounded, size: 15, color: Colors.grey),
        const SizedBox(width: 13),
        Expanded(
          child: Container(
            child: DropdownButtonFormField<Modelo?>(
              isExpanded: true,
              items: modelos.map((modelo) {
                return DropdownMenuItem<Modelo?>(
                  value: modelo,
                  child: Text(
                    modelo.descripcionModelo!,
                    style: const TextStyle(fontSize: 10),
                  ),
                );
              }).toList(),
              onChanged: (Modelo? modelo) {
                // Resto de tu lógica
              },
              hint: Text(
                seleccionarModelo,
                style: const TextStyle(fontSize: 10),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextFormField(
      {required String labelText,
      required Icon icon,
      required Function(String) onChanged,
      controlador}) {
    return TextFormField(
      controller: controlador,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: labelText,
        icon: icon,
      ),
      style: const TextStyle(fontSize: 10),
      onChanged: onChanged,
    );
  }

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
    cargarAnios();
    activar = false;
    listaModelos.clear();
    // listaModelos.clear();
    //selectedAnio = "";
    seleccionarMarca = "Seleccionar Marca";
    seleccionarModelo = "Seleccionar Modelo";
    seleccionarUbicacion = "Seleccionar Ubicacion";
    pageIndex = 1;
    controladorCodInventario.text = '';
    controladorCodPatrimonial.text = '';
    controladorDenominacion.text = '';
    filtroParqueInformatico.anio = '';
    filtroParqueInformatico.codInventario = '';
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

  Future<void> traerPaguinado(pageSize, pageIndex) async {
    filtroParqueInformatico.pageSize = pageSize;
    filtroParqueInformatico.pageIndex = pageIndex;
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      ProviderSeguimientoParqueInformatico()
          .listaParqueInformatico(filtroParqueInformatico);
    });
  }

  Widget _buildMarcaDropdownButtonFormField() {
    return FutureBuilder<List<Marca>>(
      future: ProviderSeguimientoParqueInformatico().listaMarcas(),
      builder: (BuildContext context, AsyncSnapshot<List<Marca>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return const Text('Error al cargar las opciones');
        } else {
          return Row(
            children: [
              const Icon(Icons.account_balance_wallet_outlined,
                  size: 15, color: Colors.grey),
              const SizedBox(width: 13),
              Expanded(
                child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter dropDownState) {
                    return DropdownButtonFormField<Marca>(
                      isExpanded: true,
                      items: snapshot.data?.map((user) {
                        return DropdownMenuItem<Marca>(
                          value: user,
                          child: Text(
                            user.descripcionMarca!,
                            style: const TextStyle(fontSize: 10),
                          ),
                        );
                      }).toList(),
                      onChanged: (Marca? value) {
                        dropDownState(() {
                          seleccionarMarca = value!.descripcionMarca!;
                          filtroParqueInformatico.idMarca =
                              value.idMarca.toString();
                        });
                      },
                      hint: Text(
                        seleccionarMarca,
                        style: const TextStyle(fontSize: 10),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
