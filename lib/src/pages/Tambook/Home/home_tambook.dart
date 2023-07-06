import 'dart:convert';
import 'dart:typed_data';

import 'package:actividades_pais/backend/controller/main_controller.dart';
import 'package:actividades_pais/backend/model/actividades_diarias.dart';
import 'package:actividades_pais/backend/model/actividades_diarias_resumen.dart';
import 'package:actividades_pais/backend/model/atencion_intervencion_beneficiario_resumen_model.dart';
import 'package:actividades_pais/backend/model/atencionesRegionResponse.dart';
import 'package:actividades_pais/backend/model/atencionesSectorialResponse.dart';
import 'package:actividades_pais/backend/model/atenciones_model.dart';
import 'package:actividades_pais/backend/model/atenciones_usuarios_total_model.dart';
import 'package:actividades_pais/backend/model/avance_metas.dart';
import 'package:actividades_pais/backend/model/cantidad_tambo_region.dart';
import 'package:actividades_pais/backend/model/categorizacion_tambos_model.dart';
import 'package:actividades_pais/backend/model/dto/response_base64_file_dto.dart';
import 'package:actividades_pais/backend/model/dto/response_search_tambo_dto.dart';
import 'package:actividades_pais/backend/model/indicador_categorizacion_model.dart';
import 'package:actividades_pais/backend/model/indicador_internet_model.dart';
import 'package:actividades_pais/backend/model/lista_equipamiento_informatico.dart';
import 'package:actividades_pais/backend/model/lista_tambos_estado_internet.dart';
import 'package:actividades_pais/backend/model/listar_informacion_tambos.dart';
import 'package:actividades_pais/backend/model/obtener_metas_tambo_model.dart';
import 'package:actividades_pais/backend/model/personal_puesto_model.dart';
import 'package:actividades_pais/backend/model/personal_tambo.dart';
import 'package:actividades_pais/backend/model/programacion_intervenciones_tambos_model.dart';
import 'package:actividades_pais/backend/model/resumen_parque_informatico.dart';
import 'package:actividades_pais/backend/model/servicios_basicos.dart';
import 'package:actividades_pais/backend/model/tambo_no_intervencion_model.dart';
import 'package:actividades_pais/backend/model/tambo_pias_model.dart';
import 'package:actividades_pais/backend/model/tambos_estado_internet_model.dart';
import 'package:actividades_pais/src/pages/Login/mostrarAlerta.dart';
import 'package:actividades_pais/src/pages/MonitoreoProyectoTambo/main/Project/Report/pdf/pdf_preview_page2.dart';
import 'package:actividades_pais/src/pages/SeguimientoParqueInform%C3%A1tico/Reportes/ReporteEquipoInfomatico.dart';
import 'package:actividades_pais/src/pages/Tambook/Calendario/Calendario.dart';
import 'package:actividades_pais/src/pages/Tambook/Detalle/detalle_tambook.dart';
import 'package:actividades_pais/util/Constants.dart';
import 'package:actividades_pais/util/check_connection.dart';
import 'package:actividades_pais/util/home_options.dart';
import 'package:actividades_pais/util/responsive.dart';
import 'package:flutter/material.dart';
import 'package:mat_month_picker_dialog/mat_month_picker_dialog.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:shimmer/shimmer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:intl/intl.dart';
import 'package:marquee/marquee.dart';
import 'dart:math' as math;
import 'package:actividades_pais/util/busy-indicator.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import "package:collection/collection.dart";

class HomeTambook extends StatefulWidget {
  const HomeTambook({super.key});

  @override
  State<HomeTambook> createState() => _HomeTambookState();
}

class _HomeTambookState extends State<HomeTambook>
    with TickerProviderStateMixin<HomeTambook> {
  Animation<double>? _animation;
  AnimationController? _controller;
  MainController mainCtr = MainController();

  bool isLoading = true;
  bool isLoading2 = false;
  bool isLoadingAtencionMensualizada = false;

  bool isLoadingAtencionesTipoUsuario = false;
  bool isLoadingAtencionesSector = false;
  bool isLoadingAtencionesEntidad = false;

  num totalValue = 0;
  List<ChartDataPie> chartDataPie = [];

  num totalValueTipoBeneficiario = 0;
  List<ChartDataPie> chartDataPieTipoBeneficiarios = [];

  bool isLoadingEI = true;
  bool isLoadingEquipos = false;

  bool isLoadingSinInterAnio = false;
  bool isLoadingSinInterMes = false;

  late String numTambos = "";
  late String banerTambosPias = "---                 ----                ---";

  TamboPias oTamboPias = TamboPias.empty();
  late ResumenParqueDataSource _resumenParqueInformatico;

  List<ProgIntervencionTamboModel> aAvance = [];
  List<AtenInterBeneResumenModel> aAtenInterBene = [];
  List<MetasTamboModel> aMetasTipo1 = [];
  List<MetasTamboModel> aMetasTipo2 = [];
  List<AtencionesModel> aAtencionResumen = [];
  List<AvanceMetasModel> aMetasMensualizada = [];
  late List<CantidadTamboRegion> aTambosRegion = [];
  List<SinIntervencionModel> aSinIntervencion = [];
  List<SinIntervencionModel> aSinIntervencionMes = [];

  late List<AtencionesSectorialesModel> aReporteSectorial = [];
  late List<AtencionesSectorialesModel> aReporteSectorialSector = [];
  late List<AtencionesRegionModel> aReporteAtencionRegion = [];

  List<AtencionesUsuariosTotalModel> aAtencionUsuarios = [];

  late List<EquiposInformaticosResumen> aequiposResumen = [];

  late List<ActividadesDiariasResumenModel> aActividadesResumen = [];

  List<IndicadorInternetModel> aIndicadorInternet = [];
  List<IndicadorCategorizacionModel> aIndicadorCategorizacion = [];
  List<ServiciosBasicosResumenModel> aIndicadorServiciosAgua = [];
  List<ServiciosBasicosResumenModel> aIndicadorServiciosLuz = [];
  List<TambosEstadoInternetModel> aIndicadorEstadoInternet = [];

  String sCurrentYear = DateTime.now().year.toString();
  String fechaActual = DateFormat("MM-yyyy").format(DateTime.now());
  List<EquipamientoInformaticoModel> aEquipos = [];
  List<HomeOptions> aEquipoInformatico = [];
  List<HomeOptions> aPersonalTambo = [];
  List<HomeOptions> aPlataforma = [];

  DateTime currentDate = DateTime.now();

  String fechaActividades = "";

  List<ChartData> chartData = [
    ChartData('PRESTA SERVICIO', 0, colorI),
    ChartData('NO PRESTA SERVICIO', 0, colorS),
  ];

  Future<void> buildData() async {
    setState(() {
      chartData = [
        ChartData('PRESTA SERVICIO', 486, colorS),
        ChartData('NO PRESTA SERVICIO', 5, colorP),
      ];
    });
  }

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );
    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _controller!);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    super.initState();
    //buildEquipoInformatico();
    buildPlataforma();
    getTambosRegion();
    buildPersonalTambo();
    obtenerAvanceMetasPorMes();
    getMetasGeneral();
    getCantidadTambosPIAS();
    getCantidadTotalMetas();
    getActividadesDiariasResumen("0");
    getTambosSinIntervencionAnio();
    getTambosSinIntervencionMes();
    buildData();
    obtenerIndicadorInternet();
    obtenerIndicadorEstadoInternet();
    obtenerIndicadorCategorizacion();
    obtenerResumenAgua();
    obtenerResumenLuz();
    obtenerReporteTipoUsuario('1', '0', '0', 'X');
    obtenerReporteSectorial('2', '0', '0', 'X');
    obtenerReporteAtencionRegion('0', '0', 'X');
    //getProgIntervencionTambo();
    getResumenParqueInformatico();
    setState(() {});
  }

  Future<void> buildPlataforma() async {
    String icon1 = 'assets/icons/tambo_circle.png';
    String icon2 = 'assets/icons/pias_circle.png';

    /**
     * TAMBOS
     */
    List<HomeOptions> aSubOptionTambo = [
      const HomeOptions(
        name: '1',
        name2: 'Recepcionado    ',
        name3: 'assets/icons/casa.png',
      ),
      const HomeOptions(
        name: '11',
        name2: 'En construcción',
        name3: 'assets/icons/arquitecto.png',
      ),
    ];
    aPlataforma.add(
      HomeOptions(
        code: 'OPT4001',
        name: '',
        name2: 'TAMBOS',
        name3: '',
        asubOption: aSubOptionTambo,
        image: icon1,
        color: Colors.white,
      ),
    );

    /**
     * PIAS
     */
    List<HomeOptions> aSubOptionPias = [
      const HomeOptions(
        name: '2',
        name2: 'En construcción',
        name3: 'assets/icons/arquitecto.png',
      ),
    ];
    aPlataforma.add(
      HomeOptions(
        code: 'OPT4002',
        name: '',
        name2: 'PIAS',
        name3: '',
        asubOption: aSubOptionPias,
        image: icon2,
        color: Colors.white,
      ),
    );
  }

  Future<void> getCantidadTambosPIAS() async {
    List<TamboPias> aTamboPias = await mainCtr.getCantidadTambosPIAS();
    oTamboPias = aTamboPias[0];
    banerTambosPias = '${oTamboPias.tambos} TAMBOS PRESTANDO SERVICIO';

    /**
     * Obtener tambos sin intervenciones
     * */
  }

  Future<void> getCantidadTotalMetas() async {
    aAtencionUsuarios = await mainCtr.getCantidadTotalMetas(sCurrentYear);
  }

  Future<void> getTambosSinIntervencionAnio() async {
    aSinIntervencion = await mainCtr.SinIntervencion('ANIO');
    setState(() {});
    isLoadingSinInterAnio = true;
  }

  Future<void> _selectDate(BuildContext context) async {
    BusyIndicator.show(context);

    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050),
        locale: const Locale("es", "ES"),
        helpText: "SELECCIONAR FECHA DE ACTIVIDAD",
        cancelText: "CANCELAR",
        confirmText: "SELECCIONAR");

    if (pickedDate != null && pickedDate != currentDate) {
      aActividadesResumen = await mainCtr.getActividadesDiariasResumen(
          DateFormat("yyyy-MM-dd").format(pickedDate!));

      if (aActividadesResumen.isNotEmpty) {
        fechaActividades = aActividadesResumen[0].fecha.toString();
      } else {
        fechaActividades = "";
      }
      setState(() {
        currentDate = pickedDate;
      });
    }
    BusyIndicator.hide(context);
  }

  Future<void> _selectMonth(BuildContext context) async {
    final selected = await showMonthPicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1970),
        lastDate: DateTime(2050));

    if (selected != null) {
      BusyIndicator.show(context);

      await obtenerReporteTipoUsuario('1', DateFormat("yyyy").format(selected!),
          DateFormat("M").format(selected!), 'X');

      await obtenerReporteSectorial('2', DateFormat("yyyy").format(selected!),
          DateFormat("M").format(selected!), 'X');

      await obtenerReporteAtencionRegion(DateFormat("yyyy").format(selected!),
          DateFormat("M").format(selected!), 'X');

      BusyIndicator.hide(context);
    }
  }

  Future<void> getTambosSinIntervencionMes() async {
    aSinIntervencionMes = await mainCtr.SinIntervencion('MES');
    setState(() {});
    isLoadingSinInterMes = true;
  }

  Future<void> getTambosRegion() async {
    aTambosRegion = await mainCtr.getCantidadTambosRegion();
    setState(() {});
  }

  Future<void> getActividadesDiariasResumen(String fecha) async {
    aActividadesResumen = await mainCtr.getActividadesDiariasResumen(fecha);
    if (aActividadesResumen.isNotEmpty) {
      fechaActividades = aActividadesResumen[0].fecha.toString();
      setState(() {
        currentDate = DateTime.parse(DateFormat("yyyy-MM-dd")
            .format(DateFormat("dd-MM-yyyy").parse(fechaActividades)));
      });
    } else {
      fechaActividades = "";
    }
    setState(() {});
  }

  Future getResumenParqueInformatico() async {
    List<ResumenParqueInformatico> aResumenParque =
        await mainCtr.getResumenParqueInformatico();
    _resumenParqueInformatico = ResumenParqueDataSource(parque: aResumenParque);

    var equipamiento = groupBy(aResumenParque, (obj) => obj.descripcion);

    int totalequipos = 0;
    int bueno = 0;
    int regular = 0;
    int malo = 0;
    int baja = 0;

    var tipoEquipos = equipamiento.keys.toList();
    for (int i = 0; i < tipoEquipos.length; i++) {
      for (var equipo in equipamiento[tipoEquipos[i].toString()] as List) {
        totalequipos = totalequipos + equipo.cantidad as int;
        if (equipo.estado == 'BUENO') {
          bueno = equipo.cantidad as int;
        } else if (equipo.estado == 'REGULAR') {
          regular = equipo.cantidad as int;
        } else if (equipo.estado == 'MALO') {
          malo = equipo.cantidad as int;
        } else {
          baja = equipo.cantidad as int;
        }
      }

      aequiposResumen.add(EquiposInformaticosResumen(
          tipoEquipos[i].toString(),
          totalequipos,
          bueno,
          regular,
          malo,
          baja,
          'assets/iconos_equipos/${tipoEquipos[i].toString()}.png'));
      totalequipos = 0;
      bueno = 0;
      regular = 0;
      malo = 0;
      baja = 0;
    }

    isLoadingEquipos = true;
  }

  Future<void> buildPersonalTambo() async {
    List<PersonalPuestoModel> aPersonal = await mainCtr.getPersonalPuesto();

    String icon1 = 'assets/icons/JUT.png';
    String icon2 = 'assets/icons/MONITOR.png';
    String icon3 = 'assets/icons/GESTORES.png';
    String icon4 = 'assets/icons/GUARDIAN.png';
    String icon5 = 'assets/icons/persona2.png';

    aPersonalTambo.add(
      HomeOptions(
        code: 'OPT3001',
        name: 'JEFES DE UNIDADES TERRITORIALES',
        name2: aPersonal[0].jut.toString() ?? '0',
        types: const ['Ver'],
        image: icon1,
        color: Colors.white,
      ),
    );
    aPersonalTambo.add(
      HomeOptions(
        code: 'OPT3002',
        name: 'MONITORES',
        name2: aPersonal[0].mo.toString() ?? '0',
        types: const ['Ver'],
        image: icon2,
        color: Colors.white,
      ),
    );

    /*aPersonalTambo.add(
      HomeOptions(
        code: 'OPT3003',
        name: 'GESTORES \nTAMBOS',
        name2: aPersonal[0].git.toString() ?? '0',
        types: const ['Ver'],
        image: icon3,
        color: Colors.white,
      ),
    );

    aPersonalTambo.add(
      HomeOptions(
          code: 'OPT3004',
          name: 'GUARDIANES \nTAMBOS',
          name2: aPersonal[0].gu.toString() ?? '0',
          types: const ['Ver'],
          image: icon4,
          color: Colors.white),
    );

    aPersonalTambo.add(
      HomeOptions(
          code: 'OPT3005',
          name: 'SOPORTE \n TÉCNICO DE UTI',
          name2: aPersonal[0].st.toString() ?? '0',
          types: const ['Ver'],
          image: icon5,
          color: Colors.white),
    );*/
  }

  Future<void> buildEquipoInformatico() async {
    aEquipos = await mainCtr.getEquipamientoInformatico("0");

    aEquipoInformatico = [];

    var cpu = aEquipos.where((e) => e.categoria == 'CPU').length;
    var laptop = aEquipos.where((e) => e.categoria == 'LAPTOP').length;
    var proyector = aEquipos.where((e) => e.categoria == 'PROYECTOR').length;
    var impresora = aEquipos.where((e) => e.categoria == 'IMPRESORA').length;

    //var equipamiento = groupBy(aEquipos, (obj) => obj.categoria);

    String icon1 = 'assets/icons/computadora.png';
    String icon2 = 'assets/icons/laptop.png';
    String icon3 = 'assets/icons/proyector.png';
    String icon4 = 'assets/icons/wifi.png';
    String icon5 = 'assets/icons/impresora.png';
    String icon6 = 'assets/icons/parlante.png';

    //var cpu = equipamiento['CPU']?.length ?? '0';

    //var proyector = equipamiento['PROYECTOR']?.length ?? '0';
    //var laptop = equipamiento['LAPTOP']?.length ?? '0';
    //var impresora = equipamiento['IMPRESORA']?.length ?? '0';

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
        code: 'OPT2005',
        name: 'IMPRESORAS \n(${impresora.toString()})',
        types: const ['Ver'],
        image: icon5,
        color: Colors.white,
      ),
    );

    isLoadingEquipos = true;
  }

  Future<void> getProgIntervencionTambo() async {
    aAvance = await mainCtr.progIntervencionTambo(
      'X',
      sCurrentYear,
      'X',
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
  }

  Future<void> getMetasGeneral() async {
    isLoading2 = false;
    getAtenInterBeneResumen();
    List<MetasTamboModel> aMetas =
        await mainCtr.metasTambo("0", sCurrentYear, 0);

    aMetasTipo1 = aMetas.where((e) => e.numTipoMeta == 1).toList();
    aMetasTipo2 = aMetas.where((e) => e.numTipoMeta == 2).toList();

    isLoading2 = true;
    setState(() {});
  }

  Future<void> getAtenInterBeneResumen() async {
    aAtenInterBene = await mainCtr.AtenInterBeneResumen(
      '0',
    );

    AtencionesModel o1 = AtencionesModel(
      imagePath: '',
      title: 'TAMBOS QUE PRESTAN SERVICIO',
      total: 488,
    );
    aAtencionResumen.add(o1);

    if (aAtenInterBene.isNotEmpty) {
      final totalAtenciones =
          aAtenInterBene.fold(0, (sum, item) => sum + item.atenciones!);
      final totalIntervenciones =
          aAtenInterBene.fold(0, (sum, item) => sum + item.intervenciones!);
      final totalBeneficiarios =
          aAtenInterBene.fold(0, (sum, item) => sum + item.beneficiarios!);

      AtencionesModel o2 = AtencionesModel(
        imagePath: '',
        title: 'ATENCIONES $sCurrentYear',
        total: totalAtenciones,
      );
      AtencionesModel o3 = AtencionesModel(
        imagePath: '',
        title: 'INTERVENCIONES $sCurrentYear',
        total: totalIntervenciones,
      );
      AtencionesModel o4 = AtencionesModel(
        imagePath: '',
        title: 'USUARIOS $sCurrentYear',
        total: totalBeneficiarios,
      );

      aAtencionResumen.add(o2);
      aAtencionResumen.add(o3);
      aAtencionResumen.add(o4);
      setState(() {});
    }
  }

  Future<void> tambosParaMapa() async {
    List<TambosMapaModel> tambos = await mainCtr.getTamboParaMapa();
    await Future.delayed(const Duration(seconds: 2));
    numTambos = tambos.length.toString();
    setState(() {
      isLoading = false;
    });
  }

  Future<void> obtenerAvanceMetasPorMes() async {
    try {
      aMetasMensualizada =
          await mainCtr.getAvanceMetasMensualizada(sCurrentYear);

      setState(() {
        isLoadingAtencionMensualizada = true;
      });
    } on Exception catch (e) {
      setState(() {
        isLoadingAtencionMensualizada = true;
      });
    }
  }

  Future<void> obtenerReporteTipoUsuario(tipo, anio, mes, sector) async {
    try {
      var _aReporteSectorial =
          await mainCtr.getReporteSectorial(tipo, anio, mes, sector);

      if (_aReporteSectorial.isNotEmpty) {
        aReporteSectorial = _aReporteSectorial;

        totalValue = 0;
        chartDataPie = [];
        totalValueTipoBeneficiario = 0;
        chartDataPieTipoBeneficiarios = [];

        aReporteSectorial.sort((a, b) => int.parse(b.atenciones ?? '0')
            .compareTo(int.parse(a.atenciones ?? '0')));

        totalValue = aReporteSectorial.fold(
            0, (sum, item) => sum + int.parse(item.atenciones ?? '0'));

        totalValueTipoBeneficiario = aReporteSectorial.fold(
            0, (sum, item) => sum + int.parse(item.beneficiarios ?? '0'));

        /*for (var sector in aReporteSectorial) {
          chartDataPie.add(ChartDataPie(sector.entidad!,
              double.parse(sector.atenciones!), Colors.greenAccent));
        }

        for (var element in chartDataPie) {
          totalValue += element.y;
        }

        for (var sector in aReporteSectorial) {
          chartDataPieTipoBeneficiarios.add(ChartDataPie(sector.entidad!,
              double.parse(sector.beneficiarios!), Colors.greenAccent));
        }

        for (var element in chartDataPie) {
          totalValueTipoBeneficiario += element.y;
        }*/

        setState(() {
          isLoadingAtencionesTipoUsuario = true;
        });
      } else {
        mostrarAlerta(context, "Aviso!",
            "No se encontraron registros con el mes y año seleccionado");
        await Future.delayed(const Duration(milliseconds: 2000));

        BusyIndicator.hide(context);
      }
    } on Exception catch (e) {}
  }

  Future<void> obtenerReporteSectorial(tipo, anio, mes, sector) async {
    try {
      var _aReporteSectorialSector =
          await mainCtr.getReporteSectorial(tipo, anio, mes, sector);

      if (_aReporteSectorialSector.isNotEmpty) {
        aReporteSectorialSector = _aReporteSectorialSector;
        aReporteSectorialSector.sort((a, b) => int.parse(b.atenciones ?? '0')
            .compareTo(int.parse(a.atenciones ?? '0')));
      }
    } on Exception catch (e) {}
  }

  Future<void> obtenerReporteAtencionRegion(anio, mes, region) async {
    try {
      var _aReporteAtencionRegion =
          await mainCtr.getReporteAtencionesRegion(anio, mes, region);

      if (_aReporteAtencionRegion.isNotEmpty) {
        aReporteAtencionRegion = _aReporteAtencionRegion;
        setState(() {
          isLoadingAtencionesSector = true;
        });
      }
    } on Exception catch (e) {}
  }

  Future<void> obtenerIndicadorInternet() async {
    aIndicadorInternet = await mainCtr.getIndicadorInternet("0");
  }

  Future<void> obtenerIndicadorEstadoInternet() async {
    aIndicadorEstadoInternet = await mainCtr.getIndicadorEstadoInternet();
  }

  Future<void> obtenerIndicadorCategorizacion() async {
    aIndicadorCategorizacion = await mainCtr.getIndicadorCategorizacion("0");
  }

  Future<void> obtenerResumenAgua() async {
    aIndicadorServiciosAgua =
        await mainCtr.getIndicadorResumenServiciosBasicos("AGUA", "0");
  }

  Future<void> obtenerResumenLuz() async {
    aIndicadorServiciosLuz =
        await mainCtr.getIndicadorResumenServiciosBasicos("LUZ", "0");
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    double wp = responsive.wp(14);
    double hp65 = responsive.hp(27);

    /*return Scaffold(
      backgroundColor: color_10o15,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            cardHeader(),
            const SizedBox(height: 15),
            cardAtenciones(),
            cardBeneficiarios(),
            avanceMetas(),
            avanceMetasUsuarios(),
            cardPlataforma(),
            cardPersonalTambo(),
            cardEquipamientoTecnologico(),
          ],
        ),
      ),
    );*/

    return DefaultTabController(
      length: 8, // cambiar aqui para mas pestañas
      child: Scaffold(
        backgroundColor: color_10o15,
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                  expandedHeight: 180.0,
                  automaticallyImplyLeading: false,
                  pinned: false,
                  floating: false,
                  snap: false,
                  //actionsIconTheme: IconThemeData(opacity: 0.0),
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      children: <Widget>[
                        CarouselSlider(
                          items: [
                            SizedBox(
                              width: double.maxFinite,
                              height: 180.0,
                              child: Image.asset(
                                'assets/carrusel1.jpg',
                                fit: BoxFit.fill,
                              ),
                            ),
                            SizedBox(
                              width: double.maxFinite,
                              height: 180.0,
                              child: Image.asset(
                                'assets/carrusel2.jpg',
                                fit: BoxFit.fill,
                              ),
                            ),
                            SizedBox(
                              width: double.maxFinite,
                              height: 180.0,
                              child: Image.asset(
                                'assets/carrusel3.jpg',
                                fit: BoxFit.fill,
                              ),
                            ),
                            SizedBox(
                              width: double.maxFinite,
                              height: 180.0,
                              child: Image.asset(
                                'assets/carrusel4.jpg',
                                fit: BoxFit.fill,
                              ),
                            ),
                          ],
                          options: CarouselOptions(
                            height: 190.0,
                            enlargeCenterPage: true,
                            autoPlay: true,
                            aspectRatio: 2.0,
                            autoPlayCurve: Curves.linear,
                            enableInfiniteScroll: true,
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 800),
                            viewportFraction: 1.0,
                          ),
                        ),
                      ],
                    ),
                  )),
              SliverPersistentHeader(
                pinned: true,
                delegate: _SliverAppBarDelegate(
                  minHeight: 50,
                  maxHeight: 55,
                  child: Container(
                    height: 800 * (1 / 11),
                    width: double.infinity,
                    color: const Color.fromARGB(255, 230, 234, 236),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 10),
                          child: SizedBox(
                            height: 35,
                            child: Column(
                              children: [
                                Expanded(
                                    child: Marquee(
                                  text: banerTambosPias,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                  scrollAxis:
                                      Axis.horizontal, //scroll direction
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  blankSpace: 20.0,
                                  velocity: 50.0, //speed
                                  pauseAfterRound: const Duration(seconds: 1),
                                  startPadding: 10.0,
                                  accelerationDuration:
                                      const Duration(seconds: 1),
                                  accelerationCurve: Curves.linear,
                                  decelerationDuration:
                                      const Duration(milliseconds: 500),
                                  decelerationCurve: Curves.easeOut,
                                ))
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(1.0),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    const ColoredBox(
                      color: Colors.white70,
                      child: TabBar(
                        labelColor: Colors.black87,
                        unselectedLabelColor: Colors.grey,
                        padding: EdgeInsets.all(5.0),
                        isScrollable: true,
                        tabs: [
                          Tab(
                              icon: ImageIcon(
                            AssetImage('assets/icons/icon_intervencion.png'),
                            size: 35,
                          )),
                          Tab(
                              icon: ImageIcon(
                            AssetImage('assets/icons/atenciones.png'),
                            size: 35,
                          )),
                          Tab(
                            icon: ImageIcon(
                              AssetImage('assets/icons/tambo.png'),
                              size: 35,
                            ),
                          ),
                          Tab(
                            icon: ImageIcon(
                              AssetImage('assets/intervenciones.png'),
                              size: 35,
                            ),
                          ),
                          Tab(
                            icon: ImageIcon(
                              AssetImage('assets/calendario.png'),
                              size: 35,
                            ),
                          ),
                          Tab(
                            icon: ImageIcon(
                              AssetImage('assets/icons/evoluciones.png'),
                              size: 35,
                            ),
                          ),
                          Tab(
                            icon: ImageIcon(
                              AssetImage('assets/personal.png'),
                              size: 35,
                            ),
                          ),
                          Tab(
                            icon: ImageIcon(
                              AssetImage('assets/equipos.png'),
                              size: 35,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: <Widget>[
              // REPORTES SECTORIALES
              SingleChildScrollView(
                  child: Column(
                children: [
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () => _selectMonth(context),
                    child: const Text('SELECCIONAR MES'),
                  ),
                  const SizedBox(height: 10),
                  reporteSectorialTipoUsuarioAtencion(),
                  const SizedBox(height: 10),
                  reporteSectorialTipoUsuarioBeneficiarios(),
                  const SizedBox(height: 10),
                  reporteSectorial(),
                  const SizedBox(height: 10),
                  reporteAtencionRegion(),
                  const SizedBox(height: 15),
                  //cardPlataforma(),
                ],
              )),

              SingleChildScrollView(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 15),
                  cardAtenciones(),
                  avanceMetas(),
                  cardBeneficiarios(),
                  avanceMetasUsuarios(),
                ],
              )),
              SingleChildScrollView(
                  child: Column(
                children: [
                  const SizedBox(height: 15),
                  cardTambosRegion(),
                  const SizedBox(height: 15),
                  //cardPlataforma(),
                ],
              )),
              Calendario(),
              SingleChildScrollView(
                  child: Column(
                children: [
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () => _selectDate(context),
                    child: Text('SELECCIONAR FECHA DE ACTIVIDAD'),
                  ),
                  const SizedBox(height: 10),
                  cardActividadesDiarias(),
                  const SizedBox(height: 15),
                  //cardPlataforma(),
                ],
              )),
              SingleChildScrollView(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 15),
                  cardIndicadorCategorizacion(),
                  const SizedBox(height: 15),
                  cardTambosSinIntervencion(),
                  const SizedBox(height: 15),
                  cardIndicadorInternet(),
                  const SizedBox(height: 15),
                  cardIndicadorEstadoInternet(),
                  const SizedBox(height: 15),
                  cardResumenProveedor(),
                  const SizedBox(height: 15),
                  cardIndicadorResumenAgua(),
                  const SizedBox(height: 15),
                  cardIndicadorResumenLuz(),

                  // const SizedBox(height: 15),
                  //cardTambosSinIntervencionMes(),
                ],
              )),
              SingleChildScrollView(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 15),
                  Text("ACTUALIZADO AL ${fechaActual}"),
                  const SizedBox(height: 15),
                  cardPersonalTambo(),
                ],
              )),
              SingleChildScrollView(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 15),
                  cardResumenEquipos(),
                  //cardEquipamientoTecnologico(),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }

  Container cardPlataforma() {
    return Container(
      padding: const EdgeInsets.fromLTRB(1, 1, 1, 1),
      alignment: Alignment.centerLeft,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          isLoadingEI ? plataforma() : const CircularProgressIndicator(),
        ],
      ),
    );
  }

  Widget plataforma() {
    return Flexible(
      child: SizedBox(
        height: 550.0,
        child: GridView.builder(
          physics: const BouncingScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 1.5,
            crossAxisSpacing: 30,
            mainAxisSpacing: 30,
          ),
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
            bottom: 58,
          ),
          itemCount: aPlataforma.length,
          itemBuilder: (context, index) {
            HomeOptions homeOption = aPlataforma[index];
            return InkWell(
              splashColor: Colors.white,
              highlightColor: Colors.white,
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Hero(
                              tag: homeOption.image!,
                              child: Image.asset(
                                homeOption.image!,
                                fit: BoxFit.contain,
                                width: 60,
                                height: 60,
                                alignment: Alignment.center,
                              ),
                            ),
                            Column(
                              children: [
                                Text.rich(
                                  TextSpan(
                                    text: homeOption.name2!,
                                    style: const TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: homeOption.name!,
                                        style: const TextStyle(
                                          fontSize: 19,
                                          height: 1.5,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(1),
                                  child: Center(
                                    child: Text(
                                      homeOption.name3!,
                                      style: const TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontWeight: FontWeight.w700,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 11.0,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(),
                          ],
                        ),
                      ),
                      for (var oSubOption in homeOption.asubOption!)
                        Container(
                          padding: const EdgeInsets.all(1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              oSubOption.name3 != ''
                                  ? Container(
                                      padding: const EdgeInsets.only(
                                        top: 2,
                                        bottom: 2,
                                      ),
                                      child: Hero(
                                        tag: oSubOption.name3!,
                                        child: Image.asset(
                                          oSubOption.name3!,
                                          fit: BoxFit.contain,
                                          width: 40,
                                          height: 40,
                                          alignment: Alignment.centerLeft,
                                        ),
                                      ),
                                    )
                                  : const Text("       "),
                              Text(
                                oSubOption.name2!,
                                style: const TextStyle(fontSize: 20.0),
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                oSubOption.name!,
                                style: const TextStyle(fontSize: 20.0),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              onTap: () async {
                //  var oHomeOptionSelect = aHomeOptions[index];
              },
            );
          },
        ),
      ),
    );
  }

  Column cardPersonalTambo() {
    //var heading = 'PERSONAL TAMBOS';

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        isLoadingEI ? personalTambo() : const CircularProgressIndicator(),
      ],
    );

    /*return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Expanded(
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
                padding: const EdgeInsets.fromLTRB(1, 1, 1, 1),
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    isLoadingEI
                        ? personalTambo()
                        : const CircularProgressIndicator(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );*/
  }

  Widget personalTambo() {
    return Flexible(
      child: SizedBox(
        height: 550.0,
        child: GridView.builder(
          physics: const BouncingScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
            crossAxisSpacing: 30,
            mainAxisSpacing: 30,
          ),
          padding: const EdgeInsets.only(
            left: 28,
            right: 28,
            bottom: 58,
          ),
          itemCount: aPersonalTambo.length,
          itemBuilder: (context, index) {
            HomeOptions homeOption = aPersonalTambo[index];
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
                      Container(
                        padding: const EdgeInsets.only(
                          top: 8,
                          bottom: 2,
                        ),
                        child: Hero(
                          tag: homeOption.image!,
                          child: Image.asset(
                            homeOption.image!,
                            fit: BoxFit.contain,
                            width: 100,
                            height: 100,
                            alignment: Alignment.center,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(1),
                        child: Center(
                          child: Text(
                            homeOption.name2!,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                              fontSize: 30.0,
                            ),
                            textAlign: TextAlign.center,
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
                BusyIndicator.show(context);
                HomeOptions oOption = aPersonalTambo[index];

                String sPersonalCode = '';
                String tipoPersonal = '';
                String tipoDescripcion = '';

                if (oOption.code == 'OPT3001') {
                  sPersonalCode = 'JUT';
                  tipoPersonal = 'JEFES DE UNIDADES TERRITORIALES';
                  tipoDescripcion = 'UT: ';
                }
                if (oOption.code == 'OPT3002') {
                  sPersonalCode = 'MO';
                  tipoPersonal = 'MONITORES';
                  tipoDescripcion = 'CANTIDAD: ';
                }
                if (oOption.code == 'OPT3003') {
                  sPersonalCode = 'GIT';
                  tipoPersonal = 'GESTORES INSTITUCIONALES';
                  tipoDescripcion = 'CANTIDAD: ';
                }
                if (oOption.code == 'OPT3004') {
                  sPersonalCode = 'GU';
                  tipoPersonal = 'GUARDIANES';
                  tipoDescripcion = 'CANTIDAD: ';
                }
                if (oOption.code == 'OPT3005') {
                  sPersonalCode = 'ST';
                  tipoPersonal = 'SOPORTE TÉCNICO - UTI';
                }
                List<PersonalTambo> aPersonalDetTambo =
                    await mainCtr.getPersonalPuestoTambo(sPersonalCode);

                BusyIndicator.hide(context);

                showDialog(
                  context: context,
                  builder: (BuildContext context) => buildSuccessDialog2(
                    context,
                    title: tipoPersonal,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: aPersonalDetTambo.length,
                      itemBuilder: (BuildContext context, int index) {
                        var oEquipoSelect = aPersonalDetTambo[index];
                        return Column(
                          children: [
                            ListTile(
                              title: Text(
                                oEquipoSelect.nombres ?? '',
                              ),
                              subtitle: Text(
                                  "${tipoDescripcion} ${oEquipoSelect.descripcion ?? ''}"),
                            ),
                            const Divider(color: colorI),
                          ],
                        );
                      },
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Column cardEquipamientoTecnologico() {
    //var heading = 'EQUIPAMIENTO TECNOLÓGICO';

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [equipoInformatico()],
    );

    /*return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Expanded(
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
                padding: const EdgeInsets.fromLTRB(1, 1, 1, 1),
                alignment: Alignment.centerLeft,
                child: 
              )
            ],
          ),
        ),
      ),
    );*/
  }

  Widget equipoInformatico() {
    return Flexible(
        child: Container(
            height: 500,
            color: Colors.white,
            padding:
                const EdgeInsets.symmetric(horizontal: 2.0, vertical: 15.0),
            child: FutureBuilder(
                future: getResumenParqueInformatico(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  return isLoadingEquipos
                      ? SfDataGridTheme(
                          data: SfDataGridThemeData(
                            headerColor: Colors.blue,
                          ),
                          child: SfDataGrid(
                            source: _resumenParqueInformatico,
                            columnWidthMode: ColumnWidthMode.auto,
                            gridLinesVisibility: GridLinesVisibility.both,
                            headerGridLinesVisibility: GridLinesVisibility.both,
                            columns: [
                              GridColumn(
                                  columnName: 'equipo',
                                  label: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      alignment: Alignment.centerLeft,
                                      child: const Text(
                                        'EQUIPO',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                        overflow: TextOverflow.ellipsis,
                                      ))),
                              GridColumn(
                                  columnName: 'estado',
                                  label: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      alignment: Alignment.centerLeft,
                                      child: const Text(
                                        'ESTADO',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                        overflow: TextOverflow.ellipsis,
                                      ))),
                              GridColumn(
                                  columnName: 'cantidad',
                                  label: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      alignment: Alignment.centerRight,
                                      child: const Text(
                                        'CANTIDAD',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                        overflow: TextOverflow.ellipsis,
                                      ))),
                            ],
                          ),
                        )
                      : Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                          ),
                        );
                })));
  }

  Widget cardHeader() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 0,
        right: 0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CarouselSlider(
            items: [
              SizedBox(
                width: double.maxFinite,
                height: 160.0,
                child: Image.asset(
                  'assets/banner.jpg',
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(
                width: double.maxFinite,
                height: 180.0,
                child: Image.asset(
                  'assets/fondo2.jpg',
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(
                width: double.maxFinite,
                height: 180.0,
                child: Image.asset(
                  'assets/fondo3.jpg',
                  fit: BoxFit.fill,
                ),
              ),
            ],
            options: CarouselOptions(
              height: 190.0,
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 2.0,
              autoPlayCurve: Curves.linear,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              viewportFraction: 1.0,
            ),
          ),

          const SizedBox(height: 15),
          //const Divider(color: color_02o27),
          /*const Text(
            'PLATAFORMAS FIJAS Y MOVIL',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 22,
              letterSpacing: 0.27,
              color: color_01,
            ),
          ),*/
        ],
      ),
    );
  }

/*
*------------------------------------------------
* REPORTE SECTORIALES
*------------------------------------------------
*/

  Padding reporteSectorialTipoUsuarioAtencion() {
    var heading = 'GRÁFICA DE ATENCIONES POR SECTOR';

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
            const SizedBox(height: 10),
            isLoadingAtencionesTipoUsuario == true
                ? Text(
                    'ATENCIONES DE ${(aReporteSectorial.isNotEmpty) ? obtenerNombreMesCompleto(aReporteSectorial[0].mes!) + ' DEL ' + aReporteSectorial[0].anio! : ''}')
                : const Text(""),
            const SizedBox(height: 10),
            Center(child: Text("TOTAL ${formatoDecimal(totalValue.toInt())}")),
            isLoadingAtencionesTipoUsuario == true
                ? Container(
                    alignment: Alignment.centerLeft,
                    //height: 800,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SimpleCircularProgressBar(
                                        size: 100,
                                        maxValue: 100,
                                        valueNotifier: ValueNotifier(
                                            ((double.parse(aReporteSectorial[0]
                                                            .atenciones ??
                                                        '0') /
                                                    totalValue) *
                                                100)),
                                        backColor:
                                            Colors.black.withOpacity(0.4),
                                        progressStrokeWidth: 10,
                                        backStrokeWidth: 10,
                                        mergeMode: true,
                                        onGetText: (double value) {
                                          return Text(
                                            '${((double.parse(aReporteSectorial[0].atenciones ?? '0') / totalValue) * 100).round()}%',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          );
                                        },
                                      ),
                                      const SizedBox(height: 10),
                                      ListTile(
                                        title: Center(
                                            child: Text(
                                          aReporteSectorial[0].entidad ?? '',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        )),
                                        subtitle: Center(
                                            child: Text(
                                                "(${formatoDecimal(int.parse(aReporteSectorial[0].atenciones ?? '0'))})")),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SimpleCircularProgressBar(
                                        size: 100,
                                        maxValue: 100,
                                        valueNotifier: ValueNotifier(
                                            ((double.parse(aReporteSectorial[1]
                                                            .atenciones ??
                                                        '0') /
                                                    totalValue) *
                                                100)),
                                        backColor:
                                            Colors.black.withOpacity(0.4),
                                        progressStrokeWidth: 10,
                                        backStrokeWidth: 10,
                                        mergeMode: true,
                                        onGetText: (double value) {
                                          return Text(
                                            '${((double.parse(aReporteSectorial[1].atenciones ?? '0') / totalValue) * 100).round()}%',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          );
                                        },
                                      ),
                                      const SizedBox(height: 10),
                                      ListTile(
                                        title: Center(
                                            child: Text(
                                          aReporteSectorial[1].entidad ?? '',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        )),
                                        subtitle: Center(
                                            child: Text(
                                                "(${formatoDecimal(int.parse(aReporteSectorial[1].atenciones ?? '0'))})")),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SimpleCircularProgressBar(
                                        size: 100,
                                        maxValue: 100,
                                        valueNotifier: ValueNotifier(
                                            ((double.parse(aReporteSectorial[2]
                                                            .atenciones ??
                                                        '0') /
                                                    totalValue) *
                                                100)),
                                        backColor:
                                            Colors.black.withOpacity(0.4),
                                        progressStrokeWidth: 10,
                                        backStrokeWidth: 10,
                                        mergeMode: true,
                                        onGetText: (double value) {
                                          return Text(
                                            '${((double.parse(aReporteSectorial[2].atenciones ?? '0') / totalValue) * 100).round()}%',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          );
                                        },
                                      ),
                                      const SizedBox(height: 10),
                                      ListTile(
                                        title: Center(
                                            child: Text(
                                          aReporteSectorial[2].entidad ?? '',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        )),
                                        subtitle: Center(
                                            child: Text(
                                                "(${formatoDecimal(int.parse(aReporteSectorial[2].atenciones ?? '0'))})")),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SimpleCircularProgressBar(
                                        size: 100,
                                        maxValue: 100,
                                        valueNotifier: ValueNotifier(
                                            ((double.parse(aReporteSectorial[3]
                                                            .atenciones ??
                                                        '0') /
                                                    totalValue) *
                                                100)),
                                        backColor:
                                            Colors.black.withOpacity(0.4),
                                        progressStrokeWidth: 10,
                                        backStrokeWidth: 10,
                                        mergeMode: true,
                                        onGetText: (double value) {
                                          return Text(
                                            '${((double.parse(aReporteSectorial[3].atenciones ?? '0') / totalValue) * 100).round()}%',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          );
                                        },
                                      ),
                                      const SizedBox(height: 10),
                                      ListTile(
                                        title: Center(
                                            child: Text(
                                          aReporteSectorial[3].entidad ?? '',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        )),
                                        subtitle: Center(
                                            child: Text(
                                                "(${formatoDecimal(int.parse(aReporteSectorial[3].atenciones ?? '0'))})")),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SimpleCircularProgressBar(
                                        size: 100,
                                        maxValue: 100,
                                        valueNotifier: ValueNotifier(
                                            ((double.parse(aReporteSectorial[4]
                                                            .atenciones ??
                                                        '0') /
                                                    totalValue) *
                                                100)),
                                        backColor:
                                            Colors.black.withOpacity(0.4),
                                        progressStrokeWidth: 10,
                                        backStrokeWidth: 10,
                                        mergeMode: true,
                                        onGetText: (double value) {
                                          return Text(
                                            '${((double.parse(aReporteSectorial[4].atenciones ?? '0') / totalValue) * 100).round()}%',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          );
                                        },
                                      ),
                                      const SizedBox(height: 10),
                                      ListTile(
                                        title: Center(
                                            child: Text(
                                          aReporteSectorial[4].entidad ?? '',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        )),
                                        subtitle: Center(
                                            child: Text(
                                                "(${formatoDecimal(int.parse(aReporteSectorial[4].atenciones ?? '0'))})")),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SimpleCircularProgressBar(
                                        size: 100,
                                        maxValue: 100,
                                        valueNotifier: ValueNotifier(
                                            ((double.parse(aReporteSectorial[5]
                                                            .atenciones ??
                                                        '0') /
                                                    totalValue) *
                                                100)),
                                        backColor:
                                            Colors.black.withOpacity(0.4),
                                        progressStrokeWidth: 10,
                                        backStrokeWidth: 10,
                                        mergeMode: true,
                                        onGetText: (double value) {
                                          return Text(
                                            '${((double.parse(aReporteSectorial[5].atenciones ?? '0') / totalValue) * 100).round()}%',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          );
                                        },
                                      ),
                                      const SizedBox(height: 10),
                                      ListTile(
                                        title: Center(
                                            child: Text(
                                          aReporteSectorial[5].entidad ?? '',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        )),
                                        subtitle: Center(
                                            child: Text(
                                                "(${formatoDecimal(int.parse(aReporteSectorial[5].atenciones ?? '0'))})")),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SimpleCircularProgressBar(
                                        size: 100,
                                        maxValue: 100,
                                        valueNotifier: ValueNotifier(
                                            ((double.parse(aReporteSectorial[6]
                                                            .atenciones ??
                                                        '0') /
                                                    totalValue) *
                                                100)),
                                        backColor:
                                            Colors.black.withOpacity(0.4),
                                        progressStrokeWidth: 10,
                                        backStrokeWidth: 10,
                                        mergeMode: true,
                                        onGetText: (double value) {
                                          return Text(
                                            '${((double.parse(aReporteSectorial[6].atenciones ?? '0') / totalValue) * 100).round()}%',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          );
                                        },
                                      ),
                                      const SizedBox(height: 10),
                                      ListTile(
                                        title: Center(
                                            child: Text(
                                          aReporteSectorial[6].entidad ?? '',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        )),
                                        subtitle: Center(
                                            child: Text(
                                                "(${formatoDecimal(int.parse(aReporteSectorial[6].atenciones ?? '0'))})")),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SimpleCircularProgressBar(
                                        size: 100,
                                        maxValue: 100,
                                        valueNotifier: ValueNotifier(
                                            ((double.parse(aReporteSectorial[7]
                                                            .atenciones ??
                                                        '0') /
                                                    totalValue) *
                                                100)),
                                        backColor:
                                            Colors.black.withOpacity(0.4),
                                        progressStrokeWidth: 10,
                                        backStrokeWidth: 10,
                                        mergeMode: true,
                                        onGetText: (double value) {
                                          return Text(
                                            '${((double.parse(aReporteSectorial[7].atenciones ?? '0') / totalValue) * 100).round()}%',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          );
                                        },
                                      ),
                                      const SizedBox(height: 10),
                                      ListTile(
                                        title: Center(
                                            child: Text(
                                          aReporteSectorial[7].entidad ?? '',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        )),
                                        subtitle: Center(
                                            child: Text(
                                                "(${formatoDecimal(int.parse(aReporteSectorial[7].atenciones ?? '0'))})")),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SimpleCircularProgressBar(
                                        size: 100,
                                        maxValue: 100,
                                        valueNotifier: ValueNotifier(
                                            ((double.parse(aReporteSectorial[8]
                                                            .atenciones ??
                                                        '0') /
                                                    totalValue) *
                                                100)),
                                        backColor:
                                            Colors.black.withOpacity(0.4),
                                        progressStrokeWidth: 10,
                                        backStrokeWidth: 10,
                                        mergeMode: true,
                                        onGetText: (double value) {
                                          return Text(
                                            '${((double.parse(aReporteSectorial[8].atenciones ?? '0') / totalValue) * 100).round()}%',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          );
                                        },
                                      ),
                                      const SizedBox(height: 10),
                                      ListTile(
                                        title: Center(
                                            child: Text(
                                          aReporteSectorial[8].entidad ?? '',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        )),
                                        subtitle: Center(
                                            child: Text(
                                                "(${formatoDecimal(int.parse(aReporteSectorial[8].atenciones ?? '0'))})")),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ]),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text('FUENTE: PNPAIS'),
                        const SizedBox(
                          height: 1,
                        ),
                        Text(
                            'ACTUALIZADO HASTA ${(aMetasMensualizada.isNotEmpty ? (obtenerNombreMesCompleto(aMetasMensualizada[aMetasMensualizada.length - 1].mes!)) : '')} DEL ${sCurrentYear}'),
                      ],
                    ),
                  )
                : const Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }

  Padding reporteSectorialTipoUsuarioBeneficiarios() {
    var heading = 'GRÁFICA DE USUARIOS POR SECTOR';

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
            const SizedBox(height: 10),
            isLoadingAtencionesTipoUsuario == true
                ? Text(
                    'USUARIOS UNICOS DE ${(aReporteSectorial.isNotEmpty) ? obtenerNombreMesCompleto(aReporteSectorial[0].mes!) + ' DEL ' + aReporteSectorial[0].anio! : ''}')
                : const Text(""),
            const SizedBox(height: 10),
            Center(
                child: Text(
                    "TOTAL ${formatoDecimal(totalValueTipoBeneficiario.toInt())}")),
            isLoadingAtencionesTipoUsuario == true
                ? Container(
                    alignment: Alignment.centerLeft,
                    //height: 800,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SimpleCircularProgressBar(
                                        size: 100,
                                        maxValue: 100,
                                        valueNotifier: ValueNotifier(((double
                                                    .parse(aReporteSectorial[0]
                                                            .beneficiarios ??
                                                        '0') /
                                                totalValueTipoBeneficiario) *
                                            100)),
                                        backColor:
                                            Colors.black.withOpacity(0.4),
                                        progressStrokeWidth: 10,
                                        backStrokeWidth: 10,
                                        mergeMode: true,
                                        onGetText: (double value) {
                                          return Text(
                                            '${((double.parse(aReporteSectorial[0].beneficiarios ?? '0') / totalValueTipoBeneficiario) * 100).round()}%',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          );
                                        },
                                      ),
                                      const SizedBox(height: 10),
                                      ListTile(
                                        title: Center(
                                            child: Text(
                                          aReporteSectorial[0].entidad ?? '',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        )),
                                        subtitle: Center(
                                            child: Text(
                                                "(${formatoDecimal(int.parse(aReporteSectorial[0].beneficiarios ?? '0'))})")),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SimpleCircularProgressBar(
                                        size: 100,
                                        maxValue: 100,
                                        valueNotifier: ValueNotifier(((double
                                                    .parse(aReporteSectorial[1]
                                                            .beneficiarios ??
                                                        '0') /
                                                totalValueTipoBeneficiario) *
                                            100)),
                                        backColor:
                                            Colors.black.withOpacity(0.4),
                                        progressStrokeWidth: 10,
                                        backStrokeWidth: 10,
                                        mergeMode: true,
                                        onGetText: (double value) {
                                          return Text(
                                            '${((double.parse(aReporteSectorial[1].beneficiarios ?? '0') / totalValueTipoBeneficiario) * 100).round()}%',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          );
                                        },
                                      ),
                                      const SizedBox(height: 10),
                                      ListTile(
                                        title: Center(
                                            child: Text(
                                          aReporteSectorial[1].entidad ?? '',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        )),
                                        subtitle: Center(
                                            child: Text(
                                                "(${formatoDecimal(int.parse(aReporteSectorial[1].beneficiarios ?? '0'))})")),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SimpleCircularProgressBar(
                                        size: 100,
                                        maxValue: 100,
                                        valueNotifier: ValueNotifier(((double
                                                    .parse(aReporteSectorial[2]
                                                            .beneficiarios ??
                                                        '0') /
                                                totalValueTipoBeneficiario) *
                                            100)),
                                        backColor:
                                            Colors.black.withOpacity(0.4),
                                        progressStrokeWidth: 10,
                                        backStrokeWidth: 10,
                                        mergeMode: true,
                                        onGetText: (double value) {
                                          return Text(
                                            '${((double.parse(aReporteSectorial[2].beneficiarios ?? '0') / totalValueTipoBeneficiario) * 100).round()}%',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          );
                                        },
                                      ),
                                      const SizedBox(height: 10),
                                      ListTile(
                                        title: Center(
                                            child: Text(
                                          aReporteSectorial[2].entidad ?? '',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        )),
                                        subtitle: Center(
                                            child: Text(
                                                "(${formatoDecimal(int.parse(aReporteSectorial[2].beneficiarios ?? '0'))})")),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SimpleCircularProgressBar(
                                        size: 100,
                                        maxValue: 100,
                                        valueNotifier: ValueNotifier(((double
                                                    .parse(aReporteSectorial[3]
                                                            .beneficiarios ??
                                                        '0') /
                                                totalValueTipoBeneficiario) *
                                            100)),
                                        backColor:
                                            Colors.black.withOpacity(0.4),
                                        progressStrokeWidth: 10,
                                        backStrokeWidth: 10,
                                        mergeMode: true,
                                        onGetText: (double value) {
                                          return Text(
                                            '${((double.parse(aReporteSectorial[3].beneficiarios ?? '0') / totalValueTipoBeneficiario) * 100).round()}%',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          );
                                        },
                                      ),
                                      const SizedBox(height: 10),
                                      ListTile(
                                        title: Center(
                                            child: Text(
                                          aReporteSectorial[3].entidad ?? '',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        )),
                                        subtitle: Center(
                                            child: Text(
                                                "(${formatoDecimal(int.parse(aReporteSectorial[3].beneficiarios ?? '0'))})")),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SimpleCircularProgressBar(
                                        size: 100,
                                        maxValue: 100,
                                        valueNotifier: ValueNotifier(((double
                                                    .parse(aReporteSectorial[4]
                                                            .beneficiarios ??
                                                        '0') /
                                                totalValueTipoBeneficiario) *
                                            100)),
                                        backColor:
                                            Colors.black.withOpacity(0.4),
                                        progressStrokeWidth: 10,
                                        backStrokeWidth: 10,
                                        mergeMode: true,
                                        onGetText: (double value) {
                                          return Text(
                                            '${((double.parse(aReporteSectorial[4].beneficiarios ?? '0') / totalValueTipoBeneficiario) * 100).round()}%',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          );
                                        },
                                      ),
                                      const SizedBox(height: 10),
                                      ListTile(
                                        title: Center(
                                            child: Text(
                                          aReporteSectorial[4].entidad ?? '',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        )),
                                        subtitle: Center(
                                            child: Text(
                                                "(${formatoDecimal(int.parse(aReporteSectorial[4].beneficiarios ?? '0'))})")),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SimpleCircularProgressBar(
                                        size: 100,
                                        maxValue: 100,
                                        valueNotifier: ValueNotifier(((double
                                                    .parse(aReporteSectorial[5]
                                                            .beneficiarios ??
                                                        '0') /
                                                totalValueTipoBeneficiario) *
                                            100)),
                                        backColor:
                                            Colors.black.withOpacity(0.4),
                                        progressStrokeWidth: 10,
                                        backStrokeWidth: 10,
                                        mergeMode: true,
                                        onGetText: (double value) {
                                          return Text(
                                            '${((double.parse(aReporteSectorial[5].beneficiarios ?? '0') / totalValueTipoBeneficiario) * 100).round()}%',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          );
                                        },
                                      ),
                                      const SizedBox(height: 10),
                                      ListTile(
                                        title: Center(
                                            child: Text(
                                          aReporteSectorial[5].entidad ?? '',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        )),
                                        subtitle: Center(
                                            child: Text(
                                                "(${formatoDecimal(int.parse(aReporteSectorial[5].beneficiarios ?? '0'))})")),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SimpleCircularProgressBar(
                                        size: 100,
                                        maxValue: 100,
                                        valueNotifier: ValueNotifier(((double
                                                    .parse(aReporteSectorial[6]
                                                            .beneficiarios ??
                                                        '0') /
                                                totalValueTipoBeneficiario) *
                                            100)),
                                        backColor:
                                            Colors.black.withOpacity(0.4),
                                        progressStrokeWidth: 10,
                                        backStrokeWidth: 10,
                                        mergeMode: true,
                                        onGetText: (double value) {
                                          return Text(
                                            '${((double.parse(aReporteSectorial[6].beneficiarios ?? '0') / totalValueTipoBeneficiario) * 100).round()}%',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          );
                                        },
                                      ),
                                      const SizedBox(height: 10),
                                      ListTile(
                                        title: Center(
                                            child: Text(
                                          aReporteSectorial[6].entidad ?? '',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        )),
                                        subtitle: Center(
                                            child: Text(
                                                "(${formatoDecimal(int.parse(aReporteSectorial[6].beneficiarios ?? '0'))})")),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SimpleCircularProgressBar(
                                        size: 100,
                                        maxValue: 100,
                                        valueNotifier: ValueNotifier(((double
                                                    .parse(aReporteSectorial[7]
                                                            .beneficiarios ??
                                                        '0') /
                                                totalValueTipoBeneficiario) *
                                            100)),
                                        backColor:
                                            Colors.black.withOpacity(0.4),
                                        progressStrokeWidth: 10,
                                        backStrokeWidth: 10,
                                        mergeMode: true,
                                        onGetText: (double value) {
                                          return Text(
                                            '${((double.parse(aReporteSectorial[7].beneficiarios ?? '0') / totalValueTipoBeneficiario) * 100).round()}%',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          );
                                        },
                                      ),
                                      const SizedBox(height: 10),
                                      ListTile(
                                        title: Center(
                                            child: Text(
                                          aReporteSectorial[7].entidad ?? '',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        )),
                                        subtitle: Center(
                                            child: Text(
                                                "(${formatoDecimal(int.parse(aReporteSectorial[7].beneficiarios ?? '0'))})")),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SimpleCircularProgressBar(
                                        size: 100,
                                        maxValue: 100,
                                        valueNotifier: ValueNotifier(((double
                                                    .parse(aReporteSectorial[8]
                                                            .beneficiarios ??
                                                        '0') /
                                                totalValueTipoBeneficiario) *
                                            100)),
                                        backColor:
                                            Colors.black.withOpacity(0.4),
                                        progressStrokeWidth: 10,
                                        backStrokeWidth: 10,
                                        mergeMode: true,
                                        onGetText: (double value) {
                                          return Text(
                                            '${((double.parse(aReporteSectorial[8].beneficiarios ?? '0') / totalValueTipoBeneficiario) * 100).round()}%',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          );
                                        },
                                      ),
                                      const SizedBox(height: 10),
                                      ListTile(
                                        title: Center(
                                            child: Text(
                                          aReporteSectorial[8].entidad ?? '',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        )),
                                        subtitle: Center(
                                            child: Text(
                                                "(${formatoDecimal(int.parse(aReporteSectorial[8].beneficiarios ?? '0'))})")),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ]),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text('FUENTE: PNPAIS'),
                        const SizedBox(
                          height: 1,
                        ),
                        Text(
                            'ACTUALIZADO HASTA ${(aMetasMensualizada.isNotEmpty ? (obtenerNombreMesCompleto(aMetasMensualizada[aMetasMensualizada.length - 1].mes!)) : '')} DEL ${sCurrentYear}'),
                      ],
                    ),
                  )
                : const Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }

  Padding reporteSectorial() {
    String anio_mes =
        'DE ${(aReporteSectorial.isNotEmpty) ? obtenerNombreMesCompleto(aReporteSectorial[0].mes!) + ' DEL ' + aReporteSectorial[0].anio! : ''}';

    var heading = 'REPORTE SECTORIAL ${anio_mes}';

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
                title: Text(
                  heading,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
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
                        for (var item in aReporteSectorialSector)
                          Column(
                            children: [
                              ListTile(
                                /*leading: SizedBox(
                                    height: 150.0,
                                    child: Image.asset(
                                        "assets/regiones/peru.png")),*/

                                // AssetImage("assets/regiones/AYACUCHO.png"),

                                iconColor: const Color.fromARGB(255, 0, 0, 0),
                                title: ListTile(
                                  title: Text(
                                    item.entidad ?? '',
                                    textAlign: TextAlign.justify,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    "ATENCIONES: ${formatoDecimal(int.parse(item.atenciones ?? '0'))}\nUSUARIOS: ${formatoDecimal(int.parse(item.beneficiarios ?? '0'))}",
                                    textAlign: TextAlign.justify,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                onTap: () async {
                                  BusyIndicator.show(context);

                                  List<AtencionesSectorialesModel>
                                      aReporteSectorialEntidad =
                                      await mainCtr.getReporteSectorial(
                                          '3', '2023', '3', item.entidad!);

                                  BusyIndicator.hide(context);

                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        buildSuccessDialog2(
                                      context,
                                      title:
                                          "${item.entidad}\n${anio_mes}\n(${aReporteSectorialEntidad.length})",
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount:
                                            aReporteSectorialEntidad.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          var oItem =
                                              aReporteSectorialEntidad[index];
                                          return Column(
                                            children: [
                                              ListTile(
                                                dense: true,
                                                contentPadding: EdgeInsets.only(
                                                    left: 0.0, right: 0.0),
                                                leading: Text("${index + 1}"),
                                                title: ListTile(
                                                  title: Text(
                                                    oItem.entidad ?? '',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  subtitle: Text(
                                                    "ATENCIONES : ${formatoDecimal(int.parse(oItem.atenciones ?? '0'))}\nUSUARIOS : ${formatoDecimal(int.parse(oItem.beneficiarios ?? '0'))}",
                                                    style:
                                                        TextStyle(fontSize: 15),
                                                  ),
                                                ),
                                                onTap: () async {},
                                              ),
                                              const Divider(color: colorI),
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                  );
                                },
                              ),
                              const Divider(color: colorI),
                            ],
                          ),
                        const SizedBox(height: 10),
                        const Text('FUENTE: INEI - PAIS'),
                        Text(
                            'ACTUALIZADO HASTA ${(aMetasMensualizada.isNotEmpty ? (obtenerNombreMesCompleto(aMetasMensualizada[aMetasMensualizada.length - 1].mes!)) : '')} DEL ${sCurrentYear}'),
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

  Padding reporteAtencionRegion() {
    String anio_mes =
        '${(aReporteAtencionRegion.isNotEmpty) ? obtenerNombreMesCompleto(aReporteAtencionRegion[0].mes!) + ' DEL ' + aReporteAtencionRegion[0].periodo! : ''}';
    var heading = 'RESULTADOS POR UNIDAD TERRITORIAL\n${anio_mes}';
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
                title: Text(
                  heading,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
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
                        Column(
                          children: [
                            ListTile(
                              leading: SizedBox(
                                  height: 150.0,
                                  child: Image.asset(
                                      "assets/regiones/MAPA_COSTA_SIERRA_SELVA.png")),
                              iconColor: const Color.fromARGB(255, 0, 0, 0),
                              title: ListTile(
                                title: const Text(
                                  "U.T.",
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  "REGIONES: ${formatoDecimal(aReporteAtencionRegion.length)}\nATENCIONES: ${formatoDecimal(aReporteAtencionRegion.fold(0, (sum, item) => sum + int.parse(item.atenciones!)))}\nUSUARIOS: ${formatoDecimal(aReporteAtencionRegion.fold(0, (sum, item) => sum + int.parse(item.usuarios!)))}\nINTERVENCIONES: ${formatoDecimal(aReporteAtencionRegion.fold(0, (sum, item) => sum + double.parse(item.intervenciones!).toInt()))}",
                                  textAlign: TextAlign.justify,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            const Divider(color: colorI),
                          ],
                        ),
                        const SizedBox(height: 10),
                        for (var item in aReporteAtencionRegion)
                          Column(
                            children: [
                              ListTile(
                                leading: SizedBox(
                                    height: 150.0,
                                    child: Image.asset(
                                        "assets/regiones/${item.idUt}.png")),

                                // AssetImage("assets/regiones/AYACUCHO.png"),

                                iconColor: const Color.fromARGB(255, 0, 0, 0),
                                title: ListTile(
                                  title: Text(
                                    item.region ?? '',
                                    textAlign: TextAlign.justify,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    "ATENCIONES: ${formatoDecimal(int.parse(item.atenciones ?? '0'))}\nUSUARIOS: ${formatoDecimal(int.parse(item.usuarios ?? '0'))}\nINTERVENCIONES: ${formatoDecimal(int.parse(item.intervenciones ?? '0'))}",
                                    textAlign: TextAlign.justify,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                              const Divider(color: colorI),
                            ],
                          ),
                        const SizedBox(height: 10),
                        const Text('FUENTE: INEI - PAIS'),
                        Text(
                            'ACTUALIZADO HASTA ${(aMetasMensualizada.isNotEmpty ? (obtenerNombreMesCompleto(aMetasMensualizada[aMetasMensualizada.length - 1].mes!)) : '')} DEL ${sCurrentYear}'),
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

/*
*------------------------------------------------
*             CHARTS
*-------------------------------------------------
*/

  Container tambosOperativos() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Card(
        margin: const EdgeInsets.all(7),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListView.builder(
              shrinkWrap: true,
              itemCount: isLoading ? 1 : 1,
              itemBuilder: (context, index) {
                if (isLoading) {
                  return ShinyWidget();
                } else {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        tileColor: Colors.white,
                        leading: SizedBox(
                          height: 70.0,
                          width: 70.0, // fixed width and height
                          child: Image.asset(
                            'assets/icono_tambos.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Center(
                          child: Text(
                            numTambos ?? '',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 65,
                            ),
                          ),
                        ),
                        subtitle: const Center(
                          child: Text(
                            'Tambos prestando servicio',
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                      ),
                    ],
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Padding cardIndicadorInternet() {
    var heading = 'PROVEEDOR DE INTERNET $sCurrentYear';

    final List<ChartDataAvanceIndicador> chartDataIndicador = [];

    for (var indicador in aIndicadorInternet) {
      chartDataIndicador.add(ChartDataAvanceIndicador(
          indicador.idOperadorInternet.toString()!,
          indicador.nomOperadorInternet!,
          int.parse(indicador.numAsignados!.toString()),
          obtenerColores(indicador.idOperadorInternet.toString())));
    }

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
                  isLoading2
                      ? Center(
                          child: SfCircularChart(
                              onLegendTapped: (LegendTapArgs args) async {
                                String idProveedor =
                                    chartDataIndicador[args.pointIndex ?? 0].id;

                                String proveedor =
                                    chartDataIndicador[args.pointIndex ?? 0].x;

                                BusyIndicator.show(context);

                                List<IndicadorInternetModel> indicadorInternet =
                                    await mainCtr.getIndicadorInternet(
                                        idProveedor.toString());

                                BusyIndicator.hide(context);

                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      buildSuccessDialog2(
                                    context,
                                    title:
                                        "LISTA DE TAMBOS (${indicadorInternet.length})\n${proveedor}",
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: indicadorInternet.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        var oIndicadorInternet =
                                            indicadorInternet[index];
                                        return Column(
                                          children: [
                                            ListTile(
                                              leading: Text("${index + 1}"),
                                              title: Text(
                                                oIndicadorInternet.nomTambo ??
                                                    '',
                                              ),
                                              subtitle: Text(
                                                  oIndicadorInternet.region!),
                                              onTap: () async {
                                                BusyIndicator.show(context);

                                                List<BuscarTamboDto> aTamboId =
                                                    await mainCtr
                                                        .getDatosTamboGestor(
                                                            oIndicadorInternet
                                                                    .idTambo
                                                                    .toString() ??
                                                                '0');

                                                BusyIndicator.hide(context);

                                                Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        DetalleTambook(
                                                            listTambo:
                                                                aTamboId[0]),
                                                  ),
                                                );
                                              },
                                            ),
                                            const Divider(color: colorI),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                );
                              },
                              legend: Legend(
                                  isVisible: true,
                                  toggleSeriesVisibility: false,
                                  position: LegendPosition.bottom,
                                  overflowMode: LegendItemOverflowMode.wrap),
                              series: <CircularSeries>[
                              PieSeries<ChartDataAvanceIndicador, String>(
                                  /*onPointTap:
                                      (ChartPointDetails details) async {
                                    String idProveedor = chartDataIndicador[
                                            details.pointIndex ?? 0]
                                        .id;

                                    String proveedor = chartDataIndicador[
                                            details.pointIndex ?? 0]
                                        .x;

                                    BusyIndicator.show(context);

                                    List<IndicadorInternetModel>
                                        indicadorInternet =
                                        await mainCtr.getIndicadorInternet(
                                            idProveedor.toString());

                                    BusyIndicator.hide(context);

                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          buildSuccessDialog2(
                                        context,
                                        title:
                                            "LISTA DE TAMBOS (${indicadorInternet.length})\n${proveedor}",
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: indicadorInternet.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            var oIndicadorInternet =
                                                indicadorInternet[index];
                                            return Column(
                                              children: [
                                                ListTile(
                                                  leading: Text("${index + 1}"),
                                                  title: Text(
                                                    oIndicadorInternet
                                                            .nomTambo ??
                                                        '',
                                                  ),
                                                  subtitle: Text(
                                                      oIndicadorInternet
                                                          .region!),
                                                  onTap: () {},
                                                ),
                                                const Divider(color: colorI),
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                    );
                                  },*/
                                  selectionBehavior:
                                      SelectionBehavior(enable: true),
                                  dataSource: chartDataIndicador,
                                  xValueMapper:
                                      (ChartDataAvanceIndicador data, _) =>
                                          data.x,
                                  yValueMapper:
                                      (ChartDataAvanceIndicador data, _) =>
                                          data.y,
                                  pointColorMapper:
                                      (ChartDataAvanceIndicador data, _) =>
                                          data.color,
                                  dataLabelSettings: const DataLabelSettings(
                                      // Renders the data label
                                      isVisible: true,
                                      labelPosition:
                                          ChartDataLabelPosition.outside,
                                      textStyle: TextStyle(fontSize: 20)))
                            ]))
                      : const Center(child: CircularProgressIndicator()),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text('FUENTE: PNPAIS'),
                  Text("ACTUALIZADO AL ${fechaActual}"),
                  const SizedBox(
                    height: 1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding cardIndicadorEstadoInternet() {
    var heading = 'TAMBOS POR ESTADO DE INTERNET $sCurrentYear';

    final List<ChartDataAvanceIndicador> chartDataIndicador = [];

    for (var indicador in aIndicadorEstadoInternet) {
      chartDataIndicador.add(ChartDataAvanceIndicador(
          indicador.codigo!,
          indicador.estado!,
          int.parse(indicador.cantidad!.toString()),
          obtenerColores(indicador.codigo!)));
    }

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
                  isLoading2
                      ? Center(
                          child: SfCircularChart(
                              onLegendTapped: (LegendTapArgs args) async {
                                String idEstado =
                                    chartDataIndicador[args.pointIndex ?? 0].id;

                                String estado =
                                    chartDataIndicador[args.pointIndex ?? 0].x;

                                BusyIndicator.show(context);

                                List<ListaTambosEstadoInternetModel>
                                    indicadorInternet = await mainCtr
                                        .getListaTambosEstadoInternet(idEstado);

                                BusyIndicator.hide(context);

                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      buildSuccessDialog2(
                                    context,
                                    title:
                                        "LISTA DE TAMBOS (${indicadorInternet.length})\n${estado}",
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: indicadorInternet.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        var oIndicadorInternet =
                                            indicadorInternet[index];
                                        return Column(
                                          children: [
                                            ListTile(
                                              leading: Text("${(index + 1)}"),
                                              title: Text(
                                                oIndicadorInternet.nomTambo ??
                                                    '',
                                              ),
                                              subtitle: Text(
                                                  "${oIndicadorInternet.region}\n${oIndicadorInternet.proveedor}"),
                                              onTap: () async {
                                                BusyIndicator.show(context);

                                                List<BuscarTamboDto> aTamboId =
                                                    await mainCtr
                                                        .getDatosTamboGestor(
                                                            oIndicadorInternet
                                                                    .idTambo
                                                                    .toString() ??
                                                                '0');

                                                BusyIndicator.hide(context);

                                                Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        DetalleTambook(
                                                            listTambo:
                                                                aTamboId[0]),
                                                  ),
                                                );
                                              },
                                            ),
                                            const Divider(color: colorI),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                );
                              },
                              legend: Legend(
                                isVisible: true,
                                toggleSeriesVisibility: false,
                                position: LegendPosition.bottom,
                                overflowMode: LegendItemOverflowMode.wrap,
                              ),
                              series: <CircularSeries>[
                              PieSeries<ChartDataAvanceIndicador, String>(
                                  selectionBehavior:
                                      SelectionBehavior(enable: true),
                                  dataSource: chartDataIndicador,
                                  xValueMapper:
                                      (ChartDataAvanceIndicador data, _) =>
                                          data.x,
                                  yValueMapper:
                                      (ChartDataAvanceIndicador data, _) =>
                                          data.y,
                                  pointColorMapper:
                                      (ChartDataAvanceIndicador data, _) =>
                                          data.color,
                                  dataLabelSettings: const DataLabelSettings(
                                      // Renders the data label
                                      isVisible: true,
                                      labelPosition:
                                          ChartDataLabelPosition.outside,
                                      textStyle: TextStyle(fontSize: 20)))
                            ]))
                      : const Center(child: CircularProgressIndicator()),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text('FUENTE: PNPAIS'),
                  Text("ACTUALIZADO AL ${fechaActual}"),
                  const SizedBox(
                    height: 1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding cardResumenProveedor() {
    var heading = 'RESUMEN DE PROVEEDOR DE INTERNET';
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
                title: Text(
                  heading,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
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
                        for (var indicador in aIndicadorInternet)
                          Column(
                            children: [
                              Text(
                                indicador.nomOperadorInternet ?? '',
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w700,
                                  decoration: TextDecoration.underline,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              ListTile(
                                leading: SizedBox(
                                    width: 70.0,
                                    child: Image.asset(
                                        "assets/Operador/${indicador.idOperadorInternet}.png")),
                                iconColor: const Color.fromARGB(255, 0, 0, 0),
                                title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "OPERATIVO: ${indicador.operativos ?? ''}\nINOPERATIVO: ${indicador.inoperativos ?? ''}\nEN PROCESO DE INST. : ${indicador.enproceso ?? ''}",
                                        textAlign: TextAlign.justify,
                                        style: const TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                          "TOTAL: ${indicador.numAsignados ?? ''}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w900))
                                    ]),
                              ),
                              const Divider(color: colorI),
                            ],
                          ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text('FUENTE: PNPAIS'),
                        Text("ACTUALIZADO AL ${fechaActual}"),
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

  Padding cardIndicadorCategorizacion() {
    var heading = 'CATEGORIZACIÓN $sCurrentYear';

    final List<ChartDataAvanceIndicador> chartDataIndicador = [];

    for (var indicador in aIndicadorCategorizacion) {
      chartDataIndicador.add(ChartDataAvanceIndicador(
          indicador.idPriorizacion.toString()!,
          indicador.nomPriorizacion!,
          int.parse(indicador.numAsignados!.toString()),
          Colors.blue));
    }

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
                  isLoading2
                      ? Center(
                          child: Container(
                              height: 450,
                              child: SfCartesianChart(
                                  primaryXAxis: CategoryAxis(
                                    maximumLabelWidth: 100,
                                  ),
                                  primaryYAxis: NumericAxis(
                                    edgeLabelPlacement:
                                        EdgeLabelPlacement.shift,
                                    numberFormat: NumberFormat.decimalPattern(),
                                  ),
                                  series: <ChartSeries>[
                                    // Renders bar chart
                                    BarSeries<ChartDataAvanceIndicador, String>(
                                        onPointTap:
                                            (ChartPointDetails details) async {
                                          String idCategoria =
                                              chartDataIndicador[
                                                      details.pointIndex ?? 0]
                                                  .id;

                                          String categoria = chartDataIndicador[
                                                  details.pointIndex ?? 0]
                                              .x;

                                          BusyIndicator.show(context);

                                          List<CategorizacionTambosModel>
                                              indicadorCategorizacion =
                                              await mainCtr
                                                  .getCategorizacionTambos(
                                                      idCategoria.toString());

                                          BusyIndicator.hide(context);

                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                dialogCategorizacion(
                                              context,
                                              idCategoria:
                                                  idCategoria.toString(),
                                              title:
                                                  "LISTA DE TAMBOS (${indicadorCategorizacion.length})\n${categoria}",
                                              child: ListView.builder(
                                                shrinkWrap: true,
                                                itemCount:
                                                    indicadorCategorizacion
                                                        .length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  var oIndicadorCategoria =
                                                      indicadorCategorizacion[
                                                          index];
                                                  return Column(
                                                    children: [
                                                      ListTile(
                                                        leading: Text(
                                                            "${index + 1}"),
                                                        title: Text(
                                                          oIndicadorCategoria
                                                                  .nomTambo ??
                                                              '',
                                                        ),
                                                        subtitle: Text(
                                                            "${oIndicadorCategoria.region ?? ''}\n${oIndicadorCategoria.nomCategoria ?? ''} "),
                                                        onTap: () async {
                                                          BusyIndicator.show(
                                                              context);

                                                          List<BuscarTamboDto>
                                                              aTamboId =
                                                              await mainCtr.getDatosTamboGestor(
                                                                  oIndicadorCategoria
                                                                          .idTambo
                                                                          .toString() ??
                                                                      '0');

                                                          BusyIndicator.hide(
                                                              context);

                                                          Navigator
                                                              .pushReplacement(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (BuildContext
                                                                      context) =>
                                                                  DetalleTambook(
                                                                      listTambo:
                                                                          aTamboId[
                                                                              0]),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                      const Divider(
                                                          color: colorI),
                                                    ],
                                                  );
                                                },
                                              ),
                                            ),
                                          );
                                        },
                                        dataSource: chartDataIndicador,
                                        xValueMapper:
                                            (ChartDataAvanceIndicador data,
                                                    _) =>
                                                data.x,
                                        yValueMapper:
                                            (ChartDataAvanceIndicador data,
                                                    _) =>
                                                data.y,
                                        // Width of the bars
                                        width: 0.9,
                                        // Spacing between the bars
                                        spacing: 0.2,
                                        dataLabelSettings:
                                            const DataLabelSettings(
                                                // Renders the data label
                                                isVisible: true,
                                                labelPosition:
                                                    ChartDataLabelPosition
                                                        .outside,
                                                textStyle:
                                                    TextStyle(fontSize: 17)))
                                  ])))
                      : const Center(child: CircularProgressIndicator()),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text('FUENTE: PNPAIS'),
                  Text("ACTUALIZADO AL ${fechaActual}"),
                  const SizedBox(
                    height: 1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding cardIndicadorResumenLuz() {
    var heading = 'TIPO DE CONEXIÓN DE ENERGÍA ELÉCTRICA';

    final List<ChartDataAvanceIndicador> chartDataIndicador = [];

    for (var indicador in aIndicadorServiciosLuz) {
      chartDataIndicador.add(ChartDataAvanceIndicador(
          indicador.idTipoConexion.toString()!,
          indicador.nomTipoConexion!,
          int.parse(indicador.cantidad!.toString()),
          Colors.blue));
    }

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
                  isLoading2
                      ? Center(
                          child: Container(
                              height: 450,
                              child: SfCartesianChart(
                                  primaryXAxis: CategoryAxis(
                                    maximumLabelWidth: 100,
                                  ),
                                  primaryYAxis: NumericAxis(
                                    edgeLabelPlacement:
                                        EdgeLabelPlacement.shift,
                                    numberFormat: NumberFormat.decimalPattern(),
                                  ),
                                  series: <ChartSeries>[
                                    // Renders bar chart
                                    BarSeries<ChartDataAvanceIndicador, String>(
                                        onPointTap:
                                            (ChartPointDetails details) async {
                                          String idCategoria =
                                              chartDataIndicador[
                                                      details.pointIndex ?? 0]
                                                  .id;

                                          String categoria = chartDataIndicador[
                                                  details.pointIndex ?? 0]
                                              .x;

                                          BusyIndicator.show(context);

                                          List<ServiciosBasicosResumenModel>
                                              indicadorLuz = await mainCtr
                                                  .getIndicadorResumenServiciosBasicos(
                                                      "LUZ",
                                                      idCategoria.toString());

                                          BusyIndicator.hide(context);

                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                buildSuccessDialog2(
                                              context,
                                              title:
                                                  "LISTA DE TAMBOS (${indicadorLuz.length})\n${categoria}",
                                              child: ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: indicadorLuz.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  var oIndicadorLuz =
                                                      indicadorLuz[index];
                                                  return Column(
                                                    children: [
                                                      ListTile(
                                                        leading: Text(
                                                            "${index + 1}"),
                                                        title: Text(
                                                          oIndicadorLuz
                                                                  .nomTambo ??
                                                              '',
                                                        ),
                                                        subtitle: Text(
                                                            "${oIndicadorLuz.region ?? ''}"),
                                                        onTap: () async {
                                                          BusyIndicator.show(
                                                              context);

                                                          List<BuscarTamboDto>
                                                              aTamboId =
                                                              await mainCtr.getDatosTamboGestor(
                                                                  oIndicadorLuz
                                                                          .idTambo
                                                                          .toString() ??
                                                                      '0');

                                                          BusyIndicator.hide(
                                                              context);

                                                          Navigator
                                                              .pushReplacement(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (BuildContext
                                                                      context) =>
                                                                  DetalleTambook(
                                                                      listTambo:
                                                                          aTamboId[
                                                                              0]),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                      const Divider(
                                                          color: colorI),
                                                    ],
                                                  );
                                                },
                                              ),
                                            ),
                                          );
                                        },
                                        dataSource: chartDataIndicador,
                                        xValueMapper:
                                            (ChartDataAvanceIndicador data,
                                                    _) =>
                                                data.x,
                                        yValueMapper:
                                            (ChartDataAvanceIndicador data,
                                                    _) =>
                                                data.y,
                                        // Width of the bars
                                        width: 0.9,
                                        // Spacing between the bars
                                        spacing: 0.2,
                                        dataLabelSettings:
                                            const DataLabelSettings(
                                                // Renders the data label
                                                isVisible: true,
                                                labelPosition:
                                                    ChartDataLabelPosition
                                                        .outside,
                                                textStyle:
                                                    TextStyle(fontSize: 17)))
                                  ])))
                      : const Center(child: CircularProgressIndicator()),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text('FUENTE: PNPAIS'),
                  Text("ACTUALIZADO AL ${fechaActual}"),
                  const SizedBox(
                    height: 1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding cardIndicadorResumenAgua() {
    var heading = 'TIPO DE CONEXIÓN DE AGUA';

    final List<ChartDataAvanceIndicador> chartDataIndicador = [];

    for (var indicador in aIndicadorServiciosAgua) {
      chartDataIndicador.add(ChartDataAvanceIndicador(
          indicador.idTipoConexion.toString()!,
          indicador.nomTipoConexion!,
          int.parse(indicador.cantidad!.toString()),
          Colors.blue));
    }

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
                  isLoading2
                      ? Center(
                          child: Container(
                              height: 450,
                              child: SfCartesianChart(
                                  primaryXAxis: CategoryAxis(
                                    maximumLabelWidth: 100,
                                  ),
                                  primaryYAxis: NumericAxis(
                                    edgeLabelPlacement:
                                        EdgeLabelPlacement.shift,
                                    numberFormat: NumberFormat.decimalPattern(),
                                  ),
                                  series: <ChartSeries>[
                                    // Renders bar chart
                                    BarSeries<ChartDataAvanceIndicador, String>(
                                        onPointTap:
                                            (ChartPointDetails details) async {
                                          String idCategoria =
                                              chartDataIndicador[
                                                      details.pointIndex ?? 0]
                                                  .id;

                                          String categoria = chartDataIndicador[
                                                  details.pointIndex ?? 0]
                                              .x;

                                          BusyIndicator.show(context);

                                          List<ServiciosBasicosResumenModel>
                                              indicadorAgua = await mainCtr
                                                  .getIndicadorResumenServiciosBasicos(
                                                      "AGUA",
                                                      idCategoria.toString());

                                          BusyIndicator.hide(context);

                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                buildSuccessDialog2(
                                              context,
                                              title:
                                                  "LISTA DE TAMBOS (${indicadorAgua.length})\n${categoria}",
                                              child: ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: indicadorAgua.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  var oIndicadorAgua =
                                                      indicadorAgua[index];
                                                  return Column(
                                                    children: [
                                                      ListTile(
                                                        leading: Text(
                                                            "${index + 1}"),
                                                        title: Text(
                                                          oIndicadorAgua
                                                                  .nomTambo ??
                                                              '',
                                                        ),
                                                        subtitle: Text(
                                                            "${oIndicadorAgua.region ?? ''}"),
                                                        onTap: () async {
                                                          BusyIndicator.show(
                                                              context);

                                                          List<BuscarTamboDto>
                                                              aTamboId =
                                                              await mainCtr.getDatosTamboGestor(
                                                                  oIndicadorAgua
                                                                          .idTambo
                                                                          .toString() ??
                                                                      '0');

                                                          BusyIndicator.hide(
                                                              context);

                                                          Navigator
                                                              .pushReplacement(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (BuildContext
                                                                      context) =>
                                                                  DetalleTambook(
                                                                      listTambo:
                                                                          aTamboId[
                                                                              0]),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                      const Divider(
                                                          color: colorI),
                                                    ],
                                                  );
                                                },
                                              ),
                                            ),
                                          );
                                        },
                                        dataSource: chartDataIndicador,
                                        xValueMapper:
                                            (ChartDataAvanceIndicador data,
                                                    _) =>
                                                data.x,
                                        yValueMapper:
                                            (ChartDataAvanceIndicador data,
                                                    _) =>
                                                data.y,
                                        // Width of the bars
                                        width: 0.9,
                                        // Spacing between the bars
                                        spacing: 0.2,
                                        dataLabelSettings:
                                            const DataLabelSettings(
                                                // Renders the data label
                                                isVisible: true,
                                                labelPosition:
                                                    ChartDataLabelPosition
                                                        .outside,
                                                textStyle:
                                                    TextStyle(fontSize: 17)))
                                  ])))
                      : const Center(child: CircularProgressIndicator()),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text('FUENTE: PNPAIS'),
                  Text("ACTUALIZADO AL ${fechaActual}"),
                  const SizedBox(
                    height: 1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding cardTambosSinIntervencion() {
    var heading = 'TAMBOS SIN INTERVENCIONES DEL AÑO $sCurrentYear';

    final List<ChartDataAvance> chartData1 = [];

    int totalTamboSinIter = 0;
    int totalTambo = int.parse(oTamboPias.tambos!);

    if (aSinIntervencion.isNotEmpty) {
      totalTamboSinIter = aSinIntervencion.length;
    }

    double totalPorcen1 = double.parse(((totalTamboSinIter / totalTambo) * 100)
        .toStringAsFixed(2)
        .replaceFirst(RegExp(r'\.?0*$'), ''));

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
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                      'ACTUALIZADO HASTA ${(aMetasMensualizada.isNotEmpty ? (obtenerNombreMesCompleto(aMetasMensualizada[aMetasMensualizada.length - 1].mes!)) : '')} DEL ${sCurrentYear}'),
                  const SizedBox(height: 15),
                  isLoadingSinInterAnio
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
                                "TOTAL : ",
                                style: TextStyle(fontSize: 15.0),
                                textAlign: TextAlign.right,
                              ),
                              Text(
                                formatoDecimal(totalTambo),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ]),
                            TableRow(children: [
                              const Text(
                                "SIN INTERVENCIONES : ",
                                style: TextStyle(fontSize: 15.0),
                                textAlign: TextAlign.right,
                              ),
                              Text(
                                formatoDecimal(totalTamboSinIter),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ]),
                          ],
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.blue,
                          ),
                          onPressed: () {
                            BusyIndicator.show(context);

                            BusyIndicator.hide(context);

                            showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  buildSuccessDialog2(
                                context,
                                title:
                                    "LISTA DE TAMBOS (${aSinIntervencion.length})",
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: aSinIntervencion.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    var oIndicadorInter =
                                        aSinIntervencion[index];
                                    return Column(
                                      children: [
                                        ListTile(
                                          leading: Text("${index + 1}"),
                                          title: Text(
                                            oIndicadorInter.nomTambo ?? '',
                                          ),
                                          subtitle:
                                              Text(oIndicadorInter.region!),
                                          onTap: () async {
                                            BusyIndicator.show(context);

                                            List<BuscarTamboDto> aTamboId =
                                                await mainCtr
                                                    .getDatosTamboGestor(
                                                        oIndicadorInter.idTambo
                                                                .toString() ??
                                                            '0');

                                            BusyIndicator.hide(context);

                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        DetalleTambook(
                                                            listTambo:
                                                                aTamboId[0]),
                                              ),
                                            );
                                          },
                                        ),
                                        const Divider(color: colorI),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                          child:
                              const Text('LISTA DE TAMBOS SIN INTERVENCIONES'),
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

  Padding cardTambosSinIntervencionMes() {
    var heading = 'TAMBOS SIN INTERVENCIONES DEL PRESENTE MES';

    final List<ChartDataAvance> chartData1 = [];

    int totalTamboSinIter = 0;
    int totalTambo = int.parse(oTamboPias.tambos!);

    if (aSinIntervencionMes.isNotEmpty) {
      totalTamboSinIter = aSinIntervencionMes.length;
    }

    double totalPorcen1 = double.parse(((totalTamboSinIter / totalTambo) * 100)
        .toStringAsFixed(2)
        .replaceFirst(RegExp(r'\.?0*$'), ''));

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
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  isLoadingSinInterMes
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
                                "TOTAL : ",
                                style: TextStyle(fontSize: 15.0),
                                textAlign: TextAlign.right,
                              ),
                              Text(
                                formatoDecimal(totalTambo),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ]),
                            TableRow(children: [
                              const Text(
                                "SIN INTERVECIONES : ",
                                style: TextStyle(fontSize: 15.0),
                                textAlign: TextAlign.right,
                              ),
                              Text(
                                formatoDecimal(totalTamboSinIter),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ]),
                          ],
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.blue,
                          ),
                          onPressed: () {
                            BusyIndicator.show(context);

                            BusyIndicator.hide(context);

                            showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  buildSuccessDialog2(
                                context,
                                title:
                                    "LISTA DE TAMBOS (${aSinIntervencionMes.length})",
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: aSinIntervencionMes.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    var oIndicadorInter =
                                        aSinIntervencionMes[index];
                                    return Column(
                                      children: [
                                        ListTile(
                                          leading: Text("${index + 1}"),
                                          title: Text(
                                            oIndicadorInter.nomTambo ?? '',
                                          ),
                                          subtitle:
                                              Text(oIndicadorInter.region!),
                                          onTap: () {},
                                        ),
                                        const Divider(color: colorI),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                          child:
                              const Text('LISTA DE TAMBOS SIN INTERVENCIONES'),
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

  Padding cardTambosSinIntervencionDet() {
    var heading = 'LISTA DE TAMBOS SIN INTERVENCIONES $sCurrentYear';

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
                title: Text(
                  heading,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              children: <Widget>[
                const Divider(color: colorI),
                Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (var oItem in aSinIntervencion)
                        Column(
                          children: [
                            ListTile(
                              iconColor: const Color.fromARGB(255, 0, 0, 0),
                              title: ListTile(
                                title: Text(
                                  oItem.nomTambo ?? '',
                                  textAlign: TextAlign.justify,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text("${oItem.region ?? ''}"),
                              ),
                            ),
                            const Divider(color: colorI),
                          ],
                        ),
                      const SizedBox(height: 10),
                      const Text('FUENTE: INEI - PAIS'),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Padding cardAtenciones() {
    int totalAvance1 = 0;
    if (aAtencionUsuarios.isNotEmpty) {
      totalAvance1 = int.parse(aAtencionUsuarios[0]!.atenciones ?? '0');
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
            const SizedBox(
              height: 10,
            ),
            Text(
                'ACTUALIZADO HASTA ${(aMetasMensualizada.isNotEmpty ? (obtenerNombreMesCompleto(aMetasMensualizada[aMetasMensualizada.length - 1].mes!)) : '')} DEL ${sCurrentYear}'),
            const SizedBox(
              height: 10,
            ),
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
                                formatoDecimal(totalMetaTipo1),
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
                                formatoDecimal(totalAvance1),
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
                                  formatoDecimal(totalBrecha1),
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
    if (aAtencionUsuarios.isNotEmpty) {
      totalAvance1 = int.parse(aAtencionUsuarios[0]!.usuuarios ?? '0');
    }
    final totalMetaTipo1 =
        aMetasTipo2.fold<int>(0, (sum, item) => sum + (item.metaTotal ?? 0));

    int totalBrecha1 = totalMetaTipo1 - totalAvance1;
    double totalPorcen1 = double.parse(((totalAvance1 / totalMetaTipo1) * 100)
        .toStringAsFixed(2)
        .replaceFirst(RegExp(r'\.?0*$'), ''));

    var heading = 'USUARIOS $sCurrentYear (USUARIOS ÚNICOS ACUMULADOS)';
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
            const SizedBox(
              height: 10,
            ),
            Text(
                'ACTUALIZADO HASTA ${(aMetasMensualizada.isNotEmpty ? (obtenerNombreMesCompleto(aMetasMensualizada[aMetasMensualizada.length - 1].mes!)) : '')} DEL ${sCurrentYear}'),
            const SizedBox(
              height: 10,
            ),
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
                                formatoDecimal(totalMetaTipo1),
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
                                formatoDecimal(totalAvance1),
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
                                  formatoDecimal(totalBrecha1),
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
 *            INFORMACIÓN DE ACTIVIDADES DIARIAS
 * -----------------------------------------------
 */
  Padding cardActividadesDiarias() {
    var heading = 'ACTIVIDADES DIARIAS DE LOS TAMBOS';
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
                title: Text(
                  heading,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
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
                        Text(
                          "FECHA DE ACTIVIDADES : ${fechaActividades}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Divider(
                          height: 10,
                        ),
                        if (aActividadesResumen.isNotEmpty)
                          Column(children: [
                            Row(
                              children: [
                                Container(
                                  width: 100,
                                  height: 120,
                                  child: Image.asset(
                                      "assets/regiones/MAPA_COSTA_SIERRA_SELVA.png",
                                      fit: BoxFit.cover),
                                ),
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "NACIONAL",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                      TextButton(
                                        style: TextButton.styleFrom(
                                          primary: Colors.black,
                                        ),
                                        onPressed: () {},
                                        child: Text(
                                            'CON ACTIVIDADES : ${aActividadesResumen.fold(0, (sum, item) => sum + int.parse(item.conActividades!))}'),
                                      ),
                                      TextButton(
                                        style: TextButton.styleFrom(
                                          primary: Colors.black,
                                        ),
                                        onPressed: () {},
                                        child: Text(
                                            'SIN ACTIVIDADES : ${aActividadesResumen.fold(0, (sum, item) => sum + int.parse(item.sinActividades!))}'),
                                      ),
                                    ]),
                              ],
                            ),
                            SizedBox(height: 10),
                            const Divider(color: colorI),
                          ]),
                        for (var tambos in aActividadesResumen)
                          Column(children: [
                            Row(
                              children: [
                                Container(
                                  width: 100,
                                  height: 120,
                                  child: Image.asset(
                                      "assets/regiones/${tambos.idUt}.png",
                                      fit: BoxFit.cover),
                                ),
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "U.T.: ${tambos.region ?? ''}",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                      TextButton(
                                        style: TextButton.styleFrom(
                                          primary: Colors.blue,
                                        ),
                                        onPressed: () async {
                                          BusyIndicator.show(context);

                                          List<ActividadesDiariasModel>
                                              aActividadesDiarias =
                                              await mainCtr
                                                  .getActividadesDiarias(
                                                      DateFormat("yyyy-MM-dd")
                                                          .format(currentDate!)
                                                          .toString(),
                                                      'Si',
                                                      tambos.idUt!,
                                                      '0');

                                          BusyIndicator.hide(context);

                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                buildSuccessDialog2(
                                              context,
                                              title:
                                                  "TAMBOS CON ACTIVIDADES\n${tambos.region!}\n(${aActividadesDiarias.length})",
                                              child: ListView.builder(
                                                shrinkWrap: true,
                                                itemCount:
                                                    aActividadesDiarias.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  var oActividadDiaria =
                                                      aActividadesDiarias[
                                                          index];
                                                  return Column(
                                                    children: [
                                                      ListTile(
                                                        dense: true,
                                                        contentPadding:
                                                            EdgeInsets.only(
                                                                left: 0.0,
                                                                right: 0.0),
                                                        leading: Text(
                                                            "${index + 1}"),
                                                        title: ListTile(
                                                          title: Text(
                                                            "TAMBO : ${oActividadDiaria.nomTambo ?? ''}",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          subtitle: Text(
                                                            "${oActividadDiaria.actividad ?? ''}",
                                                          ),
                                                        ),
                                                        subtitle: ListTile(
                                                          title: Text(
                                                              "LUGAR : ${oActividadDiaria.lugar!}\nTIPO DE INT. : ${oActividadDiaria.tipoIntervencion!}\nFECHA : ${oActividadDiaria.fechaActividad!}"),
                                                        ),
                                                        onTap: () async {
                                                          BusyIndicator.show(
                                                              context);

                                                          List<BuscarTamboDto>
                                                              aTamboId =
                                                              await mainCtr.getDatosTamboGestor(
                                                                  oActividadDiaria
                                                                          .idTambo
                                                                          .toString() ??
                                                                      '0');

                                                          BusyIndicator.hide(
                                                              context);

                                                          Navigator
                                                              .pushReplacement(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (BuildContext
                                                                      context) =>
                                                                  DetalleTambook(
                                                                      listTambo:
                                                                          aTamboId[
                                                                              0]),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                      const Divider(
                                                          color: colorI),
                                                    ],
                                                  );
                                                },
                                              ),
                                            ),
                                          );
                                        },
                                        child: Text(
                                            'CON ACTIVIDADES : ${tambos.conActividades}'),
                                      ),
                                      TextButton(
                                        style: TextButton.styleFrom(
                                          primary: Colors.blue,
                                        ),
                                        onPressed: () async {
                                          BusyIndicator.show(context);

                                          List<ActividadesDiariasModel>
                                              aActividadesDiarias =
                                              await mainCtr
                                                  .getActividadesDiarias(
                                                      DateFormat("yyyy-MM-dd")
                                                          .format(currentDate!)
                                                          .toString(),
                                                      'No',
                                                      tambos.idUt!,
                                                      '0');

                                          BusyIndicator.hide(context);

                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                buildSuccessDialog2(
                                              context,
                                              title:
                                                  "TAMBOS SIN ACTIVIDADES\n${tambos.region!}\n(${aActividadesDiarias.length})",
                                              child: ListView.builder(
                                                shrinkWrap: true,
                                                itemCount:
                                                    aActividadesDiarias.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  var oActividadDiaria =
                                                      aActividadesDiarias[
                                                          index];
                                                  return Column(
                                                    children: [
                                                      ListTile(
                                                        leading: Text(
                                                            "${index + 1}"),
                                                        title: Text(
                                                          "${oActividadDiaria.nomTambo ?? ''}",
                                                        ),
                                                        subtitle: Text(
                                                            "MOTIVO : ${oActividadDiaria.motivo!}\nFECHA : ${oActividadDiaria.fechaActividad!}"),
                                                        onTap: () async {
                                                          BusyIndicator.show(
                                                              context);

                                                          List<BuscarTamboDto>
                                                              aTamboId =
                                                              await mainCtr.getDatosTamboGestor(
                                                                  oActividadDiaria
                                                                          .idTambo
                                                                          .toString() ??
                                                                      '0');

                                                          BusyIndicator.hide(
                                                              context);

                                                          Navigator
                                                              .pushReplacement(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (BuildContext
                                                                      context) =>
                                                                  DetalleTambook(
                                                                      listTambo:
                                                                          aTamboId[
                                                                              0]),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                      const Divider(
                                                          color: colorI),
                                                    ],
                                                  );
                                                },
                                              ),
                                            ),
                                          );
                                        },
                                        child: Text(
                                            'SIN ACTIVIDADES : ${tambos.sinActividades}'),
                                      ),
                                    ]),
                              ],
                            ),
                            SizedBox(height: 10),
                            const Divider(color: colorI),
                          ]),
                        const SizedBox(height: 10),
                        const Text('FUENTE: PNPAIS'),
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

/*
 * -----------------------------------------------
 *            INFORMACIÓN DE TAMBOS POR REGIÓN
 * -----------------------------------------------
 */
  Padding cardTambosRegion() {
    var heading = 'TAMBOS POR UNIDAD TERRITORIAL Y SU POBLACIÓN OBJETIVO';
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
                title: Text(
                  heading,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
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
                        Column(
                          children: [
                            ListTile(
                              leading: SizedBox(
                                  height: 150.0,
                                  child: Image.asset(
                                      "assets/regiones/MAPA_COSTA_SIERRA_SELVA.png")),

                              // AssetImage("assets/regiones/AYACUCHO.png"),

                              iconColor: const Color.fromARGB(255, 0, 0, 0),
                              title: ListTile(
                                title: const Text(
                                  "NACIONAL",
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  "UT: ${aTambosRegion.length}\nDISTRITOS: ${aTambosRegion.fold(0, (sum, item) => sum + int.parse(item.distritos!))}\nCENTROS POBLADOS: ${formatoDecimal(aTambosRegion.fold(0, (sum, item) => sum + int.parse(item.cp!)))}\nPOBLACIÓN OBJETIVO: ${formatoDecimal(aTambosRegion.fold(0, (sum, item) => sum + double.parse(item.poblacion!).toInt()))}",
                                  textAlign: TextAlign.justify,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              trailing: IconButton(
                                icon: const Icon(Icons.download),
                                onPressed: () async {
                                  try {
                                    BusyIndicator.show(context);
                                    bool isConnec = await CheckConnection
                                        .isOnlineWifiMobile();
                                    if (isConnec) {
                                      RespBase64FileDto oB64 = await mainCtr
                                          .getReporteTambosPoblacion(
                                        '0',
                                      );
                                      Uint8List dataPdf =
                                          convertBase64(oB64.base64 ?? '');

                                      BusyIndicator.hide(context);
                                      _controller!.reverse();

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
                            ),
                            const Divider(color: colorI),
                          ],
                        ),
                        const SizedBox(height: 10),
                        for (var tambos in aTambosRegion)
                          Column(
                            children: [
                              ListTile(
                                leading: SizedBox(
                                    height: 150.0,
                                    child: Image.asset(
                                        "assets/regiones/${tambos.departamentoID}.png")),

                                // AssetImage("assets/regiones/AYACUCHO.png"),

                                iconColor: const Color.fromARGB(255, 0, 0, 0),
                                title: ListTile(
                                  title: Text(
                                    tambos.nombre ?? '',
                                    textAlign: TextAlign.justify,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    "TAMBOS EN SERVICIO: ${tambos.cantidad}\nCENTROS POBLADOS: ${formatoDecimal((double.tryParse(tambos.cp!) ?? 0).toInt())}\nDISTRITOS: ${formatoDecimal((double.tryParse(tambos.distritos!) ?? 0).toInt())}\nPOBLACIÓN OBJETIVO: ${formatoDecimal(double.parse(tambos.poblacion ?? '0').toInt())}",
                                    textAlign: TextAlign.justify,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                trailing: IconButton(
                                  icon: const Icon(Icons.download),
                                  onPressed: () async {
                                    try {
                                      BusyIndicator.show(context);
                                      bool isConnec = await CheckConnection
                                          .isOnlineWifiMobile();
                                      if (isConnec) {
                                        RespBase64FileDto oB64 = await mainCtr
                                            .getReporteTambosPoblacion(
                                          tambos.departamentoID!,
                                        );
                                        Uint8List dataPdf =
                                            convertBase64(oB64.base64 ?? '');

                                        BusyIndicator.hide(context);
                                        _controller!.reverse();

                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                PdfPreviewPage2(
                                                    dataPdf: dataPdf),
                                          ),
                                        );
                                        return;
                                      } else {}
                                    } catch (oError) {}
                                    BusyIndicator.hide(context);
                                  },
                                ),
                              ),
                              const Divider(color: colorI),
                            ],
                          ),
                        const SizedBox(height: 10),
                        const Text('FUENTE: INEI - PAIS'),
                        Text("ACTUALIZADO AL ${fechaActual}"),
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

  /*
 * -----------------------------------------------
 *            INFORMACIÓN RESUMEN DE EQUIPOS INFORMÁTICOS
 * -----------------------------------------------
 */
  Padding cardResumenEquipos() {
    var heading = 'ESTADO DE EQUIPOS INFORMÁTICOS';
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
                title: Text(
                  heading,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
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
                        for (var equipo in aequiposResumen)
                          Column(
                            children: [
                              Text(
                                equipo.equipo ?? '',
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w700,
                                  decoration: TextDecoration.underline,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              ListTile(
                                leading: ImageIcon(
                                  AssetImage(equipo!.imagen),
                                  size: 120,
                                  color: Colors.black,
                                ),
                                iconColor: const Color.fromARGB(255, 0, 0, 0),
                                title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "BUENO: ${formatoDecimal(equipo.bueno)}\nREGULAR: ${formatoDecimal(equipo.regular)}\nMALO: ${formatoDecimal(equipo.malo)}",
                                        textAlign: TextAlign.justify,
                                        style: const TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                          "TOTAL: ${formatoDecimal(equipo.total)}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w900))
                                    ]),
                              ),
                              const Divider(color: colorI),
                            ],
                          ),
                        const SizedBox(height: 10),
                        const Text("FUENTE: PNPAIS"),
                        Text("ACTUALIZADO AL ${fechaActual}"),
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

  Padding cardEstadoTambo() {
    var heading = 'ESTADO DE LOS TAMBOS';
    late ValueNotifier<double> valueNotifier3 = ValueNotifier(50);
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
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SfCircularChart(
                    margin: EdgeInsets.zero,
                    title: ChartTitle(
                        text: '491 TAMBOS',
                        textStyle:
                            const TextStyle(fontWeight: FontWeight.bold)),
                    legend: Legend(
                      isVisible: true,
                      position: LegendPosition.bottom,
                      orientation: LegendItemOrientation.horizontal,
                      overflowMode: LegendItemOverflowMode.wrap,
                      textStyle: const TextStyle(
                        color: color_07,
                      ),
                    ),
                    onLegendTapped: (LegendTapArgs args) {
                      //print(args.pointIndex);
                    },
                    series: [
                      PieSeries<ChartData, String>(
                        dataSource: chartData,
                        pointColorMapper: (ChartData data, _) => data.color,
                        xValueMapper: (ChartData data, _) => data.x,
                        yValueMapper: (ChartData data, _) => data.y,
                        dataLabelSettings: const DataLabelSettings(
                          isVisible: true,
                          labelAlignment: ChartDataLabelAlignment.top,
                          margin: EdgeInsets.all(1),
                        ),
                        name: 'Data',
                        //explode: true,
                        //explodeIndex: 1,
                        radius: '80%',
                        onPointTap: (ChartPointDetails details) async {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding avanceMetas() {
    var heading = 'EVOLUCIÓN DE LA EJECUCIÓN DE LAS ATENCIONES $sCurrentYear';

    final List<ChartDataAvance> chartData1 = [];

    for (var meta in aMetasMensualizada) {
      chartData1.add(ChartDataAvance(
          obtenerNombreMes(meta.mes!),
          double.parse(meta.atencionesProgramadas!),
          double.parse(meta.atencionesEjecutadas!)));
    }

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
            const SizedBox(height: 10),
            isLoadingAtencionMensualizada == true
                ? Text(
                    'ACTUALIZADO HASTA ${(aMetasMensualizada.isNotEmpty ? (obtenerNombreMesCompleto(aMetasMensualizada[aMetasMensualizada.length - 1].mes!)) : '')} DEL ${sCurrentYear}')
                : const Text(""),
            const SizedBox(height: 10),
            Container(
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  isLoadingAtencionMensualizada == true
                      ? SfCartesianChart(
                          plotAreaBorderWidth: 0,
                          legend: Legend(
                              isVisible: true,
                              position: LegendPosition.bottom,
                              overflowMode: LegendItemOverflowMode.wrap),
                          primaryXAxis: CategoryAxis(
                              visibleMinimum: 1,
                              interval: 1,
                              labelIntersectAction:
                                  AxisLabelIntersectAction.multipleRows,
                              edgeLabelPlacement: EdgeLabelPlacement.shift,
                              autoScrollingMode: AutoScrollingMode.end,
                              visibleMaximum: 3),
                          zoomPanBehavior: ZoomPanBehavior(
                            enablePanning: true,
                          ),
                          primaryYAxis: NumericAxis(
                            edgeLabelPlacement: EdgeLabelPlacement.shift,
                            numberFormat: NumberFormat.decimalPattern(),
                          ),
                          series: <CartesianSeries>[
                            // Renders line chart

                            ColumnSeries<ChartDataAvance, String>(
                                name: 'META FÍSICA',
                                dataSource: chartData1,
                                dataLabelSettings: const DataLabelSettings(
                                  isVisible: true,
                                ),
                                xValueMapper: (ChartDataAvance data, _) =>
                                    data.x,
                                yValueMapper: (ChartDataAvance data, _) =>
                                    data.y),
                            ColumnSeries<ChartDataAvance, String>(
                                name: 'EJECUCIÓN FÍSICA',
                                dataSource: chartData1,
                                dataLabelSettings:
                                    const DataLabelSettings(isVisible: true),
                                xValueMapper: (ChartDataAvance data, _) =>
                                    data.x,
                                yValueMapper: (ChartDataAvance data, _) =>
                                    data.y1),
                          ],
                          tooltipBehavior: TooltipBehavior(enable: true),
                        )
                      : const Center(child: CircularProgressIndicator()),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text('FUENTE: PNPAIS'),
                  const SizedBox(
                    height: 1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding avanceMetasUsuarios() {
    var heading =
        'EVOLUCIÓN DE LA EJECUCIÓN DE USUARIOS - $sCurrentYear (USUARIOS ÚNICOS ACUMULADOS)';

    final List<ChartDataAvance> chartData1 = [];

    for (var meta in aMetasMensualizada) {
      chartData1.add(ChartDataAvance(
          obtenerNombreMes(meta.mes!),
          double.parse(meta.usuariosProgramados!),
          double.parse(meta.usuariosAtendidos!)));
    }

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
            const SizedBox(height: 10),
            isLoadingAtencionMensualizada
                ? Text(
                    'ACTUALIZADO HASTA ${(aMetasMensualizada.isNotEmpty ? (obtenerNombreMesCompleto(aMetasMensualizada[aMetasMensualizada.length - 1].mes!)) : '')} DEL ${sCurrentYear}')
                : const Text(""),
            const SizedBox(height: 10),
            Container(
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  isLoadingAtencionMensualizada
                      ? SfCartesianChart(
                          plotAreaBorderWidth: 0,
                          legend: Legend(
                              isVisible: true,
                              position: LegendPosition.bottom,
                              overflowMode: LegendItemOverflowMode.wrap),
                          primaryXAxis: CategoryAxis(
                              visibleMinimum: 1,
                              interval: 1,
                              labelIntersectAction:
                                  AxisLabelIntersectAction.multipleRows,
                              edgeLabelPlacement: EdgeLabelPlacement.shift,
                              autoScrollingMode: AutoScrollingMode.end,
                              visibleMaximum: 3),
                          zoomPanBehavior: ZoomPanBehavior(
                            enablePanning: true,
                          ),
                          primaryYAxis: NumericAxis(
                            edgeLabelPlacement: EdgeLabelPlacement.shift,
                            numberFormat: NumberFormat.decimalPattern(),
                          ),
                          series: <CartesianSeries>[
                            ColumnSeries<ChartDataAvance, String>(
                                animationDuration: 2500,
                                name: 'META FÍSICA',
                                dataSource: chartData1,
                                dataLabelSettings:
                                    const DataLabelSettings(isVisible: true),
                                xValueMapper: (ChartDataAvance data, _) =>
                                    data.x,
                                yValueMapper: (ChartDataAvance data, _) =>
                                    data.y),
                            ColumnSeries<ChartDataAvance, String>(
                                animationDuration: 2500,
                                name: 'EJECUCIÓN FÍSICA',
                                dataSource: chartData1,
                                dataLabelSettings:
                                    const DataLabelSettings(isVisible: true),
                                xValueMapper: (ChartDataAvance data, _) =>
                                    data.x,
                                yValueMapper: (ChartDataAvance data, _) =>
                                    data.y1),
                          ],
                          tooltipBehavior: TooltipBehavior(enable: true),
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
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
            ),
          ],
        ),
      ),
    );
  }

/*
 * -----------------------------------------------
 *            TAMBOS
 * -----------------------------------------------
 */
  Padding cardTambos() {
    var heading = 'PLATAFORMAS';
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.white,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 5), // changes position of shadow
              ),
            ],
            color: Colors.white),
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
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Column(
                          children: <Widget>[
                            const Text(
                              'PRESTA SERVICIO',
                              style: TextStyle(fontSize: 10.0),
                            ),
                            Container(
                              margin: const EdgeInsets.all(5),
                              padding: const EdgeInsets.all(5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: const <Widget>[
                                  Icon(
                                    color: color_01,
                                    Icons.home_outlined,
                                  ),
                                  Text(
                                    '488',
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Column(
                          children: <Widget>[
                            const Text(
                              'EN CONSTRUCCIÓN',
                              style: TextStyle(fontSize: 10.0),
                            ),
                            Container(
                              margin: const EdgeInsets.all(5),
                              padding: const EdgeInsets.all(5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: const <Widget>[
                                  Icon(
                                    color: color_01,
                                    Icons.home_outlined,
                                  ),
                                  Text(
                                    '11',
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Column(
                          children: <Widget>[
                            const Text(
                              'RECEPCIONADO',
                              style: TextStyle(fontSize: 10.0),
                            ),
                            Container(
                              margin: const EdgeInsets.all(5),
                              padding: const EdgeInsets.all(5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: const <Widget>[
                                  Icon(
                                    color: color_01,
                                    Icons.home_outlined,
                                  ),
                                  Text(
                                    '2',
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      /*Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Column(
                          children: <Widget>[
                            const Text(
                              '3',
                              style: TextStyle(fontSize: 20.0),
                            ),
                            const Text(
                              'BAP EN SERVICIO',
                              style: TextStyle(fontSize: 10.0),
                            ),
                            const Text(""),
                            Container(
                              margin: const EdgeInsets.all(5),
                              padding: const EdgeInsets.all(5),
                              child: const Icon(
                                color: color_01,
                                Icons.directions_boat_outlined,
                              ),
                            ),
                          ],
                        ),
                      ),*/
                      Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Column(
                                  children: const <Widget>[
                                    Text(
                                      '13',
                                      style: TextStyle(fontSize: 20.0),
                                    ),
                                    Text(
                                      'PIAS OPERANDO',
                                      style: TextStyle(fontSize: 10.0),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 35,
                              ),
                              /*Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Column(
                                  children: const <Widget>[
                                    Text(
                                      '5',
                                      style: TextStyle(fontSize: 20.0),
                                    ),
                                    Text(
                                      'PIAS OPERANDO',
                                      style: TextStyle(fontSize: 10.0),
                                    ),
                                  ],
                                ),
                              ),*/
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Column(
                                  children: const <Widget>[
                                    Text(
                                      '2',
                                      style: TextStyle(fontSize: 20.0),
                                    ),
                                    Text(
                                      'EN CONSTRUCCIÓN',
                                      style: TextStyle(fontSize: 10.0),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const Text(
                            '''|__________________|''',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Color.fromRGBO(155, 155, 155, 1.0),
                            ),
                          ),
                          const Text(
                            '|',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Color.fromRGBO(155, 155, 155, 1.0),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const <Widget>[
                              Text(
                                "PIAS",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
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
  *            PERSONAL
  * -----------------------------------------------
  */
  Padding cardPersonal() {
    var heading = 'PERSONAL';
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
              padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: colorI,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const <Widget>[
                                Text(
                                  "REGION",
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Column(
                                    children: const <Widget>[
                                      Text(
                                        'JEFE UNIDAD TERRITORIAL (17)',
                                        style: TextStyle(fontSize: 12.0),
                                      ),
                                    ],
                                  ),
                                ),
                                const Text(
                                  ' | ',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: Color.fromRGBO(155, 155, 155, 1.0),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Column(
                                    children: const <Widget>[
                                      Text(
                                        'MONITOR (28)',
                                        style: TextStyle(fontSize: 12.0),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Divider(color: colorI),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const <Widget>[
                                Text(
                                  "TAMBOS PIAS Y UPS",
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Column(
                                    children: const <Widget>[
                                      Text(
                                        'GESTOR (487)',
                                        style: TextStyle(fontSize: 12.0),
                                      ),
                                    ],
                                  ),
                                ),
                                const Text(
                                  ' | ',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: Color.fromRGBO(155, 155, 155, 1.0),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Column(
                                    children: const <Widget>[
                                      Text(
                                        'GUARDIÁN (487)',
                                        style: TextStyle(fontSize: 12.0),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
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
  *            EQUIPAMIENTO
  * -----------------------------------------------
  */
  Padding cardEquipamiento() {
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
    );
    var heading = 'EQUIPAMIENTO';
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
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ButtonBar(
                    alignment: MainAxisAlignment.spaceAround,
                    buttonHeight: 52.0,
                    buttonMinWidth: 90.0,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {},
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: TextButton(
                            style: flatButtonStyle,
                            onPressed: () {},
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin: const EdgeInsets.all(5),
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                      width: 2,
                                      color: color_01,
                                    ),
                                  ),
                                  child: const Icon(
                                    color: color_01,
                                    Icons.tv,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2.0),
                                ),
                                const Text(
                                  'SALA DE TV',
                                  style: TextStyle(
                                    color: color_01,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: TextButton(
                            style: flatButtonStyle,
                            onPressed: () {},
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin: const EdgeInsets.all(5),
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                      width: 2,
                                      color: color_01,
                                    ),
                                  ),
                                  child: const Icon(
                                    color: color_01,
                                    Icons.desk,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2.0),
                                ),
                                const Text(
                                  'OFICINA',
                                  style: TextStyle(
                                    color: color_01,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: TextButton(
                            style: flatButtonStyle,
                            onPressed: () {},
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin: const EdgeInsets.all(5),
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                      width: 2,
                                      color: color_01,
                                    ),
                                  ),
                                  child: const Icon(
                                    color: color_01,
                                    Icons.kitchen_outlined,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2.0),
                                ),
                                const Text(
                                  'COMEDOR',
                                  style: TextStyle(
                                    color: color_01,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.spaceAround,
                    buttonHeight: 52.0,
                    buttonMinWidth: 90.0,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {},
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: TextButton(
                            style: flatButtonStyle,
                            onPressed: () {},
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin: const EdgeInsets.all(5),
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                      width: 2,
                                      color: color_01,
                                    ),
                                  ),
                                  child: const Icon(
                                    color: color_01,
                                    Icons.local_hospital_outlined,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2.0),
                                ),
                                const Text(
                                  'TOPICO',
                                  style: TextStyle(
                                    color: color_01,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: TextButton(
                            style: flatButtonStyle,
                            onPressed: () {},
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin: const EdgeInsets.all(5),
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                      width: 2,
                                      color: color_01,
                                    ),
                                  ),
                                  child: const Icon(
                                    color: color_01,
                                    Icons.wifi,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2.0),
                                ),
                                const Text(
                                  'INTERNET',
                                  style: TextStyle(
                                    color: color_01,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: TextButton(
                            style: flatButtonStyle,
                            onPressed: () {},
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin: const EdgeInsets.all(5),
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                      width: 2,
                                      color: color_01,
                                    ),
                                  ),
                                  child: const Icon(
                                    color: color_01,
                                    Icons.bed,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2.0),
                                ),
                                const Text(
                                  'COMEDOR',
                                  style: TextStyle(
                                    color: color_01,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
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
  *            PARQUE INFORMATICO
  * -----------------------------------------------
  */
  Padding cardEquipoTecnologico() {
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
    );
    var heading = 'PARQUE INFORMÁTICO';
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: colorI,
          ),
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
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
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ButtonBar(
                    alignment: MainAxisAlignment.spaceAround,
                    buttonHeight: 52.0,
                    buttonMinWidth: 90.0,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {},
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: TextButton(
                            style: flatButtonStyle,
                            onPressed: () {},
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin: const EdgeInsets.all(5),
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                      width: 2,
                                      color: color_01,
                                    ),
                                  ),
                                  child: const Icon(
                                    color: color_01,
                                    Icons.desktop_mac_outlined,
                                    size: 45,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2.0),
                                ),
                                const Text(
                                  'PC (224)',
                                  style: TextStyle(
                                    color: color_01,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: TextButton(
                            style: flatButtonStyle,
                            onPressed: () {},
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin: const EdgeInsets.all(5),
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                      width: 2,
                                      color: color_01,
                                    ),
                                  ),
                                  child: const Icon(
                                    color: color_01,
                                    Icons.laptop,
                                    size: 45,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2.0),
                                ),
                                const Text(
                                  'LAPTOP (1047)',
                                  style: TextStyle(
                                    color: color_01,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.spaceAround,
                    buttonHeight: 52.0,
                    buttonMinWidth: 90.0,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {},
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: TextButton(
                            style: flatButtonStyle,
                            onPressed: () {},
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin: const EdgeInsets.all(5),
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                      width: 2,
                                      color: color_01,
                                    ),
                                  ),
                                  child: const Icon(
                                    color: color_01,
                                    Icons.photo_camera_front,
                                    size: 45,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2.0),
                                ),
                                const Text(
                                  'PROYECTOR (572)',
                                  style: TextStyle(
                                    color: color_01,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: TextButton(
                            style: flatButtonStyle,
                            onPressed: () {},
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin: const EdgeInsets.all(5),
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                      width: 2,
                                      color: color_01,
                                    ),
                                  ),
                                  child: const Icon(
                                    color: color_01,
                                    Icons.wifi,
                                    size: 45,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2.0),
                                ),
                                const Text(
                                  'ANTENA WIFI (0)',
                                  style: TextStyle(
                                    color: color_01,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.spaceAround,
                    buttonHeight: 52.0,
                    buttonMinWidth: 90.0,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {},
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: TextButton(
                            style: flatButtonStyle,
                            onPressed: () {},
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin: const EdgeInsets.all(5),
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                      width: 2,
                                      color: color_01,
                                    ),
                                  ),
                                  child: const Icon(
                                    color: color_01,
                                    Icons.print_outlined,
                                    size: 45,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2.0),
                                ),
                                const Text(
                                  'IMPRESORAS (669)',
                                  style: TextStyle(
                                    color: color_01,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSuccessDialog2(
    BuildContext context, {
    String? title,
    String? subTitle,
    Widget? child,
  }) {
    return AlertDialog(
      title: Text(
        title!,
        textAlign: TextAlign.center,
      ),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      actions: const <Widget>[],
      content: SingleChildScrollView(
        child: Container(
          alignment: Alignment.centerLeft,
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

  Widget dialogCategorizacion(
    BuildContext context, {
    String? title,
    String? subTitle,
    String? idCategoria,
    Widget? child,
  }) {
    return AlertDialog(
      title: Text(
        title!,
        textAlign: TextAlign.center,
      ),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      actions: const <Widget>[],
      content: SingleChildScrollView(
        child: Container(
          alignment: Alignment.centerLeft,
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.download),
                onPressed: () async {
                  try {
                    BusyIndicator.show(context);
                    bool isConnec = await CheckConnection.isOnlineWifiMobile();
                    if (isConnec) {
                      RespBase64FileDto oB64 =
                          await mainCtr.getReporteCategorizacion(
                        idCategoria!,
                      );
                      Uint8List dataPdf = convertBase64(oB64.base64 ?? '');

                      BusyIndicator.hide(context);
                      _controller!.reverse();

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
                          Text(
                            subTitle ?? '',
                            maxLines: null,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: color_01,
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              height: 1.43,
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

  SizedBox Box01(String text1, String text2, String icon) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.25,
      width: 180,
      child: Card(
        color: const Color(0xfffaf5f5),
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.16,
              color: colorGB,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    text1,
                    style: const TextStyle(
                      fontFamily: 'Karla',
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff54c19f),
                    ),
                  ),
                  Text(
                    text2,
                    style: const TextStyle(
                      fontFamily: 'Karla',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff75777d),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              color: Colors.transparent,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(top: 7),
              child: Image.asset(
                //'assets/icons/tambos.png',
                'assets/icons/$icon',
                width: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container Box2() {
    return Container(
      padding: const EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 10.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                width: 100.0,
                height: 100.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.purple),
                ),
                child: const Center(
                  child: Text(
                    "PJ",
                    style: TextStyle(fontSize: 40.0),
                  ),
                ),
              ),
              Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: const <Widget>[
                            Text(
                              '100',
                              style: TextStyle(fontSize: 20.0),
                            ),
                            Text('Followers'),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: const <Widget>[
                            Text(
                              '100',
                              style: TextStyle(fontSize: 20.0),
                            ),
                            Text('Following'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const <Widget>[
                      Text(
                        "Peter Jonathan",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  Row(
                    children: const <Widget>[
                      Text(
                        "@pj",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontStyle: FontStyle.italic,
                          color: Color.fromRGBO(155, 155, 155, 1.0),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Uint8List convertBase64(String base64String) {
    return const Base64Decoder().convert(base64String.split(',').last);
  }

  String formatoDecimal(int numero) {
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
        nombreMes = "ENE";
        break;

      case "2":
        nombreMes = "FEB";
        break;

      case "3":
        nombreMes = "MAR";
        break;

      case "4":
        nombreMes = "ABR";
        break;

      case "5":
        nombreMes = "MAY";
        break;

      case "6":
        nombreMes = "JUN";
        break;

      case "7":
        nombreMes = "JUL";
        break;

      case "8":
        nombreMes = "AGO";
        break;

      case "9":
        nombreMes = "SET";
        break;

      case "10":
        nombreMes = "OCT";
        break;

      case "11":
        nombreMes = "NOV";
        break;

      case "12":
        nombreMes = "DIC";
        break;

      default:
        nombreMes = "SIN MES ASIGNADO";
        break;
    }
    return nombreMes;
  }

  Color obtenerColores(String id) {
    Color color = Colors.blue;
    switch (id) {
      case "1":
        color = Colors.blue;
        break;

      case "2":
        color = Colors.green;
        break;

      case "3":
        color = Colors.red;
        break;

      case "007":
        color = Colors.red;
        break;

      case "008":
        color = Colors.green;
        break;

      case "012":
        color = Colors.yellow;
        break;
    }
    return color;
  }
}

class AvancesData {
  AvancesData(this.mes, this.avanceAtenciones, this.avanceUsuarios);
  final String mes;
  final double avanceAtenciones;
  final double avanceUsuarios;
}

class ShinyWidgetImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade400,
      highlightColor: Colors.grey.shade200,
      child: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
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

class ShinyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade400,
      highlightColor: Colors.grey.shade200,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                // Container 1
                Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            // Container 2
                            child: Container(
                              height: 10,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(90),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            // Container 3
                            child: Container(
                              height: 10,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(90),
                              ),
                            ),
                          ),
                          const SizedBox(width: 30),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ChartDataAvance {
  ChartDataAvance(this.x, this.y, this.y1);
  final String x;
  final double? y;
  final double? y1;
}

class ChartDataAvanceIndicador {
  ChartDataAvanceIndicador(this.id, this.x, this.y, this.color);
  final String id;
  final String x;
  final int y;
  final Color? color;
}

class ChartDataPie {
  ChartDataPie(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}

class ResumenParqueDataSource extends DataGridSource {
  ResumenParqueDataSource({required List<ResumenParqueInformatico> parque}) {
    dataGridRows = parque
        .map<DataGridRow>((dataGridRow) => DataGridRow(cells: [
              DataGridCell<String>(
                  columnName: 'equipo', value: dataGridRow.descripcion),
              DataGridCell<String>(
                  columnName: 'estado', value: dataGridRow.estado),
              DataGridCell<int>(
                  columnName: 'cantidad', value: dataGridRow.cantidad),
            ]))
        .toList();
  }

  List<DataGridRow> dataGridRows = [];

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
          alignment: (dataGridCell.columnName == 'id' ||
                  dataGridCell.columnName == 'cantidad')
              ? Alignment.center
              : Alignment.centerLeft,
          width: (dataGridCell.columnName == 'equipo') ? 400 : 100,
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Text(
            dataGridCell.value.toString(),
            overflow: TextOverflow.clip,
          ));
    }).toList());
  }
}

class EquiposInformaticosResumen {
  String equipo;
  int total;
  int bueno;
  int regular;
  int malo;
  int baja;
  String imagen;
  EquiposInformaticosResumen(this.equipo, this.total, this.bueno, this.regular,
      this.malo, this.baja, this.imagen);
}
