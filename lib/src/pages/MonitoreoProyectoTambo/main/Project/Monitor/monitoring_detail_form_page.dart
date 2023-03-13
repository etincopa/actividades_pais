import 'dart:async';
import 'dart:io';

import 'package:actividades_pais/backend/controller/main_controller.dart';
import 'package:actividades_pais/backend/model/listar_combo_item.dart';
import 'package:actividades_pais/backend/model/listar_trama_monitoreo_model.dart';
import 'package:actividades_pais/backend/model/listar_trama_proyecto_model.dart';
import 'package:actividades_pais/backend/model/listar_usuarios_app_model.dart';
import 'package:actividades_pais/backend/model/obtener_ultimo_avance_partida_model.dart';
import 'package:actividades_pais/src/pages/MonitoreoProyectoTambo/main/Project/Search/project_search_otro.dart';
import 'package:actividades_pais/src/pages/MonitoreoProyectoTambo/main/Project/src/image_controller.dart';
import 'package:actividades_pais/src/pages/MonitoreoProyectoTambo/main/Project/src/image_multiple.dart';
import 'package:actividades_pais/src/pages/MonitoreoProyectoTambo/main/main_footer_all_option.dart';
import 'package:actividades_pais/src/pages/widgets/widget-custom.dart';
import 'package:actividades_pais/util/alert_question.dart';
import 'package:actividades_pais/util/busy-indicator.dart';
import 'package:actividades_pais/util/check_geolocator.dart';
import 'package:actividades_pais/util/throw-exception.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? _prefs;

class MonitoringDetailNewEditPage extends StatefulWidget {
  TramaProyectoModel? datoProyecto;
  TramaMonitoreoModel? datoMonitor;

  List<ComboItemModel> cbEMONI = [];
  List<ComboItemModel> cbNRIES = [];
  List<ComboItemModel> cbEAVAN = [];
  List<ComboItemModel> cbPEJEC = [];
  List<ComboItemModel> cbPIDEO = [];
  List<ComboItemModel> cbASOLU = [];
  List<ComboItemModel> cbRIDEN = [];

  final String? statusM;
  MonitoringDetailNewEditPage(
      {Key? key, this.datoProyecto, this.statusM, this.datoMonitor})
      : super(key: key);

  @override
  _MonitoringDetailNewEditPageState createState() =>
      _MonitoringDetailNewEditPageState();
}

class _MonitoringDetailNewEditPageState
    extends State<MonitoringDetailNewEditPage> {
  final _formKey = GlobalKey<FormState>();
  final _idMonitor = TextEditingController();
  final _cuiCtr = TextEditingController();
  final _dateMonitor = TextEditingController();
  final _advanceFEA = TextEditingController();
  final _advanceFEP = TextEditingController();
  final _obsMonitor = TextEditingController();
  final _dateObra = TextEditingController();
  final _longitud = TextEditingController();
  final _latitud = TextEditingController();

  List<DataRow> aDataRow = [];
  bool _enabledFormAvance = false;
  bool _enabledF = true;
  int idM = 0;
  String titleMonitor = "";
  String fechaMonitoreo = DateFormat("yyyy-MM-dd").format(
    DateTime.now(),
  );
  String? _ciu = "";
  String? _snip = "";
  String? _tambo = "";

  TramaMonitoreoModel oMonitoreo = TramaMonitoreoModel.empty();

  String? _statusMonitor; //Estado Monitoreo
  String? _statusAdvance; // Estado Avance
  String? _valuePartidaEje; //Partida Ejecutada
  String? _valueProblemaIO; //Problema Identificado
  String? _valueAlternSolucion; //Alternativa solucion
  String? _valueRiesgo; // Riesgo Identificado
  String? _valueNivelRiesgo; //Nivel Riesgo Identificado XXX

  final MainController mainCtr = MainController();
  ImageController controller = ImageController();
  final String _imgPartidaEjecutada = 'imgPartidaEjecutada';
  List<bool> expandedPE = [false, false];
  final String _imgProblemaIdentificado = 'imgProblemaIdentificado';
  List<bool> expandedPI = [false, false];
  List<bool> expandedPI2 = [false, false];
  final String _imgRiesgoIdentificado = 'imgRiesgoIdentificado';
  List<bool> expandedRI = [false, false];

  TramaMonitoreoModel oMonitor = TramaMonitoreoModel.empty();

  String sShowMessage = '';
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

  @override
  void initState() {
    super.initState();
    checkGeolocator();
    getMaestra().then((o) {
      if (mounted) {
        if (widget.statusM == "CREATE" || widget.statusM == "SEARCH") {
          loadData(context);
        }
        if (widget.statusM == "UPDATE") {
          buildFormData(widget.datoMonitor!);
        }
        if (widget.statusM == "LECTURA") {
          _enabledF = false;
          buildFormData(widget.datoMonitor!);
        }
      }
      setState(() {});
    });
  }

  Future<void> checkGeolocator() async {
    try {
      await CheckGeolocator().check();
    } catch (oError) {
      var sMessage = oError.toString();
      if (oError is ThrowCustom) {
        sMessage =
            '${oError.msg!}, vaya a Configuración de su dispositivo > Privacidad para otorgar permisos a la aplicación.';
      }
      sShowMessage = sMessage;

      setState(() {
        sShowMessage = sMessage;
      });
    }
  }

  Future<void> getMaestra() async {
    try {
      /**
       * Obtener los registros de cada combo
       */

      try {
        widget.cbASOLU =
            await mainCtr.getListComboItemByType(ComboItemModel.cbASOLU, 0, 0);

        widget.cbEAVAN =
            await mainCtr.getListComboItemByType(ComboItemModel.cbEAVAN, 0, 0);

        widget.cbEMONI =
            await mainCtr.getListComboItemByType(ComboItemModel.cbEMONI, 0, 0);

        widget.cbNRIES =
            await mainCtr.getListComboItemByType(ComboItemModel.cbNRIES, 0, 0);

        widget.cbPEJEC =
            await mainCtr.getListComboItemByType(ComboItemModel.cbPEJEC, 0, 0);

        widget.cbPIDEO =
            await mainCtr.getListComboItemByType(ComboItemModel.cbPIDEO, 0, 0);

        widget.cbRIDEN =
            await mainCtr.getListComboItemByType(ComboItemModel.cbRIDEN, 0, 0);
      } catch (oError) {
        print(oError);
      }

      /**
       * Agregar valor por defecto de los combos
       * - Seleccione una opción
       * en la primera posición
       */

      String sPlaceholder = TramaMonitoreoModel.sOptDropdownDefault;
      widget.cbASOLU.insert(
        0,
        ComboItemModel(
          codigo1: "0",
          descripcion: "$sPlaceholder para: ALTERNATIVA SOLUCION",
        ),
      );
      widget.cbEAVAN.insert(
        0,
        ComboItemModel(
          codigo1: "0",
          descripcion: "$sPlaceholder para: ESTADO AVANCE",
        ),
      );
      widget.cbEMONI.insert(
        0,
        ComboItemModel(
          codigo1: "0",
          descripcion: "$sPlaceholder para: ESTADO MONITOREO",
        ),
      );
      widget.cbNRIES.insert(
        0,
        ComboItemModel(
          codigo1: "0",
          descripcion: "$sPlaceholder  para: NIVEL RIESGO",
        ),
      );

      widget.cbPEJEC.insert(
        0,
        ComboItemModel(
          codigo1: "0",
          descripcion: "$sPlaceholder  para: PARTIDA EJECUTADA",
        ),
      );
      widget.cbPIDEO.insert(
        0,
        ComboItemModel(
          codigo1: "0",
          descripcion: "$sPlaceholder  para: PROBLEMA IDENTIFICADO OBRA",
        ),
      );
      widget.cbRIDEN.insert(
        0,
        ComboItemModel(
          codigo1: "0",
          descripcion: "$sPlaceholder  para: RIESGO IDENTIFICADO",
        ),
      );

      /**
       * Seleccionar el valor por defecto de los combos
       * - Seleccione una opción
       */
      _statusMonitor = "43";
      _statusAdvance = "0";
      _valuePartidaEje = "0";
      _valueProblemaIO = "0";
      _valueAlternSolucion = "0";
      _valueRiesgo = "0";
      _valueNivelRiesgo = widget.cbNRIES[0].descripcion;
    } catch (oError) {
      var sTitle = 'Error';
      var sMessage = oError.toString();
      if (oError is ThrowCustom) {
        sTitle = oError.typeText!;
        sMessage =
            '${oError.msg!}, vaya a Configuración de su dispositivo > Privacidad para otorgar permisos a la aplicación.';
      }
      sShowMessage = sMessage;

      setState(() {});
    }
  }

  Future<void> loadData(BuildContext context) async {
    try {
      if (widget.datoProyecto != null) {
        oMonitoreo = await mainCtr.buildNewMonitor(widget.datoProyecto!.cui!);
      }
      await buildFormData(oMonitoreo);

      setState(() {});
    } catch (oError) {
      print(oError);
    }
  }

  String getPorcent(double value) {
    return ((value * 100).toStringAsFixed(2)).toString();
  }

  int getValueSelected(int value) {
    return (value == 0) ? 0 : value;
  }

  String _toString(dynamic value, {String? def}) {
    return value != null ? value.toString() : def ?? '';
  }

  buildFormData(TramaMonitoreoModel o) {
    oMonitor = o;
    controller.itemsImagesAll = {};

    titleMonitor = o.tambo! == "" ? 'MONITOR' : o.tambo!;
    idM = o.id!;
    _snip = o.snip;
    _ciu = o.cui;
    _cuiCtr.text = o.cui!;
    _idMonitor.text = o.idMonitoreo!;

    _tambo = o.tambo;
    _dateMonitor.text = o.fechaMonitoreo!;
    _advanceFEA.text = getPorcent(o.avanceFisicoAcumulado!);
    _advanceFEP.text = getPorcent(o.avanceFisicoPartida!);
    _obsMonitor.text = o.observaciones!;
    _dateObra.text = o.fechaTerminoEstimado!;
    _longitud.text = o.longitud!;
    _latitud.text = o.latitud!;

    _statusMonitor = _toString(o.idEstadoMonitoreo, def: '0');
    _statusAdvance = _toString(o.idEstadoAvance, def: '0');
    _valuePartidaEje = _toString(o.idAvanceFisicoPartida, def: '0');
    _valueProblemaIO = _toString(o.idProblemaIdentificado, def: '0');
    _valueAlternSolucion = _toString(o.idAlternativaSolucion, def: '0');
    _valueRiesgo = _toString(o.idRiesgoIdentificado, def: '0');

    _valueNivelRiesgo =
        o.nivelRiesgo == "" ? widget.cbNRIES[0].descripcion : o.nivelRiesgo;

    List<String?> listaImage = [];
    listaImage.addAll([
      o.imgActividad,
      o.imgActividad1,
      o.imgActividad2,
      o.imgActividad3,
      o.imgActividad4
    ]);

    for (var item in listaImage) {
      if (!item.toString().contains("opt/uploads")) {
        if (item != null && item != "") {
          controller.itemsImagesAll.addAll(
            {
              _imgPartidaEjecutada: item.split(","),
            },
          );
        }
      }
    }

    listaImage = [];
    listaImage.addAll([
      o.imgProblema,
      o.imgProblema1,
      o.imgProblema2,
      o.imgProblema3,
      o.imgProblema4
    ]);
    for (var item in listaImage) {
      if (!item.toString().contains("opt/uploads")) {
        if (item != null && item != "") {
          controller.itemsImagesAll.addAll(
            {
              _imgProblemaIdentificado: item.split(","),
            },
          );
        }
      }
    }

    listaImage = [];
    listaImage.addAll([
      o.imgRiesgo,
      o.imgRiesgo1,
      o.imgRiesgo2,
      o.imgRiesgo3,
      o.imgRiesgo4,
    ]);
    for (var item in listaImage) {
      if (!item.toString().contains("opt/uploads")) {
        if (item != null && item != "") {
          controller.itemsImagesAll.addAll(
            {
              _imgRiesgoIdentificado: item.split(","),
            },
          );
        }
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: WidgetCustoms.appBar(
        titleMonitor == "" ? "MONITOR" : titleMonitor,
        context: context,
        icon: Icons.arrow_back,
        onPressed: () => {
          if (widget.statusM == "SEARCH")
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => MainFooterAllOptionPage(),
                ),
              )
            }
          else
            {
              Navigator.pop(context, () {
                setState(() {});
              }),
            }
        },
        iconAct: titleMonitor == "" ? Icons.search : Icons.monitor,
        onPressedAct: () {
          if (titleMonitor == "") {
            showSearch(
              context: context,
              delegate: ProjetSearchOtroDelegate(),
            );
          }
        },
      ),

      /**
       * Formulario
       */
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(32.0),
          children: [
            /**
               * CODIGO UNICO DE PROYECTO
              */
            Text(
              'FldMonitor001'.tr,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
            TextFormField(
              controller: _cuiCtr,
              validator: (v) => v!.isEmpty ? 'Required'.tr : null,
              enabled: false,
            ),
            /**
               * ID MONITOREO
              */
            const SizedBox(height: 10),
            Text(
              'FldMonitor002'.tr,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
            TextFormField(
              controller: _idMonitor,
              validator: (v) => v!.isEmpty ? 'Required'.tr : null,
              enabled: false,
            ),
            /**
               * ESTADO MONITOREO
              */
            const SizedBox(height: 10),
            Text(
              'FldMonitor003'.tr,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
            DropdownButtonFormField(
                isExpanded: true,
                isDense: false,
                value: _statusMonitor,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
                items: widget.cbEMONI.isNotEmpty
                    ? widget.cbEMONI.map((ComboItemModel map) {
                        return DropdownMenuItem<String>(
                          value: map.codigo1.toString(),
                          child: Row(
                            children: [
                              Expanded(
                                child: map.descripcion
                                        .toString()
                                        .toUpperCase()
                                        .contains("SELECCIONE UNA OPCIÓN")
                                    ? Text(
                                        map.descripcion.toString(),
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Theme.of(context).hintColor,
                                        ),
                                      )
                                    : Text(
                                        map.descripcion.toString(),
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                              ),
                            ],
                          ),
                        );
                      }).toList()
                    : null,
                onChanged: null),

            /**
             * FECHA MONITOREO
             */
            const SizedBox(height: 10),
            Text(
              'FldMonitor004'.tr,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
            TextFormField(
              controller: _dateMonitor,
              validator: (v) => v!.isEmpty ? 'Required'.tr : null,
              enabled: false,
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );

                if (pickedDate != null) {
                  setState(() {
                    _dateMonitor.text = _dateMonitor.text;
                  });
                }
              },
            ),
            /**
            * % AVANCE FISICO ESTIMADO ACUMULADO
            */
            const SizedBox(height: 10),
            Text(
              'FldMonitor005'.tr,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
            TextFormField(
              controller: _advanceFEA,
              keyboardType: TextInputType.number,
              maxLength: 6,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              enabled: _enabledF,
              validator: (v) {
                final intNumber = double.tryParse(v!);
                if (intNumber != null && intNumber > 0 && intNumber <= 100) {
                  return null;
                }
                return 'Ingrese el numero de 0 A 100';
              },
            ),

            /**
             * % ESTADO DE AVANCE
             */
            const SizedBox(height: 5),
            Text(
              'FldMonitor006'.tr,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
            DropdownButtonFormField(
              isExpanded: true,
              isDense: false,
              value: _statusAdvance,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
              validator: (value) => value
                          .toString()
                          .toUpperCase()
                          .contains("SELECCIONE UNA OPCIÓN") ||
                      value == ""
                  ? 'Required'.tr
                  : null,
              items: widget.cbEAVAN.isNotEmpty
                  ? widget.cbEAVAN.map((ComboItemModel map) {
                      return DropdownMenuItem<String>(
                        value: map.codigo1.toString(),
                        child: Row(
                          children: [
                            Expanded(
                              child: map.descripcion
                                      .toString()
                                      .toUpperCase()
                                      .contains("SELECCIONE UNA OPCIÓN")
                                  ? Text(
                                      map.descripcion.toString(),
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Theme.of(context).hintColor,
                                      ),
                                    )
                                  : Text(
                                      map.descripcion.toString(),
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      );
                    }).toList()
                  : null,
              onChanged: _enabledF
                  ? (String? value) {
                      _statusAdvance = value;
                    }
                  : null,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "REGISTROS DE PARTIDAS EJECUTADAS:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.add_circle),
                  color: const Color.fromARGB(255, 84, 105, 226),
                  onPressed: () async {
                    if (!_enabledFormAvance) {
                      setState(() {
                        _enabledFormAvance = true;
                      });
                    }

                    /*
                    if (_formKey.currentState!.validate()) {
                      await _showMyDialog(
                        context,
                        "PARTIDAS EJECUTADA",
                      );
                    }
                    */
                  },
                  // color: Colors.pink,
                ),
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                    sortColumnIndex: 2,
                    sortAscending: true,
                    headingRowColor: MaterialStateProperty.all(
                      const Color.fromARGB(255, 179, 180, 179),
                    ),
                    columnSpacing: 40,
                    decoration: const BoxDecoration(
                      border: Border(
                        right: BorderSide(
                          color: Colors.grey,
                          width: 0.5,
                        ),
                      ),
                    ),
                    columns: const [
                      DataColumn(label: Text("N°")),
                      DataColumn(label: Text("Partida Ejecutada")),
                      DataColumn(label: Text("% Avance")),
                    ],
                    rows: aDataRow),
              ),
            ),
            const SizedBox(height: 10),
            _enabledFormAvance
                ? Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(15),
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 236, 236, 236),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        /**
                   * PARTIDA EJECUTADA
                   */
                        const SizedBox(height: 10),
                        Text(
                          'FldMonitor007'.tr,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        DropdownButtonFormField(
                          isExpanded: true,
                          isDense: false,
                          value: _valuePartidaEje,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                          validator: (value) => value
                                      .toString()
                                      .toUpperCase()
                                      .contains("SELECCIONE UNA OPCIÓN") ||
                                  value == ""
                              ? 'Required'.tr
                              : null,
                          items: widget.cbPEJEC.isNotEmpty
                              ? widget.cbPEJEC.map(
                                  (ComboItemModel map) {
                                    return DropdownMenuItem<String>(
                                      value: map.codigo1.toString(),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: map.descripcion
                                                    .toString()
                                                    .toUpperCase()
                                                    .contains(
                                                        "SELECCIONE UNA OPCIÓN")
                                                ? Text(
                                                    map.descripcion.toString(),
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Theme.of(context)
                                                          .hintColor,
                                                    ),
                                                  )
                                                : Text(
                                                    map.descripcion.toString(),
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ).toList()
                              : null,
                          onChanged: _enabledF
                              ? (String? value) async {
                                  String sValue =
                                      value.toString().toUpperCase();
                                  _valuePartidaEje = value.toString();
                                  try {
                                    TramaProyectoModel oProyect =
                                        TramaProyectoModel.empty();
                                    oProyect.numSnip = _snip;

                                    UltimoAvancePartidaModel oLastAvance =
                                        await mainCtr
                                            .getUltimoAvanceByProyectoAndPartida(
                                      oProyect,
                                      _valuePartidaEje!,
                                    );

                                    _advanceFEP.text =
                                        ((oLastAvance.avanceFisicoPartida! *
                                                    100)
                                                .toStringAsFixed(2))
                                            .toString();
                                  } catch (e) {
                                    _advanceFEP.text = '0.00';
                                  }

                                  setState(() {});
                                }
                              : null,
                        ),
                        /**
                   * % AVANCE FISICO ACUMULADO PARTIDA
                   */
                        const SizedBox(height: 10),
                        Text(
                          'FldMonitor008'.tr,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextFormField(
                          controller: _advanceFEP,
                          maxLength: 6,
                          keyboardType: TextInputType.number,
                          validator: (v) => v!.isEmpty ? 'Required'.tr : null,
                          enabled: _enabledF,
                        ),
                        /**
                   * Fotos de la Partida Ejecutada(Obligatorio) 
                   */
                        _enabledF
                            ? OutlinedButton.icon(
                                label: Text(
                                  'FldMonitor009'.tr,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                icon: const Icon(Icons.image),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.black,
                                ),
                                onPressed: () async {
                                  await _showChoiceDialog(
                                      context, _imgPartidaEjecutada);
                                  setState(() {});
                                },
                              )
                            : Text(
                                'FldMonitor009'.tr,
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                        const SizedBox(height: 10),
                        myExpansionPanelListethod(
                            _imgPartidaEjecutada, expandedPE),
                        Container(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _enabledFormAvance = false;
                                  });
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                    const Color.fromARGB(255, 242, 94, 83),
                                  ),
                                ),
                                child: const Text("Cancelar"),
                              ),
                              const Padding(padding: EdgeInsets.all(10)),
                              ElevatedButton(
                                onPressed: () async {
                                  setState(() {
                                    _enabledFormAvance = false;
                                  });
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                    const Color.fromARGB(255, 44, 162, 99),
                                  ),
                                ),
                                child: const Text("Agregar"),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : SizedBox(),
            /**
             * OBSERVACIONES
             */
            const SizedBox(height: 20),
            Text(
              'FldMonitor010'.tr,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
            TextFormField(
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              controller: _obsMonitor,
              enabled: _enabledF,
            ),
            /**
           * PROBLEMA IDENTIFICADO EN LA OBRA (Obligatorio)
           */
            const SizedBox(height: 10),
            Text(
              'FldMonitor011'.tr,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
            DropdownButtonFormField(
              isExpanded: true,
              isDense: false,
              value: _valueProblemaIO,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
              validator: (value) => value
                          .toString()
                          .toUpperCase()
                          .contains("SELECCIONE UNA OPCIÓN") ||
                      value == ""
                  ? 'Required'.tr
                  : null,
              items: widget.cbPIDEO.isNotEmpty
                  ? widget.cbPIDEO.map((ComboItemModel map) {
                      return DropdownMenuItem<String>(
                        value: map.codigo1.toString(),
                        child: Row(
                          children: [
                            Expanded(
                              child: map.descripcion
                                      .toString()
                                      .toUpperCase()
                                      .contains("SELECCIONE UNA OPCIÓN")
                                  ? Text(
                                      map.descripcion.toString(),
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Theme.of(context).hintColor,
                                      ),
                                    )
                                  : Text(
                                      map.descripcion.toString(),
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      );
                    }).toList()
                  : null,
              onChanged: _enabledF
                  ? (String? value) {
                      _valueProblemaIO = value;
                    }
                  : null,
            ),
            /**
             * Foto del Problema Identificado (Opcional)
             */
            const SizedBox(height: 10),
            _enabledF
                ? OutlinedButton.icon(
                    label: Text(
                      'FldMonitor012'.tr,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    icon: const Icon(Icons.image),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black,
                    ),
                    onPressed: () async {
                      await _showChoiceDialog(
                          context, _imgProblemaIdentificado);
                      setState(() {});
                    },
                  )
                : Text(
                    'FldMonitor012'.tr,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
            const SizedBox(height: 10),
            myExpansionPanelListethod(_imgProblemaIdentificado, expandedPI),
            /**
             * ALTERNATIVA DE SOLUCION
             */
            const SizedBox(height: 10),
            Text(
              'FldMonitor013'.tr,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
            DropdownButtonFormField(
              isExpanded: true,
              isDense: false,
              value: _valueAlternSolucion,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
              validator: (value) => value
                          .toString()
                          .toUpperCase()
                          .contains("SELECCIONE UNA OPCIÓN") ||
                      value == ""
                  ? 'Required'.tr
                  : null,
              items: widget.cbASOLU.isNotEmpty
                  ? widget.cbASOLU.map((ComboItemModel map) {
                      return DropdownMenuItem<String>(
                        value: map.codigo1.toString(),
                        child: Row(
                          children: [
                            Expanded(
                                child: map.descripcion
                                        .toString()
                                        .toUpperCase()
                                        .contains("SELECCIONE UNA OPCIÓN")
                                    ? Text(
                                        map.descripcion.toString(),
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Theme.of(context).hintColor,
                                        ),
                                      )
                                    : Text(
                                        map.descripcion.toString(),
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      )),
                          ],
                        ),
                      );
                    }).toList()
                  : null,
              onChanged: _enabledF
                  ? (String? value) {
                      _valueAlternSolucion = value;
                    }
                  : null,
            ),
            /**
             * SELECCIONES EL RIESGO Identificado
             */
            const SizedBox(height: 10),
            Text(
              'FldMonitor014'.tr,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
            DropdownButtonFormField(
              isExpanded: true,
              isDense: false,
              value: _valueRiesgo,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
              items: widget.cbRIDEN.isNotEmpty
                  ? widget.cbRIDEN.map((ComboItemModel map) {
                      return DropdownMenuItem<String>(
                        value: map.codigo1.toString(),
                        child: Row(
                          children: [
                            Expanded(
                              child: map.descripcion
                                      .toString()
                                      .toUpperCase()
                                      .contains("SELECCIONE UNA OPCIÓN")
                                  ? Text(
                                      map.descripcion.toString(),
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Theme.of(context).hintColor,
                                      ),
                                    )
                                  : Text(
                                      map.descripcion.toString(),
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      );
                    }).toList()
                  : null,
              onChanged: _enabledF
                  ? (String? value) {
                      _valueRiesgo = value;
                    }
                  : null,
            ),
            /**
             * Foto del Riesgo Identificado (Opcional)
             */
            const SizedBox(height: 5),
            _enabledF
                ? OutlinedButton.icon(
                    label: Text(
                      'FldMonitor015'.tr,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    icon: const Icon(Icons.image),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black,
                    ),
                    onPressed: () async {
                      await _showChoiceDialog(context, _imgRiesgoIdentificado);
                      setState(() {});
                    },
                  )
                : Text(
                    'FldMonitor015'.tr,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
            const SizedBox(height: 10),
            myExpansionPanelListethod(_imgRiesgoIdentificado, expandedRI),
            /**
            * NIVEL DE RIESGO
            */
            const SizedBox(height: 10),
            Text(
              'FldMonitor016'.tr,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
            DropdownButtonFormField(
              isExpanded: true,
              isDense: false,
              value: _valueNivelRiesgo,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
              items: widget.cbNRIES.isNotEmpty
                  ? widget.cbNRIES.map((ComboItemModel map) {
                      return DropdownMenuItem<String>(
                        value: map.descripcion.toString(),
                        child: Row(
                          children: [
                            Expanded(
                              child: map.descripcion
                                      .toString()
                                      .toUpperCase()
                                      .contains("SELECCIONE UNA OPCIÓN")
                                  ? Text(
                                      map.descripcion.toString(),
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Theme.of(context).hintColor,
                                      ),
                                    )
                                  : Text(
                                      map.descripcion.toString(),
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      );
                    }).toList()
                  : null,
              onChanged: _enabledF
                  ? (String? value) {
                      _valueNivelRiesgo = value;
                    }
                  : null,
            ),
            /**
             * FECHA TERMINO OBRA
             */
            const SizedBox(height: 10),
            Text(
              'FldMonitor017'.tr,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
            TextFormField(
              controller: _dateObra,
              validator: (v) => v!.isEmpty ? 'Required'.tr : null,
              enabled: _enabledF,
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(
                    2101,
                  ),
                );

                if (pickedDate != null) {
                  String formattedDate =
                      DateFormat('yyyy-MM-dd').format(pickedDate);
                  setState(() {
                    _dateObra.text = formattedDate;
                  });
                }
              },
            ),
            /**
           * LOGITUD
           */
            const SizedBox(height: 10),
            Text(
              'FldMonitor018'.tr,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
            TextFormField(
              controller: _longitud,
              enabled: _enabledF,
              validator: (v) => v!.isEmpty ? 'Required'.tr : null,
            ),
            /**
           * LATITUD
           */
            const SizedBox(height: 10),
            Text(
              'FldMonitor019'.tr,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
            TextFormField(
              controller: _latitud,
              enabled: _enabledF,
              validator: (v) => v!.isEmpty ? 'Required'.tr : null,
            ),
            const SizedBox(height: 10),
            Text(sShowMessage,
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.red.withOpacity(1.0),
                  fontWeight: FontWeight.bold,
                )),
            /**
             * Botones
             */
            const SizedBox(height: 32),
            _enabledF
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor:
                              const Color.fromARGB(255, 12, 124, 205),
                          shadowColor: const Color.fromARGB(255, 53, 53, 53),
                          elevation: 5,
                        ),
                        onPressed: () async {
                          String imgPE = "";
                          String imgPI = "";
                          String imgRI = "";

                          controller.itemsImagesAll.forEach((key, items) {
                            if (key == _imgPartidaEjecutada) {
                              imgPE = items.join(",");
                            }
                            if (key == _imgProblemaIdentificado) {
                              imgPI = items.join(",");
                            }
                            if (key == _imgRiesgoIdentificado) {
                              imgRI = items.join(",");
                            }
                          });
                          _prefs = await SharedPreferences.getInstance();
                          UserModel oUser = UserModel(
                            nombres: _prefs!.getString("nombres") ?? "",
                            codigo: _prefs!.getString("codigo") ?? "",
                            rol: _prefs!.getString("rol") ?? "",
                          );
                          try {
                            final alert = AlertQuestion(
                                title: "Información",
                                message: "¿Está Seguro de Guardar Monitor?",
                                onNegativePressed: () {
                                  Navigator.of(context).pop();
                                },
                                onPostivePressed: () async {
                                  Navigator.of(context).pop();
                                  BusyIndicator.show(context);
                                  try {
                                    TramaMonitoreoModel dataSave =
                                        await mainCtr.saveMonitoreo(
                                      TramaMonitoreoModel(
                                        id: idM,
                                        isEdit: 1,
                                        createdTime: DateTime.now(),
                                        snip: _snip,
                                        cui: _cuiCtr.text,
                                        latitud: _latitud.text,
                                        longitud: _longitud.text,
                                        tambo: _tambo,
                                        fechaTerminoEstimado: _dateObra.text,
                                        avanceFisicoAcumulado: (double.parse(
                                                _advanceFEA.text == ""
                                                    ? "0"
                                                    : _advanceFEA.text) /
                                            100),
                                        avanceFisicoPartida: (double.parse(
                                                _advanceFEP.text == ""
                                                    ? "0"
                                                    : _advanceFEP.text) /
                                            100),
                                        fechaMonitoreo: _dateMonitor.text,
                                        idMonitoreo: _idMonitor.text,
                                        imgActividad: imgPE,
                                        imgProblema: imgPI,
                                        imgRiesgo: imgRI,
                                        observaciones: _obsMonitor.text,
                                        idEstadoAvance: getValueSelected(
                                            int.parse(_statusAdvance!)),
                                        idEstadoMonitoreo: getValueSelected(
                                            int.parse(_statusMonitor!)),
                                        idAvanceFisicoPartida: getValueSelected(
                                            int.parse(_valuePartidaEje!)),
                                        idAlternativaSolucion: getValueSelected(
                                            int.parse(_valueAlternSolucion!)),
                                        idProblemaIdentificado:
                                            getValueSelected(
                                                int.parse(_valueProblemaIO!)),
                                        idRiesgoIdentificado: getValueSelected(
                                            int.parse(_valueRiesgo!)),
                                        nivelRiesgo: _valueNivelRiesgo!
                                                .toUpperCase()
                                                .contains(
                                                    "SELECCIONE UNA OPCIÓN")
                                            ? ""
                                            : _valueNivelRiesgo!,
                                        rol: oUser.rol,
                                        usuario: oUser.codigo,
                                      ),
                                    );

                                    BusyIndicator.hide(context);
                                    if (idM == 0) {
                                      showSnackbar(
                                        success: true,
                                        text: 'Datos Guardados Correctamente',
                                      );
                                    } else {
                                      showSnackbar(
                                        success: true,
                                        text:
                                            'Datos Actualizados Correctamente',
                                      );
                                    }
                                    buildFormData(dataSave);
                                  } catch (oError) {
                                    var sTitle = 'Error';
                                    var sMessage = oError.toString();
                                    if (oError is ThrowCustom) {
                                      sTitle = oError.typeText!;
                                      sMessage = oError.msg!;
                                    }

                                    BusyIndicator.hide(context);
                                    AnimatedSnackBar.rectangle(
                                      sTitle,
                                      sMessage,
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
                          } catch (ex) {
                            BusyIndicator.hide(context);
                            AnimatedSnackBar.rectangle(
                              'Error',
                              ex.toString(),
                              type: AnimatedSnackBarType.error,
                              brightness: Brightness.light,
                              mobileSnackBarPosition:
                                  MobileSnackBarPosition.top,
                            ).show(context);
                          }
                        },
                        child: SizedBox(
                          height: 50,
                          width: width / 3.5,
                          child: Center(
                            child: Text(
                              'SaveData'.tr,
                              style: const TextStyle(
                                color: Color(0xfffefefe),
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.normal,
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor:
                              const Color.fromARGB(255, 1, 173, 130),
                          shadowColor: const Color.fromARGB(255, 53, 53, 53),
                          elevation: 5,
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            String imgPE = "";
                            String imgPI = "";
                            String imgRI = "";
                            controller.itemsImagesAll.forEach((key, items) {
                              if (key == _imgPartidaEjecutada) {
                                imgPE = items.join(",");
                              }
                              if (key == _imgProblemaIdentificado) {
                                imgPI = items.join(",");
                              }
                              if (key == _imgRiesgoIdentificado) {
                                imgRI = items.join(",");
                              }
                            });
                            _prefs = await SharedPreferences.getInstance();
                            UserModel oUser = UserModel(
                              nombres: _prefs!.getString("nombres") ?? "",
                              codigo: _prefs!.getString("codigo") ?? "",
                              rol: _prefs!.getString("rol") ?? "",
                            );
                            if (imgPE == "") {
                              showSnackbar(
                                success: false,
                                text:
                                    'Debe ingresar una imagen de la partida Ejecutada',
                              );
                            } else {
                              if (idM == 0) {
                                AnimatedSnackBar.rectangle(
                                  'Error',
                                  'Para enviar un monitoreo debes ingresar todos los campos obligatorios y hacer click en el botón grabar',
                                  type: AnimatedSnackBarType.error,
                                  brightness: Brightness.light,
                                  mobileSnackBarPosition:
                                      MobileSnackBarPosition.top,
                                ).show(context);
                              } else {
                                final alert = AlertQuestion(
                                    title: "Información",
                                    message: "¿Está Seguro de Enviar Monitor?",
                                    onNegativePressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    onPostivePressed: () async {
                                      Navigator.of(context).pop();
                                      BusyIndicator.show(context);
                                      try {
                                        List<TramaMonitoreoModel> dataSend =
                                            await mainCtr
                                                .sendMonitoreo([oMonitor]);
                                        BusyIndicator.hide(context);

                                        if (dataSend.isEmpty) {
                                          showSnackbar(
                                            success: true,
                                            text:
                                                'Datos Enviados Correctamente',
                                          );
                                        } else {
                                          /**
                                           * Mostrar el registro que esta generando error
                                           */
                                          buildFormData(dataSend[0]);

                                          AnimatedSnackBar.rectangle(
                                            'Error',
                                            'No se pudo enviar el monitor',
                                            type: AnimatedSnackBarType.error,
                                            brightness: Brightness.light,
                                            mobileSnackBarPosition:
                                                MobileSnackBarPosition.top,
                                          ).show(context);
                                        }
                                      } catch (ex) {
                                        BusyIndicator.hide(context);
                                        AnimatedSnackBar.rectangle(
                                          'Error',
                                          ex.toString(),
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
                              }
                            }
                          } else {
                            showSnackbar(
                              success: false,
                              text: 'RequiredFields'.tr,
                            );
                          }
                        },
                        child: SizedBox(
                          height: 50,
                          width: width / 3.5,
                          child: Center(
                            child: Text(
                              'SendData'.tr,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                letterSpacing: 1.5,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'OpenSans',
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                : Row(),
          ],
        ),
      ),
    );
  }

  ListView myExpansionPanelListethod(
      String fieldNameImage, List<bool> expanded) {
    return ListView(shrinkWrap: true, children: [
      ExpansionPanelList(
          expansionCallback: (panelIndex, isExpanded) {
            setState(() {
              expanded[panelIndex] = !isExpanded;
            });
          },
          animationDuration: const Duration(milliseconds: 600),
          children: [
            ExpansionPanel(
              backgroundColor: expanded[0] == true
                  ? const Color.fromARGB(255, 224, 230, 231)
                  : Colors.white,
              headerBuilder: (context, isOpen) {
                return Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  child: Text(
                    "FldMonitor020".tr,
                    style: const TextStyle(fontSize: 16),
                  ),
                );
              },
              body: Container(
                padding: const EdgeInsets.all(5),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    MyImageMultiple(
                      controller: controller,
                      nameField: fieldNameImage,
                      enabled: _enabledF,
                    ),
                  ],
                ),
              ),
              isExpanded: expanded[0],
            ),
          ]),
    ]);
  }

  Future<void> _confirmDialog(String sAction) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('W'.tr),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text('ConfirmationQuestion100'.tr),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Yes'.tr),
              onPressed: () {
                if (sAction == 'SAVE') {}
              },
            ),
            TextButton(
              child: Text('No'.tr),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showChoiceDialog(BuildContext context, String nameImage) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              ),
            ),
            title: const Text(
              'SELECCIONAR',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(45),
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.all(10),
                    ),
                    label: const Text(
                      'Imagen de Galeria',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    icon: const Icon(Icons.image),
                    onPressed: () async {
                      await controller.selectMultipleImage(nameImage);
                      Navigator.of(context).pop();
                      setState(() {});
                    },
                  ),
                ),
                const SizedBox(height: 10.0),
                Container(
                  alignment: Alignment.topLeft,
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(45),
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.all(10),
                    ),
                    label: const Text(
                      'Tomar una Foto',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    icon: const Icon(Icons.camera_alt_rounded),
                    onPressed: () async {
                      await controller.imageCamera(nameImage);
                      Navigator.of(context).pop();
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }

  final _formKey1 = GlobalKey<FormState>();
  Future<void> _showMyDialog(BuildContext context, String? title) async {
    return showDialog<void>(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(title!),
          content: Form(
            key: _formKey1,
            child: Card(
              color: Colors.transparent,
              elevation: 0.0,
              child: regitroEntidades(),
            ),
          ),
          actions: [
            Container(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                    ),
                    child: const Text("Cancelar"),
                  ),
                  const Padding(padding: EdgeInsets.all(10)),
                  ElevatedButton(
                    onPressed: () async {
                      Navigator.of(context).pop();
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 26, 155, 86)),
                    ),
                    child: const Text("Guardar"),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }

  Column regitroEntidades() {
    List<String> itemsImagePath = [];
    controller.itemsImagesAll.forEach((key, items) {
      if (key == _imgPartidaEjecutada) {
        items.forEach((entry) {
          itemsImagePath.add(entry);
        });
      }
    });

    return Column(
      children: [
        /**
         * PARTIDA EJECUTADA
         */
        const SizedBox(height: 10),
        Text(
          'FldMonitor007'.tr,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
        DropdownButtonFormField(
          isExpanded: true,
          isDense: false,
          value: _valuePartidaEje,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
          validator: (value) => value
                      .toString()
                      .toUpperCase()
                      .contains("SELECCIONE UNA OPCIÓN") ||
                  value == ""
              ? 'Required'.tr
              : null,
          items: widget.cbPEJEC.isNotEmpty
              ? widget.cbPEJEC.map(
                  (ComboItemModel map) {
                    return DropdownMenuItem<String>(
                      value: map.codigo1.toString(),
                      child: Row(
                        children: [
                          Expanded(
                            child: map.descripcion
                                    .toString()
                                    .toUpperCase()
                                    .contains("SELECCIONE UNA OPCIÓN")
                                ? Text(
                                    map.descripcion.toString(),
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context).hintColor,
                                    ),
                                  )
                                : Text(
                                    map.descripcion.toString(),
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    );
                  },
                ).toList()
              : null,
          onChanged: _enabledF
              ? (String? value) async {
                  String sValue = value.toString().toUpperCase();
                  _valuePartidaEje = value.toString();
                  try {
                    TramaProyectoModel oProyect = TramaProyectoModel.empty();
                    oProyect.numSnip = _snip;

                    UltimoAvancePartidaModel oLastAvance =
                        await mainCtr.getUltimoAvanceByProyectoAndPartida(
                      oProyect,
                      _valuePartidaEje!,
                    );

                    _advanceFEP.text = ((oLastAvance.avanceFisicoPartida! * 100)
                            .toStringAsFixed(2))
                        .toString();
                  } catch (e) {
                    _advanceFEP.text = '0.00';
                  }

                  setState(() {});
                }
              : null,
        ),
        /**
             * % AVANCE FISICO ACUMULADO PARTIDA
             */
        const SizedBox(height: 10),
        Text(
          'FldMonitor008'.tr,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
        TextFormField(
          controller: _advanceFEP,
          maxLength: 6,
          keyboardType: TextInputType.number,
          validator: (v) => v!.isEmpty ? 'Required'.tr : null,
          enabled: _enabledF,
        ),
        OutlinedButton.icon(
          label: Text(
            'FldMonitor009'.tr,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
          icon: const Icon(Icons.image),
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.black,
          ),
          onPressed: () async {
            await _showChoiceDialog(context, _imgPartidaEjecutada);
            setState(() {});
          },
        ),
        SizedBox(
            width: 400,
            height: 300,
            child: Expanded(
              child: ListView.builder(
                itemCount: itemsImagePath.length,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Image.file(
                        File(itemsImagePath[index]),
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        right: -2,
                        top: -2,
                        child: InkWell(
                          child: const Icon(
                            Icons.remove_circle,
                            size: 30,
                            color: Colors.red,
                          ),
                          onTap: () async {},
                        ),
                      )
                    ],
                  );
                },
              ),
            ))
      ],
    );
  }
}
