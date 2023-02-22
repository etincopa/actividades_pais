import 'dart:convert';

import 'package:actividades_pais/backend/controller/main_controller.dart';
import 'package:actividades_pais/backend/model/lista_trama_monitoreo_detail.dart';
import 'package:actividades_pais/backend/model/listar_trama_proyecto_model.dart';
import 'package:actividades_pais/src/pages/SeguimientoMonitoreo/dashboard.dart';
import 'package:actividades_pais/src/pages/SeguimientoMonitoreo/gallery/image_view.dart';
import 'package:actividades_pais/util/Constants.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:actividades_pais/src/pages/widgets/widget-custom.dart';

class DetalleProyecto extends StatefulWidget {
  const DetalleProyecto({super.key, required this.datoProyecto});
  final TramaProyectoModel datoProyecto;
  @override
  State<DetalleProyecto> createState() => _DetalleProyectoState();
}

class _DetalleProyectoState extends State<DetalleProyecto>
    with TickerProviderStateMixin {
  MainController mainController = MainController();
  List<MonitoreoDetailModel> aMonitoreoAprobado = [];
  late TramaProyectoModel _oProject;
  bool isOKImage = false;

  late final _numSnip;
  late final _latitud;
  late final _longitud;
  late final _subEstado;
  late final _estadoSaneamiento;
  late final _modalidad;
  late final _fechaInicio;
  late final _fechaTerminoEstimado;
  late final _inversion;
  late final _costoEjecutado;
  late final _costoEstimadoFinal;
  late final _residente;
  late final _supervisor;
  late final _crp;
  late final _codResidente;
  late final _codSupervisor;
  late final _codCrp;
  final double infoHeight = 364.0;
  AnimationController? animationController;
  Animation<double>? animation;
  double opacity1 = 0.0;
  double opacity2 = 0.0;
  double opacity3 = 0.0;

  List<ImagenesCourrusel> listImges = [];

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController!,
        curve: const Interval(0, 1.0, curve: Curves.fastOutSlowIn),
      ),
    );
    setData();

    _oProject = widget.datoProyecto;
    _numSnip = TextEditingController(text: _oProject.numSnip);
    _latitud = TextEditingController(text: _oProject.latitud);
    _longitud = TextEditingController(text: _oProject.longitud);
    _subEstado = TextEditingController(text: _oProject.subEstado);
    _estadoSaneamiento =
        TextEditingController(text: _oProject.estadoSaneamiento);
    _modalidad = TextEditingController(text: _oProject.modalidad);
    _fechaInicio = TextEditingController(text: _oProject.fechaInicio);
    _fechaTerminoEstimado =
        TextEditingController(text: _oProject.fechaTerminoEstimado);
    _inversion = TextEditingController(text: _oProject.inversion);
    _costoEjecutado = TextEditingController(text: _oProject.costoEjecutado);
    _costoEstimadoFinal =
        TextEditingController(text: _oProject.costoEstimadoFinal);
    _residente = TextEditingController(text: _oProject.residente);
    _supervisor = TextEditingController(text: _oProject.supervisor);
    _crp = TextEditingController(text: _oProject.crp);
    _codResidente = TextEditingController(text: _oProject.codResidente);
    _codSupervisor = TextEditingController(text: _oProject.codSupervisor);
    _codCrp = TextEditingController(text: _oProject.codCrp);

    buildCarrouselImg(_oProject.numSnip.toString());
  }

  Future<void> setData() async {
    animationController?.forward();
    await Future<dynamic>.delayed(const Duration(milliseconds: 20000));
    opacity1 = 1.0;
    await Future<dynamic>.delayed(const Duration(milliseconds: 20000));

    opacity2 = 1.0;
    await Future<dynamic>.delayed(const Duration(milliseconds: 20000));
    opacity3 = 1.0;
  }

  Future<void> buildCarrouselImg(String snip) async {
    aMonitoreoAprobado =
        await mainController.getMonitoreoDetail(int.parse(snip));
    int count = 1;
    isOKImage = aMonitoreoAprobado.isEmpty ? true : false;
    for (var item in aMonitoreoAprobado) {
      if (listImges.length > 5) break;
      if (item.imgActividad1!.length > 10) {
        listImges.add(ImagenesCourrusel(
          num: count,
          descripcion: item.problemaIdentificado,
          imagen: Image.memory(
            base64Decode(item.imgActividad1!),
          ),
        ));
      }

      if (listImges.length > 5) break;
      if (item.imgActividad2!.length > 10) {
        listImges.add(ImagenesCourrusel(
          num: count,
          descripcion: item.problemaIdentificado,
          imagen: Image.memory(
            base64Decode(item.imgActividad2!),
          ),
        ));
      }

      if (listImges.length > 5) break;
      if (item.imgActividad3!.length > 10) {
        listImges.add(ImagenesCourrusel(
          num: count,
          descripcion: item.problemaIdentificado,
          imagen: Image.memory(
            base64Decode(item.imgActividad3!),
          ),
        ));
      }

      if (listImges.length > 5) break;
      if (item.imgProblema1!.length > 10) {
        listImges.add(ImagenesCourrusel(
          num: count,
          descripcion: item.problemaIdentificado,
          imagen: Image.memory(
            base64Decode(item.imgProblema1!),
          ),
        ));
      }

      if (listImges.length > 5) break;
      if (item.imgProblema2!.length > 10) {
        listImges.add(ImagenesCourrusel(
          num: count,
          descripcion: item.problemaIdentificado,
          imagen: Image.memory(
            base64Decode(item.imgProblema2!),
          ),
        ));
      }

      if (listImges.length > 5) break;
      if (item.imgProblema3!.length > 10) {
        listImges.add(ImagenesCourrusel(
          num: count,
          descripcion: item.problemaIdentificado,
          imagen: Image.memory(
            base64Decode(item.imgProblema3!),
          ),
        ));
      }

      if (listImges.length > 5) break;
      if (item.imgRiesgo1!.length > 10) {
        listImges.add(ImagenesCourrusel(
          descripcion: item.problemaIdentificado,
          num: count,
          imagen: Image.memory(
            base64Decode(item.imgRiesgo1!),
          ),
        ));
      }

      if (listImges.length > 5) break;
      if (item.imgRiesgo2!.length > 10) {
        listImges.add(ImagenesCourrusel(
          descripcion: item.problemaIdentificado,
          num: count,
          imagen: Image.memory(
            base64Decode(item.imgRiesgo2!),
          ),
        ));
      }

      if (listImges.length > 5) break;
      if (item.imgRiesgo3!.length > 10) {
        listImges.add(ImagenesCourrusel(
          descripcion: item.problemaIdentificado,
          num: count,
          imagen: Image.memory(
            base64Decode(item.imgRiesgo3!),
          ),
        ));
      }

      count++;
    }
    isOKImage = listImges.isEmpty ? true : false;
    setState(() {});
  }

  Color getColorAvancefisico(dynamic oProyecto) {
    try {
      return ((double.parse(oProyecto.avanceFisico.toString()) * 100) == 100
          ? Colors.blue
          : (double.parse(oProyecto.avanceFisico.toString()) * 100) >= 50
              ? Colors.green
              : (double.parse(oProyecto.avanceFisico.toString()) * 100) <= 30
                  ? Colors.red
                  : Colors.yellow);
    } catch (oError) {
      return Colors.black;
    }
  }

  int getAvancefisicoChar(dynamic oProyecto) {
    try {
      return ((double.parse(oProyecto.avanceFisico.toString()) * 100) == 100
          ? 1 /* MUL ALTO*/
          : (double.parse(oProyecto.avanceFisico.toString()) * 100) >= 50
              ? 2 /* ALTO*/
              : (double.parse(oProyecto.avanceFisico.toString()) * 100) <= 30
                  ? 4 /* BAJO*/
                  : 3); /* MEDIO */
    } catch (oError) {
      return 4;
    }
  }

  double getAvancefisico(dynamic oProyecto) {
    try {
      return double.parse(oProyecto.avanceFisico.toString());
    } catch (oError) {
      return 1;
    }
  }

  String getAvancefisicoText(dynamic oProyecto) {
    try {
      return "${((double.parse(oProyecto.avanceFisico.toString()) * 100).toStringAsFixed(2)).toString()}%";
    } catch (oError) {
      return "NAN %";
    }
  }

  @override
  Widget build(BuildContext context) {
    final double tempHeight = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).size.width / 1.2) +
        24.0;
    return Scaffold(
      appBar: WidgetCustoms.appBar(
        widget.datoProyecto.tambo ?? '',
        context: context,
        icon: Icons.arrow_back,
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const Dashboard(),
            ),
          );
        },
        iconAct: Icons.format_align_left,
        onPressedAct: () {},
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        width: double.maxFinite,
        child: Column(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: 1,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(height: 10),
                                /**
                                 * HEADER
                                 */
                                Container(
                                  width: MediaQuery.of(context).size.width - 20,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: colorGB,
                                    border: Border.all(
                                      width: 1,
                                      color: colorGB_01o27,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: color_04.withOpacity(0.9),
                                        spreadRadius: 0,
                                        blurRadius: 2,
                                        offset: const Offset(0, 1),
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CarouselSlider(
                                          options: CarouselOptions(
                                            enlargeCenterPage: true,
                                            autoPlay: true,
                                            aspectRatio: 16 / 9,
                                            autoPlayCurve: Curves.fastOutSlowIn,
                                            enableInfiniteScroll: true,
                                            autoPlayAnimationDuration:
                                                const Duration(
                                                    milliseconds: 1000),
                                            viewportFraction: 0.8,
                                          ),
                                          items: listImges.isNotEmpty
                                              ? listImges
                                                  .map((ImagenesCourrusel map) {
                                                  return Builder(
                                                    builder:
                                                        (BuildContext context) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10.0),
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            Navigator
                                                                .pushReplacement(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (BuildContext
                                                                        context) =>
                                                                    ImageView(
                                                                        datoProyecto:
                                                                            widget
                                                                                .datoProyecto,
                                                                        galleria:
                                                                            map.imagen!),
                                                              ),
                                                            );
                                                          },
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              color: colorGB,
                                                              boxShadow: const [
                                                                BoxShadow(
                                                                    color: Colors
                                                                        .black54,
                                                                    blurRadius:
                                                                        15.0,
                                                                    offset:
                                                                        Offset(
                                                                            0.0,
                                                                            0.75))
                                                              ],
                                                            ),
                                                            child: Image(
                                                              image:
                                                                  (map.imagen)!
                                                                      .image,
                                                              errorBuilder: (context,
                                                                      url,
                                                                      error) =>
                                                                  const Icon(Icons
                                                                      .image),
                                                              fit: BoxFit.fill,
                                                              width: double
                                                                  .infinity,
                                                              height: double
                                                                  .infinity,
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  );
                                                }).toList()
                                              : [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: colorGB,
                                                        boxShadow: const [
                                                          BoxShadow(
                                                              color: Colors
                                                                  .black54,
                                                              blurRadius: 15.0,
                                                              offset: Offset(
                                                                  0.0, 0.75))
                                                        ],
                                                      ),
                                                      child: isOKImage
                                                          ? const Center(
                                                              child: Icon(
                                                                Icons.image,
                                                                size: 50,
                                                              ),
                                                            )
                                                          : Center(
                                                              child: Image.asset(
                                                                  'assets/loading_icon.gif'),
                                                            ),
                                                    ),
                                                  ),
                                                ],
                                        ),

                                        /*const SizedBox(height: 15),
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                255, 255, 255, 255),
                                            border: Border.all(
                                              width: 1.5,
                                              color: const Color(0xFF00B6F0),
                                            ),
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(16.0),
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              widget.datoProyecto.estado!,
                                              textAlign: TextAlign.left,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w800,
                                                fontSize: 18,
                                                letterSpacing: 0.0,
                                                color: Color.fromARGB(
                                                    255, 33, 32, 32),
                                              ),
                                            ),
                                          ),
                                        ),*/
                                        const SizedBox(height: 25),

                                        Text(
                                          'TAMBO ${widget.datoProyecto.tambo!}',
                                          textAlign: TextAlign.left,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 22,
                                            letterSpacing: 0.27,
                                            color: color_01,
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        Text(
                                          "${widget.datoProyecto.departamento!} / ${widget.datoProyecto.provincia!} / ${widget.datoProyecto.distrito!}",
                                          textAlign: TextAlign.left,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                            letterSpacing: 0.27,
                                            color: color_01,
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        Text(
                                          'SNIP ${widget.datoProyecto.numSnip!}',
                                          textAlign: TextAlign.left,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            letterSpacing: 0.27,
                                            color: color_01,
                                          ),
                                        ),
                                        ScaleTransition(
                                          alignment: Alignment.center,
                                          scale: CurvedAnimation(
                                            parent: animationController!,
                                            curve: Curves.fastOutSlowIn,
                                          ),
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 15),
                                            child: CircularPercentIndicator(
                                              radius: 50.0,
                                              lineWidth: 20.0,
                                              percent: getAvancefisico(
                                                  widget.datoProyecto),
                                              center: Text(
                                                getAvancefisicoText(
                                                    widget.datoProyecto),
                                                style: const TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              progressColor:
                                                  getColorAvancefisico(
                                                      widget.datoProyecto),
                                            ),
                                          ),
                                        ),

                                        //detalle
                                      ],
                                    ),
                                  ),
                                ),

                                /**
                                 * BODY
                                 */

                                const Divider(),
                                cardEstadoProyecto(),
                              ],
                            );
                          }),
                      // child:
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
  *            ESTADO DEL PROYECTO
  * -----------------------------------------------
  */
  Padding cardMonitoreo() {
    var heading = 'DETALLE DEL PROYECTO';
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: colorI,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: ExpansionTile(
          initiallyExpanded: true,
          title: ListTile(
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
            Padding(
              padding: const EdgeInsets.all(20),
              child: aMonitoreoAprobado.isNotEmpty
                  ? SizedBox(
                      height: 450,
                      child: GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          childAspectRatio: 3.0,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                        ),
                        padding: const EdgeInsets.only(
                          left: 5,
                          right: 5,
                          bottom: 58,
                        ),
                        itemCount: aMonitoreoAprobado.length,
                        itemBuilder: (context, index) {
                          MonitoreoDetailModel oMonitor =
                              aMonitoreoAprobado[index];
                          return GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.only(bottom: 5),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 1,
                                    offset: const Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Flexible(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    oMonitor.idMonitoreo!,
                                                    style: const TextStyle(
                                                      color: color_01,
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                  Text(
                                                    'TAMBO ${oMonitor.tambo ?? ''}',
                                                    style: const TextStyle(
                                                      color: color_01,
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          oMonitor.estadoMonitoreo!,
                                          style: const TextStyle(
                                            color: color_01,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : Container(
                      padding: const EdgeInsets.only(top: 40),
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: color_07,
                        ),
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
  *            ESTADO DEL PROYECTO
  * -----------------------------------------------
  */
  Padding cardEstadoProyecto() {
    var heading = 'DETALLE DEL PROYECTO';
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: colorI,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: ExpansionTile(
          initiallyExpanded: true,
          title: ListTile(
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
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'FldProyect002'.tr,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextFormField(
                    controller: _numSnip,

                    ///CÓDIGO DE SNIP
                    validator: (v) => v!.isEmpty ? 'Required'.tr : null,
                    enabled: false,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'FldProyect011'.tr,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextFormField(
                    controller: _subEstado,

                    ///SUB ESTADO DEL PROYECTO
                    validator: (v) => v!.isEmpty ? 'Required'.tr : null,
                    enabled: false,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'FldProyect012'.tr,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextFormField(
                    controller: _estadoSaneamiento,

                    ///ESTADO DE SANEAMIENTO DEL PROYECTO
                    validator: (v) => v!.isEmpty ? 'Required'.tr : null,
                    enabled: false,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'FldProyect013'.tr,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextFormField(
                    controller: _modalidad,

                    ///MODALIDAD DE CONTRATACIÓN DEL PROYECTO
                    validator: (v) => v!.isEmpty ? 'Required'.tr : null,
                    enabled: false,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'FldProyect014'.tr,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextFormField(
                    controller: _fechaInicio,

                    ///FECHA DE INICIO DEL PROYECTO
                    validator: (v) => v!.isEmpty ? 'Required'.tr : null,
                    enabled: false,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'FldProyect015'.tr,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextFormField(
                    controller: _fechaTerminoEstimado,

                    ///FECHA DE TÉRMINO ESTIMADO DEL PROYECTO
                    validator: (v) => v!.isEmpty ? 'Required'.tr : null,
                    enabled: false,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'FldProyect016'.tr,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextFormField(
                    controller: _inversion,

                    ///MONTO DE INVERSIÓN DEL PROYECTO
                    validator: (v) => v!.isEmpty ? 'Required'.tr : null,
                    enabled: false,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'FldProyect017'.tr,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextFormField(
                    controller: _costoEjecutado,

                    ///COSTO EJECUTADO ACUMULADO DEL PROYECTO
                    validator: (v) => v!.isEmpty ? 'Required'.tr : null,
                    enabled: false,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'FldProyect018'.tr,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextFormField(
                    controller: _costoEstimadoFinal,

                    ///COSTO ESTIMADO FINAL DEL PROYECTO
                    validator: (v) => v!.isEmpty ? 'Required'.tr : null,
                    enabled: false,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'FldProyect020'.tr,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextFormField(
                    controller: _residente,

                    ///NOMBRE DEL RESIDENTE
                    validator: (v) => v!.isEmpty ? 'Required'.tr : null,
                    enabled: false,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'FldProyect021'.tr,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextFormField(
                    controller: _supervisor,

                    ///NOMBRE DEL SUPERVISOR
                    validator: (v) => v!.isEmpty ? 'Required'.tr : null,
                    enabled: false,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'FldProyect022'.tr,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextFormField(
                    controller: _crp,

                    ///NOMBRE DEL COORDINADOR REGIONAL DEL PROYECTO
                    validator: (v) => v!.isEmpty ? 'Required'.tr : null,
                    enabled: false,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'FldProyect023'.tr,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextFormField(
                    controller: _codResidente,

                    ///CÓDIGO DEL RESIDENTE
                    validator: (v) => v!.isEmpty ? 'Required'.tr : null,
                    enabled: false,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'FldProyect024'.tr,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextFormField(
                    controller: _codSupervisor,

                    ///CÓDIGO DEL SUPERVISOR
                    validator: (v) => v!.isEmpty ? 'Required'.tr : null,
                    enabled: false,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'FldProyect025'.tr,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextFormField(
                    controller: _codCrp,

                    ///CÓDIGO DEL COORDINADOR REGIONAL DEL PROYECTO
                    validator: (v) => v!.isEmpty ? 'Required'.tr : null,
                    enabled: false,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'FldProyect003'.tr,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextFormField(
                    controller: _latitud,

                    ///LATITUD DE LA UBICACIÓN DEL PROYECTO
                    validator: (v) => v!.isEmpty ? 'Required'.tr : null,
                    enabled: false,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'FldProyect004'.tr,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextFormField(
                    controller: _longitud,

                    ///LONGITUD DE LA UBICACIÓN DEL PROYECTO
                    validator: (v) => v!.isEmpty ? 'Required'.tr : null,
                    enabled: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyListTitle extends StatelessWidget {
  const MyListTitle({
    Key? key,
    required this.widget,
    required this.label,
    required this.valor,
  }) : super(key: key);

  final DetalleProyecto widget;
  final String label;
  final String valor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.check, size: 50),
      title: Text(
        label,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.black,
          fontWeight: FontWeight.w700,
        ),
      ),
      subtitle: Text(
        valor,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class ImagenesCourrusel {
  int? num;
  String? imagenB64;
  Image? imagen;
  String? descripcion;

  ImagenesCourrusel.empty() {}

  ImagenesCourrusel({
    this.num,
    this.imagenB64,
    this.imagen,
    this.descripcion,
  });
}
