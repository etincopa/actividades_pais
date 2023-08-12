import 'dart:async';

import 'package:actividades_pais/backend/controller/main_controller.dart';
import 'package:actividades_pais/backend/model/listar_programa_actividad_model.dart';
import 'package:actividades_pais/backend/model/listar_usuarios_app_model.dart';
import 'package:actividades_pais/src/pages/ProgramacionActividades/Search/list_view_Programacion.dart';
import 'package:actividades_pais/src/pages/ProgramacionActividades/Search/programcion_search.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:actividades_pais/src/pages/widgets/widget-custom.dart';

SharedPreferences? _prefs;
MainController mainController = MainController();

class ProgramacionListPage extends StatefulWidget {
  const ProgramacionListPage({Key? key}) : super(key: key);

  @override
  _ProgramacionListPageState createState() => _ProgramacionListPageState();
}

class _ProgramacionListPageState extends State<ProgramacionListPage>
    with TickerProviderStateMixin<ProgramacionListPage> {
  List<ProgramacionActividadModel> aProgramacion = [];

  Animation<double>? _animation;
  AnimationController? _controller;

  ScrollController scrollController = ScrollController();
  bool loading = true;
  bool isEndPagination = false;
  int offset = 0;
  int limit = 50;

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

      final List<ProgramacionActividadModel> response =
          await mainController.getAllProgramacion(
        '',
        limit,
        offset,
      );
      if (response.isEmpty) {
        isEndPagination = true;
      } else {
        aProgramacion = aProgramacion + response;
        offset = offset + limit;
      }
      setState(() {
        loading = false;
      });
    }
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
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: WidgetCustoms.appBar(
        'ProgramacionListTitle'.tr,
        context: context,
        iconAct: Icons.search,
        onPressedAct: () {
          showSearch(
            context: context,
            delegate: ProgramacionSearchDelegate(aProgramacion),
          );
        },
      ),
      body: Container(
        child: RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 2));
            setState(() {
              isEndPagination = false;
              readJson(offset);
            });
          },
          child: aProgramacion.isNotEmpty
              ? Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(10),
                        controller: scrollController,
                        itemCount: aProgramacion.length,
                        itemBuilder: (context, index) {
                          return ListViewProgramacion(
                            context: context,
                            oProgramacion: aProgramacion[index],
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
                        'No existe niguna programación',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
