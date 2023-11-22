import 'package:actividades_pais/src/Utils/utils.dart';
import 'package:actividades_pais/src/datamodels/Clases/Intervenciones/FiltroIntervencionesTambos.dart';
import 'package:actividades_pais/src/datamodels/Provider/ProviderRegistarInterv.dart';
import 'package:actividades_pais/src/datamodels/database/DatabasePr.dart';
import 'package:actividades_pais/src/pages/Intervenciones/ProgramarPrestaciones/ActividadesGit/ActividadesGit.dart';
import 'package:actividades_pais/src/pages/Intervenciones/ProgramarPrestaciones/Event.dart';
import 'package:actividades_pais/src/pages/Intervenciones/ProgramarPrestaciones/PlanesDeTrabajo/Cronograma/CircleNumber.dart';
import 'package:actividades_pais/src/pages/Intervenciones/ProgramarPrestaciones/PlanesDeTrabajo/Cronograma/ReadMoreText.dart';
import 'package:actividades_pais/src/pages/Intervenciones/ProgramarPrestaciones/PlanesDeTrabajo/PlanesDeTrabajo.dart';
import 'package:actividades_pais/src/pages/Intervenciones/ProgramarPrestaciones/ProgramacionesIntervenciones.dart';
import 'package:actividades_pais/src/pages/Intervenciones/util/utils.dart';
import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../../../util/app-config.dart';

class Cronogramas extends StatefulWidget {
  const Cronogramas({Key? key}) : super(key: key);

  @override
  State<Cronogramas> createState() => _CronogramasState();
}

class _CronogramasState extends State<Cronogramas> {
  FiltroIntervencionesTambos filtroIntervencionesTambos =
      FiltroIntervencionesTambos();

  DateTime? nowfec = DateTime.now();
  var formatter = DateFormat('yyyy-MM-dd');
  final TextEditingController _controlleFechaInici = TextEditingController();
  final TextEditingController _controlleFechaFin = TextEditingController();
  var seleccionarUnidadTerritorial = "Seleccionar UnidadTerritorial";
  var seleccionarPlataformaDescripcion = "Seleccionar plataforma";
  String? selectedEstado = "x";
  String? selectedTipoProgramacion = "x";

  List<Evento> _selectedEvents = [];

  final fem = 1.05;
  List<Evento> eventos = [];

  bool isTambo = false;
  var UnidadTerritorialTexto = '';
  var PlataformaTexto = '';

  List<dynamic> _getEventsForDay(DateTime day) {
    return eventos
        .where((evento) => isSameDay(evento.fecha, day))
        .map((evento) => evento.descripcion)
        .toList();
  }

  Future<void> _loadEventsForDay() async {
    DateTime day = DateTime.now();
    // Simular una carga asíncrona de eventos para el día especificado
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _selectedEvents =
          eventos.where((evento) => isSameDay(evento.fecha, day)).toList();
    });
  }

  @override
  void initState() {
    cargarEventos();
    super.initState();
  }

  taerDB() async {
    setState(() {
      isTambo = false;
    });
    var respuest = await DatabasePr.db.traerSnip();
    if (respuest != 0) {
      setState(() {
        isTambo = true;
      });
      await taerDBtraerConfiguracionInicio();
    }
    await taerDBtraerConfiguracionInicio();
  }

  taerDBtraerConfiguracionInicio() async {
    _controlleFechaFin.text = '';
    _controlleFechaInici.text = '';
    selectedEstado = 'x';
    selectedTipoProgramacion = 'x';
    filtroIntervencionesTambos.id = "x";
    filtroIntervencionesTambos.tipo = "x";
    filtroIntervencionesTambos.estado = "x";
    filtroIntervencionesTambos.ut = "x";
    filtroIntervencionesTambos.inicio = "";
    filtroIntervencionesTambos.fin = "";
    filtroIntervencionesTambos.mes = "";
    filtroIntervencionesTambos.anio = DateTime.now().year;
    if (isTambo) {
      var respuest = await DatabasePr.db.traerConfiguracionInicio();
      if (respuest.length > 0) {
        filtroIntervencionesTambos.ut =
            respuest[0].idUnidTerritoriales.toString();
        filtroIntervencionesTambos.id = respuest[0].idTambo.toString();
        UnidadTerritorialTexto = respuest[0].unidTerritoriales.toString();
        PlataformaTexto = respuest[0].nombreTambo.toString();
        setState(() {});
      }
    }
  }

  cargarEventos() async {
    await taerDB();
    _selectedEvents.clear();
    eventos.clear();
    setState(() {
      _isLoading = true;
    });

    eventos = await ProviderRegistarInterv()
        .cargarEventos(filtroIntervencionesTambos);

    print(" _selectedEvents.length ${_selectedEvents.length}");
    _loadEventsForDay();
    setState(() {
      _isLoading = false;
    });
  }

  bool _isLoading = false;
  final GlobalKey<BackdropScaffoldState> _backdropKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppConfig.primaryColor, body: frontLayers());
  }

  frontLayers() {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
      margin: const EdgeInsets.only(top: 30, left: 10, right: 10, bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16 * fem),
        color: const Color(0xffffffff),
        boxShadow: [
          BoxShadow(
            color: const Color(0x3f000000),
            offset: Offset(0 * fem, 4 * fem),
            blurRadius: 2 * fem,
          ),
        ],
      ),
      height: MediaQuery.of(context).size.height * 1,
      padding: const EdgeInsets.only(top: 0, left: 10, right: 10, bottom: 3),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                child: Util().iconbuton(() {
                  Navigator.pop(context);
                }),
              ),
              SizedBox(
                width: width * 0.7,
                height: height * 0.07,
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      'CRONOGRAMA MENSUAL',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          _isLoading
              ? Container(
                  color: Colors.white,
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 20),
                        CircularProgressIndicator(),
                        SizedBox(height: 20),
                        Text(
                          "Cargando Eventos",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                )
              : Container(),
          Expanded(
            child: ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.all(14),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 3.0,
                      vertical: 4.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Container(
                      child: Column(
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Container(
                                    width: 300.0,
                                    margin: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: const ReadMoreText(
                                        "FORTALECIMIENTO DE CAPACIDADES SOBRE EL LAVADO DE MANOS CON LA FINALIDAD DE GENERAR CONCIENCIA SOBRE UN HABITO QUE PUEDA SALVAR VIDAS A CARGO DEL PUESTO DE SALUD SAN SALVADOR DIRIGIDO A ESTUDIANTES DE LA II.EE. PRIMARIA SAN BARTOLO"))
                              ],
                            ),
                          ),
                          Container(
                            width: 300.0,
                            margin: const EdgeInsets.only(
                                left: 10, right: 10, bottom: 10, top: 10),
                            child: Row(
                              children: [
                                Container(
                                  width: 25,
                                  margin: const EdgeInsets.only(right: 10),
                                  child: Image.asset(
                                    'assets/icons/intervenciones/objetivo6.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(
                                  width: 250,
                                  child: RichText(
                                    textAlign: TextAlign.start,
                                    text: const TextSpan(
                                      style: TextStyle(
                                        fontSize: 13.2,
                                        color: Colors.black,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: 'Meta',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          text: '\n2',
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 300.0,
                            margin: const EdgeInsets.only(
                                left: 10, right: 10, bottom: 10),
                            child: Row(
                              children: [
                                Container(
                                  width: 25,
                                  margin: const EdgeInsets.only(right: 10),
                                  child: Image.asset(
                                    'assets/icons/intervenciones/grupo6.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(
                                  width: 250,
                                  child: RichText(
                                    textAlign: TextAlign.start,
                                    text: const TextSpan(
                                      style: TextStyle(
                                        fontSize: 13.2,
                                        color: Colors.black,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: 'Poblacion',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                              '\nESTUDIANTES DE LA II.EE. PRIMARIA SAN BARTOLO',
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                              width: 300.0,
                              margin: const EdgeInsets.only(
                                  left: 10, right: 10, bottom: 10),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 25,
                                    child: Image.asset(
                                      'assets/icons/intervenciones/trabajo-en-equipo6.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    child: RichText(
                                      textAlign: TextAlign.start,
                                      text: const TextSpan(
                                        style: TextStyle(
                                          fontSize: 13.2,
                                          color: Colors.black,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: 'Responsable',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                '\nPUESTO DE SALUD SAN SALVADOR',
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              )),
                          Container(
                              width: 300.0,
                              margin: const EdgeInsets.only(
                                  left: 10, right: 10, bottom: 10),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 25,
                                    child: Image.asset(
                                      'assets/icons/intervenciones/grupo6.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    child: RichText(
                                      textAlign: TextAlign.start,
                                      text: const TextSpan(
                                        style: TextStyle(
                                          fontSize: 13.2,
                                          color: Colors.black,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: 'Unidad Medida',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          TextSpan(
                                            text: '\nNUMERO DE ESTUDIANTES',
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CircleNumber(2, "Ene"),
                              CircleNumber(2, "Feb"),
                              CircleNumber(2, "Mar"),
                              CircleNumber(2, "Abr"),
                              CircleNumber(2, "May"),
                              CircleNumber(2, "Jun"),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CircleNumber(2, "Jul"),
                              CircleNumber(2, "Ago"),
                              CircleNumber(2, "Set"),
                              CircleNumber(2, "Oct"),
                              CircleNumber(2, "Nov"),
                              CircleNumber(2, "Dic"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  TextoConFecha(labelText, enabled, controller) {
    return Container(
        margin: const EdgeInsets.only(top: 3),
        child: TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'Por favor Ingrese dato.';
            }
            return null;
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

  floatingButton() {
    return SpeedDial(
      icon: Icons.add,
      activeIcon: Icons.close,
      backgroundColor: AppConfig.primaryColor,
      foregroundColor: Colors.white,
      activeBackgroundColor: Colors.grey,
      activeForegroundColor: Colors.white,
      buttonSize: const Size(56.0, 56.0),
      visible: true,
      closeManually: false,
      curve: Curves.bounceIn,
      overlayColor: Colors.black,
      overlayOpacity: 0.5,
      onOpen: () => print('OPENING DIAL'),
      onClose: () => print('DIAL CLOSED'),
      elevation: 8.0,
      shape: const CircleBorder(),
      children: [
        SpeedDialChild(
          child: const Icon(Icons.playlist_add_check),
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue,
          label: 'EJECUCION DE SOPORTE',
          labelStyle: const TextStyle(fontSize: 18.0),
          onTap: () async {},
          onLongPress: () => print('THIRD CHILD LONG PRESS'),
        ),
        SpeedDialChild(
          child: const Icon(Icons.language),
          foregroundColor: Colors.white,
          backgroundColor: Colors.green,
          label: 'ACTIVIDADES - GIT',
          labelStyle: const TextStyle(fontSize: 18.0),
          onTap: () async {
            var res = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ActividadesGit(),
              ),
            );
          },
          onLongPress: () => print('THIRD CHILD LONG PRESS'),
        ),
        SpeedDialChild(
          child: const Icon(Icons.supervisor_account),
          backgroundColor: Colors.grey,
          foregroundColor: Colors.white,
          label: 'PRESTACION DE SERVICIOS',
          labelStyle: const TextStyle(fontSize: 18.0),
          onTap: () async {
            utils().showMyDialog(
                context, "¿La intervención pertenece a algún Plan de Trabajo?",
                texto1: "SI", texto2: "NO", onPressed2: () async {
              await DatabasePr.db.eliminarAccion();
              Navigator.pop(context);
              var res = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProgramacionIntervencion(),
                ),
              );
              if (res == 'OK') {
                await cargarEventos();
                setState(() {});
              }
            }, onPressed1: () async {
              Navigator.pop(context);
              var res = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PlanesDeTrabajo(),
                ),
              );
              if (res == 'OK') {
                cargarEventos();
              }
            });
          },
          onLongPress: () => print('SECOND CHILD LONG PRESS'),
        ),
      ],
    );
  }
}
