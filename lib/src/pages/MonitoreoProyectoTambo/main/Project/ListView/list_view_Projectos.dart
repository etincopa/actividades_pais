import 'package:flutter/material.dart';
import 'package:actividades_pais/backend/controller/main_controller.dart';
import 'package:actividades_pais/backend/model/listar_trama_monitoreo_model.dart';
import 'package:actividades_pais/backend/model/listar_trama_proyecto_model.dart';
import 'package:actividades_pais/src/pages/Login/mostrarAlerta.dart';
import 'package:actividades_pais/src/pages/MonitoreoProyectoTambo/main/Project/Monitor/monitoring_detail_form_page.dart';
import 'package:actividades_pais/src/pages/MonitoreoProyectoTambo/main/Project/Monitor/monitoring_list_page.dart';
import 'package:actividades_pais/src/pages/MonitoreoProyectoTambo/main/Project/project_detail_page.dart';
import 'package:actividades_pais/util/throw-exception.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ListViewProjet extends StatelessWidget {
  ListViewProjet({
    Key? key,
    required this.context,
    required this.oProyecto,
  }) : super(key: key);

  final BuildContext context;
  final TramaProyectoModel oProyecto;

  final MainController mainController = MainController();

  void sendMonitoreoPorEnviarByProject() async {
    try {
      List<TramaMonitoreoModel> aError =
          await mainController.sendMonitoreoByProyecto(oProyecto);
      if (aError.isNotEmpty) {
        mostrarAlerta(
          context,
          'Error!',
          'Existen documentos que no se puedieron enviar, verifique que todo los datos sean correctos.',
        );
      } else {
        mostrarAlerta(
          context,
          'Success!',
          'Se enviaron los registros correctamente.',
        );
      }
    } catch (oError) {
      var sTitle = "Alerta";
      var sMessage = oError.toString();
      if (oError is ThrowCustom) {
        sTitle = oError.typeText!;
        sMessage = oError.msg!;
      }
      mostrarAlerta(
        context,
        sTitle,
        sMessage,
      );
    }
  }

  String getAvancefisicoText(dynamic oProyecto) {
    try {
      return "${((double.parse(oProyecto.avanceFisico.toString()) * 100).toStringAsFixed(2)).toString()}%";
    } catch (oError) {
      return "NAN %";
    }
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

  double getAvancefisico(dynamic oProyecto) {
    try {
      return double.parse(oProyecto.avanceFisico.toString());
    } catch (oError) {
      return 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    String experienceLevelColor = '4495FF';
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.9),
              spreadRadius: 0,
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ]),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(children: [
                  Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: CircularPercentIndicator(
                      radius: 30.0,
                      lineWidth: 5.0,
                      percent: getAvancefisico(oProyecto),
                      center: Text(
                        getAvancefisicoText(oProyecto),
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      progressColor: getColorAvancefisico(oProyecto),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(oProyecto.tambo!,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500)),
                          const SizedBox(height: 5),
                          Text(oProyecto.estado!,
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 73, 72, 72))),
                          Text(oProyecto.departamento!,
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 73, 72, 72))),
                        ]),
                  )
                ]),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MonitorList(
                      datoProyecto: oProyecto,
                    ),
                  ));
                },
                child: AnimatedContainer(
                  height: 35,
                  padding: const EdgeInsets.all(5),
                  duration: const Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 179, 177, 177),
                          width: 1.0,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey.shade200),
                  child: const Center(
                    child: Icon(
                      Icons.dynamic_feed,
                      color: Color.fromARGB(255, 85, 84, 84),
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return MonitoringDetailNewEditPage(
                                datoProyecto: oProyecto, statusM: "CREATE");
                          },
                        ),
                      );
                    },
                    child: AnimatedContainer(
                      height: 35,
                      padding: const EdgeInsets.symmetric(
                          vertical: 3, horizontal: 15),
                      duration: const Duration(milliseconds: 300),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color.fromARGB(255, 179, 177, 177),
                            width: 1.0,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(12),
                        color: Color(int.parse('0xff$experienceLevelColor'))
                            .withAlpha(20),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.add_to_queue,
                          color: Color.fromARGB(255, 56, 54, 54),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            ProjectDetailPage(datoProyecto: oProyecto),
                      ));
                    },
                    child: AnimatedContainer(
                      height: 35,
                      padding: const EdgeInsets.symmetric(
                          vertical: 3, horizontal: 15),
                      duration: const Duration(milliseconds: 300),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color.fromARGB(255, 179, 177, 177),
                              width: 1.0,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(12),
                          color: Color(int.parse('0xff$experienceLevelColor'))
                              .withAlpha(20)),
                      child: const Center(
                        child: Icon(
                          Icons.visibility,
                          color: Color.fromARGB(255, 56, 54, 54),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () async {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            MonitorList(datoProyecto: oProyecto, estadoM: 'PE'),
                      ));
                    },
                    child: AnimatedContainer(
                      height: 35,
                      padding: const EdgeInsets.symmetric(
                          vertical: 3, horizontal: 15),
                      duration: const Duration(milliseconds: 300),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color.fromARGB(255, 179, 177, 177),
                              width: 1.0,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(12),
                          color: Color(int.parse('0xff$experienceLevelColor'))
                              .withAlpha(20)),
                      child: const Center(
                        child: Icon(
                          Icons.cloud_upload_rounded,
                          color: Color.fromARGB(255, 38, 173, 108),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                oProyecto.cui!,
                style: const TextStyle(
                  color: Color.fromARGB(255, 13, 0, 255),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
