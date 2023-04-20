import 'dart:convert';

import 'package:actividades_pais/src/datamodels/Clases/Intervenciones/FiltroIntervencionesTambos.dart';
import 'package:actividades_pais/src/datamodels/Clases/Intervenciones/TambosDependientes.dart';
import 'package:actividades_pais/src/datamodels/Clases/Intervenciones/UnidadesTerritoriales.dart';
import 'package:actividades_pais/src/datamodels/Provider/ProviderAprobacionPlanes.dart';
import 'package:actividades_pais/src/datamodels/Provider/ProviderRegistarInterv.dart';
import 'package:actividades_pais/src/datamodels/database/DatabasePr.dart';
import 'package:actividades_pais/src/pages/Intervenciones/util/utils.dart';
import 'package:actividades_pais/src/pages/Tambook/historialTambo/fichaIntervencion.dart';
import 'package:actividades_pais/util/app-config.dart';
import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../Intervenciones/ProgramarPrestaciones/Event.dart';

class Calendario extends StatefulWidget {
  var idTambo = "x";

  Calendario({this.idTambo = "x"});

  @override
  State<Calendario> createState() => _CalendarioState();
}

class _CalendarioState extends State<Calendario> {
  bool mostarUt = true;

  @override
  void initState() {
    print("wtambo ${widget.idTambo}");
    if (widget.idTambo == "x") {
      mostarUt = true;
    } else {
      selectedEstado = "1";
      cargarEventos();
      mostarUt = false;
    }

    super.initState();
    year = now.year;
    cargarUts();
    // kFirstDay = DateTime(kToday.year, kToday.month - 4, kToday.day);
  }

  var filterTipoProgramacion = "";
  final GlobalKey<BackdropScaffoldState> _backdropKey = GlobalKey();
  DateTime kFirstDays = DateTime(
      DateTime.now().year, DateTime.now().month - 4, DateTime.now().day);

  FiltroIntervencionesTambos filtroIntervencionesTambos =
      FiltroIntervencionesTambos();
  var estados = [
    {"value": 'x', "descripcion": 'TODOS'},
    {"value": '1', "descripcion": 'PROGRAMADAS'},
    {"value": '2', "descripcion": 'EJECUTADAS'},
    //{"value": '3', "descripcion": 'OBSERVADO'},
    {"value": '4', "descripcion": 'APROBADAS'},
    // {"value": '0', "descripcion": 'ELIMINADOS'},
  ];

  var tipoProgramacion = [
    {"value": 'x', "descripcion": 'TODOS'},
    {"value": '1', "descripcion": 'PRESTACION DE SERVICIOS'},
    {"value": '2', "descripcion": 'ACTIVIDADES - GIT'},
    {"value": '3', "descripcion": 'SOPORTE'},
  ];

  List<UnidadesTerritoriales> unidadesTerrtoriales = [];
  DateTime? nowfec = new DateTime.now();

  var formatter = new DateFormat('yyyy-MM-dd');

  final TextEditingController _controlleFechaInici = TextEditingController();

  final TextEditingController _controlleFechaFin = TextEditingController();

  var seleccionarUnidadTerritorial = "Seleccionar Unidad Territorial";

  var seleccionarPlataformaDescripcion = "Seleccionar plataforma";

  String? selectedEstado = "4";

  String? selectedTipoProgramacion = "x";

  DateTime _selectedDay = DateTime.now();

  List<Evento> _selectedEvents = [];

  String month = DateTime.now().month.toString();

  CalendarFormat _calendarFormat = CalendarFormat.twoWeeks;

  DateTime _focusedDay = DateTime.now();

  DateTime now = DateTime.now();

  List<Evento> eventos = [];

  bool isTambo = false;

  var UnidadTerritorialTexto = '';

  var PlataformaTexto = '';

  int year = 0;
  bool _isLoading = false;

/*  taerDB() async {
    setState(() {
      isTambo = false;
    });
    var respuest = await DatabasePr.db.traerSnip();
    if (respuest != 0) {
      setState(() {
        isTambo = true;
      });
      await taerDBtraerConfiguracionInicio();
      return;
    }
    await taerDBtraerConfiguracionInicio();
  }
*/

  taerDBtraerConfiguracionInicio({months}) async {
    if (widget.idTambo == null) {
      widget.idTambo = "x";
    }
    month = month.length <= 1 ? '0$month' : month;
    _controlleFechaFin.text = '';
    _controlleFechaInici.text = '';
    // selectedEstado = 'x';
    // selectedTipoProgramacion = 'x';
    filtroIntervencionesTambos.id = "${widget.idTambo}";
    filtroIntervencionesTambos.tipo = "x";
    filtroIntervencionesTambos.estado = selectedEstado;
    // filtroIntervencionesTambos.ut = "x";
    filtroIntervencionesTambos.inicio = "";
    filtroIntervencionesTambos.fin = "";
    filtroIntervencionesTambos.mes = month;
    filtroIntervencionesTambos.anio = year;
    /*   if (isTambo) {
      var respuest = await DatabasePr.db.traerConfiguracionInicio();
      if (respuest.length > 0) {
        filtroIntervencionesTambos.ut =
            respuest[0].idUnidTerritoriales.toString();
        filtroIntervencionesTambos.id = respuest[0].idTambo.toString();
        UnidadTerritorialTexto = respuest[0].unidTerritoriales.toString();
        PlataformaTexto = respuest[0].nombreTambo.toString();
        setState(() {});
      }
    }*/
  }

  cargarEventos() async {
    year = now.year;
    // await taerDB();
    await taerDBtraerConfiguracionInicio();
    _selectedEvents.clear();
    eventos.clear();
    setState(() {
      _isLoading = true;
    });

    eventos = await ProviderRegistarInterv()
        .cargarEventosTamb(filtroIntervencionesTambos);
    _loadEventsForDay();
    setState(() {
      _isLoading = false;
    });
  }

  filtro() async {
    await taerDBtraerConfiguracionInicio();
    _selectedEvents.clear();
    eventos.clear();
    setState(() {
      _isLoading = true;
    });

    eventos = await ProviderRegistarInterv()
        .cargarEventosTamb(filtroIntervencionesTambos);

    print(" _selectedEvents.length ${_selectedEvents.length}");
    _loadEventsForDay();
    setState(() {
      _isLoading = false;
    });
  }

  List<dynamic> _getEventsForDay(DateTime day) {
    return eventos
        .where((evento) => isSameDay(evento.fecha, day))
        .map((evento) => evento.descripcion)
        .toList();
  }

  Future<void> _loadEventsForDay() async {
    DateTime day = DateTime.now();
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _selectedEvents =
          eventos.where((evento) => isSameDay(evento.fecha, day)).toList();
    });
  }

  cargarUts() async {
    unidadesTerrtoriales = (await ProviderAprobacionPlanes()
        .ListarUnidadesTerritorialesTambook())!;
    print(jsonEncode(unidadesTerrtoriales));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return backdropShado();
  }

  backdropShado() {
    return BackdropScaffold(
      backLayer: baklayer(),
      headerHeight: 100,
      key: _backdropKey,
      appBar: BackdropAppBar(
        backgroundColor: AppConfig.primaryColor,
        elevation: 0.0,
        centerTitle: true,
        leading: InkWell(
          child: const Icon(
            Icons.restart_alt_sharp,
            color: Colors.black,
          ),
          onTap: () async {
            seleccionarUnidadTerritorial = "TODOS";
            seleccionarPlataformaDescripcion = "TODOS";
            await cargarEventos();
          },
        ),
        automaticallyImplyLeading: false,
        title: const Text(
          "INTERVENCIONES EN LOS TAMBOS",
          style: TextStyle(fontSize: 15, color: Colors.black),
        ),
        actions: const <Widget>[
          BackdropToggleButton(
            color: Colors.black,
            icon: AnimatedIcons.ellipsis_search,
          ),
        ],
      ),
      backLayerBackgroundColor: Colors.white,
      frontLayer: frontLayer(),
    );
  }

  frontLayer() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Column(
          children: [
            _isLoading
                ? Container(
                    color: Colors.white,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
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
                year = s.year;
                month = s.month.toString();
                kFirstDays = DateTime(year, DateTime.now().month - 4, s.day);
                _focusedDay = s;
                cargarEventos();
                setState(() {});
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
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle: TextStyle(fontSize: 13),
                titleTextFormatter: (date, _) =>
                    DateFormat.yMMMM('es_ES').format(date).toUpperCase(),
              ),
              eventLoader: _getEventsForDay,
              selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
              onDaySelected: (selectedDay, focusedDay) {
                filterTipoProgramacion = "";
                setState(() {
                  _focusedDay = focusedDay;
                  print(_focusedDay);
                  _selectedDay = selectedDay;
                  _selectedEvents = eventos
                      .where((evento) => isSameDay(evento.fecha, _selectedDay))
                      .toList();
                });
                if (_selectedEvents.isNotEmpty) {
                  showAlertDialogAprobar(context, "Detalle", _selectedEvents);
                  print(_selectedEvents.length);
                  print(_selectedEvents.length);
                  print(_selectedEvents.length);
                }
              },
              firstDay: kFirstDays,
              lastDay: kLastDay,
              focusedDay: _focusedDay,
              //  calendarFormat: _calendarFormat,
              calendarFormat: CalendarFormat.month,
            ),
            const SizedBox(height: 14.0),
            const Divider(color: Colors.black, height: 20),
          ],
        ),
      ),
    );
  }

  mostrarIntervenciones() {
    return Expanded(
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
                    var status = await Permission.storage.status;
                    if (status != PermissionStatus.granted) {
                      status = await Permission.storage.request();
                      setState(() {});
                    }
                    print(event.tipoProgramacion);
                    if (event.tipoProgramacion == '1' ||
                        event.tipoProgramacion == '3') {
                      switch (event.estadoProgramacion) {
                        case '4':
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FichaIntervencion(
                                      int.parse(event.idProgramacion),
                                      event.fecha.toString())));
                          break;
                      }
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
                            margin: const EdgeInsets.only(right: 10.0, top: 3),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(Icons.radio_button_checked_outlined,
                                        color: event.tipoProgramacion == '1'
                                            ? Colors.grey
                                            : event.tipoProgramacion == '2'
                                                ? Colors.green
                                                : event.tipoProgramacion == '3'
                                                    ? Colors.blue
                                                    : Colors.black),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Icon(event.estadoProgramacion == '1'
                                        ? Icons.check
                                        : event.estadoProgramacion == '2'
                                            ? Icons.check
                                            : event.estadoProgramacion == '3'
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
                                                            : Icons.remove),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      textAlign: TextAlign.start,
                                      "${event.estadoProgramacion == '1' ? 'PROGRAMADA' : ''}"
                                      "${event.estadoProgramacion == '2' ? 'EJECUTADA' : ''}"
                                      "${event.estadoProgramacion == '3' ? 'OBSERVADA' : ''}"
                                      "${event.estadoProgramacion == '4' ? 'APROBADA' : ''}"
                                      "${event.estadoProgramacion == '5' ? 'SUSPENDIDA' : ''}"
                                      "${event.estadoProgramacion == '0' ? 'ELIMINADA' : ''}",
                                      style: TextStyle(
                                          fontSize: 13.0,
                                          color: event.tipoProgramacion == '1'
                                              ? Colors.black
                                              : Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    if (event.tipoProgramacion == '1' ||
                                        event.tipoProgramacion == '3') ...[
                                      Icon(event.estadoProgramacion == '4'
                                          ? Icons.download
                                          : null)
                                    ],
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.60,
                                      child: RichText(
                                        textAlign: TextAlign.start,
                                        text: TextSpan(
                                          style: const TextStyle(
                                            fontSize: 13.2,
                                            color: Colors.black,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: '$tamboNm gfdg',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            TextSpan(
                                              text: 'dsas - ${elementos3[1]}',
                                            ),
                                          ],
                                        ),
                                      ),
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
    );
  }

  baklayer() {
    return ListView(children: [
      Container(
          margin: const EdgeInsets.all(20),
          child: Center(
              child: Column(mainAxisSize: MainAxisSize.max, children: [
            /*  Row(
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
            ),*/
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

            /*  FutureBuilder<List<UnidadesTerritoriales>>(
              future: ProviderAprobacionPlanes()
                  .ListarUnidadesTerritorialesTambook(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<UnidadesTerritoriales>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  print("ConnectionState.waiting:: ${ConnectionState.waiting}");
                  print(snapshot.connectionState);
                  return const CircularProgressIndicator(); // Muestra un indicador de carga mientras se carga la lista
                } else if (snapshot.hasError) {
                  return const Text('Error al cargar las opciones');
                } else {

                }
              },
            ),*/
            mostarUt ? unidadesTerritorales() : Container(),
            /* FutureBuilder<List<UnidadesTerritoriales>>(
                  future: ProviderAprobacionPlanes()
                      .ListarUnidadesTerritoriales(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<UnidadesTerritoriales>> snapshot) {
                    if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const CircularProgressIndicator(); // Muestra un indicador de carga mientras se carga la lista
                    } else if (snapshot.hasError) {
                      return const Text('Error al cargar las opciones');
                    } else {
                      List<UnidadesTerritoriales> options = snapshot.data!;
                      options.insert(
                          0,
                          UnidadesTerritoriales(
                              idUnidadesTerritoriales: 0,
                              unidadTerritorialDescripcion: 'TODOS'));

                      return Row(
                        children: [
                          const Icon(Icons.account_balance_wallet_outlined,
                              size: 15, color: Colors.grey),
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
                                        : value.idUnidadesTerritoriales)
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
                ),*/

            /* Row(
              children: [
                const Icon(Icons.date_range_outlined,
                    size: 15, color: Colors.grey),
                const SizedBox(width: 13),
                Expanded(
                  child:
                      TextoConFecha("Fecha Incio", true, _controlleFechaInici),
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
            ),*/
            const SizedBox(height: 10),
            Container(
                //  decoration: Servicios().myBoxDecoration(),
                margin: const EdgeInsets.only(right: 10, left: 10),
                height: 40.0,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: AppConfig.primaryColor2,
                  ),
                  onPressed: () async {
                    filtroIntervencionesTambos.inicio =
                        _controlleFechaInici.text;
                    filtroIntervencionesTambos.fin = _controlleFechaFin.text;
                    _backdropKey.currentState!.fling();
                    await filtro();
                  },
                  child: const Text("FILTRAR"),
                )),
          ])))
    ]);
  }

  unidadesTerritorales() {
/*     List<UnidadesTerritoriales> options = unidadesTerrtoriales;
    options.insert(
        0,
        UnidadesTerritoriales(
            idUnidadesTerritoriales: 0,
            unidadTerritorialDescripcion: 'TODOS'));
*/
    return Row(
      children: [
        const Icon(Icons.account_balance_wallet_outlined,
            size: 15, color: Colors.grey),
        const SizedBox(width: 13),
        Expanded(
          child: DropdownButtonFormField<UnidadesTerritoriales>(
            decoration: const InputDecoration(
              labelText: 'Unidad Territorial',
            ),
            isExpanded: true,
            items: unidadesTerrtoriales.map((user) {
              return DropdownMenuItem<UnidadesTerritoriales>(
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
                          : value.idUnidadesTerritoriales)
                      .toString();
              seleccionarPlataformaDescripcion = "Seleccionar plataforma";
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

  showAlertDialogAprobar(BuildContext context, texto, _selectedEventss) {
    showDialog(
      context: context,
      builder: (BuildContext context) => buildSuccessDialog2(context,
          title: "Lista Interverneciones", selectedEventss: _selectedEventss),
    );
  }

  Widget buildSuccessDialog2(
    BuildContext context, {
    String? title,
    String? subTitle,
    List<Evento>? selectedEventss,
  }) {
    var global = true;
    var filterTipoProgramacions = "";
    var cant1 = selectedEventss!
        .where((element) => element.tipoProgramacion.contains('1'))
        .toList()
        .length;
    var cant3 = selectedEventss
        .where((element) => element.tipoProgramacion.contains('3'))
        .toList()
        .length;
    var cant2 = selectedEventss
        .where((element) => element.tipoProgramacion.contains('2'))
        .toList()
        .length ;
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter sstdotstate) {
      return AlertDialog(
        title: SizedBox(
          height: 129,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    title!,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  sstdotstate(() {
                    if (cant1 == 0) {
                      global = false;
                    } else {
                      global = true;
                    }
                    filterTipoProgramacions = "1";
                    print(_selectedEvents.length);
                  });
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.radio_button_checked_outlined,
                      color: Colors.grey,
                    ),
                    Text(
                      " INTERVENCION DE PRESTACIONES ($cant1)",
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  sstdotstate(() {
                    if (cant3 == 0) {
                      global = false;
                    } else {
                      global = true;
                    }
                    filterTipoProgramacions = "3";
                  });
                },
                child: Row(
                  children: [
                    Icon(Icons.radio_button_checked_outlined,
                        color: Colors.blue),
                    Text(" INTERVENCION DE SOPORTE ($cant3)",
                        style: TextStyle(fontSize: 12)),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  sstdotstate(() {
                    if (cant2 == 0) {
                      global = false;
                    } else {
                      global = true;
                    }
                    filterTipoProgramacions = "2";
                  });
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.radio_button_checked_outlined,
                      color: Colors.green,
                    ),
                    Text(" ACTIVIDADES GIT ($cant2)",
                        style: TextStyle(fontSize: 12)),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  sstdotstate(() {
                    if (selectedEventss.isEmpty) {
                      global = false;
                    } else {
                      global = true;
                    }
                    filterTipoProgramacions = "";
                  });
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.radio_button_checked_outlined,
                      color: Colors.black,
                    ),
                    Text(" TODOS (${selectedEventss.length})",
                        style: TextStyle(fontSize: 12)),
                  ],
                ),
              ),
            ],
          ),
        ),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                child: const Icon(Icons.close),
                onTap: () {
                  Navigator.pop(context);
                },
              )
            ],
          )
        ],
        content: SingleChildScrollView(
          child: global
              ? Container(
                  alignment: Alignment.centerLeft,
                  width: double.maxFinite,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height * 0.4,
                        ),
                        child: ListView.builder(
                            itemCount: selectedEventss
                                .where((element) => element.tipoProgramacion
                                    .contains(filterTipoProgramacions))
                                .length,
                            itemBuilder: (context, index) {
                              var elementoss = selectedEventss
                                  .where((element) => element.tipoProgramacion
                                      .contains(filterTipoProgramacions))
                                  .toList();

                              final event = elementoss[index];

                              List<String> elementos =
                                  event.descripcion.split('°(');
                              List<String> elementos2 = elementos[0].split('-');
                              List<String> elementos3 =
                                  event.descripcion.split(') °');
                              List<String> elementos4 =
                                  event.descripcion.split(' °(');
                              var tamboNm = "";
                              tamboNm = elementos4[1].split(') °')[0];

                              return Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 1.0,
                                  vertical: 4.0,
                                ),
                                /*decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey.withOpacity(0.5),
                                width: 1.0,
                              ),
                            ),
                          ),*/
                                child: InkWell(
                                    onTap: () async {
                                      var status =
                                          await Permission.storage.status;
                                      if (status != PermissionStatus.granted) {
                                        status =
                                            await Permission.storage.request();
                                        setState(() {});
                                      }
                                      if (event.tipoProgramacion == '1' ||
                                          event.tipoProgramacion == '3') {
                                        switch (event.estadoProgramacion) {
                                          case '4':
                                            Navigator.pop(context);
                                            await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        FichaIntervencion(
                                                            int.parse(event
                                                                .idProgramacion),
                                                            event.fecha
                                                                .toString())));

                                            break;
                                        }
                                      }
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: event.tipoProgramacion == '1'
                                            ? Colors.grey[200]
                                            : event.tipoProgramacion == '2'
                                                ? Colors.green[100]
                                                : event.tipoProgramacion == '3'
                                                    ? Colors.blue[100]
                                                    : Colors.black,
                                        border: Border.all(
                                            width: 1,
                                            color: Colors.transparent),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Container(
                                                margin: const EdgeInsets.only(
                                                    top: 3),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Image.network(
                                                            "https://cdn-icons-png.flaticon.com/512/3652/3652267.png",
                                                            height: 25,
                                                            width: 25),
                                                        Container(
                                                          margin:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 10.0,
                                                                  top: 3),
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                elementos2[0]
                                                                    .trim(),
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize:
                                                                      15.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                              Text(
                                                                elementos2[1]
                                                                    .trim(),
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize:
                                                                      15.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
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
                                                                    ? Colors
                                                                        .green
                                                                    : event.tipoProgramacion ==
                                                                            '3'
                                                                        ? Colors
                                                                            .blue
                                                                        : Colors
                                                                            .black),
                                                        const SizedBox(
                                                          width: 2,
                                                        ),
                                                        Text(
                                                          textAlign:
                                                              TextAlign.start,
                                                          "${event.estadoProgramacion == '1' ? 'PROGRAMADA' : ''}"
                                                          "${event.estadoProgramacion == '2' ? 'EJECUTADA' : ''}"
                                                          "${event.estadoProgramacion == '3' ? 'OBSERVADA' : ''}"
                                                          "${event.estadoProgramacion == '4' ? 'APROBADA' : ''}"
                                                          "${event.estadoProgramacion == '5' ? 'SUSPENDIDA' : ''}"
                                                          "${event.estadoProgramacion == '0' ? 'ELIMINADA' : ''}",
                                                          style: TextStyle(
                                                              fontSize: 13.0,
                                                              color: event.tipoProgramacion ==
                                                                      '1'
                                                                  ? Colors.black
                                                                  : Colors
                                                                      .black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                        if (event.tipoProgramacion ==
                                                                '1' ||
                                                            event.tipoProgramacion ==
                                                                '3') ...[
                                                          Icon(
                                                              event.estadoProgramacion ==
                                                                      '4'
                                                                  ? Icons
                                                                      .download
                                                                  : null)
                                                        ],
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.60,
                                                          child: RichText(
                                                            textAlign:
                                                                TextAlign.start,
                                                            text: TextSpan(
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 13.2,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                              children: [
                                                                TextSpan(
                                                                  text:
                                                                      '$tamboNm',
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                                TextSpan(
                                                                  text:
                                                                      ' - ${elementos3[1]}',
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ]),
                                    )),
                              );
                            }),
                      ),
                    ],
                  ),
                )
              : Container(),
        ),
      );
    });
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
}
