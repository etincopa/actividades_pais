import 'dart:async';

import 'package:actividades_pais/backend/controller/main_controller.dart';
import 'package:actividades_pais/backend/model/listar_trama_monitoreo_model.dart';
import 'package:actividades_pais/backend/model/listar_trama_proyecto_model.dart';
import 'package:actividades_pais/backend/model/listar_usuarios_app_model.dart';
import 'package:actividades_pais/src/pages/Login/mostrarAlerta.dart';
import 'package:actividades_pais/src/pages/MonitoreoProyectoTambo/main/Project/ListView/list_view_monitores.dart';
import 'package:actividades_pais/src/pages/widgets/widget-custom.dart';
import 'package:actividades_pais/util/alert_question.dart';
import 'package:actividades_pais/util/busy-indicator.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? _prefs;

class MonitorList extends StatefulWidget {
  const MonitorList({Key? key, this.datoProyecto, this.estadoM})
      : super(key: key);

  final TramaProyectoModel? datoProyecto;
  final String? estadoM;

  static _MonitorListState of(BuildContext context) {
    return context.findAncestorStateOfType<_MonitorListState>()!;
  }

  @override
  _MonitorListState createState() => _MonitorListState();
}

class _MonitorListState extends State<MonitorList> {
  MainController mainController = MainController();
  List<TramaMonitoreoModel> aMonResp = [];
  late TramaProyectoModel _oProject = TramaProyectoModel.empty();

  ScrollController scrollController = ScrollController();
  bool loading = true;
  int offset = 0;
  int limit = 5;
  late bool isResume = false;
  String titleMonitor = "";

  @override
  void initState() {
    super.initState();
    if (mounted) {
      setState(() {
        loadData(context);
      });
    }
  }

  void show() {
    setState(() {
      loading = true;
    });
  }

  void hide() {
    setState(() {
      loading = false;
    });
  }

  @override
  void dispose() {
    scrollController.removeListener(() async {});
    super.dispose();
  }

  Future<String> syncMonitor(
      BuildContext context, List<TramaMonitoreoModel> a) async {
    String sMsg = "";
    try {
      List<TramaMonitoreoModel> aResp = await mainController.sendMonitoreo(a);

      if (aResp.isNotEmpty) {
        sMsg =
            'Error al enviar el Monitoreo, verifica que los datos sean correctos y vuelve a intentarlo más tarde, código de Monitoreo: ${aResp[0].idMonitoreo}';
      }
    } catch (oError) {
      sMsg =
          '¡Ups! Algo salió mal, verifica tu conexión a internet y vuelve a intentarlo más tarde.';
    }
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
    ).show(context);
  }

  Future<void> loadData(BuildContext context) async {
    if (mounted) {
      setState(() {
        loading = true;
      });
    }
    try {
      List<TramaMonitoreoModel> response = [];
      if (widget.datoProyecto != null) {
        _oProject = widget.datoProyecto!;
        if (widget.estadoM == 'PE') {
          response =
              await mainController.getAllMonitorPorEnviar(0, 0, _oProject);
        } else {
          response =
              await mainController.getAllMonitoreoByProyecto(_oProject, 0, 0);
        }
      } else {
        isResume = true;
        if (widget.estadoM == 'OTROS') {
          _prefs = await SharedPreferences.getInstance();
          UserModel oUser = UserModel(
            nombres: _prefs!.getString("nombres") ?? "",
            codigo: _prefs!.getString("codigo") ?? "",
            rol: _prefs!.getString("rol") ?? "",
          );
          response = await mainController.getAllOtherMonitoreo(oUser, 0, 0);
        } else {
          response = await mainController.getAllMonitorPorEnviar(
            0,
            0,
            TramaProyectoModel.empty(),
          );
        }
      }
      aMonResp = response;
    } catch (oError) {
      mostrarAlerta(
          context, "Warning!", "No se encontraron registros para mostrar.");
    }
    if (mounted) {
      setState(() {
        //loadData(context);
        loading = false;
      });
    }
  }

  void handleNext() {
    scrollController.addListener(() async {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {}
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.estadoM == 'PE' || widget.estadoM == 'ALL') {
      titleMonitor = 'MONITOREOS POR ENVIAR';
    } else if (widget.estadoM == 'OTROS') {
      titleMonitor = 'OTROS MONITOREOS';
    } else {
      titleMonitor = 'MonitoringListTitle'.tr;
    }
    return Scaffold(
        appBar: WidgetCustoms.appBar(
          titleMonitor,
          context: context,
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 2));
            setState(() {
              aMonResp = [];
              offset = 0;
              loadData(context);
            });
          },
          child: Container(
            child: aMonResp.isNotEmpty
                ? ListViewMonitores(
                    context: context,
                    aMonitoreo: aMonResp,
                    scrollController: scrollController)
                : Container(
                    padding: const EdgeInsets.all(20),
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 245, 246, 248)),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "No existe Monitores",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
          ),
        ),
        floatingActionButton: _getFAB(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked);
  }

  Widget _getFAB() {
    if (aMonResp.isEmpty || widget.estadoM == null) {
      return Container();
    } else {
      if (widget.estadoM == "PE" || widget.estadoM == "ALL") {
        return FloatingActionButton(
            heroTag: null,
            onPressed: () async {
              final alert = AlertQuestion(
                  title: "Información",
                  message: "¿Está Seguro de Enviar Monitores?",
                  onNegativePressed: () {
                    Navigator.of(context).pop();
                  },
                  onPostivePressed: () async {
                    Navigator.of(context).pop();
                    BusyIndicator.show(context);
                    String sMsg = await syncMonitor(context, aMonResp);
                    BusyIndicator.hide(context);
                    if (sMsg != "") {
                      await Future.delayed(const Duration(milliseconds: 100));
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
            child: const Icon(Icons.cloud_upload_rounded));
      } else {
        return Container();
      }
    }
  }
}
