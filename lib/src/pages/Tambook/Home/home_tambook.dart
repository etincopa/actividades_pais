import 'package:actividades_pais/backend/controller/main_controller.dart';
import 'package:actividades_pais/backend/model/atencion_intervencion_beneficiario_resumen_model.dart';
import 'package:actividades_pais/backend/model/atenciones_model.dart';
import 'package:actividades_pais/backend/model/avance_metas.dart';
import 'package:actividades_pais/backend/model/lista_equipamiento_informatico.dart';
import 'package:actividades_pais/backend/model/listar_informacion_tambos.dart';
import 'package:actividades_pais/backend/model/obtener_metas_tambo_model.dart';
import 'package:actividades_pais/backend/model/personal_puesto_model.dart';
import 'package:actividades_pais/backend/model/programacion_intervenciones_tambos_model.dart';
import 'package:actividades_pais/src/pages/SeguimientoParqueInform%C3%A1tico/Reportes/ReporteEquipoInfomatico.dart';
import 'package:actividades_pais/util/Constants.dart';
import 'package:actividades_pais/util/home_options.dart';
import 'package:actividades_pais/util/responsive.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:shimmer/shimmer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:intl/intl.dart';

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
  bool isLoadingEI = true;
  bool isLoadingEquipos = false;

  late String numTambos = "";

  List<ProgIntervencionTamboModel> aAvance = [];
  List<AtenInterBeneResumenModel> aAtenInterBene = [];
  List<MetasTamboModel> aMetasTipo1 = [];
  List<MetasTamboModel> aMetasTipo2 = [];
  List<AtencionesModel> aAtencionResumen = [];
  List<AvanceMetasModel> aMetasMensualizada = [];

  String sCurrentYear = DateTime.now().year.toString();

  List<HomeOptions> aEquipoInformatico = [];
  List<HomeOptions> aPersonalTambo = [];
  List<HomeOptions> aPlataforma = [];
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
    buildPersonalTambo();
    buildData();
    obtenerAvanceMetasPorMes();
    getMetasGeneral();
    getProgIntervencionTambo();

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
        name: '2',
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
        name3: '488 Prestando Servicio',
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
        name: '13',
        name2: 'PIAS operando',
        name3: 'assets/icons/embarcacion.png',
      ),
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
        name3: '13 Prestando Servicio',
        asubOption: aSubOptionPias,
        image: icon2,
        color: Colors.white,
      ),
    );
  }

  Future<void> buildPersonalTambo() async {
    List<PersonalPuestoModel> aPersonal = await mainCtr.getPersonalPuesto();

    String icon1 = 'assets/icons/persona1.png';
    String icon2 = 'assets/icons/persona2.png';
    String icon3 = 'assets/icons/persona3.png';
    String icon4 = 'assets/icons/persona2.png';

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
    aPersonalTambo.add(
      HomeOptions(
        code: 'OPT3003',
        name: 'GESTORES \nTAMBOS -PIAS',
        name2: aPersonal[0].git.toString() ?? '0',
        types: const ['Ver'],
        image: icon3,
        color: Colors.white,
      ),
    );

    aPersonalTambo.add(
      HomeOptions(
          code: 'OPT3004',
          name: 'GUARDIANES \nTAMBOS - PIAS',
          name2: aPersonal[0].gu.toString() ?? '0',
          types: const ['Ver'],
          image: icon4,
          color: Colors.white),
    );

    aPersonalTambo.add(
      HomeOptions(
          code: 'OPT3004',
          name: 'SOPORTE \n TÉCNICO',
          name2: aPersonal[0].st.toString() ?? '0',
          types: const ['Ver'],
          image: icon4,
          color: Colors.white),
    );
  }

  Future<void> buildEquipoInformatico() async {
    List<EquipamientoInformaticoModel> aEquipos =
        await mainCtr.getEquipamientoInformatico("0");

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
        title: 'BENEFICIARIOS $sCurrentYear',
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
    aMetasMensualizada = await mainCtr.getAvanceMetasMensualizada(sCurrentYear);
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
      length: 4,
      child: Scaffold(
          backgroundColor: color_10o15,
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
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
                          tabs: [
                            Tab(
                              icon: ImageIcon(
                                AssetImage('assets/logros.png'),
                                size: 60,
                              ),
                            ),
                            Tab(
                              icon: ImageIcon(
                                AssetImage('assets/PLATAFORMAS.png'),
                                size: 60,
                              ),
                            ),
                            Tab(
                              icon: ImageIcon(
                                AssetImage('assets/personal.png'),
                                size: 60,
                              ),
                            ),
                            Tab(
                              icon: ImageIcon(
                                AssetImage('assets/equipos.png'),
                                size: 60,
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
                SingleChildScrollView(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 15),
                    cardAtenciones(),
                    cardBeneficiarios(),
                    avanceMetas(),
                    avanceMetasUsuarios(),
                  ],
                )),
                SingleChildScrollView(
                    child: Column(
                  children: [
                    const SizedBox(height: 15),
                    cardPlataforma(),
                  ],
                )),
                SingleChildScrollView(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 15),
                    cardPersonalTambo(),
                  ],
                )),
                SingleChildScrollView(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 15),
                    cardEquipamientoTecnologico(),
                  ],
                )),
              ],
            ),
          )),
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
                                        text: '${homeOption.name!}',
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
                //  var oHomeOptionSelect = aHomeOptions[index];
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
      child: SizedBox(
          height: 550.0,
          child: FutureBuilder(
              future: buildEquipoInformatico(),
              builder: (context, snapshot) {
                if (aEquipoInformatico.isNotEmpty) {
                  return GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
                      HomeOptions homeOption = aEquipoInformatico[index];
                      return InkWell(
                        splashColor: Colors.white10,
                        highlightColor: Colors.white10,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: const DecorationImage(
                              image:
                                  AssetImage("assets/icons/botones 1-02.png"),
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
                          //  var oHomeOptionSelect = aHomeOptions[index];
                        },
                      );
                    },
                  );
                }
                return const Center(child: CircularProgressIndicator());
              })),
    );
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
                                "Meta :",
                                style: TextStyle(fontSize: 15.0),
                                textAlign: TextAlign.right,
                              ),
                              Text(
                                '${formatoDecimal(totalMetaTipo1)}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ]),
                            TableRow(children: [
                              const Text(
                                "Avance :",
                                style: TextStyle(fontSize: 15.0),
                                textAlign: TextAlign.right,
                              ),
                              Text(
                                '${formatoDecimal(totalAvance1)}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ]),
                            TableRow(
                              children: [
                                const Text(
                                  "Brecha :",
                                  style: TextStyle(fontSize: 15.0),
                                  textAlign: TextAlign.right,
                                ),
                                Text(
                                  '${formatoDecimal(totalBrecha1)}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
                'ACTUALIZADO AL MES DE ${(aMetasMensualizada.isNotEmpty ? (obtenerNombreMesCompleto(aMetasMensualizada[aMetasMensualizada.length - 1].mes!)) : '')}')
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

    var heading = 'BENEFICIARIOS $sCurrentYear';
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
                                "Meta :",
                                style: TextStyle(fontSize: 15.0),
                                textAlign: TextAlign.right,
                              ),
                              Text(
                                '${formatoDecimal(totalMetaTipo1)}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ]),
                            TableRow(children: [
                              const Text(
                                "Avance :",
                                style: TextStyle(fontSize: 15.0),
                                textAlign: TextAlign.right,
                              ),
                              Text(
                                '${formatoDecimal(totalAvance1)}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ]),
                            TableRow(
                              children: [
                                const Text(
                                  "Brecha :",
                                  style: TextStyle(fontSize: 15.0),
                                  textAlign: TextAlign.right,
                                ),
                                Text(
                                  '${formatoDecimal(totalBrecha1)}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
                'ACTUALIZADO AL MES DE ${(aMetasMensualizada.isNotEmpty ? (obtenerNombreMesCompleto(aMetasMensualizada[aMetasMensualizada.length - 1].mes!)) : '')}')
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
    var heading = 'METAS ATENCIONES 2023';

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
            Container(
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SfCartesianChart(
                    plotAreaBorderWidth: 0,
                    legend: Legend(
                        isVisible: true,
                        position: LegendPosition.bottom,
                        overflowMode: LegendItemOverflowMode.wrap),
                    primaryXAxis: CategoryAxis(),
                    series: <CartesianSeries>[
                      // Renders line chart

                      ColumnSeries<ChartDataAvance, String>(
                          name: 'Programado',
                          dataSource: chartData1,
                          dataLabelSettings:
                              const DataLabelSettings(isVisible: true),
                          xValueMapper: (ChartDataAvance data, _) => data.x,
                          yValueMapper: (ChartDataAvance data, _) => data.y),
                      ColumnSeries<ChartDataAvance, String>(
                          name: 'Ejecutado',
                          dataSource: chartData1,
                          dataLabelSettings:
                              const DataLabelSettings(isVisible: true),
                          xValueMapper: (ChartDataAvance data, _) => data.x,
                          yValueMapper: (ChartDataAvance data, _) => data.y1),
                    ],
                    tooltipBehavior: TooltipBehavior(enable: true),
                  ),
                  Text(
                      'ACTUALIZADO AL MES DE ${(aMetasMensualizada.isNotEmpty ? (obtenerNombreMesCompleto(aMetasMensualizada[aMetasMensualizada.length - 1].mes!)) : '')}')
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding avanceMetasUsuarios() {
    var heading = 'METAS DE USUARIOS - 2023';

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
            Container(
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SfCartesianChart(
                    plotAreaBorderWidth: 0,
                    legend: Legend(
                        isVisible: true,
                        position: LegendPosition.bottom,
                        overflowMode: LegendItemOverflowMode.wrap),
                    primaryXAxis: CategoryAxis(),
                    series: <CartesianSeries>[
                      ColumnSeries<ChartDataAvance, String>(
                          animationDuration: 2500,
                          name: 'Programado',
                          dataSource: chartData1,
                          dataLabelSettings:
                              const DataLabelSettings(isVisible: true),
                          xValueMapper: (ChartDataAvance data, _) => data.x,
                          yValueMapper: (ChartDataAvance data, _) => data.y),
                      ColumnSeries<ChartDataAvance, String>(
                          animationDuration: 2500,
                          name: 'Ejecutado',
                          dataSource: chartData1,
                          dataLabelSettings:
                              const DataLabelSettings(isVisible: true),
                          xValueMapper: (ChartDataAvance data, _) => data.x,
                          yValueMapper: (ChartDataAvance data, _) => data.y1),
                    ],
                    tooltipBehavior: TooltipBehavior(enable: true),
                  ),
                  Text(
                      'ACTUALIZADO AL MES DE ${(aMetasMensualizada.isNotEmpty ? (obtenerNombreMesCompleto(aMetasMensualizada[aMetasMensualizada.length - 1].mes!)) : '')}')
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

  String formatoDecimal(int numero) {
    NumberFormat f = new NumberFormat("#,###.0#", "es_US");
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
}

class AvancesData {
  AvancesData(this.mes, this.avanceAtenciones, this.avanceUsuarios);
  final String mes;
  final double avanceAtenciones;
  final double avanceUsuarios;
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
