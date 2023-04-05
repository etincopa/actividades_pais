import 'dart:convert';

import 'package:actividades_pais/backend/controller/main_controller.dart';
import 'package:actividades_pais/backend/model/IncidentesInternetModel.dart';
import 'package:actividades_pais/backend/model/atencion_intervencion_beneficiario_resumen_model.dart';
import 'package:actividades_pais/backend/model/avance_metas.dart';
import 'package:actividades_pais/backend/model/clima_model.dart';
import 'package:actividades_pais/backend/model/dato_jefe_ut_model.dart';
import 'package:actividades_pais/backend/model/dto/response_base64_file_dto.dart';
import 'package:actividades_pais/backend/model/dto/response_search_tambo_dto.dart';
import 'package:actividades_pais/backend/model/dto/response_tambo_servicio_internet_dto.dart';
import 'package:actividades_pais/backend/model/historial_gestor_model.dart';
import 'package:actividades_pais/backend/model/historial_jefe_ut_model.dart';
import 'package:actividades_pais/backend/model/imagen_jut_model.dart';
import 'package:actividades_pais/backend/model/lista_equipamiento_informatico.dart';
import 'package:actividades_pais/backend/model/mantenimiento_infraestructura_model.dart';
import 'package:actividades_pais/backend/model/plan_mantenimiento_model.dart';
import 'package:actividades_pais/backend/model/priorizacion_model.dart';
import 'package:actividades_pais/backend/model/programacion_intervenciones_tambos_model.dart';
import 'package:actividades_pais/backend/model/obtener_metas_tambo_model.dart';
import 'package:actividades_pais/backend/model/programacion_mantenimiento_model.dart';
import 'package:actividades_pais/backend/model/tambo_activida_model.dart';
import 'package:actividades_pais/backend/model/tambo_combustible_model.dart';
import 'package:actividades_pais/backend/model/tambo_guardiania_model.dart';
import 'package:actividades_pais/backend/model/tambo_model.dart';
import 'package:actividades_pais/backend/model/tambo_ruta_model.dart';
import 'package:actividades_pais/backend/model/tambo_servicio_basico_model.dart';
import 'package:actividades_pais/backend/model/unidad_ut_jefe_model.dart';
import 'package:actividades_pais/src/pages/MonitoreoProyectoTambo/main/Components/fab.dart';
import 'package:actividades_pais/src/pages/MonitoreoProyectoTambo/main/Project/Report/pdf/pdf_preview_page2.dart';
import 'package:actividades_pais/src/pages/Tambook/Home/home_tambook.dart';
import 'package:actividades_pais/src/pages/Tambook/Home/main_tambook.dart';
import 'package:actividades_pais/src/pages/Tambook/Detalle/mapa.dart';
import 'package:actividades_pais/src/pages/Tambook/search/search_tambook.dart';
import 'package:actividades_pais/src/pages/widgets/image_preview.dart';
import 'package:actividades_pais/util/Constants.dart';
import 'package:actividades_pais/util/busy-indicator.dart';
import 'package:actividades_pais/util/check_connection.dart';
import 'package:actividades_pais/util/home_options.dart';
import 'package:actividades_pais/util/image_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:kdgaugeview/kdgaugeview.dart';
import 'package:lecle_bubble_timeline/lecle_bubble_timeline.dart';
import 'package:lecle_bubble_timeline/models/timeline_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import "package:collection/collection.dart";

class DetalleTambook extends StatefulWidget {
  const DetalleTambook({super.key, this.listTambo});
  final BuscarTamboDto? listTambo;

  @override
  _DetalleTambookState createState() => _DetalleTambookState();
}

class _DetalleTambookState extends State<DetalleTambook>
    with TickerProviderStateMixin<DetalleTambook> {
  late TabController _tabController;
  late TabController _tabControllerTitle;
  final List<String> titleList = [
    "INFORMACIÓN DEL TAMBO",
    "INFORMACIÓN DEL PERSONAL",
    "METAS",
    "PLAN DE MANTENIMIENTO",
    "SERVICIOS DEL TAMBO",
    "EQUIPOS INFORMÁTICOS",
    "ACTIVIDADES",
    "CLIMA",
    "COMO LLEGAR AL TAMBO",
    "INTERVENCIONES"
  ];
  String currentTitle = '';
  int _selectedTab = 0;

  ScrollController scrollCtr = ScrollController();
  ScrollController scrollCtr2 = ScrollController();
  Animation<double>? _animation;
  AnimationController? _controller;
  MainController mainCtr = MainController();

  late TamboModel oTambo = TamboModel.empty();
  late DatosJUTTamboModel oJUT = DatosJUTTamboModel.empty();
  late UnidadTerritorialModel oUT = UnidadTerritorialModel.empty();
  late List<TamboActividadModel> aActividad = [];
  List<AvanceMetasModel> aMetasMensualizada = [];

  late List<AtenInterBeneResumenModel> aAtenInterBene = [];
  late List<TamboActividadModel> aInterAmbDir = [];
  late List<TamboActividadModel> aInterSopEnt = [];
  late List<TamboActividadModel> aCoordinacio = [];
  List<HomeOptions> aEquipoInformatico = [];
  late List<ImagenJUTModel> aImagenJut = [];

  late List<IncidentesInternetModel> incidencias = [];
  late GuardianiaTamboModel oGuardia = GuardianiaTamboModel.empty();

  late List<RutaTamboModel> aRuta = [];
  late List<PriorizacionModel> aPriorizacion = [];
  late List<PlanMantenimientoModel> aPlanMantenimientoInformatico = [];
  late List<ProgramacionMantenimientoModel> aPlanMantenimientoMeses = [];
  late List<PlanMantenimientoInfraestructuraModel>
      aPlanMantenimientoInfraestructura = [];
  late List<ServicioBasicoTamboModel> aSrvBasico = [];
  late List<HistorialGestorModel> aHistorialGestor = [];
  late List<HistorialJUTModel> aHistorialJUT = [];

  late ClimaModel clima = ClimaModel.empty();
  bool isLoading = true;
  bool isLoadingTambo = false;
  bool isLoadingRuta = false;
  bool isLoadingMantenimientoEquipos = true;
  bool isLoadingMantenimientoMeses = true;
  bool isLoadingMantenimientoInfraestructura = true;
  bool isLoadingPriorizacion = false;

  bool isLoadingSrvBasico = true;
  bool isLoadingGuardian = false;
  bool isLoadingJUT = false;
  bool isLoadingImagenJUT = false;
  bool isLoading2 = false;
  bool isLoadingEI = true;
  bool isLoadingHistorialGestor = false;
  int statusLoadActividad = 0;
  bool loading = true;
  bool isEndPagination = false;
  int offset = 0;
  int limit = 15;
  DateFormat oDFormat = DateFormat('yyyy-MM-dd');
  DateFormat oDFormat2 = DateFormat('HHmmss');
  DateTime now = DateTime.now();
  String sCurrentYear = "";
  String sCurrentTime = "0";
  String sCurrentLogo = "assets/sol.png";

  CombustibleTamboModel oCombustible = CombustibleTamboModel.empty();
  List<ProgIntervencionTamboModel> aAvance = [];
  List<MetasTamboModel> aMetasTipo1 = [];
  List<MetasTamboModel> aMetasTipo2 = [];
  List<EquipamientoInformaticoModel> aEquipos = [];
  AtenInterBeneResumenModel oDatoGeneral = AtenInterBeneResumenModel.empty();

  @override
  void dispose() {
    scrollCtr.dispose();
    scrollCtr2.removeListener(() async {});
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    sCurrentYear = now.year.toString();
    sCurrentTime = oDFormat2.format(now);

    sCurrentLogo =
        int.parse(sCurrentTime) > 180000 ? 'assets/luna.png' : 'assets/sol.png';

    scrollCtr = ScrollController();
    scrollCtr.addListener(
      () => setState(() {}),
    );

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );
    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _controller!);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    _tabController = TabController(vsync: this, length: 3);

    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {
          _selectedTab = _tabController.index;
        });
      }
    });

    currentTitle = titleList[0];
    _tabControllerTitle = TabController(length: 10, vsync: this);
    _tabControllerTitle.addListener(changeTitle);

    super.initState();
    /**
     * OBTENER DETALLE GENERAL DE TMBO
     */

    tamboDatoGeneral();
    obtenerAvanceMetasPorMes();
    TamboIntervencionAtencionIncidencia();

    //incidenciasInternet();
  }

  Future<void> tamboDatoGeneral() async {
    oTambo = await mainCtr.getTamboDatoGeneral(
      (widget.listTambo!.idTambo).toString(),
    );

    isLoadingTambo = true;

    jutTambo(oTambo.nSnip ?? 0);
    jutTamboImagen(oTambo.nSnip.toString() ?? '0');
    guardianTambo(oTambo.nSnip ?? 0);
    rutaTambo(oTambo.nSnip ?? 0);
    servicioBasicoTambo(oTambo.idTambo ?? 0);
    obtenerDatosClima();
    getMetasGeneral();
    incidenciasInternet(oTambo.nSnip ?? 0);
    //getCombustibleTambo();
    getProgIntervencionTambo();

    getPlanMantenimientoInformatico(oTambo.ut.toString());

    getPlanMantenimientoInfraestructura(oTambo.nSnip.toString());
    getPriorizacionTambo(oTambo.idTambo.toString() ?? "0");
    buildEquipoInformatico(oTambo.nSnip.toString());
    //getHistorialGestores(oTambo.nSnip.toString());

    setState(() {});
  }

  // This function is called, every time active tab is changed
  void changeTitle() {
    setState(() {
      // get index of active tab & change current appbar title
      currentTitle = titleList[_tabControllerTitle.index];
    });
  }

  Future<void> obtenerAvanceMetasPorMes() async {
    aMetasMensualizada = await mainCtr.getAvanceMetasMensualizada(sCurrentYear);
  }

  Future<void> getProgIntervencionTambo() async {
    /**
      Intervenciones en los Tambos
      ----------------------------------
      - TIPO											                CLAVE
      TODOS											                  x
      INTERVENCION DE PRESTACIONES DE SERVICIOS		1
      ACTIVIDADES-GIT									            2
      INTERVENCION DE SOPORTE							        3
      - ESTADO				            CLAVE
      TODOS				                x
      PROGRAMADOS			            1
      EJECUTADO / POR APROBAR			2
      OBSERVADOS			            3
      APROBADAS			              4
      ELIMINADOS			            0
     */
    aAvance = await mainCtr.progIntervencionTambo(
      '${oTambo.idTambo}',
      sCurrentYear,
      '03',
      'X',
      'X',
      'X',
      'X',
    );

    /**
     * Solo filtral registros cuyo estados esten en 
     * 4 : FINALIZADO/APROBADOS
     */
    aAvance = aAvance.where((e) => e.estadoProgramacion == 4).toList();
    //aAvance.sort((a, b) => a.fecha!.compareTo(b.fecha!));
  }

  Future<void> getAtenInterBeneResumen() async {
    aAtenInterBene = await mainCtr.AtenInterBeneResumen(
      '${oTambo.nSnip}',
    );

    if (aAtenInterBene.isNotEmpty) {
      oDatoGeneral = aAtenInterBene[0];
    }
  }

  Future<void> getCombustibleTambo() async {
    var aCombustible = await mainCtr.CombustibleTambo(
      '0',
      '${oTambo.idTambo}',
      '1',
      '1',
      '10',
    );
    if (aCombustible.isNotEmpty) {
      oCombustible = aCombustible[0];
      setState(() {});
    }
  }

  Future<void> getMetasGeneral() async {
    isLoading2 = false;
    getAtenInterBeneResumen();
    DateTime today = DateTime.now();
    String dateStr = "${today.year}";
    List<MetasTamboModel> aMetas =
        await mainCtr.metasTambo('${oTambo.nSnip ?? 0}', sCurrentYear, 0);

    aMetasTipo1 = aMetas.where((e) => e.numTipoMeta == 1).toList();
    aMetasTipo2 = aMetas.where((e) => e.numTipoMeta == 2).toList();

    isLoading2 = true;
    setState(() {});
  }

  void handleNext() {
    scrollCtr2.addListener(() async {
      if ((scrollCtr2.offset >= scrollCtr2.position.maxScrollExtent)) {
        offset = offset + 1;
        readJson(offset);
      }
    });
  }

  Future<void> readJson(paraOffset) async {
    if (!isEndPagination) {
      setState(() {
        loading = true;
      });

      setState(() {
        loading = false;
      });
    }
  }

  Uint8List convertBase64(String base64String) {
    return const Base64Decoder().convert(base64String.split(',').last);
  }

  Future<void> guardianTambo(int snip) async {
    isLoadingGuardian = false;
    List<GuardianiaTamboModel> aGuardia =
        await mainCtr.guardianiaTambo(snip.toString());
    if (aGuardia.isNotEmpty) {
      oGuardia = aGuardia[0];
    }
    isLoadingGuardian = true;
    setState(() {});
  }

  Future<void> jutTamboImagen(String snip) async {
    isLoadingImagenJUT = false;
    aImagenJut = await mainCtr.obtenerImagenJUT(snip.toString());

    isLoadingImagenJUT = true;
    setState(() {});
  }

  Future<void> jutTambo(int snip) async {
    isLoadingJUT = false;
    List<DatosJUTTamboModel> aJut =
        await mainCtr.DatosJUTTambo(snip.toString());

    if (aJut.isNotEmpty) {
      oJUT = aJut[0];
      List<UnidadTerritorialModel> aUnidadTerritoria =
          await mainCtr.UnidadTerritorial(oJUT.idUnidadesTerritoriales);
      if (aUnidadTerritoria.isNotEmpty) {
        oUT = aUnidadTerritoria[0];
      }

      getHistorialJUT(oJUT.idUnidadesTerritoriales!);
    }

    isLoadingJUT = true;
    setState(() {});
  }

  Future<void> rutaTambo(int snip) async {
    isLoadingRuta = false;
    aRuta = await mainCtr.rutaTambo(snip.toString());
    isLoadingRuta = true;
    setState(() {});
  }

  Future<void> servicioBasicoTambo(int idTambo) async {
    isLoadingGuardian = false;
    aSrvBasico = await mainCtr.servicioBasicoTambo(idTambo.toString());
    isLoadingGuardian = true;
    setState(() {});
  }

  Future<void> incidenciasInternet(int snip) async {
    incidencias = await mainCtr.getIncidenciasInternet(snip);
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      isLoading = false;
    });
  }

  Future<void> obtenerDatosClima() async {
    String url =
        "https://api.open-meteo.com/v1/forecast?latitude=${oTambo.yCcpp}2&longitude=${oTambo.xCcpp}&current_weather=true";

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      clima =
          ClimaModel.fromJson(json.decode(response.body)['current_weather']);
    } else {
      print("Error con la respuesta");
    }
  }

  Future<void> TamboIntervencionAtencionIncidencia() async {
    /*
   * statusLoadActividad:
   * 0: ESPERANDO
   * 1: FINALIZO
   * 2: ERROR
   * */

    statusLoadActividad = 0;
    try {
      aActividad = await mainCtr.getTamboIntervencionAtencionIncidencia(
        widget.listTambo!.idTambo,
        0,
        0,
        0,
      );

      /*
        TIPO:
        1 - INTERVENCIÓN DE ÁMBITO DIRECTO
        2 - INTERVENCIÓN DE SOPORTE A ENTIDADES
        4 - COORDINACIONES
        */
      int maxData = 50;
      for (var oAct in aActividad) {
        if (oAct.tipo == 1) {
          if (aInterAmbDir.length < maxData) aInterAmbDir.add(oAct);
        } else if (oAct.tipo == 2) {
          if (aInterSopEnt.length < maxData) aInterSopEnt.add(oAct);
        } else if (oAct.tipo == 4) {
          if (aCoordinacio.length < maxData) aCoordinacio.add(oAct);
        }
      }

      statusLoadActividad = 1;

      setState(() {});
    } catch (oError) {
      statusLoadActividad = 2;
    }
  }

  Future<Uint8List> downloadPDF() async {
    RespBase64FileDto oB64 = await mainCtr.getBuildBase64PdfFichaTecnica(
      (widget.listTambo!.idTambo).toString(),
    );
    return convertBase64(oB64.base64 ?? '');
  }

  Future<void> getPlanMantenimientoInformatico(String idRegion) async {
    isLoadingMantenimientoEquipos = true;
    aPlanMantenimientoInformatico = await mainCtr.planMantenimiento(idRegion);
    isLoadingMantenimientoEquipos = false;
    setState(() {});
  }

  Future<void> getProgramacionMantenimientoInfrasestructura(
      String idRegion) async {
    isLoadingMantenimientoMeses = true;
    aPlanMantenimientoMeses =
        await mainCtr.getProgramacionMantenimiento(idRegion);
    isLoadingMantenimientoMeses = false;
    setState(() {});
  }

  Future<void> getPlanMantenimientoInfraestructura(String snip) async {
    isLoadingMantenimientoInfraestructura = true;
    aPlanMantenimientoInfraestructura =
        await mainCtr.planMantenimientoInfraestructura(snip);

    if (aPlanMantenimientoInfraestructura.isNotEmpty) {
      getProgramacionMantenimientoInfrasestructura(
          aPlanMantenimientoInfraestructura[0].departamento!);
    }

    isLoadingMantenimientoInfraestructura = false;
    setState(() {});
  }

  Future<void> getPriorizacionTambo(String idTambo) async {
    isLoadingPriorizacion = false;
    aPriorizacion = await mainCtr.priorizacionTambo(idTambo);
    isLoadingPriorizacion = true;
    setState(() {});
  }

  Future<void> getHistorialGestores(String snip) async {
    isLoadingHistorialGestor = false;
    aHistorialGestor = await mainCtr.getHistorialGestor(snip);
    isLoadingHistorialGestor = true;
    setState(() {});
  }

  Future<void> getHistorialJUT(String ut) async {
    isLoadingHistorialGestor = false;
    aHistorialJUT = await mainCtr.HistorialJUT(ut);
    isLoadingHistorialGestor = true;
    setState(() {});
  }

  Future<void> buildEquipoInformatico(String snip) async {
    aEquipos = await mainCtr.getEquipamientoInformatico(snip);

    var equipamiento = groupBy(aEquipos, (obj) => obj.categoria);

    var tipoEquipos = equipamiento.keys.toList();

    for (int i = 0; i < tipoEquipos.length; i++) {
      aEquipoInformatico.add(
        HomeOptions(
          code: 'OPT200${i + 1}',
          name:
              '${tipoEquipos[i].toString()}\n(${equipamiento[tipoEquipos[i].toString()]!.length})',
          name2: tipoEquipos[i].toString(),
          types: const ['Ver'],
          image: 'assets/iconos_equipos/${tipoEquipos[i].toString()}.png',
          color: Colors.white,
        ),
      );
    }

    /*String icon1 = 'assets/icons/computadora.png';
    String icon2 = 'assets/icons/laptop.png';
    String icon3 = 'assets/icons/proyector.png';
    String icon4 = 'assets/icons/wifi.png';
    String icon5 = 'assets/icons/impresora.png';
    String icon6 = 'assets/icons/parlante.png';

    var cpu = equipamiento['CPU']?.length ?? '0';
    var laptop = equipamiento['LAPTOP']?.length ?? '0';
    var proyector = equipamiento['PROYECTOR']?.length ?? '0';
    var impresora = equipamiento['IMPRESORA']?.length ?? '0';

    aEquipoInformatico.add(
      HomeOptions(
        code: 'OPT2001',
        name: 'PC \n(${cpu.toString()})',
        types: const ['Ver'],
        image: icon1,
        color: Colors.white,
      ),
    );
    aEquipoInformatico.add(
      HomeOptions(
        code: 'OPT2002',
        name: 'LAPTOP \n(${laptop.toString()})',
        types: const ['Ver'],
        image: icon2,
        color: Colors.white,
      ),
    );
    aEquipoInformatico.add(
      HomeOptions(
        code: 'OPT2003',
        name: 'PROYECTOR \n(${proyector.toString()})',
        types: const ['Ver'],
        image: icon3,
        color: Colors.white,
      ),
    );
    aEquipoInformatico.add(
      HomeOptions(
        code: 'OPT2004',
        name: 'ANTENA WIFI \n(1047)',
        types: const ['Ver'],
        image: icon4,
        color: Colors.white,
      ),
    );
    aEquipoInformatico.add(
      HomeOptions(
        code: 'OPT2005',
        name: 'IMPRESORAS \n(${impresora.toString()})',
        types: const ['Ver'],
        image: icon5,
        color: Colors.white,
      ),
    );
    aEquipoInformatico.add(
      HomeOptions(
        code: 'OPT2006',
        name: 'PARLANTES \n(1047)',
        types: const ['Ver'],
        image: icon6,
        color: Colors.white,
      ),
    );*/
  }

  Widget equipoInformatico() {
    return Flexible(
      child: SizedBox(
        height: 400.0,
        child: GridView.builder(
          physics: const BouncingScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.1,
            crossAxisSpacing: 30,
            mainAxisSpacing: 30,
          ),
          padding: const EdgeInsets.only(
            left: 28,
            right: 28,
            bottom: 58,
          ),
          itemCount: aEquipoInformatico.length,
          itemBuilder: (context, index) {
            if (aEquipoInformatico.isNotEmpty) {
              HomeOptions homeOption = aEquipoInformatico[index];
              return InkWell(
                splashColor: Colors.white10,
                highlightColor: Colors.white10,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: const DecorationImage(
                      image: AssetImage("assets/icons/botones 1-02.png"),
                      fit: BoxFit.cover,
                    ),
                    color: homeOption.color,
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 241, 240, 240)
                            .withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        const SizedBox(height: 5),
                        Container(
                          padding: const EdgeInsets.only(
                            top: 12,
                            bottom: 8,
                          ),
                          child: Hero(
                            tag: homeOption.image!,
                            child: Image.asset(
                              homeOption.image!,
                              fit: BoxFit.contain,
                              width: 80,
                              height: 70,
                              alignment: Alignment.center,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(1),
                          child: Center(
                            child: Text(
                              homeOption.name!,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                                fontSize: 11.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                onTap: () async {
                  var oEquipoInformatico = aEquipoInformatico[index];

                  var aEquipoSelect = aEquipos
                      .where((o) =>
                          o.categoria!.toUpperCase() ==
                          oEquipoInformatico.name2)
                      .toList();
                  if (aEquipoSelect.isNotEmpty) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => buildSuccessDialog2(
                        context,
                        title: "DETALLE DE EQUIPOS",
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: aEquipoSelect.length,
                          itemBuilder: (BuildContext context, int index) {
                            var oEquipoSelect = aEquipoSelect[index];
                            return Column(
                              children: [
                                Text(
                                  oEquipoSelect.descripcion ?? '',
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        const TextSpan(
                                          text: "FECHA DE ADQUISICIÓN: ",
                                          style: TextStyle(
                                            color: color_01,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                              oEquipoSelect.fechaContabilidad ??
                                                  '',
                                          style: const TextStyle(
                                            color: color_01,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        const TextSpan(
                                          text: "ESTADO: ",
                                          style: TextStyle(
                                            color: color_01,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        TextSpan(
                                          text: oEquipoSelect.estado ?? '',
                                          style: const TextStyle(
                                            color: color_01,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        const TextSpan(
                                          text: "CÓDIGO PATRIMONIAL: ",
                                          style: TextStyle(
                                            color: color_01,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                              oEquipoSelect.codigoPatrimonial ??
                                                  '',
                                          style: const TextStyle(
                                            color: color_01,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        const TextSpan(
                                          text: "MARCA: ",
                                          style: TextStyle(
                                            color: color_01,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        TextSpan(
                                          text: oEquipoSelect.marca ?? '',
                                          style: const TextStyle(
                                            color: color_01,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const Divider(color: colorI),
                              ],
                            );
                          },
                        ),
                      ),
                    );
                  }
                },
              );
            } else {
              Center(
                child: Text(
                  'SIN EQUIPOS ASIGNADOS',
                  style: const TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                    fontSize: 30.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var flexibleSpaceWidget = SliverAppBar(
      /*title const Text(
        "¡ BIENVENIDO A",
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
          fontWeight: FontWeight.w700,
        ),
      ),*/
      automaticallyImplyLeading: true,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      snap: false,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const TambookHome(),
            ),
          );
        },
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(15),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Text(
              "¡ BIENVENIDO A ${widget.listTambo?.nombreTambo} !",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Container(
            color: const Color.fromARGB(100, 22, 44, 33),
            margin: const EdgeInsets.only(left: 150.0, bottom: 45),
            padding: const EdgeInsets.all(10),
            child: Stack(children: [
              Text(
                "${clima.temp ?? ''} °",
                style: const TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                ),
              ),
              Positioned(
                right: -4.0,
                top: 12.0,
                child: ImageIcon(
                  AssetImage(sCurrentLogo),
                  size: 20,
                  color: Colors.yellow,
                ),
              ),
            ])),
        background: SizedBox(
          height: 200.0,
          child: InteractiveViewer(
            panEnabled: false, // Set it to false
            boundaryMargin: const EdgeInsets.all(100),
            minScale: 0.5,
            maxScale: 2,
            child: ImageUtil.ImageUrl(
              oTambo.tamboPathImage ?? '',
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            showSearch(
              context: context,
              delegate: SearchTambookDelegate(),
            );
          },
        )
      ],
    );
    return Scaffold(
      backgroundColor: color_10o15,
      body: SafeArea(
        child: Stack(
          children: [
            DefaultTabController(
              length: 10,
              child: NestedScrollView(
                controller: scrollCtr,
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return [
                    flexibleSpaceWidget,
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: _SliverAppBarDelegate(
                        minHeight: 40,
                        maxHeight: 40,
                        child: Container(
                          height: 800 * (1 / 11),
                          width: double.infinity,
                          color: const Color.fromARGB(255, 230, 234, 236),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.only(top: 10),
                                child: Center(
                                  child: Text(
                                    currentTitle,
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      letterSpacing: 0.0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: _SliverAppBarDelegate(
                        minHeight: 80,
                        maxHeight: 80,
                        child: Container(
                          color: const Color.fromARGB(255, 230, 234, 236),
                          child: TabBar(
                            labelColor: Colors.black,
                            unselectedLabelColor: Colors.black38,
                            indicatorColor: Colors.black,
                            isScrollable: true,
                            indicator: const BoxDecoration(
                              color: Colors.white70,
                            ),
                            controller: _tabControllerTitle,
                            tabs: const [
                              Tooltip(
                                waitDuration: Duration(seconds: 1),
                                showDuration: Duration(seconds: 2),
                                padding: EdgeInsets.all(5),
                                height: 35,
                                textStyle: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal),
                                triggerMode: TooltipTriggerMode.longPress,
                                message: 'Información del tambo',
                                child: Tab(
                                  icon: ImageIcon(
                                    AssetImage('assets/icono_tambo.png'),
                                    size: 55,
                                  ),
                                ),
                              ),
                              Tooltip(
                                waitDuration: Duration(seconds: 1),
                                showDuration: Duration(seconds: 2),
                                padding: EdgeInsets.all(5),
                                height: 35,
                                textStyle: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal),
                                triggerMode: TooltipTriggerMode.longPress,
                                message: 'Información del gestor institucional',
                                child: Tab(
                                  icon: ImageIcon(
                                    AssetImage('assets/gestor.png'),
                                    size: 55,
                                  ),
                                ),
                              ),
                              Tooltip(
                                waitDuration: Duration(seconds: 1),
                                showDuration: Duration(seconds: 2),
                                padding: EdgeInsets.all(5),
                                height: 35,
                                textStyle: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal),
                                triggerMode: TooltipTriggerMode.longPress,
                                message:
                                    'Información de metas de atención y usuarios',
                                child: Tab(
                                  icon: ImageIcon(
                                    AssetImage('assets/meta.png'),
                                    size: 55,
                                  ),
                                ),
                              ),
                              Tooltip(
                                waitDuration: Duration(seconds: 1),
                                showDuration: Duration(seconds: 2),
                                padding: EdgeInsets.all(5),
                                height: 35,
                                textStyle: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal),
                                triggerMode: TooltipTriggerMode.longPress,
                                message: 'Plan de mantenimiento',
                                child: Tab(
                                  icon: ImageIcon(
                                    AssetImage('assets/mantenimiento.png'),
                                    size: 55,
                                  ),
                                ),
                              ),
                              Tooltip(
                                waitDuration: Duration(seconds: 1),
                                showDuration: Duration(seconds: 2),
                                padding: EdgeInsets.all(5),
                                height: 35,
                                textStyle: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal),
                                triggerMode: TooltipTriggerMode.longPress,
                                message: 'INFORMACIÓN DE SERVICIOS DEL TAMBO',
                                child: Tab(
                                  icon: ImageIcon(
                                    AssetImage('assets/SERVICIOS.png'),
                                    size: 55,
                                  ),
                                ),
                              ),
                              Tooltip(
                                waitDuration: Duration(seconds: 1),
                                showDuration: Duration(seconds: 2),
                                padding: EdgeInsets.all(5),
                                height: 35,
                                textStyle: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal),
                                triggerMode: TooltipTriggerMode.longPress,
                                message: 'INFORMACIÓN DE EQUIPOS INFORMÁTICOS',
                                child: Tab(
                                  icon: ImageIcon(
                                    AssetImage('assets/computadora.png'),
                                    size: 55,
                                  ),
                                ),
                              ),

                              /*Tab(
                                icon: ImageIcon(
                                  AssetImage('assets/grifo.png'),
                                  size: 55,
                                ),
                              ),*/

                              Tooltip(
                                waitDuration: Duration(seconds: 1),
                                showDuration: Duration(seconds: 2),
                                padding: EdgeInsets.all(5),
                                height: 35,
                                textStyle: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal),
                                triggerMode: TooltipTriggerMode.longPress,
                                message: ' ACTIVIDADES PROGRAMADAS APROBADAS',
                                child: Tab(
                                  icon: ImageIcon(
                                    AssetImage('assets/calendario.png'),
                                    size: 55,
                                  ),
                                ),
                              ),
                              Tooltip(
                                waitDuration: Duration(seconds: 1),
                                showDuration: Duration(seconds: 2),
                                padding: EdgeInsets.all(5),
                                height: 35,
                                textStyle: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal),
                                triggerMode: TooltipTriggerMode.longPress,
                                message: 'INFORMACIÓN DEL CLIMA',
                                child: Tab(
                                  icon: ImageIcon(
                                    AssetImage('assets/lluvioso.png'),
                                    size: 55,
                                  ),
                                ),
                              ),
                              Tooltip(
                                waitDuration: Duration(seconds: 1),
                                showDuration: Duration(seconds: 2),
                                padding: EdgeInsets.all(5),
                                height: 35,
                                textStyle: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal),
                                triggerMode: TooltipTriggerMode.longPress,
                                message: 'COMO LLEGAR AL TAMBO',
                                child: Tab(
                                  icon: ImageIcon(
                                    AssetImage('assets/iconos_card/rutas.png'),
                                    size: 55,
                                  ),
                                ),
                              ),
                              Tooltip(
                                waitDuration: Duration(seconds: 1),
                                showDuration: Duration(seconds: 2),
                                padding: EdgeInsets.all(5),
                                height: 35,
                                textStyle: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal),
                                triggerMode: TooltipTriggerMode.longPress,
                                message: 'INTERVENCIONES',
                                child: Tab(
                                  icon: ImageIcon(
                                    AssetImage('assets/intervenciones.png'),
                                    size: 55,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // pinned: true,
                    ),
                  ];
                },
                body: TabBarView(
                  physics: const BouncingScrollPhysics(),
                  controller: _tabControllerTitle,
                  children: [
                    //const TabScreen("TAMBO"),
                    ListView(
                      children: [
                        const SizedBox(height: 10),

                        /*
                          * DATOS DE UBICACIÓN
                          */
                        cardDatosUbicacion(),
                        const SizedBox(height: 10),
                        /*
                          * CATEGORIZACIÓN TAMBOS
                          */
                        if (aPriorizacion.isNotEmpty) cardDatosCategorizacion(),
                        const SizedBox(height: 10),

                        /*
                          * DATOS GENERALES
                          */
                        cardDatosGenerales(),
                        const SizedBox(height: 10),

                        /*
                          * DATOS DEMOGRÁFICOS
                          */
                        cardDatosDemograficos(),
                        const SizedBox(height: 10),

                        /*
                          * DATOS DE LA OBRA
                          */
                        cardDatosObra(),
                        const SizedBox(height: 10),

                        /*
                          * CENTROS POBLADOS
                          */
                        cardAmbitoAccion(),
                        const SizedBox(height: 50),
                      ],
                    ),

                    //TabScreen("PERSONAL"),
                    ListView(
                      children: [
                        const SizedBox(height: 10),
                        /*
                          * NUESTRO GESTOR
                          */
                        cardNuestroGestor(),
                        const SizedBox(height: 10),
                        //cardHistorialGestores(),
                        //const SizedBox(height: 10),
                        cardVigilante(),
                        const SizedBox(height: 10),

                        /*
                          * NUESTRO JEFE DE UNIDAD TERRITORIAL
                          */
                        cardNuestroJefeUnidad(),
                        //const SizedBox(height: 10),
                        //cardHistorialJUT(),
                        const SizedBox(height: 50),
                      ],
                    ),

                    //const TabScreen("METAS"),
                    ListView(
                      children: [
                        const SizedBox(height: 10),
                        cardAtenciones(),
                        //cardIntervenciones(),
                        cardBeneficiarios(),
                      ],
                    ),

                    //const TabScreen("PLAN DE MANTENIMIENTO"),
                    ListView(
                      children: [
                        const SizedBox(height: 10),
                        cardDatosMantenimientoInformatico(),
                        const SizedBox(height: 10),
                        if (aPlanMantenimientoInfraestructura.isNotEmpty)
                          cardDatosMantenimientoInfraestructura(),
                        const SizedBox(height: 40),
                      ],
                    ),

                    //const TabScreen("SERVICIOS INTERNET"),
                    ListView(
                      children: [
                        cardDatosSrvInternet(),
                        const SizedBox(height: 10),
                        cardIncidencia(),
                        const SizedBox(height: 10),
                        cardServicioBasico(),
                        const SizedBox(height: 40),
                      ],
                    ),

                    //const TabScreen("EQUIPAMIENTO TECNOLÓGICO DEL TAMBO"),

                    SingleChildScrollView(
                        child: Column(
                      children: [
                        const SizedBox(height: 15),
                        cardEquipoTecnologico(),
                        const SizedBox(height: 40),
                      ],
                    )),

//const TabScreen("COMBUSTIBLE"),

                    /*ListView(
                      children: [
                        cardCombustible(),
                        const SizedBox(height: 40),
                      ],
                    ),*/

                    //const TabScreen("ACTIVIDADES PROGRAMADAS"),

                    ListView(
                      children: [
                        cardActividadProgramada(),
                        const SizedBox(height: 40),
                      ],
                    ),

                    //const TabScreen("Clima"),

                    ListView(
                      children: [
                        cardClima(),
                        const SizedBox(height: 10),
                      ],
                    ),

                    //const TabScreen("Clima"),

                    ListView(
                      children: [
                        const SizedBox(height: 10),
                        cardCamino(),
                      ],
                    ),

                    //const TabScreen("INTERVENCIONES"),
                    DefaultTabController(
                      length: 3,
                      child: Column(
                        children: <Widget>[
                          Material(
                            color: Colors.grey.shade300,
                            child: TabBar(
                              //isScrollable: true,
                              unselectedLabelColor: Colors.blue,
                              labelColor: Colors.blue,
                              indicatorColor: Colors.white,
                              controller: _tabController,
                              labelPadding: const EdgeInsets.all(0.0),
                              tabs: [
                                _getTab(
                                  0,
                                  const Center(
                                    child: Text(
                                      "Intervención de Ámbito Directo",
                                      style: TextStyle(
                                        color: colorS,
                                        fontWeight: FontWeight.w700,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 12.0,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                _getTab(
                                  1,
                                  const Center(
                                    child: Text(
                                      "Intervención de Soporte a Entidades",
                                      style: TextStyle(
                                        color: colorI,
                                        fontWeight: FontWeight.w700,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 12.0,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                _getTab(
                                  2,
                                  const Center(
                                    child: Text(
                                      "Coordinaciones",
                                      style: TextStyle(
                                        color: colorP,
                                        fontWeight: FontWeight.w700,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 12.0,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: TabBarView(
                              physics: const NeverScrollableScrollPhysics(),
                              controller: _tabController,
                              children: [
                                ListView(
                                  children: [
                                    cardDatosIntervencionCod1(),
                                    const SizedBox(height: 40),
                                  ],
                                ),
                                ListView(
                                  children: [
                                    cardDatosIntervencionCod2(),
                                    const SizedBox(height: 40),
                                  ],
                                ),
                                ListView(
                                  children: [
                                    cardDatosIntervencionCod4(),
                                    const SizedBox(height: 40),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: ExpandedAnimationFab(
        items: [
          FabItem(
            "Centros poblados",
            Icons.map_outlined,
            onPress: () async {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MapaTambo(
                      snip: oTambo.nSnip ?? 0,
                      latitud: double.parse(oTambo.yCcpp ?? '0'),
                      longitud: double.parse(oTambo.xCcpp ?? '0')),
                ),
              );
            },
          ),
          FabItem(
            "Ficha técnica",
            Icons.picture_as_pdf_sharp,
            onPress: () async {
              try {
                BusyIndicator.show(context);
                bool isConnec = await CheckConnection.isOnlineWifiMobile();
                if (isConnec) {
                  Uint8List dataPdf = await downloadPDF();
                  BusyIndicator.hide(context);
                  _controller!.reverse();

                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PdfPreviewPage2(dataPdf: dataPdf),
                    ),
                  );
                  return;
                } else {}
              } catch (oError) {}
              BusyIndicator.hide(context);
            },
          ),
        ],
        animation: _animation!,
        onPress: () {
          if (_controller!.isCompleted) {
            _controller!.reverse();
          } else {
            _controller!.forward();
          }
        },
      ),
    );
  }

  _getTab(index, child) {
    return Tab(
      child: SizedBox.expand(
        child: Container(
          child: child,
          decoration: BoxDecoration(
              color:
                  (_selectedTab == index ? Colors.white : Colors.grey.shade300),
              borderRadius: _generateBorderRadius(index)),
        ),
      ),
    );
  }

  _generateBorderRadius(index) {
    if ((index + 1) == _selectedTab)
      return const BorderRadius.only(bottomRight: Radius.circular(10.0));
    else if ((index - 1) == _selectedTab)
      return const BorderRadius.only(bottomLeft: Radius.circular(10.0));
    else
      return BorderRadius.zero;
  }

/*
 * -----------------------------------------------
 *            GESTOR
 * -----------------------------------------------
 */
  Padding cardNuestroGestor() {
    var heading = 'NUESTRO GESTOR';
    var subheading =
        '${oTambo.gestorNombre ?? ''} ${oTambo.gestorApellidos ?? ''}'
            .toUpperCase();
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: colorI,
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 5), // changes position of shadow
            ),
          ],
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          children: [
            ExpansionTile(
              tilePadding: const EdgeInsets.only(left: 0, right: 10),
              initiallyExpanded: true,
              title: ListTile(
                visualDensity: const VisualDensity(vertical: -4),
                leading: const ImageIcon(
                  AssetImage("assets/iconos_card/gestores.png"),
                  size: 40,
                  color: Colors.black,
                ),
                title: Text(
                  heading,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
                subtitle: Text(
                  subheading,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              children: <Widget>[
                isLoadingTambo
                    ? oTambo.gestorNombre!.isNotEmpty
                        ? Column(children: [
                            const Divider(color: colorI),
                            SizedBox(
                              height: 150.0,
                              child: ImageUtil.ImageUrl(
                                oTambo.gestorPathImage ?? '',
                                width: 150,
                                imgDefault: 'assets/icons/user-male-2.png',
                              ),
                            ),
                            Container(
                              // padding: EdgeInsets.all(5.0),
                              alignment: Alignment.centerLeft,
                              child: Card(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ListTile(
                                      title: const Text('CARRERA'),
                                      subtitle: Text(oTambo.gestorProfession!
                                              .toUpperCase() ??
                                          ''),
                                    ),
                                    ListTile(
                                      title: const Text('GRADO'),
                                      subtitle: Text(oTambo
                                              .gestorGradoAcademico!
                                              .toUpperCase() ??
                                          ''),
                                    ),
                                    ListTile(
                                      title: const Text('SEXO'),
                                      subtitle: Text(
                                          oTambo.gestorSexo!.toUpperCase() ??
                                              ''),
                                    ),
                                    ListTile(
                                      title: const Text('ESTADO CIVIL'),
                                      subtitle:
                                          Text(oTambo.gestorEstadoCivil ?? ''),
                                    ),
                                    ListTile(
                                      title: const Text('EMAIL'),
                                      subtitle: Text(oTambo.gestorCorreo ?? ''),
                                    ),
                                    ListTile(
                                      title: const Text('CELULAR'),
                                      subtitle:
                                          Text(oTambo.gestorTelefono ?? ''),
                                    ),
                                    ListTile(
                                      title: const Text('TIPO CONTRATO'),
                                      subtitle:
                                          Text(oTambo.gestorTipoContrato ?? ''),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ])
                        : Center(
                            child: Container(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 20, 20, 20),
                                child: const Text(
                                  'TAMBO SIN GESTOR',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                )))
                    : const CircularProgressIndicator(),
              ],
            ),
          ],
        ),
      ),
    );
  }

/*
 * -----------------------------------------------
 *            Guardian
 * -----------------------------------------------
 */
  Padding cardVigilante() {
    var heading = 'GUARDIÁN';
    var subheading =
        "${oGuardia.empleadoNombre!.toUpperCase() ?? ''} ${oGuardia.empleadoApellidoPaterno!.toUpperCase() ?? ''} ${oGuardia.empleadoApellidoMaterno!.toUpperCase() ?? ''}";

    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: colorI,
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 5), // changes position of shadow
            ),
          ],
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          children: [
            ExpansionTile(
              tilePadding: const EdgeInsets.only(left: 0, right: 10),
              initiallyExpanded: true,
              title: ListTile(
                visualDensity: const VisualDensity(vertical: -4),
                leading: const ImageIcon(
                  AssetImage("assets/iconos_card/guardian.png"),
                  size: 40,
                  color: Colors.black,
                ),
                title: Text(
                  heading,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
                subtitle: Text(
                  subheading,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              children: <Widget>[
                const Divider(color: colorI),
                Container(
                  // padding: EdgeInsets.all(5.0),
                  alignment: Alignment.centerLeft,
                  child: Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: const Text('DNI'),
                          subtitle: Text(oGuardia.numeroDocumento ?? ''),
                        ),
                        ListTile(
                          title: const Text('SEXO'),
                          subtitle: Text(oGuardia.sexo!.toUpperCase() ?? ''),
                        ),
                        ListTile(
                          title: const Text('CELULAR'),
                          subtitle: Text(oGuardia.celular!.toUpperCase() ?? ''),
                        ),
                        ListTile(
                          title: const Text('TIPO CONTRATO'),
                          subtitle:
                              Text(oGuardia.tipoContrato!.toUpperCase() ?? ''),
                        ),
                        ListTile(
                          title: const Text('FECHA INICIO CONTRATO'),
                          subtitle: Text(oGuardia.fecInicioContrato ?? ''),
                        ),
                        ListTile(
                          title: const Text('FECHA FIN CONTRATO'),
                          subtitle: Text(oGuardia.fecFinalContrato ?? ''),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Padding cardHistorialGestores() {
    var heading = 'HISTORIAL DE GESTORES';
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: colorI,
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 5), // changes position of shadow
            ),
          ],
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          children: [
            ExpansionTile(
              tilePadding: const EdgeInsets.only(left: 0, right: 10),
              initiallyExpanded: true,
              title: ListTile(
                visualDensity: const VisualDensity(vertical: -4),
                leading: const ImageIcon(
                  AssetImage("assets/iconos_card/historial.png"),
                  size: 40,
                  color: Colors.black,
                ),
                title: Text(
                  heading,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              children: <Widget>[
                const Divider(color: colorI),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        BubbleTimeline(
                          bubbleSize: 85,
                          // List of Timeline Bubble Items
                          items: [
                            if (isLoadingHistorialGestor)
                              for (var gestor in aHistorialGestor!)
                                TimelineItem(
                                  title: '${gestor.nombres}',
                                  subtitle:
                                      'FECHA INICIO: ${gestor.fechaInicio} \nFECHA FIN: ${gestor.fechaFin} ',
                                  icon: const Icon(
                                    Icons.person,
                                    color: Colors.white,
                                    size: 40,
                                  ),
                                  bubbleColor: Colors.grey,
                                ),
                          ],
                          stripColor: colorI,
                          dividerCircleColor: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Padding cardHistorialJUT() {
    var heading = 'UT HISTORIAL DE JUT';
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: colorI,
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 5), // changes position of shadow
            ),
          ],
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          children: [
            ExpansionTile(
              tilePadding: const EdgeInsets.only(left: 0, right: 10),
              initiallyExpanded: true,
              title: ListTile(
                visualDensity: const VisualDensity(vertical: -4),
                leading: const ImageIcon(
                  AssetImage("assets/iconos_card/historial.png"),
                  size: 40,
                  color: Colors.black,
                ),
                title: Text(
                  heading,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              children: <Widget>[
                const Divider(color: colorI),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        BubbleTimeline(
                          bubbleSize: 85,
                          // List of Timeline Bubble Items
                          items: [
                            if (isLoadingHistorialGestor)
                              for (var oJut in aHistorialJUT)
                                TimelineItem(
                                  title: '${oJut.nombresJut}',
                                  subtitle:
                                      '${oJut.apellidoPaternoJut} ${oJut.apellidoMaternoJut}',
                                  icon: const Icon(
                                    Icons.person,
                                    color: Colors.white,
                                    size: 40,
                                  ),
                                  bubbleColor: Colors.grey,
                                ),
                          ],
                          stripColor: colorI,
                          dividerCircleColor: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Padding cardDatosCategorizacion() {
    var heading = 'CATEGORIZACIÓN';
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: colorI,
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 5), // changes position of shadow
            ),
          ],
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          children: [
            ExpansionTile(
              initiallyExpanded: true,
              tilePadding: const EdgeInsets.only(left: 0, right: 10),
              title: ListTile(
                visualDensity: const VisualDensity(vertical: -4),
                leading: const ImageIcon(
                  AssetImage("assets/iconos_card/categorizacion.png"),
                  size: 40,
                  color: Colors.black,
                ),
                title: Text(
                  heading,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
              ),
              children: <Widget>[
                const Divider(color: colorI),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (aPriorizacion.isNotEmpty)
                          for (var priorizacion in aPriorizacion!)
                            ListTile(
                              iconColor: const Color.fromARGB(255, 0, 0, 0),
                              title:
                                  Text(priorizacion.nombrePriorizacion ?? ''),
                            ),
                        const SizedBox(height: 10),
                        const Text(
                            'FUENTE: UNIDAD DE PLATAFORMA DE SERVCIOS - PNPAIS'),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Padding cardDatosGenerales() {
    var heading = 'DATOS GENERALES';
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: colorI,
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 5), // changes position of shadow
            ),
          ],
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          children: [
            ExpansionTile(
              tilePadding: const EdgeInsets.only(left: 0, right: 10),
              initiallyExpanded: true,
              title: ListTile(
                visualDensity: const VisualDensity(vertical: -4),
                leading: const ImageIcon(
                  AssetImage("assets/iconos_card/datos_generales.png"),
                  size: 40,
                  color: Colors.black,
                ),
                title: Text(
                  heading,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
              ),
              children: <Widget>[
                const Divider(color: colorI),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: const Text('ATENCIONES'),
                          subtitle: Text('${oDatoGeneral.atenciones}'),
                        ),
                        ListTile(
                          title: const Text('INTERVENCIONES'),
                          subtitle: Text('${oDatoGeneral.intervenciones}'),
                        ),
                        ListTile(
                          title: const Text('USUARIOS'),
                          subtitle: Text('${oDatoGeneral.beneficiarios}'),
                        ),
                        const SizedBox(height: 10),
                        Text(
                            'ACTUALIZADO HASTA ${(aMetasMensualizada.isNotEmpty ? (obtenerNombreMesCompleto(aMetasMensualizada[aMetasMensualizada.length - 1].mes!)) : '')} DEL ${sCurrentYear}'),
                        const SizedBox(height: 10),
                        const Text('FUENTE: PNPAIS'),
                        const SizedBox(
                          height: 1,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Padding cardNuestroJefeUnidad() {
    var heading = 'NUESTRO JEFE DE UNIDAD TERRITORIAL';
    var subheading =
        "${oJUT.nombresJut!.toUpperCase() ?? ''} ${oJUT.apellidoPaternoJut!.toUpperCase() ?? ''} ${oJUT.apellidoMaternoJut!.toUpperCase() ?? ''}";
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: colorI,
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 5), // changes position of shadow
            ),
          ],
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          children: [
            ExpansionTile(
              tilePadding: const EdgeInsets.only(left: 0, right: 10),
              initiallyExpanded: true,
              title: ListTile(
                visualDensity: const VisualDensity(vertical: -4),
                leading: const ImageIcon(
                  AssetImage("assets/iconos_card/gestores.png"),
                  size: 40,
                  color: Colors.black,
                ),
                title: Text(
                  heading,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
                subtitle: Text(
                  subheading,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              children: <Widget>[
                const Divider(color: colorI),
                SizedBox(
                  height: 150.0,
                  child: isLoadingImagenJUT
                      ? ImageUtil.ImageUrl(
                          'https://www.pais.gob.pe/backendsismonitor/public/storage/${aImagenJut[0].path}',
                          width: 150,
                          imgDefault: 'assets/icons/user-male-2.png',
                        )
                      : Center(),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: const Text('DNI'),
                          subtitle: Text(oJUT.nroDocumento ?? ''),
                        ),
                        ListTile(
                          title: const Text('SEXO'),
                          subtitle: Text(oJUT.genero!.toUpperCase() ?? ''),
                        ),
                        ListTile(
                          title: const Text('CELULAR'),
                          subtitle: Text(oJUT.telefono ?? ''),
                        ),
                        ListTile(
                          title: const Text('EMAIL'),
                          subtitle: Text(oJUT.correo ?? ''),
                        ),
                        ListTile(
                          title: const Text('UNIDAD TERRITORIAL'),
                          subtitle: Text(oUT.nombreUt ?? ''),
                        ),
                        ListTile(
                          title: const Text('UT DIRECCIÓN'),
                          subtitle: Text(oUT.unidadTerritorialDireccion ?? ''),
                        ),
                        ListTile(
                          title: const Text('UT DEPARTAMENTO'),
                          subtitle: Text(oUT.departamentoUt ?? ''),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Padding cardDatosUbicacion() {
    var heading = 'DATOS DE UBICACIÓN';
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: colorI,
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 5), // changes position of shadow
            ),
          ],
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          children: [
            ExpansionTile(
              initiallyExpanded: true,
              tilePadding: const EdgeInsets.only(left: 0, right: 10),
              title: ListTile(
                visualDensity: const VisualDensity(vertical: -4),
                leading: const ImageIcon(
                  AssetImage("assets/iconos_card/ubicacion.png"),
                  size: 40,
                  color: Colors.black,
                ),
                title: Text(
                  heading,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
              ),
              children: <Widget>[
                const Divider(color: colorI),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: const Text('DEPARTAMENTO'),
                          subtitle: Text(oTambo.nombreDepartamento ?? ''),
                        ),
                        ListTile(
                          title: const Text('PROVINCIA'),
                          subtitle: Text(oTambo.nombreProvincia ?? ''),
                        ),
                        ListTile(
                          title: const Text('DISTRITO'),
                          subtitle: Text(oTambo.nombreDistrito ?? ''),
                        ),
                        ListTile(
                          title: const Text('CENTRO POBLADO'),
                          subtitle: Text(oTambo.nombreCcpp ?? ''),
                        ),
                        ListTile(
                          title: const Text('COORDENADAS'),
                          subtitle: Text(
                              '${oTambo.xCcpp ?? ''} , ${oTambo.yCcpp ?? ''}'),
                        ),
                        ListTile(
                          title: const Text('ALTITUD'),
                          subtitle: Text("${oTambo.altitudCcpp ?? ''} msnm"),
                        ),
                        const SizedBox(height: 10),
                        const Text('FUENTE: INEI'),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Padding cardDatosDemograficos() {
    var heading = 'AMBITOS DE INFLUENCIA';
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: colorI,
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 5), // changes position of shadow
            ),
          ],
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          children: [
            ExpansionTile(
              tilePadding: const EdgeInsets.only(left: 0, right: 10),
              initiallyExpanded: true,
              title: ListTile(
                visualDensity: const VisualDensity(vertical: -4),
                leading: const ImageIcon(
                  AssetImage("assets/iconos_card/demografico.png"),
                  size: 40,
                  color: Colors.black,
                ),
                title: Text(
                  heading,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
              ),
              children: <Widget>[
                const Divider(color: colorI),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: const Text('N° DE HOGARES'),
                          subtitle: Text(formatoDecimal(double.tryParse(
                                  oTambo.hogaresAnteriores ?? '0') ??
                              0)),
                        ),
                        ListTile(
                          title: const Text('N° DE VIVIENDAS'),
                          subtitle: Text(formatoDecimal(double.tryParse(
                                  oTambo.viviendasAnterior ?? '0') ??
                              0)),
                        ),
                        ListTile(
                          title: const Text('POBLACIÓN'),
                          subtitle: Text(formatoDecimal(double.tryParse(
                                  oTambo.poblacionAnterior ?? '0') ??
                              0)),
                        ),
                        const SizedBox(height: 10),
                        const Text('FUENTE: INEI'),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Padding cardDatosObra() {
    var heading = 'DATOS DE LA OBRA';
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: colorI,
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 5), // changes position of shadow
            ),
          ],
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          children: [
            ExpansionTile(
              tilePadding: const EdgeInsets.only(left: 0, right: 10),
              initiallyExpanded: true,
              title: ListTile(
                visualDensity: const VisualDensity(vertical: -4),
                leading: const ImageIcon(
                  AssetImage("assets/iconos_card/datos_obra.png"),
                  size: 40,
                  color: Colors.black,
                ),
                title: Text(
                  heading,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
              ),
              children: <Widget>[
                const Divider(color: colorI),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: const Text('N° SNIP'),
                          subtitle: Text(oTambo.nSnip == null
                              ? ''
                              : oTambo.nSnip.toString()),
                        ),
                        if (oTambo.montoAdjudicado != "")
                          ListTile(
                            title: const Text('MONTO CONTRATADO'),
                            subtitle: Text(
                                "${formatoDecimal(double.parse(oTambo.montoAdjudicado ?? '0'))}"),
                          ),
                        const SizedBox(height: 10),
                        const Text('FUENTE: BANCO DE INVERSIONES - MEF'),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Padding cardAmbitoAccion() {
    var heading = 'AMBITOS DE ACCIÓN';
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: colorI,
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 5), // changes position of shadow
            ),
          ],
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          children: [
            ExpansionTile(
              tilePadding: const EdgeInsets.only(left: 0, right: 10),
              initiallyExpanded: true,
              title: ListTile(
                visualDensity: const VisualDensity(vertical: -4),
                leading: const ImageIcon(
                  AssetImage("assets/iconos_card/ambitos_accion.png"),
                  size: 40,
                  color: Colors.black,
                ),
                title: Text(
                  '$heading ( ${oTambo.aCentroPoblado!.length} )',
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
              ),
              children: <Widget>[
                const Divider(color: colorI),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        for (var oCentro in oTambo.aCentroPoblado!)
                          ListTile(
                            iconColor: const Color.fromARGB(255, 0, 0, 0),
                            title: Text(oCentro.nombreCcpp!),
                            subtitle: Text(
                                'DISTRITO: ${oCentro.distrito} \n( ALTITUD: ${oCentro.altitudCcpp} - REGION: ${oCentro.regionCatural} )\nDISTANCIA AL TAMBO: ${oCentro.distanciaKm} km'),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Padding cardServicioBasico() {
    var heading = 'SERVICIOS BÁSICOS';
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: colorI,
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 5), // changes position of shadow
            ),
          ],
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          children: [
            ExpansionTile(
              initiallyExpanded: true,
              tilePadding: const EdgeInsets.only(left: 0, right: 10),
              title: ListTile(
                visualDensity: const VisualDensity(vertical: -1),
                leading: const ImageIcon(
                  AssetImage("assets/iconos_card/servicios_basicos.png"),
                  size: 55,
                  color: Colors.black,
                ),
                title: Text(
                  heading,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
              ),
              children: <Widget>[
                const Divider(color: colorI),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        for (var oSrvBasico in aSrvBasico)
                          ListTile(
                            title: Text(oSrvBasico.nombreServicio ?? ''),
                            subtitle: Text(oSrvBasico.tipoServicio ?? ''),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

/*
 * -----------------------------------------------
 *            META
 * -----------------------------------------------
 */

  Padding cardAtenciones() {
    int totalAvance1 = 0;
    if (aAtenInterBene.isNotEmpty) {
      totalAvance1 =
          aAtenInterBene.fold(0, (sum, item) => sum + item.atenciones!);
    }

    final totalMetaTipo1 =
        aMetasTipo1.fold<int>(0, (sum, item) => sum + (item.metaTotal ?? 0));

    int totalBrecha1 = totalMetaTipo1 - totalAvance1;
    double totalPorcen1 = double.parse(((totalAvance1 / totalMetaTipo1) * 100)
        .toStringAsFixed(2)
        .replaceFirst(RegExp(r'\.?0*$'), ''));

    var heading = 'ATENCIONES $sCurrentYear';
    late ValueNotifier<double> valueNotifier =
        ValueNotifier(totalPorcen1.isNaN ? 0 : totalPorcen1);

    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Container(
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage("assets/icons/botones 1-02.png"),
            fit: BoxFit.cover,
          ),
          border: Border.all(
            width: 1,
            color: colorI,
          ),
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 5), // changes position of shadow
            ),
          ],
        ),
        child: ExpansionTile(
          initiallyExpanded: true,
          tilePadding: const EdgeInsets.only(left: 0, right: 10),
          title: ListTile(
            visualDensity: const VisualDensity(vertical: -4),
            leading: const ImageIcon(
              AssetImage("assets/iconos_card/atenciones.png"),
              size: 40,
              color: Colors.black,
            ),
            title: Text(
              heading,
              style: const TextStyle(
                fontSize: 16,
                color: color_01,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          children: <Widget>[
            const Divider(color: colorI),
            const SizedBox(height: 10),
            Text(
                'ACTUALIZADO HASTA ${(aMetasMensualizada.isNotEmpty ? (obtenerNombreMesCompleto(aMetasMensualizada[aMetasMensualizada.length - 1].mes!)) : '')} DEL ${sCurrentYear}'),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  isLoading2
                      ? Center(
                          child: SimpleCircularProgressBar(
                            size: 150,
                            maxValue: 100,
                            valueNotifier: valueNotifier,
                            backColor: Colors.black.withOpacity(0.4),
                            progressStrokeWidth: 10,
                            backStrokeWidth: 10,
                            mergeMode: true,
                            onGetText: (double value) {
                              return Text(
                                '${totalPorcen1.isNaN ? 0 : totalPorcen1}%',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 35,
                                ),
                              );
                            },
                          ),
                        )
                      : const CircularProgressIndicator(),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                    width: double.maxFinite,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Table(
                          children: [
                            TableRow(children: [
                              const Text(
                                "META FÍSICA : ",
                                style: TextStyle(fontSize: 15.0),
                                textAlign: TextAlign.right,
                              ),
                              Text(
                                ' ${formatoDecimal(totalMetaTipo1.toDouble() ?? 0)}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ]),
                            TableRow(children: [
                              const Text(
                                "EJECUCIÓN FÍSICA : ",
                                style: TextStyle(fontSize: 15.0),
                                textAlign: TextAlign.right,
                              ),
                              Text(
                                ' ${formatoDecimal(totalAvance1.toDouble() ?? 0)}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ]),
                            /*TableRow(
                              children: [
                                const Text(
                                  "Brecha :",
                                  style: TextStyle(fontSize: 15.0),
                                  textAlign: TextAlign.right,
                                ),
                                Text(
                                  '${formatoDecimal(totalBrecha1.toDouble())}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),*/
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text('FUENTE: PNPAIS'),
                        const SizedBox(
                          height: 1,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding cardBeneficiarios() {
    int totalAvance1 = 0;
    if (aAtenInterBene.isNotEmpty) {
      totalAvance1 =
          aAtenInterBene.fold(0, (sum, item) => sum + item.beneficiarios!);
    }
    final totalMetaTipo1 =
        aMetasTipo2.fold<int>(0, (sum, item) => sum + (item.metaTotal ?? 0));

    int totalBrecha1 = totalMetaTipo1 - totalAvance1;
    double totalPorcen1 = double.parse(((totalAvance1 / totalMetaTipo1) * 100)
        .toStringAsFixed(2)
        .replaceFirst(RegExp(r'\.?0*$'), ''));

    var heading = 'USUARIOS $sCurrentYear';
    late ValueNotifier<double> valueNotifier =
        ValueNotifier(totalPorcen1.isNaN ? 0 : totalPorcen1);

    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Container(
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage("assets/icons/botones 1-02.png"),
            fit: BoxFit.cover,
          ),
          border: Border.all(
            width: 1,
            color: colorI,
          ),
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 5), // changes position of shadow
            ),
          ],
        ),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.only(left: 0, right: 10),
          initiallyExpanded: true,
          title: ListTile(
            visualDensity: const VisualDensity(vertical: -1),
            leading: const ImageIcon(
              AssetImage("assets/iconos_card/beneficiarios.png"),
              size: 55,
              color: Colors.black,
            ),
            title: Text(
              heading,
              style: const TextStyle(
                fontSize: 16,
                color: color_01,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          children: <Widget>[
            const Divider(color: colorI),
            const SizedBox(height: 10),
            Text(
                'ACTUALIZADO HASTA ${(aMetasMensualizada.isNotEmpty ? (obtenerNombreMesCompleto(aMetasMensualizada[aMetasMensualizada.length - 1].mes!)) : '')} DEL ${sCurrentYear}'),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  isLoading2
                      ? Center(
                          child: SimpleCircularProgressBar(
                            size: 150,
                            maxValue: 100,
                            valueNotifier: valueNotifier,
                            backColor: Colors.black.withOpacity(0.4),
                            progressStrokeWidth: 10,
                            backStrokeWidth: 10,
                            mergeMode: true,
                            onGetText: (double value) {
                              return Text(
                                '${totalPorcen1.isNaN ? 0 : totalPorcen1}%',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 35,
                                ),
                              );
                            },
                          ),
                        )
                      : const CircularProgressIndicator(),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                    width: double.maxFinite,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Table(
                          children: [
                            TableRow(children: [
                              const Text(
                                "META FÍSICA : ",
                                style: TextStyle(fontSize: 15.0),
                                textAlign: TextAlign.right,
                              ),
                              Text(
                                ' ${formatoDecimal(totalMetaTipo1.toDouble() ?? 0)}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ]),
                            TableRow(children: [
                              const Text(
                                "EJECUCIÓN FÍSICA : ",
                                style: TextStyle(fontSize: 15.0),
                                textAlign: TextAlign.right,
                              ),
                              Text(
                                ' ${formatoDecimal(totalAvance1.toDouble() ?? 0)}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ]),
                            /*TableRow(
                              children: [
                                const Text(
                                  "Brecha :",
                                  style: TextStyle(fontSize: 15.0),
                                  textAlign: TextAlign.right,
                                ),
                                Text(
                                  '${formatoDecimal(totalBrecha1.toDouble())}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),*/
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text('FUENTE: PNPAIS'),
                        const SizedBox(
                          height: 1,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

/*
 * -----------------------------------------------
 *  PLAN DE MANTENIMIENTO DEL PARQUE INFORMÁTICO
 * -----------------------------------------------
 */
  Padding cardDatosMantenimientoInformatico() {
    var heading = 'MANTENIMIENTO DE EQUIPOS INFORMÁTICOS';

    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: colorI,
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 5), // changes position of shadow
            ),
          ],
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          children: [
            ExpansionTile(
              tilePadding: const EdgeInsets.only(left: 0, right: 10),
              initiallyExpanded: true,
              title: ListTile(
                visualDensity: const VisualDensity(vertical: -4),
                leading: const ImageIcon(
                  AssetImage("assets/iconos_card/mantenimiento_equipos.png"),
                  size: 35,
                  color: Colors.black,
                ),
                title: Text(
                  heading,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
              ),
              children: <Widget>[
                const Divider(color: colorI),
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: isLoadingMantenimientoEquipos
                        ? 1
                        : (aPlanMantenimientoInformatico.isEmpty
                            ? 1
                            : aPlanMantenimientoInformatico.length),
                    itemBuilder: (context, index) {
                      if (isLoadingMantenimientoEquipos) {
                        return ShinyWidget();
                      } else {
                        return Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Column(children: [
                              ListTile(
                                  title: Text.rich(TextSpan(
                                      text:
                                          'MANTENIMIENTO PROGRAMADO PARA EL MES DE ',
                                      children: [
                                    TextSpan(
                                        text:
                                            "${obtenerNombreMes(aPlanMantenimientoInformatico[index].mes ?? '')}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(text: " DEL AÑO "),
                                    TextSpan(
                                        text:
                                            "${aPlanMantenimientoInformatico[index].anio}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(text: ".")
                                  ]))),
                              const ListTile(
                                title: Text('SOPORTE DE UTI ASIGNADO : '),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: const Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: SizedBox(
                                  height: 150.0,
                                  child: CachedNetworkImage(
                                    width: 110,
                                    imageUrl:
                                        aPlanMantenimientoInformatico[index]
                                                .rutaFoto ??
                                            '',
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    placeholder: (context, url) =>
                                        ShinyWidgetImage(),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),

                                  /*ImageUtil.ImageUrl(
                                    aPlanMantenimientoInformatico[index]
                                            .rutaFoto ??
                                        '',
                                    width: 110,
                                    imgDefault: 'assets/icons/user-male-2.png',
                                  ),*/
                                ),
                              ),
                              Container(
                                // padding: EdgeInsets.all(5.0),
                                alignment: Alignment.centerLeft,
                                child: Card(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ListTile(
                                        title:
                                            const Text('NOMBRES Y APELLIDOS'),
                                        subtitle: Text(
                                            '${aPlanMantenimientoInformatico[index].nombresTecnico} ${aPlanMantenimientoInformatico[index].apellidoPaternoTecnico} ${aPlanMantenimientoInformatico[index].apellidoMaternoTecnico}'),
                                      ),
                                      ListTile(
                                        title: const Text('CORREO'),
                                        subtitle: Text(
                                            aPlanMantenimientoInformatico[index]
                                                    .correoTecnico ??
                                                ''),
                                      ),
                                      ListTile(
                                        title: const Text('CELULAR'),
                                        subtitle: Text(
                                            aPlanMantenimientoInformatico[index]
                                                    .celularTecnico ??
                                                ''),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ]));
                      }
                    })
              ],
            ),
          ],
        ),
      ),
    );
  }

/*
 * -----------------------------------------------
 *  PLAN DE MANTENIMIENTO DEL INFRAESTRUCTURA
 * -----------------------------------------------
 */
  Padding cardDatosMantenimientoInfraestructura() {
    var heading = 'MANTENIMIENTO DE INFRAESTRUCTURA';

    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: colorI,
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 5), // changes position of shadow
            ),
          ],
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          children: [
            ExpansionTile(
              tilePadding: const EdgeInsets.only(left: 0, right: 10),
              initiallyExpanded: true,
              title: ListTile(
                visualDensity: const VisualDensity(vertical: -4),
                leading: const ImageIcon(
                  AssetImage(
                      "assets/iconos_card/mantenimiento_infraestructura.png"),
                  size: 40,
                  color: Colors.black,
                ),
                title: Text(
                  heading,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
              ),
              children: <Widget>[
                const Divider(color: colorI),
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: isLoadingMantenimientoInfraestructura
                        ? 1
                        : (aPlanMantenimientoInfraestructura.isEmpty
                            ? 1
                            : aPlanMantenimientoInfraestructura.length),
                    itemBuilder: (context, index) {
                      if (isLoadingMantenimientoInfraestructura) {
                        return ShinyWidget();
                      } else {
                        if (aPlanMantenimientoInfraestructura.isNotEmpty) {
                          return Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: Column(children: [
                                Container(
                                  // padding: EdgeInsets.all(5.0),
                                  alignment: Alignment.centerLeft,
                                  child: Card(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ListTile(
                                          title: const Text('SITUACIÓN:'),
                                          subtitle: Text(
                                              '${aPlanMantenimientoInfraestructura[index].situacion!.toUpperCase()}'),
                                        ),
                                        if ((double.tryParse(
                                                    aPlanMantenimientoInfraestructura[
                                                                index]
                                                            .montoMantenimientoInfraestructura ??
                                                        '0') ??
                                                0) !=
                                            0)
                                          ListTile(
                                            title: const Text(
                                                'MANTENIMIENTO DE INFRAESTRUCTURA'),
                                            subtitle: Text(
                                                "S/.  ${formatoDecimal(double.parse(aPlanMantenimientoInfraestructura[index].montoMantenimientoInfraestructura ?? '0').roundToDouble())}"),
                                          ),
                                        if ((double.tryParse(
                                                    aPlanMantenimientoInfraestructura[
                                                                index]
                                                            .pozoTierra ??
                                                        '0') ??
                                                0) !=
                                            0)
                                          ListTile(
                                            title: const Text('POZO A TIERRA'),
                                            subtitle: Text(
                                                "S/. ${formatoDecimal(double.tryParse(aPlanMantenimientoInfraestructura[index].pozoTierra ?? '0') ?? 0.roundToDouble())}"),
                                          ),
                                        /*ListTile(
                                          title:
                                              const Text('CAMBIO DE BATERIAS'),
                                          subtitle: Text(
                                              aPlanMantenimientoInfraestructura[
                                                          index]
                                                      .cambioBaterias ??
                                                  '0'),
                                        ),*/
                                        ListTile(
                                          title: const Text(
                                              'MANTENIMIENTO PROGRAMADO PARA'),
                                          subtitle: Text(aPlanMantenimientoMeses
                                                  .isNotEmpty
                                              ? '${aPlanMantenimientoMeses[0].marzo!.isNotEmpty ? 'MARZO' : ''} ${aPlanMantenimientoMeses[0].abril!.isNotEmpty ? 'ABRIL' : ''} ${aPlanMantenimientoMeses[0].mayo!.isNotEmpty ? 'MAYO' : ''}  ${aPlanMantenimientoMeses[0].junio!.isNotEmpty ? 'JUNIO' : ''} ${aPlanMantenimientoMeses[0].julio!.isNotEmpty ? 'JULIO' : ''} ${aPlanMantenimientoMeses[0].agosto!.isNotEmpty ? 'AGOSTO' : ''} ${aPlanMantenimientoMeses[0].setiembre!.isNotEmpty ? 'SETIEMBRE' : ''} ${aPlanMantenimientoMeses[0].octubre!.isNotEmpty ? 'OCTUBRE' : ''} '
                                              : ''),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ]));
                        } else {
                          return Center(
                              child: Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 20, 20, 20),
                                  child: const Text(
                                    'TAMBO NO CONSIDERADO DENTRO DEL PLAN DE MANTENIMIENTO',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  )));
                        }
                      }
                    })
              ],
            ),
          ],
        ),
      ),
    );
  }

  Padding cardIntervenciones() {
    var heading = 'INTERVENCIONES 2023';

    late ValueNotifier<double> valueNotifier = ValueNotifier(20);

    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: colorI,
          ),
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 5), // changes position of shadow
            ),
          ],
        ),
        child: ExpansionTile(
          initiallyExpanded: true,
          title: ListTile(
            visualDensity: const VisualDensity(vertical: -4),
            title: Text(
              heading,
              style: const TextStyle(
                fontSize: 16,
                color: color_01,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          children: <Widget>[
            const Divider(color: colorI),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: SimpleCircularProgressBar(
                      size: 150,
                      maxValue: 100,
                      valueNotifier: valueNotifier,
                      backColor: Colors.black.withOpacity(0.4),
                      progressStrokeWidth: 20,
                      backStrokeWidth: 20,
                      mergeMode: true,
                      progressColors: const [
                        Colors.yellow,
                        Colors.yellowAccent
                      ],
                      onGetText: (double value) {
                        return Text(
                          '${value.toInt()}%',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 35),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.2),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Table(
                          children: const [
                            TableRow(children: [
                              Text(
                                "Meta :",
                                style: TextStyle(fontSize: 15.0),
                              ),
                              Text(
                                "12,000",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                            ]),
                            TableRow(children: [
                              Text(
                                "Avance :",
                                style: TextStyle(fontSize: 15.0),
                              ),
                              Text(
                                "1,560",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                            ]),
                            /*TableRow(children: [
                              Text(
                                "Brecha :",
                                style: TextStyle(fontSize: 15.0),
                              ),
                              Text(
                                "10,440",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                            ]),*/
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

/*
 * -----------------------------------------------
 *            SERVICIOS INTERNET
 * -----------------------------------------------
 */
  Padding cardDatosSrvInternet() {
    var heading = 'SERVICIOS INTERNET';
    TamboServicioInternetDto oSrvInter =
        oTambo.oServicioInternet ?? TamboServicioInternetDto.empty();
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: colorI,
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 5), // changes position of shadow
            ),
          ],
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          children: [
            ExpansionTile(
              tilePadding: const EdgeInsets.only(left: 0, right: 10),
              initiallyExpanded: true,
              title: ListTile(
                visualDensity: const VisualDensity(vertical: -4),
                title: Text(
                  heading,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
                leading: const ImageIcon(
                  AssetImage("assets/wifi.png"),
                  size: 40,
                  color: Colors.black,
                ),
              ),
              children: <Widget>[
                const Divider(color: colorI),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        /*ListTile(
                    title: const Text('CENTRO POBLADO'),
                    subtitle: Text(oSrvInter.nombreCcpp!),
                  ),*/
                        ListTile(
                          title: const Text('INTERNET'),
                          subtitle: Text(oSrvInter.internet!),
                        ),
                        ListTile(
                          title: const Text('FECHA INSTALACIÓN'),
                          subtitle: Text(oSrvInter.fecInstalacion!),
                        ),
                        ListTile(
                          title: const Text('ESTADO INTERNET'),
                          subtitle: (oSrvInter.estadoInternet! == 'OPERATIVO')
                              ? Text(oSrvInter.estadoInternet!,
                                  style: const TextStyle(color: Colors.green))
                              : Text(
                                  "${oSrvInter.estadoInternet!}\n${(incidencias.isNotEmpty) ? "(${incidencias![0].fechaAveria})" : ''}",
                                  style: const TextStyle(color: Colors.red),
                                ),
                        ),
                        ListTile(
                          title: const Text('VELOCIDAD BAJADA'),
                          subtitle: Text(oSrvInter.veloBaja!),
                        ),
                        ListTile(
                          title: const Text('VELOCIDAD SUBIDA'),
                          subtitle: Text(oSrvInter.veloSube!),
                        ),
                      ],
                    ),
                  ),
                ),

                const Divider(color: colorI),
                //DOWNLOAD Mbps
                const ListTile(
                  title: Text(
                    'VELOCIDAD DE BAJADA Mbps',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text("1000 Kbps = 1 Mbps"),
                ),
                Container(
                  width: 200,
                  height: 200,
                  padding: const EdgeInsets.all(10),
                  child: KdGaugeView(
                    fractionDigits: 2,
                    minSpeed: 0.0,
                    maxSpeed: 10.0,
                    minMaxTextStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                    ),
                    speed: kbpsTOmbps(getNumber(oSrvInter.veloBaja ?? '0')),
                    speedTextStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                    animate: true,
                    alertSpeedArray: const [0, 5, 10],
                    alertColorArray: const [colorP, colorI, colorS],
                    duration: const Duration(seconds: 6),
                    unitOfMeasurement:
                        "Mbps", //getText(oSrvInter.veloBaja ?? "Mbps"),
                    unitOfMeasurementTextStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                    gaugeWidth: 15,
                    innerCirclePadding: 15,
                  ),
                ),

                //VELOCIDAD DE BAJADA ASEGURADA
                const ListTile(
                  title: Text(
                    'PORCENTAJE  ASEGURADO',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  width: 200,
                  height: 200,
                  padding: const EdgeInsets.all(10),
                  child: KdGaugeView(
                    fractionDigits: 2,
                    minSpeed: 0.0,
                    maxSpeed: 100.0,
                    minMaxTextStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                    ),
                    speed: (getNumber(oSrvInter.veloMinBajaPtje ?? '0') / 100),
                    speedTextStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                    animate: true,
                    alertSpeedArray: const [0, 5, 10],
                    alertColorArray: const [colorP, colorI, colorS],
                    duration: const Duration(seconds: 6),
                    unitOfMeasurement:
                        "%", //getText(oSrvInter.veloBaja ?? "Mbps"),
                    unitOfMeasurementTextStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                    gaugeWidth: 15,
                    innerCirclePadding: 15,
                  ),
                ),
                Divider(
                  height: 4,
                ),
                const ListTile(
                  title: Text(
                    'VELOCIDAD DE SUBIDA Mbps',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text("1000 Kbps = 1 Mbps"),
                ),
                Container(
                  width: 200,
                  height: 200,
                  padding: const EdgeInsets.all(10),
                  child: KdGaugeView(
                    fractionDigits: 2,
                    minSpeed: 0,
                    maxSpeed: 10,
                    minMaxTextStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                    ),
                    speed: kbpsTOmbps(getNumber(oSrvInter.veloSube ?? '0')),
                    speedTextStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                    animate: true,
                    alertSpeedArray: const [0, 60, 90],
                    alertColorArray: const [colorP, colorI, colorS],
                    duration: const Duration(seconds: 6),
                    unitOfMeasurement:
                        "Mbps", //getText(oSrvInter.veloSube ?? "Mbps"),
                    unitOfMeasurementTextStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                    gaugeWidth: 15,
                    innerCirclePadding: 15,
                  ),
                ),

                //VELOCIDAD DE SUBIDA ASEGURADA
                const ListTile(
                  title: Text(
                    'PORCENTAJE  ASEGURADO',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  width: 200,
                  height: 200,
                  padding: const EdgeInsets.all(10),
                  child: KdGaugeView(
                    fractionDigits: 2,
                    minSpeed: 0.0,
                    maxSpeed: 100.0,
                    minMaxTextStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                    ),
                    speed: (getNumber(oSrvInter.veloMinSubePtje ?? '0') / 100),
                    speedTextStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                    animate: true,
                    alertSpeedArray: const [0, 5, 10],
                    alertColorArray: const [colorP, colorI, colorS],
                    duration: const Duration(seconds: 6),
                    unitOfMeasurement:
                        "%", //getText(oSrvInter.veloBaja ?? "Mbps"),
                    unitOfMeasurementTextStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                    gaugeWidth: 15,
                    innerCirclePadding: 15,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  double kbpsTOmbps(double kbps) {
    //1000 Kbps = 1 Mbps
    double mbps = 1000;
    return kbps / mbps;
  }

  double getNumber(String value) {
    try {
      return double.parse(value.replaceAll(new RegExp(r'[^0-9]'), ''));
    } catch (oError) {
      return 0;
    }
  }

  String getText(String value) {
    try {
      return value.replaceAll(new RegExp(r'[^A-Za-z]'), '');
    } catch (oError) {
      return '';
    }
  }

  Padding cardIncidencia() {
    var heading = 'INCIDENCIAS REPORTADAS';
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: colorI,
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 5), // changes position of shadow
            ),
          ],
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          children: [
            ExpansionTile(
              tilePadding: const EdgeInsets.only(left: 0, right: 10),
              initiallyExpanded: true,
              title: ListTile(
                visualDensity: const VisualDensity(vertical: -4),
                leading: const ImageIcon(
                  AssetImage("assets/iconos_card/incidencias.png"),
                  size: 40,
                  color: Colors.black,
                ),
                title: Text(
                  heading,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
              ),
              children: <Widget>[
                const Divider(color: colorI),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: isLoading
                        ? 4
                        : (incidencias.isEmpty ? 1 : incidencias.length),
                    itemBuilder: (context, index) {
                      if (isLoading) {
                        return ShinyWidget();
                      } else {
                        if (incidencias.isEmpty) {
                          return Center(
                              child: Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 20, 20, 20),
                                  child: const Text(
                                    'NO EXISTE INCIDENCIAS',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  )));
                        }

                        return Column(
                          children: [
                            ListTile(
                              title: ListTile(
                                title: Text(
                                  "N° TICKET : ${incidencias[index].ticket ?? ''}",
                                  textAlign: TextAlign.justify,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  "FECHA DE AVERÍA: ${incidencias[index].fechaAveria ?? ''}\nDÍAS SIN INTERNET: ${incidencias[index].diasPasados ?? ''}\nFECHA DE CIERRE: ${incidencias[index].fechaCierre ?? ''}\nESTADO: ${incidencias[index].nomEstado ?? ''}",
                                  textAlign: TextAlign.justify,
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            const Divider(color: colorI),
                          ],
                        );
                      }
                    })
              ],
            ),
          ],
        ),
      ),
    );
  }

/*
 * -----------------------------------------------
 *            INTERVENCIONES
 * -----------------------------------------------
 */
  Padding cardDatosIntervencionCod1() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          children: [
            if (aInterAmbDir.isEmpty && statusLoadActividad == 0)
              ListTile(
                title: const Text("CARGANDO..."),
                subtitle: Text(
                  "Esperando los registros. Esto puede tomar tiempo",
                  style: TextStyle(
                      color: const Color.fromARGB(255, 53, 8, 200)
                          .withOpacity(0.6)),
                ),
              ),
            if (aInterAmbDir.isEmpty && statusLoadActividad == 1)
              ListTile(
                title: const Text("SIN DATOS"),
                subtitle: Text(
                  "No se encontraron registros para mostrar.",
                  style: TextStyle(
                      color: const Color.fromARGB(255, 53, 8, 200)
                          .withOpacity(0.6)),
                ),
              ),
            if (aInterAmbDir.isEmpty && statusLoadActividad == 2)
              ListTile(
                title: const Text("¡Ups! Algo salió mal"),
                subtitle: Text(
                  "No se pudo recuperar los registros para mostrar.",
                  style: TextStyle(
                      color: const Color.fromARGB(255, 211, 13, 13)
                          .withOpacity(0.6)),
                ),
              ),
            for (var oActividad in aInterAmbDir)
              cardActividadestambo(
                oActividad,
                () async {},
              ),
          ],
        ),
      ),
    );
  }

  Card cardActividadestambo(
    TamboActividadModel oActividad,
    callback,
  ) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.all(20),
      elevation: 7,
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 10,
          ),
          ListTile(
            contentPadding: const EdgeInsets.fromLTRB(25, 5, 25, 15),
            title: Row(
              children: [
                SizedBox(
                  width: 70.0,
                  height: 70.0,
                  child: CircleAvatar(
                    backgroundColor: Colors.white.withOpacity(0.1),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        'assets/icons/icons8-male-user-100.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  '${oActividad.nombreTambo} \n${oActividad.fecha}',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Divider(
                  color: color_10o15,
                  height: 5,
                  thickness: 3,
                  indent: 0,
                  endIndent: 0,
                ),
              ],
            ),
            subtitle: Column(
              children: [
                const SizedBox(height: 10),
                Text(
                  textAlign: TextAlign.justify,
                  '${oActividad.descripcion}',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 10),
                /*
                FancyShimmerImage(
                  imageUrl: oActividad.actividadPathImage!,
                  errorWidget: Image.network(
                      'https://i0.wp.com/www.dobitaobyte.com.br/wp-content/uploads/2016/02/no_image.png?ssl=1'),
                  width: 200,
                  height: 200,
                  shimmerBaseColor: Color.fromARGB(255, 226, 226, 226),
                  shimmerHighlightColor: Colors.white,
                  shimmerBackColor: Colors.white,
                ),
                */
                GestureDetector(
                  onTap: () async {
                    BusyIndicator.show(context);
                    try {
                      if (oActividad.actividadPathImage == '') {
                        return;
                      }
                      if (oActividad.base64Temp == '') {
                        String sB64 = await ImageUtil().networkImageToBase64(
                            oActividad.actividadPathImage!);
                        oActividad.base64Temp = sB64;
                      }
                      //File aFile = await ImageUtil().imgBase64Decode(sB64);
                      /*
                      final directory =
                          await getApplicationDocumentsDirectory();
                      Uint8List bytes = base64.decode(sB64);
                      var fileImg =
                          File('${directory.path}/temporalImageGenerate.png');
                      fileImg.writeAsBytesSync(bytes);
                      */
                      BusyIndicator.hide(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ImagePreview(
                            imagen: oActividad.base64Temp,
                          ),
                        ),
                      );
                    } catch (oError) {
                      BusyIndicator.hide(context);
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Icon(
                      Icons.photo_size_select_large,
                      color: Colors.black,
                    ),
                  ),
                ),

                /*ImageUtil.ImageAssetNetwork(
                  oActividad.actividadPathImage!,
                  width: 200,
                  height: 200,
                  imgDefault: 'assets/iconusuario.png',
                ),*/
                const SizedBox(height: 8),
                /*InkWell(
                  onTap: callback,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: const Icon(
                          Icons.download,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                )*/
              ],
            ),
          )
        ],
      ),
    );
  }

  Padding cardDatosIntervencionCod2() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          children: [
            if (aInterSopEnt.isEmpty && statusLoadActividad == 0)
              ListTile(
                title: const Text("CARGANDO..."),
                subtitle: Text(
                  "Esperando los registros. Esto puede tomar tiempo",
                  style: TextStyle(
                      color: const Color.fromARGB(255, 53, 8, 200)
                          .withOpacity(0.6)),
                ),
              ),
            if (aInterSopEnt.isEmpty && statusLoadActividad == 1)
              ListTile(
                title: const Text("SIN DATOS"),
                subtitle: Text(
                  "No se encontraron registros para mostrar.",
                  style: TextStyle(
                      color: const Color.fromARGB(255, 53, 8, 200)
                          .withOpacity(0.6)),
                ),
              ),
            if (aInterSopEnt.isEmpty && statusLoadActividad == 2)
              ListTile(
                title: const Text("¡Ups! Algo salió mal"),
                subtitle: Text(
                  "No se pudo recuperar los registros para mostrar.",
                  style: TextStyle(
                      color: const Color.fromARGB(255, 211, 13, 13)
                          .withOpacity(0.6)),
                ),
              ),
            for (var oActividad in aInterSopEnt)
              cardActividadestambo(
                oActividad,
                () async {},
              ),
          ],
        ),
      ),
    );
  }

  Padding cardDatosIntervencionCod4() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          children: [
            if (aCoordinacio.isEmpty && statusLoadActividad == 0)
              ListTile(
                title: const Text("CARGANDO..."),
                subtitle: Text(
                  "Esperando los registros. Esto puede tomar tiempo",
                  style: TextStyle(
                      color: const Color.fromARGB(255, 53, 8, 200)
                          .withOpacity(0.6)),
                ),
              ),
            if (aCoordinacio.isEmpty && statusLoadActividad == 1)
              ListTile(
                title: const Text("SIN DATOS"),
                subtitle: Text(
                  "No se encontraron registros para mostrar.",
                  style: TextStyle(
                      color: const Color.fromARGB(255, 53, 8, 200)
                          .withOpacity(0.6)),
                ),
              ),
            if (aCoordinacio.isEmpty && statusLoadActividad == 2)
              ListTile(
                title: const Text("¡Ups! Algo salió mal"),
                subtitle: Text(
                  "No se pudo recuperar los registros para mostrar.",
                  style: TextStyle(
                      color: const Color.fromARGB(255, 211, 13, 13)
                          .withOpacity(0.6)),
                ),
              ),
            for (var oActividad in aCoordinacio)
              cardActividadestambo(
                oActividad,
                () async {},
              ),
          ],
        ),
      ),
    );
  }

/*
 * -----------------------------------------------
 *            EQUIPAMIENTO TECNOLÓGICO
 * -----------------------------------------------
 */
  Column cardEquipoTecnologico() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        isLoadingEI ? equipoInformatico() : const CircularProgressIndicator(),
      ],
    );
  }

  Widget buildSuccessDialog2(
    BuildContext context, {
    String? title,
    String? subTitle,
    Widget? child,
  }) {
    return AlertDialog(
      title: Text(title!),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      actions: const <Widget>[],
      content: SingleChildScrollView(
        child: Container(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Divider(),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.4,
                ),
                child: child,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSuccessDialog(
    BuildContext context, {
    String? title,
    String? subTitle,
    Widget? child,
  }) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          5.00,
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Text(
                              title ?? '',
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                color: color_01,
                                fontSize: 15,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const Divider(),
                          SizedBox(
                            child: child,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      actions: const <Widget>[
        /*
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  colorS,
                ),
              ),
              child: const Text("Aceptar"),
            ),
          ],
        ),

        */
      ],
    );
  }

  Widget dialogBox() {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    5.00,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Text(
                        "EQUIPAMIENTO TECNOLÓGICO",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: color_01,
                          fontSize: 15,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      "IMPRESORAS",
                      maxLines: null,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: color_01,
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        height: 1.43,
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Text(
                        "OPERATIVO: 5",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: color_01,
                          fontSize: 13,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Text(
                        "INOPERATIVO: 5",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: color_01,
                          fontSize: 13,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 14,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

/*
 * -----------------------------------------------
 *            COMBUSTIBLE
 * -----------------------------------------------
 */
  Padding cardCombustible() {
    var heading = 'COMBUSTIBLE ASIGNADO';
    double totalPorcen1 = double.parse(
        ((oCombustible.consumoGal! / oCombustible.stockCsmble!) * 100)
            .toStringAsFixed(2)
            .replaceFirst(RegExp(r'\.?0*$'), ''));

    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: colorI,
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 5), // changes position of shadow
            ),
          ],
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          children: [
            ExpansionTile(
              tilePadding: const EdgeInsets.only(left: 0, right: 10),
              initiallyExpanded: true,
              title: ListTile(
                visualDensity: const VisualDensity(vertical: -4),
                leading: const ImageIcon(
                  AssetImage("assets/iconos_card/combustible.png"),
                  size: 40,
                  color: Colors.black,
                ),
                title: Text(
                  heading,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              children: <Widget>[
                const Divider(color: colorI),
                const ListTile(
                  title: Text(
                    'Consumo de combustible',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text("5 Gal = 5 km/h"),
                ),
                Container(
                  width: 200,
                  height: 200,
                  padding: const EdgeInsets.all(10),
                  child: KdGaugeView(
                    minSpeed: 0,
                    maxSpeed: 100,
                    minMaxTextStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                    ),
                    speed: totalPorcen1.isNaN ? 0.0 : totalPorcen1,
                    speedTextStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                    animate: true,
                    alertSpeedArray: const [0, 5, 10],
                    alertColorArray: const [colorP, colorI, colorS],
                    duration: const Duration(seconds: 1),
                    unitOfMeasurement: "Consumo",
                    unitOfMeasurementTextStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                    gaugeWidth: 15,
                    innerCirclePadding: 15,
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          leading: const ImageIcon(
                            AssetImage(
                              "assets/generador.png",
                            ),
                            size: 55,
                            color: Colors.black,
                          ),
                          iconColor: const Color.fromARGB(255, 0, 0, 0),
                          title: const Text('Generador'),
                          subtitle:
                              Text('${oCombustible.horasGelectronico} hrs'),
                        ),
                        ListTile(
                          leading: const ImageIcon(
                            AssetImage("assets/moto.png"),
                            size: 55,
                          ),
                          iconColor: const Color.fromARGB(255, 0, 0, 0),
                          title: const Text('Moto'),
                          subtitle: Text('${oCombustible.recorridoMoto} km'),
                        ),
                        ListTile(
                          leading: const ImageIcon(
                              AssetImage("assets/carro.png"),
                              size: 55),
                          iconColor: const Color.fromARGB(255, 0, 0, 0),
                          title: const Text('Carro'),
                          subtitle:
                              Text('${oCombustible.recorridoCamioneta} km'),
                        ),
                        ListTile(
                          leading: const ImageIcon(
                              AssetImage("assets/deslizador.png"),
                              size: 55),
                          iconColor: const Color.fromARGB(255, 0, 0, 0),
                          title: const Text('Deslizador'),
                          subtitle: Text('${oCombustible.horasDeslizador} km'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

/*
 * -----------------------------------------------
 *            ACTIVIDADES PROGRAMADAS
 * -----------------------------------------------
 */
  Padding cardActividadProgramada() {
    var heading = 'ACTIVIDADES PROGRAMADAS APROBADAS';
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: colorI,
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 5), // changes position of shadow
            ),
          ],
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          children: [
            ExpansionTile(
              tilePadding: const EdgeInsets.only(left: 0, right: 10),
              initiallyExpanded: true,
              title: ListTile(
                visualDensity: const VisualDensity(vertical: -4),
                leading: const ImageIcon(
                  AssetImage("assets/iconos_card/actividades.png"),
                  size: 40,
                  color: Colors.black,
                ),
                title: Text(
                  heading,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
              ),
              children: <Widget>[
                const Divider(color: colorI),
                Container(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    height: 420,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: isLoading
                          ? 4
                          : (aAvance.isEmpty ? 1 : aAvance.length),
                      itemBuilder: (context, index) {
                        if (isLoading) {
                          return ShinyWidget();
                        } else {
                          if (aAvance.isEmpty) {
                            return Center(
                              child: Container(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 20, 20, 20),
                                child: const Text(
                                  'NO EXISTE ACTIVIDADES',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                            );
                          }

                          return Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                Text(
                                  aAvance[index].descripcion.toString(),
                                  textAlign: TextAlign.justify,
                                  style: const TextStyle(
                                    fontSize: 15,
                                  ), //Textstyle
                                ), //Text
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Chip(
                                      label: Text(
                                        'Fecha : ${aAvance[index].fecha ?? ''}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 5,
                                        horizontal: 10,
                                      ),
                                      backgroundColor: Colors.blue,
                                    ),
                                  ],
                                ),

                                const Divider(color: colorI), //SizedBox
                              ],
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

/*
 * -----------------------------------------------
 *            INFORMACIÓN DEL CLIMA
 * -----------------------------------------------
 */
  Padding cardClima() {
    var heading = 'DATOS DEL CLIMA';
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: colorI,
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 5), // changes position of shadow
            ),
          ],
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          children: [
            ExpansionTile(
              tilePadding: const EdgeInsets.only(left: 0, right: 10),
              initiallyExpanded: true,
              title: ListTile(
                visualDensity: const VisualDensity(vertical: -4),
                leading: const ImageIcon(
                  AssetImage("assets/iconos_card/clima.png"),
                  size: 40,
                  color: Colors.black,
                ),
                title: Text(
                  heading,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
              ),
              children: <Widget>[
                const Divider(color: colorI),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          iconColor: const Color.fromARGB(255, 0, 0, 0),
                          title: const Text('TEMPERATURA:'),
                          subtitle: Text(
                            '${clima.temp} °',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30),
                          ),
                        ),
                        ListTile(
                          iconColor: const Color.fromARGB(255, 0, 0, 0),
                          title: const Text('VELOCIDAD DEL VIENTO:'),
                          subtitle: Text(
                            '${clima.speed} km/h',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30),
                          ),
                        ),
                        ListTile(
                          iconColor: const Color.fromARGB(255, 0, 0, 0),
                          title: const Text('DIRECCIÓN DEL VIENTO:'),
                          subtitle: Text(
                            '${clima.direction}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

/*
 * -----------------------------------------------
 *            INFORMACIÓN COMO LLEGAR AL TAMBO
 * -----------------------------------------------
 */
  Padding cardCamino() {
    var heading = 'COMO LLEGAR AL TAMBO';
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: colorI,
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 5), // changes position of shadow
            ),
          ],
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          children: [
            ExpansionTile(
              tilePadding: const EdgeInsets.only(left: 0, right: 10),
              initiallyExpanded: true,
              title: ListTile(
                visualDensity: const VisualDensity(vertical: -1),
                leading: const ImageIcon(
                  AssetImage("assets/iconos_card/rutas.png"),
                  size: 55,
                  color: Colors.black,
                ),
                title: Text(
                  heading,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
              ),
              children: <Widget>[
                const Divider(color: colorI),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        for (var oRuta in aRuta)
                          Column(
                            children: [
                              Text(
                                oRuta.cidNombre ?? '',
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              ListTile(
                                leading: ImageIcon(
                                  AssetImage(oRuta.cidNombre!.contains("AÉREA")
                                      ? "assets/avion.png"
                                      : "assets/carro.png"),
                                  size: 40,
                                  color: Colors.black,
                                ),
                                iconColor: const Color.fromARGB(255, 0, 0, 0),
                                title: ListTile(
                                  title: Text(
                                    oRuta.txtDescripcion ?? '',
                                    textAlign: TextAlign.justify,
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  subtitle: Text(
                                    oRuta.txtEncuenta ?? '',
                                    textAlign: TextAlign.justify,
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              const Divider(color: colorI),
                            ],
                          )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String formatoDecimal(double numero) {
    NumberFormat f = NumberFormat("#,###.##", "es_US");
    String result = f.format(numero);
    return result;
  }

  String obtenerNombreMesCompleto(String mes) {
    String nombreMes = "";
    switch (mes) {
      case "1":
        nombreMes = "ENERO";
        break;

      case "2":
        nombreMes = "FEBRERO";
        break;

      case "3":
        nombreMes = "MARZO";
        break;

      case "4":
        nombreMes = "ABRIL";
        break;

      case "5":
        nombreMes = "MAYO";
        break;

      case "6":
        nombreMes = "JUNIO";
        break;

      case "7":
        nombreMes = "JULIO";
        break;

      case "8":
        nombreMes = "AGOSTO";
        break;

      case "9":
        nombreMes = "SETIEMBRE";
        break;

      case "10":
        nombreMes = "OCTUBRE";
        break;

      case "11":
        nombreMes = "NOVIEMBRE";
        break;

      case "12":
        nombreMes = "DICIEMBRE";
        break;

      default:
        nombreMes = "SIN MES ASIGNADO";
        break;
    }
    return nombreMes;
  }

  String obtenerNombreMes(String mes) {
    String nombreMes = "";
    switch (mes) {
      case "1":
        nombreMes = "ENERO";
        break;

      case "2":
        nombreMes = "FEBRERO";
        break;

      case "3":
        nombreMes = "MARZO";
        break;

      case "4":
        nombreMes = "ABRIL";
        break;

      case "5":
        nombreMes = "MAYO";
        break;

      case "6":
        nombreMes = "JUNIO";
        break;

      case "7":
        nombreMes = "JULIO";
        break;

      case "8":
        nombreMes = "AGOSTO";
        break;

      case "9":
        nombreMes = "SETIEMBRE";
        break;

      case "10":
        nombreMes = "OCTUBRE";
        break;

      case "11":
        nombreMes = "NOVIEMBRE";
        break;

      case "12":
        nombreMes = "DICIEMBRE";
        break;

      default:
        nombreMes = "SIN MES ASIGNADO";
        break;
    }
    return nombreMes;
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });
  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

class TabScreen extends StatelessWidget {
  const TabScreen(this.listType, {super.key});
  final String listType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              listType,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class SliverContainer extends StatefulWidget {
  final List<Widget> slivers;
  final Widget floatingActionButton;
  final double expandedHeight;
  final double marginRight;
  final double topScalingEdge;

  const SliverContainer(
      {super.key,
      required this.slivers,
      required this.floatingActionButton,
      this.expandedHeight = 256.0,
      this.marginRight = 16.0,
      this.topScalingEdge = 96.0});

  @override
  State<StatefulWidget> createState() {
    return SliverFabState();
  }
}

class SliverFabState extends State<SliverContainer> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(
      () => setState(() {}),
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        CustomScrollView(
          controller: scrollController,
          slivers: widget.slivers,
        ),
        _buildFab(),
      ],
    );
  }

  Widget _buildFab() {
    final topMarginAdjustVal =
        Theme.of(context).platform == TargetPlatform.iOS ? 12.0 : -4.0;
    final double defaultTopMargin = widget.expandedHeight + topMarginAdjustVal;

    double top = defaultTopMargin;
    double scale = 1.0;
    if (scrollController.hasClients) {
      double offset = scrollController.offset;
      top -= offset > 0 ? offset : 0;
      if (offset < defaultTopMargin - widget.topScalingEdge) {
        scale = 1.0;
      } else if (offset < defaultTopMargin - widget.topScalingEdge / 2) {
        scale = (defaultTopMargin - widget.topScalingEdge / 2 - offset) /
            (widget.topScalingEdge / 2);
      } else {
        scale = 0.0;
      }
    }

    return Positioned(
      top: top,
      right: widget.marginRight,
      child: Transform(
        transform: Matrix4.identity()..scale(scale, scale),
        alignment: Alignment.center,
        child: widget.floatingActionButton,
      ),
    );
  }
}
