import 'package:actividades_pais/src/Utils/utils.dart';
import 'package:actividades_pais/src/datamodels/Clases/Intervenciones/FiltroIntervencionesTambos.dart';
import 'package:actividades_pais/src/datamodels/Clases/Intervenciones/TambosDependientes.dart';
import 'package:actividades_pais/src/datamodels/Clases/Intervenciones/UnidadesTerritoriales.dart';
import 'package:actividades_pais/src/datamodels/Provider/ProviderAprobacionPlanes.dart';
import 'package:actividades_pais/src/datamodels/Provider/ProviderRegistarInterv.dart';
import 'package:actividades_pais/src/pages/Intervenciones/ProgramarPrestaciones/ActividadesGit/ActividadesGit.dart';
import 'package:actividades_pais/src/pages/Intervenciones/ProgramarPrestaciones/CalificarIntervencion.dart';
import 'package:actividades_pais/src/pages/Intervenciones/ProgramarPrestaciones/Event.dart';
import 'package:actividades_pais/src/pages/Intervenciones/ProgramarPrestaciones/PlanesDeTrabajo/PlanesDeTrabajo.dart';
import 'package:actividades_pais/src/pages/Intervenciones/ProgramarPrestaciones/ProgramacionesIntervenciones.dart';
import 'package:actividades_pais/src/pages/Intervenciones/ProgramarPrestaciones/ProgramacionesIntervencionesHome.dart';
import 'package:actividades_pais/util/app-config.dart';
import 'package:actividades_pais/util/busy-indicator.dart';
import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:marquee/marquee.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../datamodels/database/DatabasePr.dart';
import '../util/utils.dart';
import 'ProgramacionPrestacion.dart';

class ListaIntervecionesProgramadas extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<ListaIntervecionesProgramadas> {
  FiltroIntervencionesTambos filtroIntervencionesTambos =
      FiltroIntervencionesTambos();
  var estados = [
    {"value": 'x', "descripcion": 'TODOS'},
    {"value": '1', "descripcion": 'PROGRAMADOS'},
    {"value": '2', "descripcion": 'POR APROBAR'},
    {"value": '3', "descripcion": 'OBSERVADO'},
    {"value": '4', "descripcion": 'APROBADAS'},
    {"value": '0', "descripcion": 'ELIMINADOS'},

    /*   [{ value: 'x', descripcion: 'TODOS' },
      { value: '1', descripcion: 'PROGRAMADOS' },
      { value: '2', descripcion: 'POR APROBAR' },
      { value: '3', descripcion: 'OBSERVADOS' },
      { value: '4', descripcion: 'APROBADAS' },
      { value: '0', descripcion: 'ELIMINADOS' },
    ]*/
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

  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();

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
    return BackdropScaffold(
      floatingActionButton: floatingButton(),
      key: _backdropKey,
      appBar: BackdropAppBar(
        backgroundColor: AppConfig.primaryColor,
        elevation: 0.0,
        leading: Util().iconbuton(() {
          Navigator.pop(context);
        }),
        automaticallyImplyLeading: false,
        title: const Text(
          "Intervenciones en los Tambos",
          style: TextStyle(fontSize: 15, color: Colors.black),
        ),
        actions: <Widget>[
          const BackdropToggleButton(
            color: Colors.black,
            icon: AnimatedIcons.list_view,
          ),
          InkWell(
            child: const Icon(
              Icons.restart_alt_sharp,
              color: Colors.black,
            ),
            onTap: () async {
              //  BusyIndicator.show(context);
              seleccionarUnidadTerritorial = "TODOS";
              seleccionarPlataformaDescripcion = "TODOS";
              await cargarEventos();
              //  BusyIndicator.hide(context);
            },
          )
        ],
      ),
      // frontLayerBackgroundColor: Colors.white,
      //frontLayerBorderRadius: BorderRadius.horizontal(),
      backLayerBackgroundColor: Colors.white,
      backLayer: ListView(children: [
        Container(
            margin: const EdgeInsets.all(20),
            child: Center(
                child: Column(mainAxisSize: MainAxisSize.max, children: [
              Row(
                children: [
                  const Icon(Icons.account_balance_wallet_outlined,
                      size: 15, color: Colors.grey),
                  const SizedBox(width: 13),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: selectedTipoProgramacion,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedTipoProgramacion = newValue;
                          filtroIntervencionesTambos.tipo = newValue;
                        });
                      },
                      decoration: const InputDecoration(
                        labelText: 'Tipo Programacion',
                      ),
                      items: tipoProgramacion.map((item) {
                        return DropdownMenuItem<String>(
                          value: item["value"],
                          child: Text(
                            item["descripcion"]!,
                            style: const TextStyle(fontSize: 10),
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
                      value: selectedEstado,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedEstado = newValue;
                          filtroIntervencionesTambos.estado = newValue;
                        });
                      },
                      decoration: const InputDecoration(
                        labelText: 'Estado',
                      ),
                      items: estados.map((item) {
                        return DropdownMenuItem<String>(
                          value: item["value"],
                          child: Text(
                            item["descripcion"]!,
                            style: const TextStyle(fontSize: 10),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              isTambo
                  ? Column(
                      children: [
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(Icons.date_range_outlined,
                                size: 15, color: Colors.grey),
                            const SizedBox(width: 13),
                            Expanded(
                              child: Text("$UnidadTerritorialTexto"),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(Icons.date_range_outlined,
                                size: 15, color: Colors.grey),
                            const SizedBox(width: 13),
                            Expanded(
                              child: Text("$PlataformaTexto"),
                            ),
                          ],
                        ),
                      ],
                    )
                  : Column(children: [
                      FutureBuilder<List<UnidadesTerritoriales>>(
                        future: ProviderAprobacionPlanes()
                            .ListarUnidadesTerritoriales(),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<UnidadesTerritoriales>>
                                snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator(); // Muestra un indicador de carga mientras se carga la lista
                          } else if (snapshot.hasError) {
                            return const Text('Error al cargar las opciones');
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
                                const SizedBox(width: 13),
                                Expanded(
                                  child: DropdownButtonFormField<
                                      UnidadesTerritoriales>(
                                    decoration: const InputDecoration(
                                      labelText: 'Unidad Territorial',
                                    ),
                                    isExpanded: true,
                                    items: options.map((user) {
                                      return DropdownMenuItem<
                                          UnidadesTerritoriales>(
                                        value: user,
                                        child: Text(
                                          user.unidadTerritorialDescripcion!,
                                          style: const TextStyle(fontSize: 10),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (UnidadesTerritoriales? value) {
                                      seleccionarUnidadTerritorial =
                                          value!.unidadTerritorialDescripcion!;
                                      filtroIntervencionesTambos.ut =
                                          ((value.idUnidadesTerritoriales == 0)
                                                  ? "x"
                                                  : value
                                                      .idUnidadesTerritoriales)
                                              .toString();
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
                              ],
                            );
                          }
                        },
                      ),
                      Container(
                        margin: const EdgeInsets.only(),
                        child: FutureBuilder<List<TambosDependientes>>(
                            future: ProviderAprobacionPlanes()
                                .ListarTambosDependientes(
                                    filtroIntervencionesTambos.ut),
                            builder: (BuildContext context,
                                AsyncSnapshot<List<TambosDependientes>>
                                    snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator(); // Muestra un indicador de carga mientras se carga la lista
                              } else if (snapshot.hasError) {
                                return const Text('');
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
                                      const SizedBox(width: 13),
                                      Expanded(
                                        child: Container(
                                          child: DropdownButtonFormField<
                                              TambosDependientes>(
                                            decoration: const InputDecoration(
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
                                              filtroIntervencionesTambos.id =
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
                    ]),
              Row(
                children: [
                  const Icon(Icons.date_range_outlined,
                      size: 15, color: Colors.grey),
                  const SizedBox(width: 13),
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
                  const SizedBox(width: 13),
                  Expanded(
                    child: TextoConFecha("Fecha Fin", true, _controlleFechaFin),
                  ),
                ],
              ),
              const SizedBox(height: 10),
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
                      filtroIntervencionesTambos.inicio =
                          _controlleFechaInici.text;
                      filtroIntervencionesTambos.fin = _controlleFechaFin.text;
                      _backdropKey.currentState!.fling();
                      await filtro();
                      /* filtroDataPlanMensual.estado = selectedEstado;
                          filtroDataPlanMensual.inicio =
                              _controlleFechaInici.text;
                          filtroDataPlanMensual.fin = _controlleFechaFin.text;
                          pageIndex = 0;
                          filtroDataPlanMensual.pageIndex = 0;
                          filtroDataPlanMensual.pageSize = 10;
                          _loadData();*/
                    },
                    child: const Text("FILTRAR"),
                  )),
            ])))
      ]),
      frontLayer: Column(
        children: [
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
          TableCalendar(
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
            headerStyle: const HeaderStyle(
              formatButtonVisible: true,
              titleCentered: true,
              titleTextStyle: TextStyle(fontSize: 20),
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
                    .where((evento) => isSameDay(evento.fecha, _selectedDay))
                    .toList();
              });
            },
            firstDay: kFirstDay,
            lastDay: kLastDay,
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
          ),
          const SizedBox(height: 14.0),
          const Divider(color: Colors.black, height: 20),
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
                    margin: const EdgeInsets.symmetric(
                      horizontal: 15.0,
                      vertical: 4.0,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                    child: InkWell(
                        onTap: () async {
                          /*       "${event.estadoProgramacion == '1' ? 'PROGRAMADO' : ''}"
                                            "${event.estadoProgramacion == '2' ? 'POR APROBAR' : ''}"
                                            "${event.estadoProgramacion == '3' ? 'OBSERVADO' : ''}"
                                            "${event.estadoProgramacion == '4' ? 'APROBADA' : ''}"
                                            "${event.estadoProgramacion == '0' ? 'ELIMINADO' : ''}",*/
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
                              Image.network(
                                  "https://cdn-icons-png.flaticon.com/512/3652/3652267.png",
                                  height: 45,
                                  width: 33),
                              Container(
                                margin: const EdgeInsets.only(
                                    right: 13.0, left: 3, top: 3),
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
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      right: 10.0, top: 3),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
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
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: Text(
                                              textAlign: TextAlign.start,
                                              "$tamboNm - ${elementos3[1]}",
                                              style: const TextStyle(
                                                fontSize: 13.2,
                                              ),
                                            ),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.60,
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
                  builder: (context) => const PlanesDeTrabajo(),
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
