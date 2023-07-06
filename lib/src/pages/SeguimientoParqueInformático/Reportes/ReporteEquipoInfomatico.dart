import 'package:actividades_pais/backend/model/listar_trama_proyecto_model.dart';
import 'package:actividades_pais/src/datamodels/Provider/ProviderSeguimientoParqueInformatico.dart';
import 'package:actividades_pais/src/pages/SeguimientoParqueInform%C3%A1tico/Reportes/DetalleReporteTicket.dart';
import 'package:actividades_pais/util/busy-indicator.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ReporteEquipoInformatico extends StatefulWidget {
  const ReporteEquipoInformatico({Key? key}) : super(key: key);

  @override
  State<ReporteEquipoInformatico> createState() =>
      _ReporteEquipoInformaticoState();
}

List<ChartData> chartData = [
  ChartData('ACTIVO', 0, const Color(0xFF80D8A4)),
  ChartData('INACTIVO', 0, const Color(0xFFE84258)),
];

List<ChartData> tickets = [
  ChartData('EN COLA', 0, const Color(0xFFE84258)),
  ChartData('EN PROCESO', 0, Colors.yellow),
  ChartData('RESUELTO', 0, const Color(0xFF80D8A4)),
  ChartData('FINALIZADO', 0, Colors.grey),
];

List<TramaProyectoModel> aProyecto = [];

var activo = 0;
var inactivo = 0;
var enCola = 0;
var enProceso = 0;
var reseulto = 0;
var finalizado = 0;

class _ReporteEquipoInformaticoState extends State<ReporteEquipoInformatico> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    buildData();
    cargarTicketPie();
  }

  Future<void> buildData() async {
    print("uno ${1}");
    activo = await ProviderSeguimientoParqueInformatico().ReporteEquipos(1);
    inactivo = await ProviderSeguimientoParqueInformatico().ReporteEquipos(0);

    setState(() {
      chartData = [
        ChartData('ACTIVO', activo, const Color(0xFF80D8A4)),
        ChartData('INACTIVO', inactivo, const Color(0xFFE84258)),
      ];
    });
  }

  Future<void> cargarTicketPie() async {
    finalizado = await ProviderSeguimientoParqueInformatico()
        .estadosTickePie("FINALIZADO");
    reseulto = await ProviderSeguimientoParqueInformatico()
        .estadosTickePie("RESUELTO");
    enProceso = await ProviderSeguimientoParqueInformatico()
        .estadosTickePie("EN PROCESO");
    enCola =
        await ProviderSeguimientoParqueInformatico().estadosTickePie("EN COLA");

    setState(() {
      tickets = [
        ChartData('EN COLA', enCola, const Color(0xFFE84258)),
        ChartData('EN PROCESO', enProceso, Colors.yellow),
        ChartData('RESUELTO', reseulto, const Color(0xFF80D8A4)),
        ChartData('FINALIZADO', finalizado, Colors.grey),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("REPORTE EQUIPO INFORMATICO"),
      ),
      body: Column(
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
                      color: const Color(0xFFF5F5F5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 3,
                      child: SfCircularChart(
                        title: ChartTitle(
                          text: 'ESTADOS DE EQUIPOS',
                          textStyle: const TextStyle(
                            color: Color.fromRGBO(0, 116, 227, 1),
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
                            color: Color.fromRGBO(0, 116, 227, 1),
                          ),
                        ),
                        onLegendTapped: (LegendTapArgs args) {
                          print(args.pointIndex);
                          buildData();
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
                            onPointTap: (ChartPointDetails details) async {
                              BusyIndicator.show(context);
                              await Future<dynamic>.delayed(
                                  const Duration(milliseconds: 1000));
                              int iIndex = details.pointIndex! + 1;

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
                    const SizedBox(height: 15),
                    Card(
                      color: const Color(0xFFF5F5F5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 3,
                      child: SfCircularChart(
                        title: ChartTitle(
                          text: 'EQUIPOS TICKETS',
                          textStyle: const TextStyle(
                            color: Color.fromRGBO(0, 116, 227, 1),
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
                            color: Color.fromRGBO(0, 116, 227, 1),
                          ),
                        ),
                        onLegendTapped: (LegendTapArgs args) {
                          print(args.pointIndex);
                          buildData();
                        },
                        series: [
                          PieSeries<ChartData, String>(
                            dataSource: tickets,
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
                            onPointTap: (ChartPointDetails details) async {
                              BusyIndicator.show(context);
                              await Future<dynamic>.delayed(
                                  const Duration(milliseconds: 1000));
                              int iIndex = details.pointIndex! + 1;

                              switch (iIndex) {
                                case 1:
                                  await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DetalleReporte("EN COLA"),
                                      ));
                                  print(iIndex);
                                  break;
                                case 2:
                                  await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DetalleReporte("EN PROCESO"),
                                      ));
                                  print(iIndex);
                                  break;
                                case 3:
                                  await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DetalleReporte("RESUELTO"),
                                      ));
                                  await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DetalleReporte("RESUELTO"),
                                      ));
                                  break;
                                case 4:
                                  /* MEDIO */
                                  print(iIndex);
                                  await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DetalleReporte("FINALIZADO"),
                                      ));

                                  break;
                                default:
                              }
                              /*  switch (iIndex) {
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
                            }*/
                              setState(() {});
                              BusyIndicator.hide(context);
                            },
                          ),
                        ],
                      ),
                    ),
                    /*Container(
                    padding: const EdgeInsets.all(10),
                    child: const Center(
                      child: Text(
                        "PROYECTOS TAMBOS",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromRGBO(0, 116, 227, 1),
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'Roboto-Bold',
                        ),
                      ),
                    ),
                  ),*/
                    /*      aProyecto.isNotEmpty
                      ? ListView.builder(
                    itemCount: aProyecto.length,
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(10),
                    itemBuilder: (context, index) {
                      return ListaProyectos(
                        context: context,
                        oProyecto: aProyecto[index],
                      );
                    },
                  )
                      : Container(
                    padding: const EdgeInsets.only(top: 40),
                    child: const Center(
                      child: CircularProgressIndicator(
                        color:
                        Color.fromARGB(255, 0, 102, 255),
                      ),
                    ),
                  ),*/
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, this.color);

  final String x;
  final int y;
  final Color color;
}
