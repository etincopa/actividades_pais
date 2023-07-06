import 'package:actividades_pais/backend/controller/main_controller.dart';
import 'package:actividades_pais/backend/model/dto/dropdown_dto.dart';
import 'package:actividades_pais/backend/model/dto/response_program_dto.dart';
import 'package:actividades_pais/backend/model/programa_actividad_model.dart';
import 'package:actividades_pais/src/pages/widgets/widget-custom.dart';
import 'package:actividades_pais/util/busy-indicator.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class CordinacionArticulacion extends StatefulWidget {
  const CordinacionArticulacion({super.key});

  @override
  State<CordinacionArticulacion> createState() =>
      _CordinacionArticulacionState();
}

class _CordinacionArticulacionState extends State<CordinacionArticulacion> {
  MainController controller = MainController();
  final _formKey = GlobalKey<FormState>();
  final _dateFecha = TextEditingController();
  final _timeInicio = TextEditingController();
  final _timeFinal = TextEditingController();
  final _descripcionEvento = TextEditingController();
  final _evento = TextEditingController();
  List<CombosDto> _itemAccion = [];
  List<CombosDto> _tipoUsuario = [];
  List<CombosDto> _sector = [];
  List<CombosDto> _programa = [];
  List<CombosDto> _itemDocAcredita = [];
  List<CombosDto> _itemArOri = [];

  String? _valueAccion;
  String? _valueTipoUsuario;
  String? _valueSector;
  String? _valuePrograma;
  String? _valueAcredita;
  String? _valueArOri;

  String? _fechaca;

  @override
  void initState() {
    super.initState();
    getMaestraCombo();
    _valueAccion = "0";
    _valueTipoUsuario = "0";
    _valueSector = "0";
    _valuePrograma = "0";
    _valueAcredita = "0";
    _valueArOri = "0";
    setState(() {});
  }

  Future<void> getMaestraCombo() async {
    try {
      _itemAccion = await controller.getAccion();
      insertCombo(_itemAccion);
      _tipoUsuario = await controller.getTipoUsuario();
      insertCombo(_tipoUsuario);
      _itemDocAcredita = await controller.getDocAcredita();
      insertCombo(_itemDocAcredita);
      _itemArOri = await controller.getArticulacionOrientada();
      insertCombo(_itemArOri);
      setState(() {});
    } catch (oError) {
      print(oError);
    }
  }

  insertCombo(List<CombosDto> item) {
    item.insert(
      0,
      CombosDto(id: 0, descrip2: "SELECIONE UNA OPCIÓN"),
    );
  }

  Future<void> getMaestroSector(int key) async {
    try {
      _sector = await controller.getSector(key);
      insertCombo(_sector);
      setState(() {});
    } catch (oError) {
      print(oError);
    }
  }

  Future<void> getMaestroPrograma(int key) async {
    try {
      _programa = await controller.getPrograma(key);
      insertCombo(_programa);
      setState(() {});
    } catch (oError) {
      print(oError);
    }
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

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: WidgetCustoms.appBar(
        "COOR Y ARTICULACIÓN",
        context: context,
        iconAct: Icons.supervised_user_circle_sharp,
      ),
      body: Form(
        key: _formKey,
        // autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          padding: const EdgeInsets.only(
              left: 32.0, right: 32.0, top: 15.0, bottom: 20.0),
          children: [
            TextFormField(
              controller: _dateFecha,
              validator: (v) => v!.isEmpty ? 'Required'.tr : null,
              decoration: const InputDecoration(
                  labelText: 'Fecha de Cordinación y Articulación'),
              enabled: true,
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101));

                if (pickedDate != null) {
                  String formattedDate =
                      DateFormat('dd/MM/yyyy').format(pickedDate);
                  setState(() {
                    _dateFecha.text = formattedDate;
                    _fechaca = pickedDate.toIso8601String();
                  });
                }
              },
            ),
            /**
             * Hora de Inicio
             */
            TextFormField(
              controller: _timeInicio,
              validator: (v) => v!.isEmpty ? 'Required'.tr : null,
              decoration: const InputDecoration(labelText: "Hora Inicio"),
              readOnly: true,
              onTap: () async {
                TimeOfDay? pickedTime = await showTimePicker(
                  initialTime: TimeOfDay.now(),
                  context: context,
                );
                if (pickedTime != null) {
                  DateTime parsedTime = DateFormat.jm()
                      .parse(pickedTime.format(context).toString());
                  String formattedTime =
                      DateFormat('hh:mm a').format(parsedTime);
                  setState(() {
                    _timeInicio.text = formattedTime;
                  });
                }
              },
            ),
            /**
             * Hora Final
             */
            TextFormField(
              controller: _timeFinal,
              validator: (v) => v!.isEmpty ? 'Required'.tr : null,
              decoration: const InputDecoration(labelText: "Hora Final"),
              readOnly: true,
              onTap: () async {
                TimeOfDay? pickedTime = await showTimePicker(
                  initialTime: TimeOfDay.now(),
                  context: context,
                );
                if (pickedTime != null) {
                  DateTime parsedTime = DateFormat.jm()
                      .parse(pickedTime.format(context).toString());
                  String formattedTime =
                      DateFormat('hh:mm a').format(parsedTime);
                  setState(() {
                    _timeFinal.text = formattedTime;
                  });
                }
              },
            ),
            /**
             * Accion
             */
            DropdownButtonFormField(
              decoration: const InputDecoration(labelText: "Accion"),
              isExpanded: true,
              isDense: false,
              value: _valueAccion!,
              validator: (value) => value! == "0" ? 'Requerido *' : null,
              onChanged: (String? value) {
                setState(() {
                  _valueAccion = value!;
                });
              },
              items: _itemAccion.isNotEmpty
                  ? _itemAccion.map((CombosDto map) {
                      return DropdownMenuItem<String>(
                        value: map.id.toString() == "0"
                            ? "0"
                            : map.descrip2.toString(),
                        child: Text(
                          map.descrip2.toString(),
                          style: const TextStyle(fontSize: 14),
                        ),
                      );
                    }).toList()
                  : null,
            ),
            /**
             * Tipo Usuario
             */
            DropdownButtonFormField(
              decoration: const InputDecoration(labelText: "Tipo Usuario"),
              isExpanded: true,
              isDense: false,
              value: _valueTipoUsuario!,
              validator: (value) => value! == "0" ? 'Requerido *' : null,
              items: _tipoUsuario.isNotEmpty
                  ? _tipoUsuario.map((CombosDto map) {
                      return DropdownMenuItem<String>(
                        value: map.id.toString(),
                        child: Text(
                          map.descrip2.toString(),
                          style: const TextStyle(fontSize: 14),
                        ),
                      );
                    }).toList()
                  : null,
              onChanged: (String? value) async {
                _programa = [];
                BusyIndicator.show(context);
                await getMaestroSector(int.parse(value!));
                BusyIndicator.hide(context);
                setState(() {
                  _valueTipoUsuario = value;
                  _valueSector = "0";
                });
              },
            ),
            /**
             * Sector
             */
            DropdownButtonFormField(
              decoration: const InputDecoration(labelText: "Sector"),
              isExpanded: true,
              isDense: false,
              value: _valueSector!,
              validator: (value) => value! == "0" ? 'Requerido *' : null,
              onChanged: (String? value) async {
                BusyIndicator.show(context);
                await getMaestroPrograma(int.parse(value!));
                BusyIndicator.hide(context);
                setState(() {
                  _valueSector = value;
                  _valuePrograma = "0";
                });
              },
              items: _sector.isNotEmpty
                  ? _sector.map((CombosDto map) {
                      return DropdownMenuItem<String>(
                        value: map.id.toString(),
                        child: Text(
                          map.descrip2.toString(),
                          style: const TextStyle(fontSize: 14),
                        ),
                      );
                    }).toList()
                  : null,
            ),
            /**
             * Programa
             */
            DropdownButtonFormField(
              decoration: const InputDecoration(labelText: "Programa"),
              isExpanded: true,
              isDense: false,
              value: _valuePrograma!,
              validator: (value) => value! == "0" ? 'Requerido *' : null,
              onChanged: (String? value) {
                setState(() {
                  _valuePrograma = value!;
                });
              },
              items: _programa.isNotEmpty
                  ? _programa.map((CombosDto map) {
                      return DropdownMenuItem<String>(
                        value: map.id.toString(),
                        child: Text(
                          map.descrip2.toString(),
                          style: const TextStyle(fontSize: 14),
                        ),
                      );
                    }).toList()
                  : null,
            ),
            /**
             * Documento que Acredita el Evento
             */
            DropdownButtonFormField(
              decoration: const InputDecoration(
                  labelText: "Documento que Acredita el Evento"),
              isExpanded: true,
              isDense: false,
              value: _valueAcredita!,
              validator: (value) => value! == "0" ? 'Requerido *' : null,
              onChanged: (String? value) {
                setState(() {
                  _valueAcredita = value!;
                });
              },
              items: _itemDocAcredita.isNotEmpty
                  ? _itemDocAcredita.map((CombosDto map) {
                      return DropdownMenuItem<String>(
                        value: map.id.toString(),
                        child: Text(
                          map.descrip2.toString(),
                          style: const TextStyle(fontSize: 14),
                        ),
                      );
                    }).toList()
                  : null,
            ),
            /**
             * ¿Dónde se Realizó el Evento?
             */
            TextFormField(
              controller: _evento,
              decoration: const InputDecoration(
                labelText: '¿Dónde se Realizó el Evento?',
              ),
              validator: (v) => v!.isEmpty ? 'Required'.tr : null,
              enabled: true,
            ),
            /**
             * Articulación Orientada A.
             */
            DropdownButtonFormField(
              decoration:
                  const InputDecoration(labelText: "Articulación Orientada A."),
              isExpanded: true,
              isDense: false,
              value: _valueArOri!,
              validator: (value) => value! == "0" ? 'Requerido *' : null,
              onChanged: (String? value) {
                setState(() {
                  _valueArOri = value!;
                });
              },
              items: _itemArOri.isNotEmpty
                  ? _itemArOri.map((CombosDto map) {
                      return DropdownMenuItem<String>(
                        value: map.id.toString(),
                        child: Text(
                          map.descrip2.toString(),
                          style: const TextStyle(fontSize: 14),
                        ),
                      );
                    }).toList()
                  : null,
            ),
            /**
             * Descripcion del Evento
             */
            TextFormField(
              controller: _descripcionEvento,
              decoration: const InputDecoration(
                labelText: 'Descripción del Evento',
              ),
              validator: (v) => v!.isEmpty ? 'Required'.tr : null,
              enabled: true,
            ),
            /**
             * Bonones De Control
             */
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        BusyIndicator.show(context);
                        ProgActModel oProg = ProgActModel.empty();

                        oProg.fecha = _fechaca;
                        oProg.descripcion = _evento.text;
                        oProg.tipoGobierno = int.parse(_valueTipoUsuario!);
                        oProg.sector = int.parse(_valueSector!);
                        oProg.programa = int.parse(_valuePrograma!);
                        oProg.documento = int.parse(_valueAcredita!);
                        oProg.articulacion = int.parse(_valueArOri!);
                        oProg.realizo = _evento.text;
                        oProg.horaInicio = _timeInicio.text;
                        oProg.horaFin = _timeFinal.text;
                        oProg.accion = _valueAccion;

                        ProgramRespDto response = await controller
                            .sendCoordinacionArticulacion(oProg);
                        BusyIndicator.hide(context);
                        if (response.estado!) {
                          showSnackbar(
                            success: true,
                            text: 'Datos Enviados Correctamente',
                          );
                          _formKey.currentState?.reset();
                        } else {
                          AnimatedSnackBar.rectangle(
                            'Error',
                            response.mensaje!,
                            type: AnimatedSnackBarType.error,
                            brightness: Brightness.light,
                            mobileSnackBarPosition: MobileSnackBarPosition.top,
                          ).show(context);
                        }
                      } catch (ex) {
                        BusyIndicator.hide(context);
                        AnimatedSnackBar.rectangle(
                          'Error',
                          ex.toString(),
                          type: AnimatedSnackBarType.error,
                          brightness: Brightness.light,
                          mobileSnackBarPosition: MobileSnackBarPosition.top,
                        ).show(context);
                      }
                    }
                  },
                  child: SizedBox(
                    height: 50,
                    width: width / 3.5,
                    child: const Center(
                      child: Text(
                        'Guardar',
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          letterSpacing: 1.5,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'OpenSans',
                        ),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: const Color.fromARGB(255, 237, 82, 68),
                    shadowColor: const Color.fromARGB(255, 53, 53, 53),
                    elevation: 5,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: SizedBox(
                    height: 50,
                    width: width / 3.5,
                    child: const Center(
                      child: Text(
                        'Cancelar',
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          letterSpacing: 1.5,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'OpenSans',
                        ),
                      ),
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
