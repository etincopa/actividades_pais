import 'package:actividades_pais/backend/controller/main_controller.dart';
import 'package:actividades_pais/backend/model/dto/dropdown_dto.dart';
import 'package:actividades_pais/backend/model/dto/response_program_dto.dart';
import 'package:actividades_pais/backend/model/programa_actividad_model.dart';
import 'package:actividades_pais/util/busy-indicator.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:actividades_pais/src/pages/widgets/widget-custom.dart';

class ActividadesPnpais extends StatefulWidget {
  const ActividadesPnpais({super.key});

  @override
  State<ActividadesPnpais> createState() => _ActividadesPnpaisState();
}

class _ActividadesPnpaisState extends State<ActividadesPnpais> {
  MainController controller = MainController();
  final _formKey = GlobalKey<FormState>();
  final _dateFecha = TextEditingController();
  final _timeInicio = TextEditingController();
  final _timeFinal = TextEditingController();
  final _descripcion = TextEditingController();

  List<CombosDto> _itemTipoActividad = [];
  String? _valueTipoActidad;
  String? _fechaca;

  @override
  void initState() {
    super.initState();
    getMaestraCombo();
    _valueTipoActidad = "0";
    setState(() {});
  }

  Future<void> getMaestraCombo() async {
    try {
      _itemTipoActividad = await controller.getTipoActividad();
      _itemTipoActividad.insert(
        0,
        CombosDto(id: 0, descrip2: "SELECIONE UNA OPCIÓN"),
      );
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
        "ACTIVIDADES PNPAIS",
        context: context,
        iconAct: Icons.menu_open,
        onPressedAct: () {},
      ),
      body: Form(
        key: _formKey,
        // autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          padding: const EdgeInsets.only(left: 32.0, right: 32.0, top: 32.0),
          children: [
            TextFormField(
              controller: _dateFecha,
              validator: (v) => v!.isEmpty ? 'Required'.tr : null,
              decoration: const InputDecoration(
                  labelText: 'Fecha de Actividades PNPAIS'),
              enabled: true,
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101));

                if (pickedDate != null) {
                  print(pickedDate);
                  String formattedDate =
                      DateFormat('dd/MM/yyyy').format(pickedDate);
                  print(formattedDate);

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
             * Tipo Actividad
             */
            DropdownButtonFormField(
              decoration: const InputDecoration(labelText: "Tipo Actividad"),
              isExpanded: true,
              isDense: false,
              value: _valueTipoActidad!,
              validator: (value) => value! == "0" ? 'Requerido *' : null,
              onChanged: (String? value) async {
                setState(() {
                  _valueTipoActidad = value;
                });
              },
              items: _itemTipoActividad.isNotEmpty
                  ? _itemTipoActividad.map((CombosDto map) {
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
             * Descripcion
             */
            TextFormField(
              controller: _descripcion,
              decoration: const InputDecoration(
                labelText: 'Descripción',
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
                        oProg.descripcion = _descripcion.text;
                        oProg.tipoActividad = int.parse(_valueTipoActidad!);
                        oProg.horaInicio = _timeInicio.text;
                        oProg.horaFin = _timeFinal.text;
                        ProgramRespDto response =
                            await controller.sendActividadesPNPAIS(oProg);

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
