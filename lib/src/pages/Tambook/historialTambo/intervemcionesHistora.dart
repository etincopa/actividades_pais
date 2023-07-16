import 'package:actividades_pais/src/datamodels/Clases/Tambos/TamboServicioIntervencionesGeneral.dart';
import 'package:actividades_pais/src/datamodels/Clases/Tambos/TipoGobiernoResponse.dart';
import 'package:actividades_pais/src/datamodels/Provider/ProviderTambok.dart';
import 'package:actividades_pais/src/pages/Intervenciones/Listas/Listas.dart';
import 'package:actividades_pais/src/pages/Tambook/historialTambo/fichaIntervencion.dart';
import 'package:actividades_pais/util/app-config.dart';
import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class intervencionesHistoria extends StatefulWidget {
  const intervencionesHistoria({Key? key}) : super(key: key);

  @override
  State<intervencionesHistoria> createState() => _intervencionesHistoriaState();
}

class _intervencionesHistoriaState extends State<intervencionesHistoria> {
  final controller = ScrollController();
  bool isLoading = false;
  var pageIndexQ = 1;
  var pageSizeQ = 2;
  var tipoIntervencions = [
    {"value": '1', "descripcion": 'Intervención de Ámbito Directo'},
    {"value": '2', "descripcion": 'Intervención de Soporte a Entidades'},
    {"value": '3', "descripcion": 'Coordinaciones'},
  ];
  final GlobalKey<BackdropScaffoldState> _backdropKey = GlobalKey();

  List<TipoGobiernoResponse> tipoGobiernos = [];
  List<TipoGobiernoResponse> sectores = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    obtenerListaTipoGobierno(0);
    controller.addListener(_onlistener);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.removeListener(_onlistener);
    super.dispose();
  }

  _onlistener() async {
    print(controller.position.maxScrollExtent);

    if ((controller.offset >= controller.position.maxScrollExtent)) {
      isLoading = true;
      setState(() {
        pageSizeQ = pageSizeQ + 2;
      });
      await traerPaguinado(10);
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> traerPaguinado(pageSize) async {
    // await Future.delayed(const Duration(seconds: 1));
    //  pageIndexQ = pageIndex;
    await ProviderTambok().listaTamboServicioIntervencionesGeneral(
        gobierno: 0, sector: 0, pag: 1, sizePag: pageSize);
    setState(() {});
  }

  Future<void> obtenerListaTipoGobierno(tipo) async {
    TipoGobiernoResponse oDefault = TipoGobiernoResponse();
    oDefault.idSector = 0;
    oDefault.idTipoGobierno = 0;
    oDefault.nombre = "TODOS LOS TIPOS DE GOBIERNO";

    tipoGobiernos = await ProviderTambok().obtenerTipoGobierno(tipo) ?? [];
    tipoGobiernos.add(oDefault);
    tipoGobiernos
        .sort((a, b) => a.idTipoGobierno!.compareTo(b.idTipoGobierno!));

    //print(tipoGobiernos[0].nombre);
    setState(() {});
  }

  String? tipoIntervencion = '1';
  String? idTipoGobierno = '0';
  String? idSector = '0';

  @override
  Widget build(BuildContext context) {
    Listas listas = Listas();
    return BackdropScaffold(
        key: _backdropKey,
        appBar: BackdropAppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          // backgroundColor: AppConfig.primaryColor,
          leading: InkWell(
            child: const Icon(
              Icons.restart_alt_sharp,
              color: Colors.black,
            ),
            onTap: () async {
              pageSizeQ = 10;
              tipoIntervencion = '1';

              setState(() {});
            },
          ),
          automaticallyImplyLeading: false,
          title: const Text(
            "INTERVENCIONES",
            style: TextStyle(fontSize: 15, color: Colors.black),
          ),
          centerTitle: true,
          actions: const <Widget>[
            BackdropToggleButton(
              color: Colors.black,
              icon: AnimatedIcons.list_view,
            ),
          ],
        ),
        frontLayerBackgroundColor: Colors.white,
        //frontLayerBorderRadius: BorderRadius.horizontal(),
        backLayerBackgroundColor: Colors.white60,
        frontLayer: FutureBuilder<List<TamboServicioIntervencionesGeneral>>(
          future: ProviderTambok().listaTamboServicioIntervencionesGeneral(
              pag: 1,
              sizePag: pageSizeQ,
              tipo: tipoIntervencion,
              gobierno: idTipoGobierno,
              sector: idSector),
          builder: (BuildContext context,
              AsyncSnapshot<List<TamboServicioIntervencionesGeneral>>
                  snapshot) {
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
                          child: RefreshIndicator(
                              onRefresh: resetlista,
                              child: ListView.builder(
                                controller: controller,
                                itemCount: listaPersonalAux.length,
                                itemBuilder: (context, i) =>
                                    listas.cardHistrialTambosInter(
                                  listaPersonalAux[i],
                                  () async {
                                    var status =
                                        await Permission.storage.status;
                                    if (status != PermissionStatus.granted) {
                                      status =
                                          await Permission.storage.request();
                                      setState(() {});
                                    }
                                    await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                FichaIntervencion(
                                                    listaPersonalAux[i]
                                                        .idProgramacion!,
                                                    listaPersonalAux[i]
                                                        .fecha!)));
                                  },
                                ),
                              ))),
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
        backLayer: ListView(children: [
          Container(
              margin: const EdgeInsets.all(20),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.account_balance_wallet_outlined,
                            size: 15, color: Colors.grey),
                        const SizedBox(width: 13),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: tipoIntervencion,
                            onChanged: (String? newValue) {
                              tipoIntervencion = newValue;

                              /*  setState(() {

                            });*/
                            },
                            decoration: const InputDecoration(
                              labelText: 'Tipo Intervencion',
                            ),
                            items: tipoIntervencions.map((item) {
                              return DropdownMenuItem<String>(
                                value: item["value"],
                                child: Text(
                                  item["descripcion"]!,
                                  style: const TextStyle(fontSize: 12),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.account_balance_wallet_outlined,
                            size: 15, color: Colors.grey),
                        const SizedBox(width: 13),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: idTipoGobierno,
                            onChanged: (String? newValue) async {
                              var sectores = await ProviderTambok()
                                      .obtenerTipoGobierno(newValue) ??
                                  [];

                              TipoGobiernoResponse oDefault =
                                  TipoGobiernoResponse();
                              oDefault.idSector = 0;
                              oDefault.idTipoGobierno = 0;
                              oDefault.nombre = "TODOS LOS SECTORES";

                              sectores.add(oDefault);

                              sectores.sort(
                                  (a, b) => a.idSector!.compareTo(b.idSector!));

                              setState(() {
                                sectores = sectores;
                                idTipoGobierno = newValue;
                                idSector = "0";
                              });
                            },
                            decoration: const InputDecoration(
                              labelText: 'Tipo de Gobierno',
                            ),
                            items: tipoGobiernos.map((item) {
                              return DropdownMenuItem<String>(
                                value: item.idTipoGobierno.toString(),
                                child: Text(
                                  item.nombre!,
                                  style: const TextStyle(fontSize: 12),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.account_balance_wallet_outlined,
                            size: 15, color: Colors.grey),
                        const SizedBox(width: 13),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            isExpanded: true,
                            value: idSector == "0" ? null : idSector,
                            onChanged: (String? newValue) {
                              setState(() {
                                idSector = newValue;
                              });
                            },
                            decoration: const InputDecoration(
                              labelText: 'Seleccione sector',
                            ),
                            items: sectores.map((item) {
                              return DropdownMenuItem<String>(
                                value: item.idSector.toString(),
                                child: Text(
                                  item.nombre!,
                                  style: const TextStyle(fontSize: 10),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Container(
                        //  decoration: Servicios().myBoxDecoration(),
                        margin: const EdgeInsets.only(right: 10, left: 10),
                        height: 40.0,
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppConfig.primaryColor,
                          ),
                          onPressed: () async {
                            await ProviderTambok()
                                .listaTamboServicioIntervencionesGeneral(
                                    pag: 1,
                                    sizePag: pageSizeQ,
                                    tipo: tipoIntervencion,
                                    gobierno: idTipoGobierno,
                                    sector: idSector);
                            _backdropKey.currentState!.fling();
                            setState(() {});
                            //_loadData();
                          },
                          child: const Text("FILTRAR"),
                        )),
                  ],
                ),
              ))
        ]));
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
    // await ProviderTambok().listaTamboServicioIntervencionesGeneral(1, 10);
    pageIndexQ = 1;
    pageSizeQ = 2;
    await ProviderTambok().listaTamboServicioIntervencionesGeneral(
        pag: pageIndexQ, sizePag: pageSizeQ);

    setState(() {});
    /*   seleccionarMarca = "Seleccionar Marca";
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
    });*/
  }
}
