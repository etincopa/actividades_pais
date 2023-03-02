import 'package:actividades_pais/src/datamodels/Clases/Intervenciones/DatosPlanMensual.dart';
import 'package:actividades_pais/src/datamodels/Clases/Intervenciones/FiltroDatosPlanesMensual.dart';
import 'package:actividades_pais/src/datamodels/Clases/Intervenciones/TambosDependientes.dart';
import 'package:actividades_pais/src/datamodels/Clases/Intervenciones/UnidadesTerritoriales.dart';
import 'package:actividades_pais/src/datamodels/Provider/ProviderAprobacionPlanes.dart';
import 'package:actividades_pais/src/datamodels/Servicios/Servicios.dart';
import 'package:actividades_pais/src/pages/Intervenciones/AprobacionPlanes/AprobarObservar.dart';
import 'package:actividades_pais/src/pages/Intervenciones/AprobacionPlanes/BackdropScaffold/backdrofile.dart';
import 'package:actividades_pais/src/pages/Intervenciones/AprobacionPlanes/DetalleObservacion.dart';
import 'package:actividades_pais/src/pages/Intervenciones/AprobacionPlanes/DetalleSubsanado.dart';
import 'package:actividades_pais/src/pages/Intervenciones/Listas/Listas.dart';
import 'package:actividades_pais/src/pages/Intervenciones/util/utils.dart';
import 'package:actividades_pais/util/app-config.dart';
import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AprobacionPlanesTrabajo extends StatefulWidget {
  const AprobacionPlanesTrabajo({Key? key}) : super(key: key);

  @override
  State<AprobacionPlanesTrabajo> createState() =>
      _AprobacionPlanesTrabajoState();
}

class _AprobacionPlanesTrabajoState extends State<AprobacionPlanesTrabajo> {
  //final controller = ScrollController();
  final GlobalKey<BackdropScaffoldState> _backdropKey = GlobalKey();
  final TextEditingController _controlleFechaInici = TextEditingController();
  final TextEditingController _controlleFechaFin = TextEditingController();
  FiltroDataPlanMensual filtroDataPlanMensual = FiltroDataPlanMensual();

  bool isLoading = false;
  bool isMostar = false;

  var seleccionarUnidadTerritorial = "Seleccionar UnidadTerritorial";
  var seleccionarPlataformaDescripcion = "Seleccionar plataforma";

  var estados = [
    {"value": 'x', "descripcion": 'TODOS'},
    {"value": '0', "descripcion": 'PROGRAMADO'},
    {"value": '1', "descripcion": 'APROBADO'},
    {"value": '2', "descripcion": 'OBSERVADO'},
    {"value": '3', "descripcion": 'SUBSANADO'},
  ];
  DateTime? nowfec = new DateTime.now();
  var formatter = new DateFormat('yyyy-MM-dd');

  var pageIndex = 1;

  @override
  void initState() {
    // TODO: implement initState
    inicio();
    ///controller.addListener(_onlistener);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
  //  controller.removeListener(_onlistener);
    super.dispose();
  }

  _onlistener() async {
       setState(() {
        isLoading = true;
        pageIndex = pageIndex + 1;
      });
      await traerPaguinado(10, pageIndex);
      setState(() {
        isLoading = false;
      });

  }

  /*  _onlistener() async {
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
  }*/
  Future<Null> traerPaguinado(pageSize, pageIndex) async {
    filtroDataPlanMensual.pageSize = pageSize;
    filtroDataPlanMensual.pageIndex = pageIndex;
    setState(() {});
  }

  inicio() async {
    filtroDataPlanMensual.id = "x";
    filtroDataPlanMensual.estado = "x";
    filtroDataPlanMensual.ut = "x";
    pageIndex = 1;
    filtroDataPlanMensual.pageIndex = 1;
    filtroDataPlanMensual.pageSize = 10;
    filtroDataPlanMensual.inicio = DateFormat('yyyy-MM-dd HH:mm:ss')
        .format(DateTime.now().subtract(Duration(days: 7)));
    filtroDataPlanMensual.fin =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    setState(() {});
  }

  String? selectedEstado = "x";


  List<DatosPlanMensual>? _posts = [];
  int _currentPage = 1;
  bool _isLoading = false;
  bool _showAddPageButton = true;


  @override
  Widget build(BuildContext context) {
    return BackdropScaffold(
        key: _backdropKey,
        appBar: BackdropAppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          // backgroundColor: AppConfig.primaryColor,
          leading: Util().iconbuton(() {
            Navigator.pop(context);
          }),
          automaticallyImplyLeading: false,
          title: Text(
            "PLAN DE TRABAJO MENSUAL",
            style: TextStyle(fontSize: 15, color: Colors.black),
          ),
          actions: <Widget>[
            BackdropToggleButton(
              color: Colors.black,
              icon: AnimatedIcons.list_view,
            ),
            InkWell(
              child: const Icon(
                Icons.restart_alt_sharp,
                color: Colors.black,
              ),
              onTap: () async {
                _loadData();
                setState(() {
                  isLoading = true;
                });
                await inicio();
                seleccionarUnidadTerritorial = "TODOS";
                seleccionarPlataformaDescripcion = "TODOS";
                isLoading = false;
                setState(() {
                  selectedEstado = "x";
                });
              },
            )
          ],
        ),
        frontLayerBackgroundColor: Colors.white,
        //frontLayerBorderRadius: BorderRadius.horizontal(),
        backLayerBackgroundColor: Colors.white60,
        //  backgroundColor: Colors.deepPurple,
        backLayer: ListView(
          children: [
            Container(
              margin: EdgeInsets.all(20),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                        child: Row(
                      children: [
                        const Icon(Icons.account_balance_wallet_outlined,
                            size: 15, color: Colors.grey),
                        SizedBox(width: 13),
                        Expanded(
                          child: Container(
                            child: DropdownButtonFormField<String>(
                              value: selectedEstado,
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedEstado = newValue;
                                });
                              },
                              decoration: InputDecoration(
                                labelText: 'Estado',
                              ),
                              items: estados.map((item) {
                                return DropdownMenuItem<String>(
                                  value: item["value"],
                                  child: Text(
                                    item["descripcion"]!,
                                    style: TextStyle(fontSize: 10),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    )),
                    Container(
                      child: FutureBuilder<List<UnidadesTerritoriales>>(
                        future: ProviderAprobacionPlanes()
                            .ListarUnidadesTerritoriales(),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<UnidadesTerritoriales>>
                                snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator(); // Muestra un indicador de carga mientras se carga la lista
                          } else if (snapshot.hasError) {
                            return Text('Error al cargar las opciones');
                          } else {
                            List<UnidadesTerritoriales> options =
                                snapshot.data!;
                            options.insert(
                                0,
                                UnidadesTerritoriales(
                                    idUnidadesTerritoriales: 0,
                                    unidadTerritorialDescripcion: 'TODOS'));

                            return Row(
                              children: [
                                const Icon(
                                    Icons.account_balance_wallet_outlined,
                                    size: 15,
                                    color: Colors.grey),
                                SizedBox(width: 13),
                                Expanded(
                                  child: Container(
                                    child: DropdownButtonFormField<
                                        UnidadesTerritoriales>(
                                      decoration: InputDecoration(
                                        labelText: 'Unidad Territorial',
                                      ),
                                      isExpanded: true,
                                      items: options.map((user) {
                                        return DropdownMenuItem<
                                            UnidadesTerritoriales>(
                                          value: user,
                                          child: Text(
                                            user.unidadTerritorialDescripcion!,
                                            style: TextStyle(fontSize: 10),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged:
                                          (UnidadesTerritoriales? value) {
                                        seleccionarUnidadTerritorial = value!
                                            .unidadTerritorialDescripcion!;
                                        filtroDataPlanMensual.ut =
                                            ((value.idUnidadesTerritoriales ==
                                                        0)
                                                    ? "x"
                                                    : value
                                                        .idUnidadesTerritoriales)
                                                .toString();

                                        isMostar = true;
                                        seleccionarPlataformaDescripcion =
                                            "Seleccionar plataforma";

                                        setState(() {});
                                      },
                                      hint: Text(
                                        seleccionarUnidadTerritorial,
                                        style: const TextStyle(fontSize: 10),
                                      ),
                                    ),
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
                      child: FutureBuilder<List<TambosDependientes>>(
                          future: ProviderAprobacionPlanes()
                              .ListarTambosDependientes(
                                  filtroDataPlanMensual.ut),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<TambosDependientes>>
                                  snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator(); // Muestra un indicador de carga mientras se carga la lista
                            } else if (snapshot.hasError) {
                              return Text('');
                            } else {
                              if (snapshot.hasData) {
                                List<TambosDependientes> optionsP =
                                    snapshot.data!;
                                optionsP.insert(
                                    0,
                                    TambosDependientes(
                                        idPlataforma: "x",
                                        plataformaDescripcion: 'TODOS'));

                                return Row(
                                  children: [
                                    const Icon(
                                        Icons.account_balance_wallet_outlined,
                                        size: 15,
                                        color: Colors.grey),
                                    SizedBox(width: 13),
                                    Expanded(
                                      child: Container(
                                        child: DropdownButtonFormField<
                                            TambosDependientes>(
                                          decoration: InputDecoration(
                                            labelText: 'Plataforma',
                                          ),
                                          isExpanded: true,
                                          items: optionsP.map((user) {
                                            return new DropdownMenuItem<
                                                TambosDependientes>(
                                              value: user,
                                              child: new Text(
                                                user.plataformaDescripcion!,
                                                style: const TextStyle(
                                                    fontSize: 10),
                                              ),
                                            );
                                          }).toList(),
                                          onChanged:
                                              (TambosDependientes? value) {
                                            seleccionarPlataformaDescripcion =
                                                value!.plataformaDescripcion!;
                                            filtroDataPlanMensual.id =
                                                value.idPlataforma;
                                          },
                                          hint: Text(
                                            seleccionarPlataformaDescripcion,
                                            style:
                                                const TextStyle(fontSize: 10),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }
                            }

                            return Container();
                          }),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.date_range_outlined,
                            size: 15, color: Colors.grey),
                        SizedBox(width: 13),
                        Expanded(
                          child: TextoConFecha(
                              "Fecha Incio", true, _controlleFechaInici),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.date_range_sharp,
                            size: 15, color: Colors.grey),
                        SizedBox(width: 13),
                        Expanded(
                          child: TextoConFecha(
                              "Fecha Fin", true, _controlleFechaFin),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Container(
                        //  decoration: Servicios().myBoxDecoration(),
                        margin: const EdgeInsets.only(right: 10, left: 10),
                        height: 40.0,
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: AppConfig.primaryColor,
                          ),
                          onPressed: () async {
                            _backdropKey.currentState!.fling();
                            filtroDataPlanMensual.estado = selectedEstado;
                            filtroDataPlanMensual.inicio =
                                _controlleFechaInici.text;
                            filtroDataPlanMensual.fin = _controlleFechaFin.text;
                            pageIndex = 0;
                            filtroDataPlanMensual.pageIndex = 0;
                            filtroDataPlanMensual.pageSize = 10;
                            _loadData();

                          },
                          child: const Text("FILTRAR"),
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
        frontLayer: Center(
          child:_isLoading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
            itemCount: _posts!.length + (_showAddPageButton ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == _posts!.length) {
                if (_isLoading) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return _buildAddPageButton();
                }
              } else {
                var post = _posts![index];
             return   Listas().cardAprobacionPlanTrabajo(
               _posts![index],
                      () async {
                    switch (_posts![index].idEvaluacion) {
                      case "1":
                        var resp = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  AprobarObservar(_posts![index]),
                            ));
                        if (resp == "R") {
                          resetlista();
                        }
                        break;

                      case "0":
                        var resp = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  AprobarObservar(_posts![index]),
                            ));
                        if (resp == "R") {
                          resetlista();
                        }
                        break;
                      case "2":
                        var resp = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetalleObservacion(
                                    _posts![index]
                                        .idProgramacion
                                        .toString(),
                                    datosPlanMensual:_posts![index],
                                  ),
                            ));
                        if (resp == "R") {
                          resetlista();
                        }
                        break;
                      case "3":
                        var resp = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetalleSubsanado(
                                    _posts![index]
                                        .idProgramacion
                                        .toString(),
                                    datosPlanMensual: _posts![index],
                                  ),
                            ));
                        if (resp == "R") {
                          resetlista();
                        }
                        break;
                    }
                  },
                );
                return ListTile(
                  title: Text(post.unidadTerritorialDescripcion.toString()),
               //   leading: Image.network(post.),
                );
              }
            },
            ///  controller: controller,
            //scrollDirection: ,
          //  onScrollEndDrag: ,
          ),



        /*  FutureBuilder<List<DatosPlanMensual>>(
            future: ProviderAprobacionPlanes()
                .ListarAprobacionPlanTrabajo(filtroDataPlanMensual),
            builder: (BuildContext context,
                AsyncSnapshot<List<DatosPlanMensual>> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.hasData == false) {
                  return const Center(
                    child: Text("¡No existen registros"),
                  );
                } else {
                  final lista = snapshot.data;
                  if (lista!.length == 0) {
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
                                itemCount: lista.length,
                                itemBuilder: (context, i) =>
                                    Listas().cardAprobacionPlanTrabajo(
                                  lista[i],
                                  () async {
                                    switch (lista[i].idEvaluacion) {
                                      case "1":
                                        var resp = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  AprobarObservar(lista[i]),
                                            ));
                                        if (resp == "R") {
                                          resetlista();
                                        }
                                        break;

                                      case "0":
                                        var resp = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  AprobarObservar(lista[i]),
                                            ));
                                        if (resp == "R") {
                                          resetlista();
                                        }
                                        break;
                                      case "2":
                                        var resp = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  DetalleObservacion(
                                                lista[i]
                                                    .idProgramacion
                                                    .toString(),
                                                datosPlanMensual: lista[i],
                                              ),
                                            ));
                                        if (resp == "R") {
                                          resetlista();
                                        }
                                        break;
                                      case "3":
                                        var resp = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  DetalleSubsanado(
                                                lista[i]
                                                    .idProgramacion
                                                    .toString(),
                                                datosPlanMensual: lista[i],
                                              ),
                                            ));
                                        if (resp == "R") {
                                          resetlista();
                                        }
                                        break;
                                    }
                                  },
                                ),
                              )),

                        )),
                        // if (isLoading == true)
                        // new Center(
                        // child: const CircularProgressIndicator(),
                        //)

                      ],
                    );
                  }
                }
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),*/
        ));
  }

  Widget _buildAddPageButton() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: GestureDetector(
        onTap: _addPage,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add),
            SizedBox(width: 8),
            Text('Agregar página'),
          ],
        ),
      ),
    );
  }

  void _addPage() {
    _loadData();
  }

  void _onScrollEnd(ScrollMetrics metrics) {
    if (metrics.pixels >= metrics.maxScrollExtent && !_isLoading) {
      _loadData();
    }
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
    });

    _onlistener();
    try {
      var posts = await ProviderAprobacionPlanes()
          .ListarAprobacionPlanTrabajo(filtroDataPlanMensual);

   //   Iterable<DatosPlanMensual> iterableDatos = posts != null ? Iterable<DatosPlanMensual>.of(posts) : Iterable.empty();
      Iterable<DatosPlanMensual> iterableDatos = posts != null ? List<DatosPlanMensual>.from(posts) : Iterable.empty();

      /*ProviderAprobacionPlanes()
                .ListarAprobacionPlanTrabajo(filtroDataPlanMensual)*/
      _posts =[];
      setState(() {

        _posts?.addAll(iterableDatos);
        _currentPage++;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print(e);
    }
  }
  TextoConFecha(labelText, enabled, controller) {
    return Container(
        margin: EdgeInsets.only(top: 3),
        child: TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'Por favor Ingrese dato.';
            }
          },
          enabled: enabled,
          controller: controller,
          decoration: InputDecoration(
            labelText: labelText,
            hintText: labelText,
          ),
          onTap: () {
            FechaSeleccionar(controller: controller);
          },
        ));
  }

  FechaSeleccionar({controller}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: nowfec!,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      setState(() {
        controller.text = formatter.format(picked);
        return controller;
      });
    }
  }

  Future resetlista() async {
    setState(() {});
/*    seleccionarMarca = "Seleccionar Marca";
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
}
