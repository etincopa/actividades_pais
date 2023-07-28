import 'dart:convert';
import 'dart:typed_data';

import 'package:actividades_pais/backend/controller/main_controller.dart';
import 'package:actividades_pais/backend/model/dto/response_base64_file_dto.dart';
import 'package:actividades_pais/src/datamodels/Clases/Intervenciones/FiltroIntervencionesTambos.dart';
import 'package:actividades_pais/src/datamodels/Clases/Intervenciones/UnidadesTerritoriales.dart';
import 'package:actividades_pais/src/datamodels/Provider/ProviderAprobacionPlanes.dart';
import 'package:actividades_pais/src/datamodels/Provider/ProviderRegistarInterv.dart';
import 'package:actividades_pais/src/pages/MonitoreoProyectoTambo/main/Project/Report/pdf/pdf_preview_page2.dart';
import 'package:actividades_pais/src/pages/Tambook/historialTambo/fichaIntervencion.dart';
import 'package:actividades_pais/util/app-config.dart';
import 'package:actividades_pais/util/busy-indicator.dart';
import 'package:actividades_pais/util/check_connection.dart';
import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../Intervenciones/ProgramarPrestaciones/Event.dart';

class Calendario extends StatefulWidget {
  var idTambo = "x";

  Calendario({super.key, this.idTambo = "x"});

  @override
  State<Calendario> createState() => _CalendarioState();
}

class _CalendarioState extends State<Calendario> {
  Color darken(Color color, [double amount = .1]) {
    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }

  bool mostarUt = true;
  int porcentaje = 0;
  Color colorPorcentaje = Colors.red;
  MainController mainCtr = MainController();

  @override
  void initState() {
    loadEvents();
    if (widget.idTambo == "x") {
      mostarUt = true;
    } else {
      selectedEstado = "x";

      mostarUt = false;
    }
    super.initState();
    year = now.year;
    cargarUts();
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
    {"value": '4', "descripcion": 'APROBADAS'},
  ];

  var tipoProgramacion = [
    {"value": 'x', "descripcion": 'TODOS'},
    {"value": '1', "descripcion": 'PRESTACION DE SERVICIOS'},
    {"value": '2', "descripcion": 'ACTIVIDADES - GIT'},
    {"value": '3', "descripcion": 'SOPORTE'},
  ];

  List<UnidadesTerritoriales> unidadesTerrtoriales = [];
  DateTime? nowfec = DateTime.now();

  var formatter = DateFormat('yyyy-MM-dd');

  final TextEditingController _controlleFechaInici = TextEditingController();

  final TextEditingController _controlleFechaFin = TextEditingController();

  var seleccionarUnidadTerritorial = "Seleccionar Unidad Territorial";

  var seleccionarPlataformaDescripcion = "Seleccionar plataforma";

  String? selectedEstado = "x";

  String? selectedTipoProgramacion = "x";

  DateTime _selectedDay = DateTime.now();

  List<Evento> _selectedEvents = [];

  String month = DateTime.now().month.toString();

  DateTime _focusedDay = DateTime.now();

  DateTime now = DateTime.now();

  List<Evento> eventos = [];

  bool isTambo = false;

  var UnidadTerritorialTexto = '';

  var PlataformaTexto = '';

  int year = 0;
  bool _isLoading = false;

  bringDBConfigurationHome({months}) async {
    widget.idTambo ??= "x";
    month = month.length <= 1 ? '0$month' : month;
    _controlleFechaFin.text = '';
    _controlleFechaInici.text = '';
    // selectedEstado = 'x';
    // selectedTipoProgramacion = 'x';
    filtroIntervencionesTambos.id = widget.idTambo;
    filtroIntervencionesTambos.tipo = "x";
    filtroIntervencionesTambos.estado = selectedEstado;
    // filtroIntervencionesTambos.ut = "x";
    filtroIntervencionesTambos.inicio = "";
    filtroIntervencionesTambos.fin = "";
    filtroIntervencionesTambos.mes = month;
    filtroIntervencionesTambos.anio = year;
  }

  loadEvents() async {
    year = now.year;
    await bringDBConfigurationHome();
    _selectedEvents.clear();
    eventos.clear();
    setState(() {
      _isLoading = true;
    });

    eventos = await ProviderRegistarInterv()
        .cargarEventosTambGet(filtroIntervencionesTambos);
    _loadEventsForDay();
    setState(() {
      _isLoading = false;
    });
  }

  filters() async {
    await bringDBConfigurationHome();
    _selectedEvents.clear();
    eventos.clear();
    setState(() {
      _isLoading = true;
    });

    eventos = await ProviderRegistarInterv()
        .cargarEventosTambGet(filtroIntervencionesTambos);
    await _loadEventsForDay();
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
    setState(() {});
  }

  Color getColor(DateTime date) {
    var color1 = Colors.red[100];
    var color2 = Colors.yellow[100];
    var color3 = Colors.green[100];

    var evento_ =
        eventos.where((evento) => isSameDay(evento.fecha, date)).toList();

    if (evento_.isEmpty) {
      return Colors.white;
    }

    var totalTambo = evento_[0].totalTambo;
    var totalIntervenciones = evento_[0].totalTambosIntervenciones;

    var porcentaje = (totalIntervenciones! / totalTambo!) * 100;

    if (porcentaje >= 0 && porcentaje <= 50) {
      return color1!;
    } else if (porcentaje > 50 && porcentaje <= 90) {
      return color2!;
    } else {
      return color3!;
    }
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
        toolbarHeight: 40,
        backgroundColor: Colors.white,
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
            await loadEvents();
          },
        ),
        automaticallyImplyLeading: false,
        title: const Text(
          "INTERVENCIONES EN LOS TAMBOS",
          style: TextStyle(fontSize: 13, color: Colors.black),
        ),
        actions: const <Widget>[
          BackdropToggleButton(
            color: Colors.black,
            icon: AnimatedIcons.ellipsis_search,
          ),
        ],
      ),
      backLayerBackgroundColor: Colors.white,
      frontLayerBackgroundColor: Colors.white,
      frontLayer: frontLayer(),
    );
  }

  frontLayer() {
    const blue400 = Color(0xFF42A5F5);
    const blue100 = Color(0xFFBBDEFB);

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        padding: const EdgeInsets.only(top: 0, left: 10, right: 10, bottom: 3),
        child: Column(
          children: [
            _isLoading
                ? Container(
                    color: Colors.white,
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            strokeWidth: 3.0,
                          ),
                          SizedBox(height: 20),
                          Text(
                            "CARGANDO INTERVENCIONES ...",
                            style: TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  )
                : Container(),
            // const SizedBox(height: 1),
            !_isLoading
                ? Text(
                    "Haz clic en el ícono lupa para buscar intervenciones",
                    style: TextStyle(fontSize: 11),
                  )
                : Container(),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.only(
                  top: 0, left: 20, right: 20, bottom: 18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 0,
                    blurRadius: 5,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                  /*BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(-3, 0), // changes position of shadow
                  ),*/
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(3, 0), // changes position of shadow
                  ),
/*  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, -3), // changes position of shadow
                  ),*/
                ],
              ),
              child: Column(
                children: [
                  TableCalendar(
                    rowHeight: 36,
                    calendarBuilders: CalendarBuilders(
                      defaultBuilder: (context, date, events) {
                        if (mostarUt == true) {
                          var color = getColor(
                              date); // Usamos la función getColor para obtener el color
                          return Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  color: date == _selectedDay
                                      ? color.withOpacity(0.7)
                                      : color,
                                ),
                              ),
                              Text(
                                '${date.day}',
                                style: const TextStyle(
                                  fontSize: 13, // ajusta el tamaño de la fuente
                                ),
                              ),
                            ],
                          );
                        }
                      },
                      singleMarkerBuilder: (context, date, event) {
                        if (mostarUt == false) {
                          return Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: date == _selectedDay
                                    ? Colors.white
                                    : Colors.grey), //Change color
                            width: 5.0,
                            height: 5.0,
                            //   color: Colors.black,
                            margin: const EdgeInsets.symmetric(horizontal: 1.5),
                          );
                        } else {
                          return Container(
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: null),
                            width: 5.0,
                            height: 5.0,
                            //   color: Colors.black,
                            margin: const EdgeInsets.symmetric(horizontal: 1.5),
                          );
                        }
                      },
                    ),
                    onPageChanged: (s) {
                      year = s.year;
                      month = s.month.toString();
                      kFirstDays =
                          DateTime(year, DateTime.now().month - 4, s.day);
                      _focusedDay = s;
                      loadEvents();
                      setState(() {});
                    },
                    formatAnimationCurve: Curves.linear,
                    headerVisible: true,
                    calendarStyle: CalendarStyle(
                      todayDecoration: mostarUt
                          ? BoxDecoration(
                              color: getColor(DateTime.now()).withOpacity(
                                  0.7), // Usa getColor para el día actual
                              shape: BoxShape.rectangle,
                              border: Border.all(color: Colors.red), //
                            )
                          : BoxDecoration(
                              color: Colors
                                  .transparent, // Usa getColor para el día actual
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.red), //
                            ),
                      selectedDecoration: mostarUt
                          ? BoxDecoration(
                              color: _selectedDay != null
                                  ? getColor(_selectedDay!).withOpacity(0.8)
                                  : Colors.transparent,
                              shape: BoxShape.rectangle,
                              border: Border.all(
                                  color: getColor(_selectedDay!).withOpacity(
                                      1)), // Agrega esta línea para eliminar el borde blanco
                            )
                          : BoxDecoration(
                              color: Colors
                                  .grey, // Usa getColor para el día actual
                              shape: BoxShape.circle,
                              // border: Border.all(color: Colors.red), //
                            ),
                      selectedTextStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors
                              .black // ajusta el color de la fuente del día seleccionado
                          ),
                      cellPadding: const EdgeInsets.symmetric(vertical: 4),
                      rangeHighlightColor: Colors.green,
                      todayTextStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors
                              .blueGrey // ajusta el tamaño de la fuente del día actual
                          ),
                    ),
                    daysOfWeekStyle: const DaysOfWeekStyle(
                      weekendStyle: TextStyle(color: Colors.red),
                      weekdayStyle: TextStyle(color: Colors.blue),
                    ),
                    locale: 'es_ES',
                    headerStyle: HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                      titleTextStyle: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.bold),
                      titleTextFormatter: (date, _) =>
                          DateFormat.yMMMM('es_ES').format(date).toUpperCase(),
                    ),
                    eventLoader: _getEventsForDay,
                    selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
                    onDaySelected: (selectedDay, focusedDay) {
                      filterTipoProgramacion = "";
                      setState(() {
                        _focusedDay = focusedDay;
                        _selectedDay = selectedDay;
                        _selectedEvents = eventos
                            .where((evento) =>
                                isSameDay(evento.fecha, _selectedDay))
                            .toList();
                      });
                      if (_selectedEvents.isNotEmpty) {
                        BusyIndicator.show(context);

                        showAlertDialogAprobar(context, _selectedDay);

                        // "Detalle", _selectedEvents,
                      }
                    },
                    firstDay: kFirstDays,
                    lastDay: kLastDay,
                    focusedDay: _focusedDay,
                    calendarFormat: CalendarFormat.month,
                  ),
                  const SizedBox(height: 15.0),
                  mostarUt
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.red[
                                    100], // Cambia el color según tus necesidades
                              ),
                            ),
                            Text(" 0 AL 50%"),
                            Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.yellow[
                                    100], // Cambia el color según tus necesidades
                              ),
                            ),
                            Text(" 51 AL 90%"),
                            Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.green[
                                    100], // Cambia el color según tus necesidades
                              ),
                            ),
                            Text(" 91 AL 100%"),
                          ],
                        )
                      : Container(),
                  mostarUt
                      ? Text(
                          "% de Tambos con Actividades Programadas y/o Ejecutadas",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      : Container(),
                  const Text(
                    "FUENTE: PNPAIS",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),

            //     const SizedBox(height: 14.0),
            //       const Divider(color: Colors.black, height: 20),
          ],
        ),
      ),
    );
  }

  baklayer() {
    return ListView(children: [
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
            mostarUt ? unidadesTerritorales() : Container(),
            const SizedBox(height: 10),
            Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                margin: const EdgeInsets.only(right: 15, left: 30),
                height: 40.0,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFB40404),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  onPressed: () async {
                    filtroIntervencionesTambos.inicio =
                        _controlleFechaInici.text;
                    filtroIntervencionesTambos.fin = _controlleFechaFin.text;
                    _backdropKey.currentState!.fling();
                    await filters();
                  },
                  child: const Text("FILTRAR"),
                )),
          ])))
    ]);
  }

  unidadesTerritorales() {
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

  showAlertDialogAprobar(BuildContext context, selectDay) async {
    FiltroIntervencionesTambos filtroIntervencionesTambosS =
        FiltroIntervencionesTambos();
    filtroIntervencionesTambosS.inicio =
        DateFormat('dd-MM-yyyy').format(selectDay);
    filtroIntervencionesTambosS.fin =
        DateFormat('dd-MM-yyyy').format(selectDay);
    filtroIntervencionesTambosS.id = filtroIntervencionesTambos.id;
    filtroIntervencionesTambosS.mes = filtroIntervencionesTambos.mes;
    filtroIntervencionesTambosS.anio = filtroIntervencionesTambos.anio;
    //filtroIntervencionesTambosS.anio =
    //    int.parse(DateFormat('yyyy').format(selectDay));
    //filtroIntervencionesTambosS.mes = DateFormat('MM').format(selectDay);
    filtroIntervencionesTambosS.estado = filtroIntervencionesTambos.estado;
    filtroIntervencionesTambosS.ut = filtroIntervencionesTambos.ut;

    print(filtroIntervencionesTambosS.inicio);

    var selectedEventss = await ProviderRegistarInterv()
        .cargarEventosTamb(filtroIntervencionesTambosS);
    var totalTambos = '';
    var totalTamboCon = '';
    var totalTamboSin = '';
    await ProviderRegistarInterv()
        .cantidadTambo(filtroIntervencionesTambosS)
        .then((values) {
      setState(() {
        totalTambos = values[0];
        totalTamboCon = values[1];
        totalTamboSin = values[2];
      });
      porcentaje =
          ((int.parse(totalTamboCon) / int.parse(totalTambos)) * 100).toInt();

      colorPorcentaje = ((porcentaje <= 50)
          ? Colors.red
          : ((porcentaje > 50 && porcentaje <= 90)
              ? Colors.amber
              : Colors.green));
    });
    BusyIndicator.hide(context);

    showDialog(
      context: context,
      builder: (BuildContext context) => buildSuccessDialog2(context,
          title: "LISTA DE INTERVENCIONES NIVEL NACIONAL",
          selectedEventss: selectedEventss,
          selectDay: selectDay,
          totalTamboCon: totalTamboCon,
          totalTamboSin: totalTamboSin),
    );
  }

  Widget buildSuccessDialog2(BuildContext context,
      {String? title,
      String? subTitle,
      List<Evento>? selectedEventss,
      selectDay,
      totalTamboCon,
      totalTamboSin}) {
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
        .length;

    var dentro = selectedEventss
        .where((element) => element.idLugarIntervencion.contains('1'))
        .toList()
        .length;
    var fuera = selectedEventss
        .where((element) => element.idLugarIntervencion.contains('2'))
        .toList()
        .length;
    var SV = selectedEventss
        .where((element) =>
            element.idLugarIntervencion == null ||
            element.idLugarIntervencion == '0')
        .toList()
        .length;

    return StatefulBuilder(
        builder: (BuildContext context, StateSetter sstdotstate) {
      return AlertDialog(
        title: SizedBox(
          height: mostarUt ? 300 : 280,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                      child: Text(
                    title!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    softWrap: false,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  )),
                ],
              ),
              const SizedBox(
                height: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    DateFormat('dd/MM/yyyy').format(selectDay),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              mostarUt == true
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "TAMBOS CON INTERVENCIONES ($totalTamboCon) ($porcentaje %)",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 11, fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  : Container(),
              mostarUt == true
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "TAMBOS SIN INTERVENCIONES ($totalTamboSin) (${100 - porcentaje} %)",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 11, fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  : Container(),
              Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "DENTRO DEL TAMBO : $dentro",
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "FUERA DEL TAMBO : $fuera",
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "SIN VALOR : $SV",
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              //  : Container(),
              const SizedBox(
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
                  });
                },
                child: Row(
                  children: [
                    const Icon(
                      Icons.radio_button_checked_outlined,
                      color: Colors.grey,
                    ),
                    Text(
                      " INTERVENCION DE PRESTACIONES ($cant1)",
                      style: const TextStyle(fontSize: 11),
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
                    const Icon(Icons.radio_button_checked_outlined,
                        color: Colors.blue),
                    Text(" INTERVENCION DE SOPORTE ($cant3)",
                        style: const TextStyle(fontSize: 11)),
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
                    const Icon(
                      Icons.radio_button_checked_outlined,
                      color: Colors.green,
                    ),
                    Text(" ACTIVIDADES GIT ($cant2)",
                        style: const TextStyle(fontSize: 11)),
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
                    const Icon(
                      Icons.radio_button_checked_outlined,
                      color: Colors.black,
                    ),
                    Text(" TODOS (${selectedEventss.length})",
                        style: const TextStyle(fontSize: 11)),
                  ],
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Exportar Detalle ',
                      style: TextStyle(fontSize: 15),
                    ), // Texto para mostrar al lado del icono

                    IconButton(
                      icon: const Icon(Icons.download),
                      onPressed: () async {
                        try {
                          print(DateFormat('dd/MM/yyyy').format(selectDay));

                          BusyIndicator.show(context);
                          bool isConnec =
                              await CheckConnection.isOnlineWifiMobile();
                          if (isConnec) {
                            RespBase64FileDto oB64 =
                                await mainCtr.getReporteIntervenciones(
                                    (filtroIntervencionesTambos.id == '0'
                                        ? 'X'
                                        : filtroIntervencionesTambos.id ?? 'X'),
                                    (filtroIntervencionesTambos.tipo == '0'
                                        ? 'X'
                                        : filtroIntervencionesTambos.tipo ??
                                            'X'),
                                    (filtroIntervencionesTambos.estado == '0'
                                        ? 'X'
                                        : filtroIntervencionesTambos.estado ??
                                            'X'),
                                    (filtroIntervencionesTambos.ut == '0'
                                        ? 'X'
                                        : filtroIntervencionesTambos.ut ?? 'X'),
                                    DateFormat('dd-MM-yyyy').format(selectDay),
                                    DateFormat('dd-MM-yyyy').format(selectDay),
                                    (filtroIntervencionesTambos.mes == '0'
                                        ? 'X'
                                        : filtroIntervencionesTambos.mes ??
                                            'X'),
                                    filtroIntervencionesTambos.anio.toString());
                            Uint8List dataPdf =
                                convertBase64(oB64.base64 ?? '');

                            BusyIndicator.hide(context);

                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    PdfPreviewPage2(dataPdf: dataPdf),
                              ),
                            );
                            return;
                          } else {}
                        } catch (oError) {}
                        BusyIndicator.hide(context);
                      },
                    ),
                  ],
                ),
              )
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
                                      padding: const EdgeInsets.all(4),
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
                                        borderRadius: const BorderRadius.all(
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
                                                        SizedBox(
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
                                                                  text: tamboNm,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                                TextSpan(
                                                                  text:
                                                                      ' - ${elementos3[1]}\n',
                                                                ),
                                                                const TextSpan(
                                                                  text:
                                                                      'LUGAR : ',
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                                TextSpan(
                                                                    text:
                                                                        "${event.idLugarIntervencion == '1' ? 'DENTRO DEL TAMBO' : ''}"
                                                                        "${event.idLugarIntervencion == '2' ? 'FUERA DEL TAMBO' : ''}"
                                                                        "${event.idLugarIntervencion != '1' && event.idLugarIntervencion != '2' ? 'SIN VALOR' : ''}"),
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
}

Uint8List convertBase64(String base64String) {
  return const Base64Decoder().convert(base64String.split(',').last);
}
