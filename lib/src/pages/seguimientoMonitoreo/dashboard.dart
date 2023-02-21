import 'package:actividades_pais/backend/controller/main_controller.dart';
import 'package:actividades_pais/backend/model/listar_trama_proyecto_model.dart';
import 'package:actividades_pais/src/pages/Home/home.dart';
import 'package:actividades_pais/src/pages/widgets/widget-custom.dart';
import 'package:actividades_pais/src/pages/seguimientoMonitoreo/detalleProyecto.dart';
import 'package:actividades_pais/util/Constants.dart';
import 'package:actividades_pais/util/busy-indicator.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

MainController mainController = MainController();

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<TramaProyectoModel> aProyecto1 = [];
  List<TramaProyectoModel> aProyecto2 = [];
  List<TramaProyectoModel> aProyecto3 = [];
  List<TramaProyectoModel> aProyecto4 = [];
  List<TramaProyectoModel> aProyectoAll = [];

  List<TramaProyectoModel> aProyecto = [];
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    buildData();
  }

  List<ChartData> chartData = [
    ChartData('MUY ALTO', 0, colorI),
    ChartData('ALTO', 0, colorS),
    ChartData('MEDIO', 0, color_13),
    ChartData('BAJO', 0, colorP),
  ];

  Future<void> buildData() async {
    aProyecto1 = [];
    aProyecto2 = [];
    aProyecto3 = [];
    aProyecto4 = [];

    aProyectoAll = await mainController.getAllProyectoDashboard("");

    aProyectoAll.sort((a, b) => a.avanceFisico!.compareTo(b.avanceFisico!));

    for (var o in aProyectoAll) {
      int iSection = getAvancefisicoChar(o);
      switch (iSection) {
        case 1: /* MUL ALTO*/
          aProyecto1.add(o);
          break;
        case 2: /* ALTO*/
          aProyecto2.add(o);
          break;
        case 3: /* BAJO*/
          aProyecto3.add(o);
          break;
        case 4: /* MEDIO */
          aProyecto4.add(o);
          break;
        default:
      }
    }

    setState(() {
      aProyecto = aProyectoAll;
      chartData = [
        ChartData('MUY ALTO', aProyecto1.length, colorI),
        ChartData('ALTO', aProyecto2.length, colorS),
        ChartData('MEDIO', aProyecto3.length, color_13),
        ChartData('BAJO', aProyecto4.length, colorP),
      ];
    });
  }

  Color getColorAvancefisico(dynamic oProyecto) {
    try {
      return ((double.parse(oProyecto.avanceFisico.toString()) * 100) == 100
          ? colorI
          : (double.parse(oProyecto.avanceFisico.toString()) * 100) >= 50
              ? colorS
              : (double.parse(oProyecto.avanceFisico.toString()) * 100) <= 30
                  ? colorP
                  : color_13);
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
    return Scaffold(
      appBar: WidgetCustoms.appBar(
        "DASHBOARD PROYECTOS",
        context: context,
        icon: Icons.arrow_back,
        onPressed: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => HomePagePais(),
              ));
        },
        iconAct: Icons.restart_alt_outlined,
        onPressedAct: () async {
          BusyIndicator.show(context);
          await buildData();
          BusyIndicator.hide(context);
        },
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        width: double.maxFinite,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 1,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /**
                       * PIE CHART
                       */
                      Card(
                        color: colorGB,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 3,
                        child: SfCircularChart(
                          title: ChartTitle(
                            text: 'ESTADOS DE TAMBOS',
                            textStyle: const TextStyle(
                              color: color_07,
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                            ),
                            alignment: ChartAlignment.center,
                          ),
                          legend: Legend(
                            isVisible: true,
                            position: LegendPosition.right,
                            orientation: LegendItemOrientation.vertical,
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
                              pointColorMapper: (ChartData data, _) =>
                                  data.color,
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
                              onPointTap: (ChartPointDetails details) async {
                                BusyIndicator.show(context);
                                await Future<dynamic>.delayed(
                                    const Duration(milliseconds: 1000));
                                int iIndex = details.pointIndex! + 1;
                                switch (iIndex) {
                                  case 1: /* MUL ALTO*/
                                    aProyecto = aProyecto1;
                                    break;
                                  case 2: /* ALTO*/
                                    aProyecto = aProyecto2;
                                    break;
                                  case 3: /* BAJO*/
                                    aProyecto = aProyecto3;
                                    break;
                                  case 4: /* MEDIO */
                                    aProyecto = aProyecto4;
                                    break;
                                  default:
                                }
                                setState(() {});
                                BusyIndicator.hide(context);
                              },
                            ),
                          ],
                        ),
                      ),

                      /**
                       * DATA
                       */
                      const SizedBox(height: 10),
                      const Center(
                        child: Text(
                          "PROYECTOS TAMBOS",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: color_07,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            fontFamily: 'Roboto-Bold',
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      aProyecto.isNotEmpty
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
                                itemCount: aProyecto.length,
                                itemBuilder: (context, index) {
                                  TramaProyectoModel oProyecto =
                                      aProyecto[index];
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => DetalleProyecto(
                                            datoProyecto: oProyecto,
                                          ),
                                        ),
                                      );
                                    },
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
                                            offset: Offset(0, 1),
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
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 1),
                                                      child:
                                                          CircularPercentIndicator(
                                                        radius: 30.0,
                                                        lineWidth: 10.0,
                                                        percent:
                                                            getAvancefisico(
                                                                oProyecto),
                                                        center: Text(
                                                          getAvancefisicoText(
                                                              oProyecto),
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        progressColor:
                                                            getColorAvancefisico(
                                                                oProyecto),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 10),
                                                    Flexible(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            oProyecto.cui!,
                                                            style:
                                                                const TextStyle(
                                                              color: color_01,
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                            ),
                                                          ),
                                                          Text(
                                                            'TAMBO ${oProyecto.tambo ?? ''}',
                                                            style: TextStyle(
                                                              color: color_01,
                                                              fontSize: 11,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  oProyecto.estado!,
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
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void searhProyectos(String query) {
    final suggestions = aProyectoAll.where((item) {
      final nombre = item.tambo!.toLowerCase();
      final input = query.toLowerCase();
      return nombre.contains(input);
    }).toList();
    if (suggestions.isEmpty) {
      aProyecto = aProyectoAll;
    } else {
      setState(() => aProyecto = suggestions);
    }
  }
}

class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final int y;
  final Color color;
}
