import 'dart:async';

import 'package:actividades_pais/backend/controller/main_controller.dart';
import 'package:actividades_pais/backend/model/listar_trama_proyecto_model.dart';
import 'package:actividades_pais/backend/model/listar_usuarios_app_model.dart';
import 'package:actividades_pais/src/pages/Home/home.dart';
import 'package:actividades_pais/src/pages/MonitoreoProyectoTambo/main/Project/ListView/list_view_Projectos.dart';
import 'package:actividades_pais/src/pages/MonitoreoProyectoTambo/main/Project/Monitor/monitoring_list_page.dart';
import 'package:actividades_pais/src/pages/MonitoreoProyectoTambo/main/Project/Search/project_search.dart';
import 'package:actividades_pais/src/pages/MonitoreoProyectoTambo/main/Project/Monitor/monitoring_detail_form_page.dart';
import 'package:actividades_pais/src/pages/MonitoreoProyectoTambo/main/Components/fab.dart';
import 'package:actividades_pais/util/alert_question.dart';
import 'package:actividades_pais/util/busy-indicator.dart';
import 'package:actividades_pais/util/throw-exception.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:actividades_pais/src/pages/widgets/widget-custom.dart';

SharedPreferences? _prefs;
MainController mainController = MainController();

class ProjectListPage extends StatefulWidget {
  const ProjectListPage({Key? key}) : super(key: key);

  @override
  _ProjectListPageState createState() => _ProjectListPageState();
}

class _ProjectListPageState extends State<ProjectListPage>
    with TickerProviderStateMixin<ProjectListPage> {
  List<TramaProyectoModel> aProyecto = [];

  Animation<double>? _animation;
  AnimationController? _controller;

  ScrollController scrollController = ScrollController();
  bool loading = true;
  bool isEndPagination = false;
  int offset = 0;
  int limit = 15;

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
    if (mounted) {
      readJson(offset);
      handleNext();
    }
  }

  @override
  void dispose() {
    scrollController.removeListener(() async {});
    super.dispose();
  }

  Future<void> readJson(paraOffset) async {
    if (!isEndPagination) {
      setState(() {
        loading = true;
      });

      _prefs = await SharedPreferences.getInstance();
      UserModel oUser = UserModel(
        nombres: _prefs!.getString('nombres') ?? '',
        codigo: _prefs!.getString('codigo') ?? '',
        rol: _prefs!.getString('rol') ?? '',
      );

      final List<TramaProyectoModel> response =
          await mainController.getAllProyectoByUserSearch(
        oUser,
        '',
        limit,
        offset,
      );
      if (response.isEmpty) {
        isEndPagination = true;
      } else {
        aProyecto = aProyecto + response;
        offset = offset + limit;
      }
      setState(() {
        loading = false;
      });
    }
  }

  Future<List<TramaProyectoModel>> getAllProjectForReport() async {
    setState(() {
      loading = true;
    });

    _prefs = await SharedPreferences.getInstance();
    UserModel oUser = UserModel(
      nombres: _prefs!.getString('nombres') ?? '',
      codigo: _prefs!.getString('codigo') ?? '',
      rol: _prefs!.getString('rol') ?? '',
    );

    final List<TramaProyectoModel> response =
        await mainController.getAllProyectoByUserSearch(oUser, '', 0, 0);

    setState(() {
      loading = false;
    });

    return response;
  }

  void handleNext() {
    scrollController.addListener(() async {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        readJson(offset);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetCustoms.appBar(
        'ProjectListTitle'.tr,
        context: context,
        icon: Icons.arrow_back,
        onPressed: () => {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => const HomePagePais(),
              ),
              (route) => false),
        },
        iconAct: Icons.search,
        onPressedAct: () async {
          showSearch(
            context: context,
            delegate: ProjectSearchDelegate(),
          );
        },
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 2));
          setState(() {
            aProyecto = [];
            offset = 0;
            isEndPagination = false;
            readJson(offset);
          });
        },
        child: aProyecto.isNotEmpty
            ? Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(10),
                      controller: scrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: aProyecto.length,
                      itemBuilder: (context, index) {
                        return ListViewProjet(
                          context: context,
                          oProyecto: aProyecto[index],
                        );
                      },
                    ),
                  ),
                  if (loading == true)
                    const Padding(
                      padding: EdgeInsets.only(
                        top: 10,
                        bottom: 40,
                      ),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  if (isEndPagination == true)
                    Container(
                      padding: const EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                      ),
                      color: Colors.blue,
                      child: const Center(
                        child: Text('Has obtenido todo el contenido.'),
                      ),
                    ),
                ],
              )
            : Container(
                padding: const EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 245, 246, 248)),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'No existe nigún proyecto asignado',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: ExpandedAnimationFab(
        items: [
          FabItem(
            "Nuevo Monitoreo",
            Icons.add_to_queue,
            onPress: () {
              _controller!.reverse();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return MonitoringDetailNewEditPage(
                      datoProyecto: null,
                    );
                  },
                ),
              );
            },
          ),
          FabItem(
            "Otros Monitoreos",
            Icons.remove_red_eye,
            onPress: () {
              _controller!.reverse();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return const MonitorList(
                      estadoM: 'OTROS',
                    );
                  },
                ),
              );
            },
          ),
          /*FabItem(
            "Reporte",
            Icons.document_scanner_rounded,
            onPress: () async {
              try {
                List<TramaProyectoModel> aList = await getAllProjectForReport();
                if (aList.isNotEmpty) {
                  _controller!.reverse();
                  final oDataPdf = ReportDto(
                    customer: 'Proyectos Tambo',
                    address: 'PAIS',
                    items: aList,
                    name: 'REPORTE PROYECTOS TAMBO',
                  );

                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (builder) =>
                          ReportProjectPage(dataPdf: oDataPdf),
                    ),
                  );
                }
              } catch (oError) {
                setState(() {
                  loading = false;
                });
              }
            },
          ),*/
          FabItem(
            "Sincronizar",
            Icons.cloud_sync_rounded,
            onPress: () async {
              BusyIndicator.show(context);
              try {
                await mainController.syncLoadInitialData();
                BusyIndicator.hide(context);
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const HomePagePais(),
                ));
                Fluttertoast.showToast(
                  msg: 'Los registros se sincronizan con éxito',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 2,
                  backgroundColor: const Color.fromARGB(255, 133, 243, 168),
                  textColor: Colors.black,
                  fontSize: 16.0,
                );
              } catch (oError) {
                var sMessage = oError.toString();
                if (oError is ThrowCustom) {
                  sMessage = oError.msg!;
                }
                BusyIndicator.hide(context);
                Fluttertoast.showToast(
                  msg: sMessage,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 2,
                  backgroundColor: const Color.fromARGB(255, 252, 95, 74),
                  textColor: Colors.black,
                  fontSize: 16.0,
                );
              }

              _controller!.reverse();
            },
          ),
          FabItem(
            "Eliminar Data",
            Icons.cleaning_services_sharp,
            onPress: () async {
              final alert = AlertQuestion(
                title: "Alerta!",
                message:
                    "¿Está Seguro de eliminar todos los registros locales?",
                onNegativePressed: () {
                  Navigator.of(context).pop();
                },
                onPostivePressed: () async {
                  BusyIndicator.show(context);
                  try {
                    await mainController.deleteAllMonitorByEstadoENV();
                    BusyIndicator.hide(context);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const HomePagePais(),
                      ),
                    );
                    Fluttertoast.showToast(
                      msg: 'Los registros se eliminaron con éxito',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 2,
                      backgroundColor: const Color.fromARGB(255, 133, 243, 168),
                      textColor: Colors.black,
                      fontSize: 16.0,
                    );
                  } catch (oError) {
                    var sMessage = oError.toString();
                    if (oError is ThrowCustom) {
                      sMessage = oError.msg!;
                    }
                    BusyIndicator.hide(context);
                    Fluttertoast.showToast(
                      msg: sMessage,
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 2,
                      backgroundColor: const Color.fromARGB(255, 252, 95, 74),
                      textColor: Colors.black,
                      fontSize: 16.0,
                    );
                  }
                  _controller!.reverse();
                },
              );

              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return alert;
                },
              );
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
}
