import 'package:actividades_pais/backend/controller/main_controller.dart';
import 'package:actividades_pais/backend/model/listar_trama_monitoreo_model.dart';
import 'package:actividades_pais/src/pages/Login/mostrarAlerta.dart';
import 'package:actividades_pais/src/pages/MonitoreoProyectoTambo/main/Project/Monitor/monitoring_detail_form_page.dart';
import 'package:actividades_pais/util/alert_question.dart';
import 'package:actividades_pais/util/busy-indicator.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

MainController mainController = MainController();

class ListViewMonitores extends StatefulWidget {
  List<TramaMonitoreoModel> oMonitoreo;
  ScrollController? scrollController;
  ListViewMonitores({
    Key? key,
    required this.context,
    required this.oMonitoreo,
    this.scrollController,
  }) : super(key: key);

  final BuildContext context;

  @override
  State<ListViewMonitores> createState() => _ListViewMonitoresState();
}

class _ListViewMonitoresState extends State<ListViewMonitores> {
  Color getColorByStatus(String estadoMonitoreo) {
    Color c = Colors.green;
    switch (estadoMonitoreo) {
      case TramaMonitoreoModel.sEstadoINC:
        c = const Color.fromARGB(255, 255, 115, 96);
        break;
      case TramaMonitoreoModel.sEstadoPEN:
        c = const Color.fromARGB(249, 255, 152, 0);
        break;
      case TramaMonitoreoModel.sEstadoENV:
        c = Colors.green;
        break;
    }
    return c;
  }

  bool isUpdate(String estadoMonitoreo) {
    bool isUpdae = false;
    switch (estadoMonitoreo) {
      case TramaMonitoreoModel.sEstadoINC:
        isUpdae = false;
        break;
      case TramaMonitoreoModel.sEstadoPEN:
        isUpdae = true;
        break;
      case TramaMonitoreoModel.sEstadoENV:
        isUpdae = false;
        break;
      default:
    }
    return isUpdae;
  }

  bool isEditDelete(String estadoMonitoreo) {
    bool isUpdae = false;
    switch (estadoMonitoreo) {
      case TramaMonitoreoModel.sEstadoINC:
        isUpdae = true;
        break;
      case TramaMonitoreoModel.sEstadoPEN:
        isUpdae = true;
        break;
      case TramaMonitoreoModel.sEstadoENV:
        isUpdae = false;
        break;
      default:
    }
    return isUpdae;
  }

  Future<String> syncMonitor(
      BuildContext context, List<TramaMonitoreoModel> a) async {
    String sMsg = "";
    try {
      List<TramaMonitoreoModel> aResp = await mainController.sendMonitoreo(a);

      if (aResp.length > 0) {
        sMsg =
            'Error al enviar el Monitoreo, verifica que los datos sean correctos y vuelve a intentarlo m??s tarde, c??digo de Monitoreo: ${aResp[0].idMonitoreo}';
      }
    } catch (oError) {
      sMsg =
          '??Ups! Algo sali?? mal, verifica tu conexi??n a internet y vuelve a intentarlo m??s tarde.';
    }
    //throw Exception('??Ups! Algo sali?? mal, vuelve a intentarlo mas tarde.');
    return sMsg;
  }

  void showSnackbar({required bool success, required String text}) {
    AnimatedSnackBar.rectangle(
      'I'.tr,
      text,
      type:
          success ? AnimatedSnackBarType.success : AnimatedSnackBarType.warning,
      brightness: Brightness.light,
      mobileSnackBarPosition: MobileSnackBarPosition.top,
    ).show(widget.context);
  }

  @override
  Widget build(BuildContext context) {
    String experienceLevelColor = "4495FF";
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      controller: widget.scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: widget.oMonitoreo.length,
      itemBuilder: (context, index) {
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
            ],
          ),
          child: Column(
            children: [
              Container(
                child: Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          widget.oMonitoreo[index].tambo!,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 37, 71, 194),
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Chip(
                      label: Text(
                          widget.oMonitoreo[index].actividadPartidaEjecutada!),
                      backgroundColor: Colors.green,
                      labelStyle: const TextStyle(color: Colors.white)),
                  const Padding(padding: EdgeInsets.all(10.0)),
                  Chip(
                    label: Text(widget.oMonitoreo[index].estadoMonitoreo!),
                    backgroundColor: getColorByStatus(
                        widget.oMonitoreo[index].estadoMonitoreo!),
                    labelStyle: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(children: [
                      const SizedBox(width: 10),
                      Flexible(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    'Estado Avance: ',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 62, 61, 61),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    widget.oMonitoreo[index].estadoAvance!,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'Avance Fisico Acumulado: ',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 62, 61, 61),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    "${((widget.oMonitoreo[index].avanceFisicoAcumulado! * 100).toStringAsFixed(2)).toString()}%",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'Nivel Riesgo: ',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 62, 61, 61),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    widget.oMonitoreo[index].nivelRiesgo!,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  const Text(
                                    'Fecha Monitoreo: ',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 62, 61, 61),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    widget.oMonitoreo[index].fechaMonitoreo!,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ]),
                      )
                    ]),
                  ),
                  if (isUpdate(widget.oMonitoreo[index].estadoMonitoreo!))
                    GestureDetector(
                      onTap: () async {
                        final alert = AlertQuestion(
                            title: "Informaci??n",
                            message: "??Est?? Seguro de Enviar Monitoreo?",
                            onNegativePressed: () {
                              Navigator.of(context).pop();
                            },
                            onPostivePressed: () async {
                              Navigator.of(context).pop();
                              BusyIndicator.show(context);
                              String sMsg = await syncMonitor(
                                  context, [widget.oMonitoreo[index]]);
                              BusyIndicator.hide(context);
                              if (sMsg != "") {
                                await Future.delayed(
                                    const Duration(milliseconds: 100));
                                mostrarAlerta(context, "Error!", sMsg);
                              } else {
                                showSnackbar(
                                  success: true,
                                  text: 'Monitor Enviado Correctamente',
                                );
                                setState(() {});
                              }
                            });

                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      },
                      child: AnimatedContainer(
                        height: 35,
                        padding: const EdgeInsets.all(5),
                        duration: const Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromARGB(255, 179, 177, 177),
                            width: 1.0,
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          color: Color(
                            int.parse("0xff${experienceLevelColor}"),
                          ).withAlpha(20),
                        ),
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
              const SizedBox(height: 20),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        if (isEditDelete(
                            widget.oMonitoreo[index].estadoMonitoreo!))
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    MonitoringDetailNewEditPage(
                                        datoMonitor: widget.oMonitoreo[index],
                                        statusM: 'UPDATE'),
                              ));
                            },
                            child: AnimatedContainer(
                              height: 35,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 3, horizontal: 15),
                              duration: const Duration(milliseconds: 300),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color.fromARGB(
                                          255, 179, 177, 177),
                                      width: 1.0,
                                      style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(12),
                                  color: Color(int.parse(
                                          "0xff${experienceLevelColor}"))
                                      .withAlpha(20)),
                              child: const Center(
                                child: Icon(
                                  Icons.edit,
                                  color: Color.fromARGB(255, 56, 54, 54),
                                ),
                              ),
                            ),
                          ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => MonitoringDetailNewEditPage(
                                  datoMonitor: widget.oMonitoreo[index],
                                  statusM: 'LECTURA'),
                            ));
                          },
                          child: AnimatedContainer(
                            height: 35,
                            padding: const EdgeInsets.symmetric(
                                vertical: 3, horizontal: 15),
                            duration: const Duration(milliseconds: 300),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: const Color.fromARGB(
                                        255, 179, 177, 177),
                                    width: 1.0,
                                    style: BorderStyle.solid),
                                borderRadius: BorderRadius.circular(12),
                                color: Color(int.parse(
                                        "0xff${experienceLevelColor}"))
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
                        if (isEditDelete(
                            widget.oMonitoreo[index].estadoMonitoreo!))
                          GestureDetector(
                            onTap: () async {
                              final alert = AlertQuestion(
                                  title: "Informaci??n",
                                  message:
                                      "??Est?? Seguro de Eliminar Monitoreo?",
                                  onNegativePressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  onPostivePressed: () async {
                                    Navigator.of(context).pop();
                                    BusyIndicator.show(context);
                                    bool res =
                                        await mainController.deleteMonitor(
                                            widget.oMonitoreo[index]);
                                    BusyIndicator.hide(context);
                                    if (res) {
                                      showSnackbar(
                                        success: true,
                                        text: 'Monitor Eliminado Correctamente',
                                      );
                                      widget.oMonitoreo.removeAt(index);
                                      setState(() {});
                                    } else {
                                      // ignore: use_build_context_synchronously
                                      AnimatedSnackBar.rectangle(
                                        'Error',
                                        'No se pudo Enviar Monitore',
                                        type: AnimatedSnackBarType.error,
                                        brightness: Brightness.light,
                                        mobileSnackBarPosition:
                                            MobileSnackBarPosition.top,
                                      ).show(context);
                                    }
                                  });

                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return alert;
                                },
                              );
                            },
                            child: AnimatedContainer(
                              height: 35,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 3, horizontal: 15),
                              duration: const Duration(milliseconds: 300),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: const Color.fromARGB(
                                        255, 179, 177, 177),
                                    width: 1.0,
                                    style: BorderStyle.solid),
                                borderRadius: BorderRadius.circular(12),
                                color: Color(
                                  int.parse("0xff${experienceLevelColor}"),
                                ).withAlpha(20),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.delete,
                                  color: Color.fromARGB(255, 241, 85, 64),
                                ),
                              ),
                            ),
                          ),
                        const SizedBox(width: 10),
                      ],
                    ),
                    Expanded(
                      child: Text(
                        textAlign: TextAlign.right,
                        widget.oMonitoreo[index].idMonitoreo!,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 13, 0, 255),
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
