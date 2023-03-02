import 'dart:convert';
import 'dart:io';

import 'package:actividades_pais/backend/controller/main_controller.dart';
import 'package:actividades_pais/backend/model/IncidentesInternetModel.dart';
import 'package:actividades_pais/backend/model/clima_model.dart';
import 'package:actividades_pais/backend/model/dto/response_base64_file_dto.dart';
import 'package:actividades_pais/backend/model/dto/response_search_tambo_dto.dart';
import 'package:actividades_pais/backend/model/dto/response_tambo_servicio_internet_dto.dart';
import 'package:actividades_pais/backend/model/programacion_intervenciones_tambos_model.dart';
import 'package:actividades_pais/backend/model/obtener_metas_tambo_model.dart';
import 'package:actividades_pais/backend/model/tambo_activida_model.dart';
import 'package:actividades_pais/backend/model/tambo_model.dart';
import 'package:actividades_pais/src/pages/MonitoreoProyectoTambo/main/Components/fab.dart';
import 'package:actividades_pais/src/pages/MonitoreoProyectoTambo/main/Project/Report/pdf/pdf_preview_page2.dart';
import 'package:actividades_pais/src/pages/Pias/Incidentes_Actividades/mostarFoto.dart';
import 'package:actividades_pais/src/pages/Tambook/Home/home_tambook.dart';
import 'package:actividades_pais/src/pages/Tambook/Home/main_tambook.dart';
import 'package:actividades_pais/src/pages/Tambook/Detalle/mapa.dart';
import 'package:actividades_pais/src/pages/Tambook/search/search_tambook.dart';
import 'package:actividades_pais/src/pages/widgets/image_preview.dart';
import 'package:actividades_pais/util/Constants.dart';
import 'package:actividades_pais/util/app-config.dart';
import 'package:actividades_pais/util/busy-indicator.dart';
import 'package:actividades_pais/util/check_connection.dart';
import 'package:actividades_pais/util/image_util.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'dart:math' as math;
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:kdgaugeview/kdgaugeview.dart';
import 'package:lecle_bubble_timeline/lecle_bubble_timeline.dart';
import 'package:lecle_bubble_timeline/models/timeline_item.dart';
import 'package:badges/badges.dart' as badges;
import 'package:http/http.dart' as http;

class DetalleTambook extends StatefulWidget {
  const DetalleTambook({super.key, this.listTambo});
  final BuscarTamboDto? listTambo;

  @override
  _DetalleTambookState createState() => _DetalleTambookState();
}

class _DetalleTambookState extends State<DetalleTambook>
    with TickerProviderStateMixin<DetalleTambook> {
  late TabController _tabController;

  int _selectedTab = 0;

  ScrollController scrollCtr = ScrollController();
  ScrollController scrollCtr2 = ScrollController();
  Animation<double>? _animation;
  AnimationController? _controller;
  MainController mainCtr = MainController();

  late TamboModel oTambo = TamboModel.empty();
  late List<TamboActividadModel> aActividad = [];

  late List<TamboActividadModel> aInterAmbDir = [];
  late List<TamboActividadModel> aInterSopEnt = [];
  late List<TamboActividadModel> aCoordinacio = [];

  late List<IncidentesInternetModel> incidencias = [];
  late ClimaModel clima = ClimaModel.empty();
  bool isLoading = true;
  bool isLoading2 = false;

  int statusLoadActividad = 0;
  bool loading = true;
  bool isEndPagination = false;
  int offset = 0;
  int limit = 15;
  String sCurrentYear = DateTime.now().year.toString();

  List<ProgIntervencionTamboModel> aAvance = [];
  List<MetasTamboModel> aMetasTipo1 = [];
  List<MetasTamboModel> aMetasTipo2 = [];

  @override
  void dispose() {
    scrollCtr.dispose();
    scrollCtr2.removeListener(() async {});
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
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

    super.initState();
    /**
     * OBTENER DETALLE GENERAL DE TMBO
     */

    print("${widget.listTambo!.idTambo}");

    tamboDatoGeneral();
    TamboIntervencionAtencionIncidencia();
    //incidenciasInternet();
  }

  Future<void> getProgIntervencionTambo() async {
    aAvance = await mainCtr.progIntervencionTambo(
      '${oTambo.idTambo}',
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
    aAvance.sort((a, b) => a.fecha!.compareTo(b.fecha!));
  }

  Future<void> getMetasGeneral() async {
    isLoading2 = false;
    DateTime today = DateTime.now();
    String dateStr = "${today.year}";
    List<MetasTamboModel> aMetas =
        await mainCtr.metasTambo('${oTambo.nSnip ?? 0}', sCurrentYear, 0);

    aMetasTipo1 = aMetas.where((e) => e.numTipoMeta == 1).toList();
    aMetasTipo2 = aMetas.where((e) => e.numTipoMeta == 2).toList();

    await getProgIntervencionTambo();

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

  Future<void> tamboDatoGeneral() async {
    oTambo = await mainCtr.getTamboDatoGeneral(
      (widget.listTambo!.idTambo).toString(),
    );
    obtenerDatosClima();
    getMetasGeneral();
    incidenciasInternet(oTambo.nSnip ?? 0);

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
      print("Error con la respusta");
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

  @override
  Widget build(BuildContext context) {
    var flexibleSpaceWidget = SliverAppBar(
      title: const Text(
        "¡ BIENVENIDO A",
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
          fontWeight: FontWeight.w700,
        ),
      ),
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
              "${widget.listTambo?.nombreTambo} !",
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
                style: const TextStyle(fontSize: 25, color: Colors.white),
              ),
              const SizedBox(width: 30),
              const Positioned(
                right: -4.0,
                top: 14.0,
                child: ImageIcon(
                  AssetImage('assets/sol.png'),
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
              length: 8,
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
                                child: const Center(
                                  child: Text(
                                    'Operativo',
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
                          child: const TabBar(
                            labelColor: Colors.black,
                            unselectedLabelColor: Colors.black38,
                            indicatorColor: Colors.black,
                            isScrollable: true,
                            indicator: BoxDecoration(
                              color: Colors.white70,
                            ),
                            tabs: [
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
                                    'Información de metas de atención y beneficiarios',
                                child: Tab(
                                  icon: ImageIcon(
                                    AssetImage('assets/meta.png'),
                                    size: 55,
                                  ),
                                ),
                              ),
                              Tab(
                                icon: ImageIcon(
                                  AssetImage('assets/internet.png'),
                                  size: 55,
                                ),
                              ),
                              Tab(
                                icon: ImageIcon(
                                  AssetImage('assets/computadora.png'),
                                  size: 55,
                                ),
                              ),
                              Tab(
                                icon: ImageIcon(
                                  AssetImage('assets/grifo.png'),
                                  size: 55,
                                ),
                              ),
                              Tab(
                                icon: ImageIcon(
                                  AssetImage('assets/calendario.png'),
                                  size: 55,
                                ),
                              ),
                              Tab(
                                icon: ImageIcon(
                                  AssetImage('assets/lluvioso.png'),
                                  size: 55,
                                ),
                              ),
                              Tab(
                                icon: ImageIcon(
                                  AssetImage('assets/intervenciones.png'),
                                  size: 55,
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
                  children: [
                    //TabScreen("GESTOR"),
                    ListView(
                      children: [
                        const SizedBox(height: 10),
                        /*
                          * NUESTRO GESTOR
                          */
                        cardNuestroGestor(),
                        const SizedBox(height: 10),
                        cardVigilante(),
                        const SizedBox(height: 10),
                        cardHistorialGestores(),
                        const SizedBox(height: 10),
                        /*
                          * DATOS GENERALES
                          */
                        cardDatosGenerales(),
                        const SizedBox(height: 10),
                        /*
                          * NUESTRO JEFE DE UNIDAD TERRITORIAL
                          */
                        cardNuestroJefeUnidad(),
                        const SizedBox(height: 10),

                        /*
                          * DATOS DE UBICACIÓN
                          */
                        cardDatosUbicacion(),
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
                        const SizedBox(height: 10),
                        cardServicios(),
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

                    //const TabScreen("SERVICIOS INTERNET"),
                    ListView(
                      children: [
                        cardDatosSrvInternet(),
                        const SizedBox(height: 10),
                        cardIncidencia(),
                        const SizedBox(height: 40),
                      ],
                    ),

                    //const TabScreen("EQUIPAMIENTO TECNOLÓGICO DEL TAMBO"),

                    ListView(
                      children: [
                        cardEquipoTecnologico(),
                        const SizedBox(height: 40),
                      ],
                    ),

//const TabScreen("COMBUSTIBLE"),

                    ListView(
                      children: [
                        cardCombustible(),
                        const SizedBox(height: 40),
                      ],
                    ),

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
            "Ubicación Tambo",
            Icons.map_outlined,
            onPress: () async {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MapaTambo(snip: oTambo.nSnip ?? 0),
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
    var subheading = oTambo.gestorNombre ?? '';
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
              initiallyExpanded: true,
              title: ListTile(
                visualDensity: const VisualDensity(vertical: -4),
                title: Text(
                  heading,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
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
                  child: ImageUtil.ImageUrl(
                    oTambo.gestorPathImage ?? '',
                    width: 150,
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
                          subtitle: Text(oTambo.gestorProfession ?? ''),
                        ),
                        ListTile(
                          title: const Text('GRADO'),
                          subtitle: Text(oTambo.gestorGradoAcademico ?? ''),
                        ),
                        ListTile(
                          title: const Text('SEXO'),
                          subtitle: Text(oTambo.gestorSexo ?? ''),
                        ),
                        ListTile(
                          title: const Text('ESTADO CIVIL'),
                          subtitle: Text(oTambo.gestorEstadoCivil ?? ''),
                        ),
                        ListTile(
                          title: const Text('FECHA DE NACIMIENTO'),
                          subtitle: Text(oTambo.gestorFechaNacimiento ?? ''),
                        ),
                        ListTile(
                          title: const Text('EMAIL'),
                          subtitle: Text(oTambo.gestorCorreo ?? ''),
                        ),
                        const ListTile(
                          title: Text('TIPO CONTRATO'),
                          subtitle: Text('ORDEN SERVICIO'),
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
 *            Guardian
 * -----------------------------------------------
 */
  Padding cardVigilante() {
    var heading = 'GUARDIÁN';
    var subheading = 'HARDY';
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
              initiallyExpanded: true,
              title: ListTile(
                visualDensity: const VisualDensity(vertical: -4),
                title: Text(
                  heading,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
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
                          subtitle: Text(''),
                        ),
                        ListTile(
                          title: const Text('INICIO DE CONTRATO'),
                          subtitle: Text(''),
                        ),
                        ListTile(
                          title: const Text('SEXO'),
                          subtitle: Text(''),
                        ),
                        ListTile(
                          title: const Text('ESTADO CIVIL'),
                          subtitle: Text(''),
                        ),
                        ListTile(
                          title: const Text('FECHA DE NACIMIENTO'),
                          subtitle: Text(''),
                        ),
                        ListTile(
                          title: Text('TIPO CONTRATO'),
                          subtitle: Text(''),
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
              title: ListTile(
                visualDensity: const VisualDensity(vertical: -4),
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
                      children: const [
                        BubbleTimeline(
                          bubbleSize: 70,
                          // List of Timeline Bubble Items
                          items: [
                            TimelineItem(
                              title: 'Irma Soledad',
                              subtitle: '20/10/2021',
                              icon: Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                              bubbleColor: Colors.grey,
                            ),
                            TimelineItem(
                              title: 'Juan Luis',
                              subtitle: '01/01/2019',
                              icon: Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                              bubbleColor: Colors.grey,
                            ),
                          ],
                          stripColor: Colors.teal,
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
              title: ListTile(
                visualDensity: const VisualDensity(vertical: -4),
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
                        ListTile(
                          title: const Text('ATENCIONES'),
                          subtitle: Text(oTambo.atencion ?? ''),
                        ),
                        ListTile(
                          title: const Text('INTERVENCIONES'),
                          subtitle: Text(oTambo.intervencion ?? ''),
                        ),
                        ListTile(
                          title: const Text('BENEFICIARIOS'),
                          subtitle: Text(oTambo.beneficiario ?? ''),
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
        "${oTambo.jefeNombre ?? ''} ${oTambo.jefeApellidoPaterno ?? ''} ${oTambo.jefeApellidoMaterno ?? ''}";
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
              title: ListTile(
                visualDensity: const VisualDensity(vertical: -4),
                title: Text(
                  heading,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
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
                  alignment: Alignment.centerLeft,
                  child: Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: const Text('TÉLEFONO'),
                          subtitle: Text(oTambo.jefeTelefono ?? ''),
                        ),
                        ListTile(
                          title: const Text('EMAIL'),
                          subtitle: Text(oTambo.jefeCorreo ?? ''),
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
              title: ListTile(
                visualDensity: const VisualDensity(vertical: -4),
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
                          subtitle: Text(oTambo.altitudCcpp ?? ''),
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

  Padding cardDatosDemograficos() {
    var heading = 'DATOS DEMOGRÁFICOS';
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
              title: ListTile(
                visualDensity: const VisualDensity(vertical: -4),
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
                        ListTile(
                          title: const Text('N° DE HOGARES'),
                          subtitle: Text(oTambo.hogaresAnteriores ?? ''),
                        ),
                        ListTile(
                          title: const Text('N° DE VIVIENDAS'),
                          subtitle: Text(oTambo.viviendasAnterior ?? ''),
                        ),
                        ListTile(
                          title: const Text('POBLACIÓN'),
                          subtitle: Text(oTambo.poblacionAnterior ?? ''),
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
              title: ListTile(
                visualDensity: const VisualDensity(vertical: -4),
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
                        ListTile(
                          title: const Text('N° SNIP'),
                          subtitle: Text(oTambo.nSnip == null
                              ? ''
                              : oTambo.nSnip.toString()),
                        ),
                        ListTile(
                          title: const Text('MONTO CONTRATADO'),
                          subtitle: Text(oTambo.montoAdjudicado ?? ''),
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
              title: ListTile(
                visualDensity: const VisualDensity(vertical: -4),
                title: Text(
                  '$heading ( ${oTambo.aCentroPoblado!.length} )',
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
                        for (var oCentro in oTambo.aCentroPoblado!)
                          ListTile(
                            iconColor: const Color.fromARGB(255, 0, 0, 0),
                            title: Text(oCentro.nombreCcpp!),
                            subtitle: Text(
                                '( ALTITUD: ${oCentro.altitudCcpp} - REGION: ${oCentro.regionCatural} )'),
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

  Padding cardServicios() {
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
              title: ListTile(
                visualDensity: const VisualDensity(vertical: -4),
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
                        ListTile(
                          title: const Text(
                              '¿TIENE SERVICIO DE ENERGÍA ELÉCTRICA?'),
                          subtitle: Text(''),
                        ),
                        ListTile(
                          title: const Text(
                              'TIPO DE CONEXIÓN DE ENERGÍA ELÉCTRICA'),
                          subtitle: Text(''),
                        ),
                        ListTile(
                          title: const Text('PROVEEDOR DE ENERGÍA ELÉCTRICA'),
                          subtitle: Text(''),
                        ),
                        ListTile(
                          title: const Text('¿TIENE SERVICIO DE AGUA?'),
                          subtitle: Text(''),
                        ),
                        ListTile(
                          title: const Text(
                              'TIPO DE CONEXIÓN DEL SERVICIO DE AGUA'),
                          subtitle: Text(''),
                        ),
                        ListTile(
                          title: const Text('PROVEEDOR DE SERVICIO DE AGUA'),
                          subtitle: Text(''),
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
    final totalMetaTipo1 =
        aMetasTipo1.fold<int>(0, (sum, item) => sum + (item.metaTotal ?? 0));

    int totalAvance1 = aAvance.length;
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
                            progressStrokeWidth: 20,
                            backStrokeWidth: 20,
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
                          children: [
                            TableRow(children: [
                              const Text(
                                "Meta :",
                                style: TextStyle(fontSize: 15.0),
                              ),
                              Text(
                                '$totalMetaTipo1',
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
                              ),
                              Text(
                                '$totalAvance1',
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
                                ),
                                Text(
                                  '$totalBrecha1',
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
          ],
        ),
      ),
    );
  }

  Padding cardBeneficiarios() {
    final totalMetaTipo1 =
        aMetasTipo2.fold<int>(0, (sum, item) => sum + (item.metaTotal ?? 0));

    int totalAvance1 = 0;
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
                            progressStrokeWidth: 20,
                            backStrokeWidth: 20,
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
                          children: [
                            TableRow(children: [
                              const Text(
                                "Meta :",
                                style: TextStyle(fontSize: 15.0),
                              ),
                              Text(
                                '$totalMetaTipo1',
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
                              ),
                              Text(
                                '$totalAvance1',
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
                                ),
                                Text(
                                  '$totalBrecha1',
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
                            TableRow(children: [
                              Text(
                                "Brecha :",
                                style: TextStyle(fontSize: 15.0),
                              ),
                              Text(
                                "10,440",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                            ]),
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
              initiallyExpanded: true,
              title: ListTile(
                visualDensity: const VisualDensity(vertical: -4),
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
                          subtitle: Text(oSrvInter.estadoInternet!),
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
                    'Velocidad de bajada Mbps',
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
                    minSpeed: 0,
                    maxSpeed: 10,
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
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                    gaugeWidth: 15,
                    innerCirclePadding: 15,
                  ),
                ),
                const ListTile(
                  title: Text(
                    'Velocidad de subida Mbps',
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
                    minSpeed: 0,
                    maxSpeed: 100,
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
                      fontSize: 30,
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
              initiallyExpanded: true,
              title: ListTile(
                visualDensity: const VisualDensity(vertical: -4),
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
                                    'No existe incidencias',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  )));
                        }

                        return Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(children: [
                              Text(
                                incidencias[index].tipoAveria.toString(),
                                style: const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w500,
                                ), //Textstyle
                              ), //Text
                              const SizedBox(
                                height: 10,
                              ), //SizedBox
                              Text(
                                incidencias[index].observacion.toString(),
                                textAlign: TextAlign.justify,
                                style: const TextStyle(
                                  fontSize: 15,
                                ), //Textstyle
                              ), //Text
                              const SizedBox(
                                height: 10,
                              ),

                              Wrap(spacing: 10, children: [
                                Chip(
                                  label: Text(
                                    'Fecha de averia : ${incidencias[index].fechaAveria ?? ''}',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  backgroundColor: Colors.blue,
                                ),
                                Chip(
                                    label: Text(
                                      'Ticket : ${incidencias[index].ticket ?? ''}',
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    padding: const EdgeInsets.all(1),
                                    backgroundColor: Colors.blue),
                                Chip(
                                    label: Text(
                                      '${incidencias[index].estado ?? ''}',
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    padding: const EdgeInsets.all(1),
                                    backgroundColor: Colors.blue),
                              ]),

                              const Divider(color: colorI), //SizedBox
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
            height: 25,
          ),
          const Divider(
            color: color_10o15,
            height: 5,
            thickness: 3,
            indent: 0,
            endIndent: 0,
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
  Padding cardEquipoTecnologico() {
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
    );
    var heading = 'EQUIPAMIENTO TECNOLÓGICO';
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
                                      size: 45),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2.0),
                                ),
                                const Text(
                                  'PC (10)',
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
                                      color: color_01, Icons.laptop, size: 45),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2.0),
                                ),
                                const Text(
                                  'LAPTOP (10)',
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
                                      size: 45),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2.0),
                                ),
                                const Text(
                                  'PROYECTOR (30)',
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
                                      color: color_01, Icons.wifi, size: 45),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2.0),
                                ),
                                const Text(
                                  'ANTENA WIFI (30)',
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
                                      size: 45),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2.0),
                                ),
                                const Text(
                                  'IMPRESORAS (10)',
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

  Widget buildSuccessDialog(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          dialogBox(),
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
              title: ListTile(
                visualDensity: const VisualDensity(vertical: -4),
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
                    maxSpeed: 10,
                    minMaxTextStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                    ),
                    speed: kbpsTOmbps(3000),
                    speedTextStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                    animate: true,
                    alertSpeedArray: const [0, 5, 10],
                    alertColorArray: const [colorP, colorI, colorS],
                    duration: const Duration(seconds: 6),
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
                      children: const [
                        ListTile(
                          leading: ImageIcon(
                            AssetImage(
                              "assets/generador.png",
                            ),
                            size: 55,
                            color: Colors.grey,
                          ),
                          iconColor: Color.fromARGB(255, 0, 0, 0),
                          title: Text('Generador'),
                          subtitle: Text('0 hrs'),
                        ),
                        ListTile(
                          leading: ImageIcon(
                            AssetImage("assets/moto.png"),
                            size: 55,
                          ),
                          iconColor: Color.fromARGB(255, 0, 0, 0),
                          title: Text('Moto'),
                          subtitle: Text('0 km'),
                        ),
                        ListTile(
                          leading: ImageIcon(AssetImage("assets/carro.png"),
                              size: 55),
                          iconColor: Color.fromARGB(255, 0, 0, 0),
                          title: Text('Carro'),
                          subtitle: Text('0 km'),
                        ),
                        ListTile(
                          leading: ImageIcon(
                              AssetImage("assets/deslizador.png"),
                              size: 55),
                          iconColor: Color.fromARGB(255, 0, 0, 0),
                          title: Text('Deslizador'),
                          subtitle: Text('0 km'),
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
    var heading = 'ACTIVIDADES PROGRAMADAS';
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
              title: ListTile(
                visualDensity: const VisualDensity(vertical: -4),
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
                                  'No existe actividades',
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
                                    const Padding(
                                      padding: EdgeInsets.only(right: 8.0),
                                      child: Icon(
                                        Icons.check_circle,
                                        color: Colors.green,
                                      ),
                                    ),
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
              initiallyExpanded: true,
              title: ListTile(
                visualDensity: const VisualDensity(vertical: -4),
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
                        ListTile(
                          iconColor: const Color.fromARGB(255, 0, 0, 0),
                          title: const Text('Temperatura:'),
                          subtitle: Text(
                            '${clima.temp} °',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30),
                          ),
                        ),
                        ListTile(
                          iconColor: const Color.fromARGB(255, 0, 0, 0),
                          title: const Text('Velocidad del viento:'),
                          subtitle: Text(
                            '${clima.speed} km/h',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30),
                          ),
                        ),
                        ListTile(
                          iconColor: const Color.fromARGB(255, 0, 0, 0),
                          title: const Text('Dirección del viento:'),
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
 *            INFORMACIÓN DEL CLIMA
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
              initiallyExpanded: true,
              title: ListTile(
                visualDensity: const VisualDensity(vertical: -4),
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
                      children: const [
                        ListTile(
                          leading: ImageIcon(
                            AssetImage(
                              "assets/carro.png",
                            ),
                            size: 55,
                            color: Colors.grey,
                          ),
                          iconColor: Color.fromARGB(255, 0, 0, 0),
                          title: Text(
                            'En BUS desde Lima por La Oroya hasta Huánuco, son 410 km y 08 horas en auto aproximadamente).',
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        Divider(color: colorI),
                        ListTile(
                          leading: ImageIcon(
                            AssetImage(
                              "assets/avion.png",
                            ),
                            size: 55,
                            color: Colors.grey,
                          ),
                          iconColor: Color.fromARGB(255, 0, 0, 0),
                          title: Text(
                            'En AVIÓN desde Lima a Huánuco son aproximadamente 45 minutos.',
                            textAlign: TextAlign.justify,
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
