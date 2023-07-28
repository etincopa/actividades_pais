// ignore_for_file: unused_local_variable

import 'dart:async';
import 'package:actividades_pais/src/datamodels/Clases/ActividadesTambo.dart';
import 'package:actividades_pais/src/datamodels/Clases/UbicacionUsuario.dart';
import 'package:actividades_pais/src/datamodels/Provider/Provider.dart';
import 'package:actividades_pais/src/datamodels/Servicios/Servicios.dart';
import 'package:actividades_pais/src/pages/CierreActividades/CierreActividades.dart';

import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:actividades_pais/src/datamodels/database/DatabasePr.dart';

// ignore: must_be_immutable
class Asistencia extends StatefulWidget {
  String imei;
  String long = '';
  String lat = '';

  Asistencia({super.key, this.imei = '', this.long='',this.lat=''});

  @override
  _AsistenciaState createState() => _AsistenciaState();
}

class _AsistenciaState extends State<Asistencia> {
  String _nombrePersona = "";
  String dni = "";
  String _apellidosPersona = "";
  String mimei = "";
  var cargo = "";
  var numeroDni = 0;
  int snip = 0;
  int cantidad = 0;
  int cantidadInf = 0;
  int lugarPrestacion = 0;
  int unidadesOrganicas = 0;
  Color color = Colors.red;

  final ScrollController _scrollController = ScrollController();
  var variable = "";
  var unidadTerritorial = "";
  final int _user = 0;
  /*String long = '';
  String lat = '';*/
  var tipoAsistencia = 0;

  var respuesta;
  int millisec = 0;
  int ok = 0;
  bool absorbing = false;

  Servicios servicios = Servicios();
  int idLugarDeprestacion = 0;
  int idTambo = 0;
  int idUnidTerritoriales = 0;
  int idUnidadesOrganicas = 0;
  var seleccionarUnidOrganicas = "SELECCIONAR ACTIVIDAD";

  //prdats = ProviderDatos();
  final _prdats = ProviderDatos();

  @override
  void initState() {
    traerdato();
    traerRegUbicacion();
    DatabasePr.db.initDB();
    setState(() {});
    cargarDatos();

    super.initState();
  }

  traerdato() async {
    var art = await ProviderDatos().verificacionpesmiso();
    widget.lat = art[0].latitude.toString();
    widget.long = art[0].longitude.toString();
    setState(() {});
  }
  @override
  void dispose() {
    _scrollController.dispose();
    traerRegUbicacion();
    super.dispose();
  //  setState(() {});
    //cargarDatos();
  }

  traerTiempo() async {
    var valor = await _prdats.gettiempo();
    millisec = int.parse(valor);
    print("aqui pe mano: $valor}");
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFEEEEEE),
        body: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () {
                  /*  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              HomePagePais() /*     nombre: _nombrePersona + ' ' + _apellidosPersona,
                              dni: dni*/
                          ),
                    );*/
                    Navigator.pop(context, 'ok');
                  },
                ),
                backgroundColor: Colors.blue[800],
                expandedHeight: 50.0,
                floating: false,
                pinned: true,
                flexibleSpace: const FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text('REGISTRAR BITACORA'),
                  stretchModes: [],
                ),
              ),
            ];
          },
          body: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  cardNombre(_nombrePersona),
                  const SizedBox(
                    height: 20,
                  ),
                  if (unidadTerritorial != "")
                    cardTambo("UT $unidadTerritorial"),
                  cardTambo(variable),
                  const SizedBox(
                    height: 20,
                  ),
                  actividad(),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          if (ok == 0) columprimero() else columnSegundo()
                        ],
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void cargarDatos() {
    mostrarNombre();
    mostrarTmbo();
    mostrarInfo();
  }

  Future mostrarTmbo() async {
    DatabasePr.db.initDB();
    var abc = await DatabasePr.db.getAllTasksConfigInicio();
    cantidad = abc.length - 1;
    var idlp = abc[cantidad].idLugarPrestacion;
    var iduo = abc[cantidad].idUnidadesOrganicas;
    setState(() {
      if (idlp == 1) {
        variable = abc[cantidad].lugarPrestacion;
        unidadTerritorial = abc[cantidad].unidTerritoriales;
        idLugarDeprestacion = abc[cantidad].idLugarPrestacion;
        idUnidTerritoriales = abc[cantidad].idUnidTerritoriales;
        idUnidadesOrganicas = abc[cantidad].idUnidadesOrganicas;
        idTambo = abc[cantidad].idTambo;
        snip = 0;
        lugarPrestacion = idlp;
        unidadesOrganicas = iduo;
      } else if (idlp == 2) {
        lugarPrestacion = idlp;
        variable = abc[cantidad].nombreTambo;
        snip = abc[cantidad].snip;
        unidadTerritorial = abc[cantidad].unidTerritoriales;
        print(abc[cantidad].unidTerritoriales);
        idLugarDeprestacion = abc[cantidad].idLugarPrestacion;
        idUnidTerritoriales = abc[cantidad].idUnidTerritoriales;
        idUnidadesOrganicas = abc[cantidad].idUnidadesOrganicas;
        idTambo = abc[cantidad].idTambo;
        unidadesOrganicas = iduo;
      }
    });
  }

  Future mostrarInfo() async {
    DatabasePr.db.initDB();
    var abc = await DatabasePr.db.getAllInfoTel();
    cantidadInf = abc.length - 1;
    // mimei = abc[cantidadInf].imei.toUpperCase();
  }

  Future mostrarNombre() async {
    DatabasePr.db.initDB();
    var abc = await DatabasePr.db.getAllConfigPersonal();
    cantidad = abc.length - 1;
    _nombrePersona = abc[cantidad].nombres.toUpperCase();
    dni = abc[cantidad].numeroDni.toString();
    _apellidosPersona = '${abc[cantidad].apellidoPaterno.toUpperCase()} ${abc[cantidad].apellidoMaterno.toUpperCase()}';
    numeroDni = abc[cantidad].numeroDni;
    //cargo = abc[cantidad].cargo;
  }

  void _startTimerPeriodic(tipo) {
    Timer.periodic(Duration(seconds: millisec), (Timer timer) async {
      if (millisec == 0) {
        timer.cancel();
      } else {
        refreshList(tipo);
      }
    });
  }

  Future<void> refreshList(tipo) async {
    setState(() {
     // latlong();
      var a = UbicacionUsuario(
          idLugarDeprestacion: idLugarDeprestacion,
          idUnidTerritoriales: idUnidTerritoriales,
          idUnidadesOrganicas: idUnidadesOrganicas,
          idPlataforma: idTambo,
          actividad: tipoAsistencia.toString(),
          snip: snip,
          dni: numeroDni.toString(),
          latitud: widget.lat.toString(),
          longitud: widget.long.toString(),
          fechaHora: DateFormat('yyyy-MM-dd HH:mm:s').format(DateTime.now()),
          tipo: tipo,
          idselecttipotrab: tipoAsistencia,
          selecttipotrab: seleccionarUnidOrganicas,
          millisec: millisec);
      DatabasePr.db.inserUbicacionUsuario(a);

      ///seleccionarUnidOrganicas = newVal.actividad;
      //    tipoAsistencia = newVal.idActividad;

      ProviderDatos().registroUbicacionUsuario(a);

      /// traerRegUbicacion();
    });
  }

  columprimero() {
    return Column(children: [
      const Text(
        "Marcar inicio de actividades",
        style: TextStyle(fontSize: 20.0),
      ),
      const SizedBox(
        height: 10,
      ),
      InkWell(
        child: cardIngreso(Colors.red, 250.0),
        onTap: () async {
          ///   print("imei: " + widget.imei);
          ok = 1;
          // traerTiempo();
          var valor = await _prdats.gettiempo();
          millisec = int.parse(valor);

          ///millisec = 10;
          absorbing = true;

          setState(() {
            _startTimerPeriodic(ok);
            //   sowDialog();
          });

       //   latlong();
          var a = UbicacionUsuario(
              idLugarDeprestacion: idLugarDeprestacion,
              idUnidTerritoriales: idUnidTerritoriales,
              idUnidadesOrganicas: idUnidadesOrganicas,
              idPlataforma: idTambo,
              actividad: tipoAsistencia.toString(),
              snip: snip,
              dni: numeroDni.toString(),
              latitud: widget.lat.toString(),
              longitud: widget.long.toString(),
              fechaHora:
                  DateFormat('yyyy-MM-dd HH:mm:s').format(DateTime.now()),
              tipo: ok,
              idselecttipotrab: tipoAsistencia,
              selecttipotrab: seleccionarUnidOrganicas,
              millisec: millisec);
          DatabasePr.db.inserUbicacionUsuario(a);
          ProviderDatos().registroUbicacionUsuario(a);
        },
      ),
    ]);
  }

  actividad() {
    return Container(
      child: FutureBuilder<List<ActividadesTambo>>(
        future: _prdats.getactividades(),
        builder: (BuildContext context,
            AsyncSnapshot<List<ActividadesTambo>> snapshot) {
          // ignore: unused_local_variable
          ActividadesTambo? depatalits;

          if (!snapshot.hasData) {
            if (snapshot.hasData == false) {
              return const Center(
                child: Text("¡No existen registros!"),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }
          final preguntas = snapshot.data;

          if (preguntas!.isEmpty) {
            return const Center(
              child: Text("sin dato"),
            );
          } else {
            return AbsorbPointer(
              absorbing: absorbing,
              child: Card(
                elevation: 19.0,
                color: Colors.white,
                child: Container(
                    child: DropdownButton<ActividadesTambo>(
                  enableFeedback: false,
                  underline: const SizedBox(),
                  isExpanded: true,
                  icon: Icon(
                    Icons.arrow_drop_down,
                    size: 40,
                    color: Colors.blue[800],
                  ),
                  items: snapshot.data
                      ?.map((user) => DropdownMenuItem<ActividadesTambo>(
                            value: user,
                            child: Text(
                              user.actividad,
                              style: TextStyle(
                                  color: Colors.blue[800], fontSize: 16),
                            ),
                          ))
                      .toList(),
                  onChanged: (ActividadesTambo? newVal) {
                    setState(() {
                      depatalits = newVal!;
                      seleccionarUnidOrganicas = newVal.actividad;
                      tipoAsistencia = newVal.idActividad;
                      //  tablaid = newVal.IDUO;
                    });
                  },
                  //value: depatalits.,
                  hint: Text(
                    "   $seleccionarUnidOrganicas",
                    style: TextStyle(color: Colors.blue[800], fontSize: 16),
                  ),
                )),
              ),
            );
          }
        },
      ),
    );
  }

  columnSegundo() {
    return Column(children: [
      const Text(
        "Marcar termino de actividades",
        style: TextStyle(fontSize: 20.0),
      ),
      const SizedBox(
        height: 10,
      ),
      InkWell(
        child: cardSalida(Colors.grey, 250.00),
        onTap: () async {
         // latlong();
          final respuesta = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CierreActividadesPage(
                    idLugarDeprestacion: idLugarDeprestacion,
                    idUnidTerritoriales: idUnidTerritoriales,
                    idUnidadesOrganicas: idUnidadesOrganicas,
                    idPlataforma: idTambo,
                    dni: numeroDni.toString(),
                    latitud: widget.lat.toString(),
                    longitud: widget.long.toString(),
                    fechaHora: DateTime.now().toString(),
                    snip: snip)),
          );

          if (respuesta.toString() == 'OK') {
            ok = 0;
            millisec = 0;
            absorbing = false;
            _startTimerPeriodic(ok);
          }

          setState(() {
            traerRegUbicacion();
          });
        },
      ),
    ]);
  }

  Future traerRegUbicacion() async {
    DatabasePr.db.initDB();
    var abc = await DatabasePr.db.getAllUbicacionUsuario();

    if (abc.isNotEmpty) {
      ok = abc[abc.length - 1].tipo;
      if (ok == 0) {
        absorbing = false;
      } else {
        tipoAsistencia = abc[abc.length - 1].idselecttipotrab;
        seleccionarUnidOrganicas = abc[abc.length - 1].selecttipotrab;
        absorbing = true;
        millisec = abc[abc.length - 1].millisec;
        _startTimerPeriodic(ok);
      }
    }
  }
}

Widget cardIngreso(Color color, tamanio) {
  return Card(
    elevation: 19.0,
    color: color,
    child: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            children: [
              SizedBox(
                width: tamanio,
                height: tamanio,
                child: Icon(
                  Icons.alarm,
                  size: tamanio,
                  color: Colors.white,
                ),
              ),
            ],
          )
        ],
      ),
    ),
  );
}

Widget cardSalida(Color color, tamanio) {
  // var a1=170.00;
/*
    var tamanioingreso = 250.00;
  var tamaniosalida = 0.0;
  var tamaniotextoingreso = 20.0;
  var tamaniotextosalida = 0.0; */
  return Card(
    elevation: 19.0,
    color: color,
    child: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            children: [
              SizedBox(
                width: tamanio,
                height: tamanio,
                child: Icon(
                  Icons.timer_off,
                  size: tamanio,
                  color: Colors.white,
                ),
              ),
            ],
          )
        ],
      ),
    ),
  );
}

Widget cardNombre(nombre) {
  return Container(
    child: Card(
      elevation: 19.0,
      color: Colors.white,
      child: Container(
        margin: const EdgeInsets.only(top: 3, left: 5, bottom: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: [
                Icon(
                  Icons.perm_contact_calendar,
                  size: 40,
                  color: Colors.blue[900],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 170,
                      child: Text(" $nombre",
                          style:
                              TextStyle(color: Colors.blue[900], fontSize: 16)),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    ),
  );
}

Widget cardTambo(nombre) {
  return Container(
    child: Card(
      elevation: 19.0,
      color: Colors.white,
      child: Container(
        margin: const EdgeInsets.only(top: 3, left: 5, bottom: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: [
                Container(
                  child: Row(
                    children: [
                      Icon(
                        Icons.house,
                        size: 40,
                        color: Colors.blue[900],
                      ),
                      SizedBox(
                        width: 190,
                        child: Text(" $nombre",
                            style: TextStyle(
                                color: Colors.blue[900], fontSize: 16)),
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ),
  );
}
