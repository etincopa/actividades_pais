import 'package:actividades_pais/src/Utils/utils.dart';
import 'package:actividades_pais/src/datamodels/Clases/Intervenciones/FiltroIntervencionesTambos.dart';
import 'package:actividades_pais/src/datamodels/Clases/Intervenciones/TambosDependientes.dart';
import 'package:actividades_pais/src/datamodels/Clases/Intervenciones/UnidadesTerritoriales.dart';
import 'package:actividades_pais/src/datamodels/Provider/ProviderAprobacionPlanes.dart';
import 'package:actividades_pais/src/datamodels/Provider/ProviderRegistarInterv.dart';
import 'package:actividades_pais/src/datamodels/database/DatabasePr.dart';
import 'package:actividades_pais/src/pages/Intervenciones/ProgramarPrestaciones/ActividadesGit/ActividadesGit.dart';
import 'package:actividades_pais/src/pages/Intervenciones/ProgramarPrestaciones/CalificarIntervencion.dart';
import 'package:actividades_pais/src/pages/Intervenciones/ProgramarPrestaciones/Event.dart';
import 'package:actividades_pais/src/pages/Intervenciones/ProgramarPrestaciones/PlanesDeTrabajo/Cronograma/RegistroCronograma.dart';
import 'package:actividades_pais/src/pages/Intervenciones/ProgramarPrestaciones/ProgramacionPrestacion.dart';
import 'package:actividades_pais/src/pages/Intervenciones/ProgramarPrestaciones/ProgramacionesIntervenciones.dart';
import 'package:actividades_pais/src/pages/Intervenciones/util/utils.dart';
import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../../../util/app-config.dart';
import '../PlanesDeTrabajo.dart';

class ListaCronograma extends StatefulWidget {
  const ListaCronograma({Key? key}) : super(key: key);

  @override
  State<ListaCronograma> createState() => _ListaCronogramaState();
}

class _ListaCronogramaState extends State<ListaCronograma> {
  FiltroIntervencionesTambos filtroIntervencionesTambos =
      FiltroIntervencionesTambos();
  var estados = [
    {"value": 'x', "descripcion": 'TODOS'},
    {"value": '1', "descripcion": 'PROGRAMADOS'},
    {"value": '2', "descripcion": 'POR APROBAR'},
    {"value": '3', "descripcion": 'OBSERVADO'},
    {"value": '4', "descripcion": 'APROBADAS'},
    {"value": '0', "descripcion": 'ELIMINADOS'},
  ];
  var tipoProgramacion = [
    {"value": 'x', "descripcion": 'TODOS'},
    {"value": '1', "descripcion": 'PRESTACION DE SERVICIOS'},
    {"value": '2', "descripcion": 'ACTIVIDADES - GIT'},
    {"value": '3', "descripcion": 'SOPORTE'},
  ];
  DateTime? nowfec = new DateTime.now();
  var formatter = new DateFormat('yyyy-MM-dd');
  final TextEditingController _controlleFechaInici = TextEditingController();
  final TextEditingController _controlleFechaFin = TextEditingController();
  var seleccionarUnidadTerritorial = "Seleccionar UnidadTerritorial";
  var seleccionarPlataformaDescripcion = "Seleccionar plataforma";
  String? selectedEstado = "x";
  String? selectedTipoProgramacion = "x";
  DateTime _selectedDay = DateTime.now();
  List<Evento> _selectedEvents = [];

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
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

  filtro() async {
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
      margin: EdgeInsets.only(top: 30, left: 10, right: 10, bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16 * fem),
        color: Color(0xffffffff),
        boxShadow: [
          BoxShadow(
            color: Color(0x3f000000),
            offset: Offset(0 * fem, 4 * fem),
            blurRadius: 2 * fem,
          ),
        ],
      ),

      height: MediaQuery.of(context).size.height * 1,
      // establece una altura fija

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
              Container(
                width: width * 0.7,
                height: height * 0.07,
                child: Center(
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
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
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
    /*      Container(
            width: width * 1,
            height: height * 0.07,
            child: Center(
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
          ),*/
          Stack(
            children: [
              Container(
                padding: const EdgeInsets.only(
                    top: 0, left: 20, right: 20, bottom: 35),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(3, 0),
                    ),
                  ],
                ),
                child: TableCalendar(
                  rowHeight: 32,
                  calendarBuilders: CalendarBuilders(
                    singleMarkerBuilder: (context, date, _) {
                      return Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: date == _selectedDay
                                ? Colors.white
                                : Colors.black), //Change color
                        width: 5.0,
                        height: 5.0,
                        margin: const EdgeInsets.symmetric(horizontal: 1.5),
                      );
                    },
                  ),
                  onHeaderTapped: (DateTime focusedDay) {
                    print('Se ha cambiado el mes a ${focusedDay.month}');
                    setState(() {});
                  },
                  onPageChanged: (s) {
                    print(s.year);
                  },
                  formatAnimationCurve: Curves.linear,
                  headerVisible: true,
                  calendarStyle: const CalendarStyle(
                    rangeHighlightColor: Colors.green,
                  ),
                  daysOfWeekStyle: const DaysOfWeekStyle(
                    weekendStyle: TextStyle(color: Colors.red),
                    weekdayStyle: TextStyle(color: Colors.blue),
                  ),
                  locale: 'es_ES',
                  headerStyle: HeaderStyle(
                    // formatButtonVisible: false,
                    titleCentered: true,
                    titleTextStyle: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                    titleTextFormatter: (date, _) =>
                        DateFormat.yMMMM('es_ES').format(date).toUpperCase(),
                  ),
                  onFormatChanged: (format) {
                    if (_calendarFormat != format) {
                      setState(() {
                        _calendarFormat = format;
                      });
                    }
                  },
                  eventLoader: _getEventsForDay,
                  selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _focusedDay = focusedDay;
                      _selectedDay = selectedDay;
                      _selectedEvents = eventos
                          .where(
                              (evento) => isSameDay(evento.fecha, _selectedDay))
                          .toList();
                    });
                  },
                  firstDay: kFirstDay,
                  lastDay: kLastDay,
                  focusedDay: _focusedDay,
                  calendarFormat: _calendarFormat,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 10,
                child: FloatingActionButton(
                  mini: true, // Esto hará que el botón sea más pequeño
                  onPressed: () async {
                    var res = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegistroCronograma(),
                      ),
                    );
                    if (res == 'refrescar') {
                      print("aqui lege ");
                      await cargarEventos();
                    }
                  },
                  backgroundColor: Colors.blue,
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14.0),
          Expanded(
            child: ListView.builder(
                itemCount: _selectedEvents.length,
                itemBuilder: (context, index) {
                  final event = _selectedEvents[index];
                  List<String> elementos = event.descripcion.split('°(');
                  List<String> elementos2 = elementos[0].split('-');
                  List<String> elementos3 = event.descripcion.split(') °');
                  List<String> elementos4 = event.descripcion.split(' °(');
                  var tamboNm = "";
                  tamboNm = elementos4[1].split(') °')[0];

                  return Container(
                    padding: const EdgeInsets.all(14),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 3.0,
                      vertical: 4.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: AppConfig.primaryColor, // color del borde
                        width: 2, // grosor del borde
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: InkWell(
                        onTap: () async {
                          print(
                              "event.estadoProgramacion ${event.estadoProgramacion}");

                          switch (event.estadoProgramacion) {
                            case '1':
                              var res = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ProgramacionPrestacion(event),
                                ),
                              );
                              if (res == 'refrescar') {
                                print("aqui lege ");
                                await cargarEventos();
                              }
                              break;
                            case '2':
                              var res = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CalificarIntervencion(event),
                                ),
                              );
                              break;

                            case '0':
                              var res = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ProgramacionPrestacion(event),
                                ),
                              );
                              break;
                            case '5':
                              var res = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ProgramacionPrestacion(event),
                                ),
                              );
                              break;
                          }
                        },
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 5,
                                height: 10,
                              ),
                              Expanded(
                                child: Container(
                                  margin:
                                      const EdgeInsets.only(right: 2.0, top: 3),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image.network(
                                              "https://cdn-icons-png.flaticon.com/512/3652/3652267.png",
                                              height: 45,
                                              width: 33),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                right: 10.0, left: 3, top: 3),
                                            child: Column(
                                              children: [
                                                Text(
                                                  elementos2[0],
                                                  style: const TextStyle(
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  elementos2[1].trim(),
                                                  style: const TextStyle(
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Icon(
                                              Icons
                                                  .radio_button_checked_outlined,
                                              color: event.tipoProgramacion ==
                                                      '1'
                                                  ? Colors.grey
                                                  : event.tipoProgramacion ==
                                                          '2'
                                                      ? Colors.green
                                                      : event.tipoProgramacion ==
                                                              '3'
                                                          ? Colors.blue
                                                          : Colors.black),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Icon(event.estadoProgramacion == '1'
                                              ? Icons.check
                                              : event.estadoProgramacion == '2'
                                                  ? Icons.check
                                                  : event.estadoProgramacion ==
                                                          '3'
                                                      ? Icons.cancel
                                                      : event.estadoProgramacion ==
                                                              '4'
                                                          ? Icons.star
                                                          : event.estadoProgramacion ==
                                                                  '0'
                                                              ? Icons.block
                                                              : event.estadoProgramacion ==
                                                                      '5'
                                                                  ? Icons.stop
                                                                  : Icons
                                                                      .remove),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            textAlign: TextAlign.start,
                                            "${event.estadoProgramacion == '1' ? 'PROGRAMADO' : ''}"
                                            "${event.estadoProgramacion == '2' ? 'POR APROBAR' : ''}"
                                            "${event.estadoProgramacion == '3' ? 'OBSERVADO' : ''}"
                                            "${event.estadoProgramacion == '4' ? 'APROBADA' : ''}"
                                            "${event.estadoProgramacion == '5' ? 'SUSPENDIDO' : ''}"
                                            "${event.estadoProgramacion == '0' ? 'ELIMINADO' : ''}",
                                            style: TextStyle(
                                                fontSize: 13.0,
                                                color: event.tipoProgramacion ==
                                                        '1'
                                                    ? Colors.black
                                                    : Colors.black,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: Text(
                                              textAlign: TextAlign.justify,
                                              "$tamboNm - ${elementos3[1]}",
                                              style: const TextStyle(
                                                fontSize: 13.2,
                                              ),
                                            ),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.78,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ])),
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
