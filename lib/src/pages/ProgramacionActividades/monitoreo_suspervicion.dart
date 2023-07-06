import 'package:actividades_pais/backend/controller/main_controller.dart';
import 'package:actividades_pais/backend/model/actividad_tambo_model.dart';
import 'package:actividades_pais/backend/model/dto/response_program_dto.dart';
import 'package:actividades_pais/backend/model/listar_registro_entidad_actividad_model.dart';
import 'package:actividades_pais/backend/model/programa_actividad_model.dart';
import 'package:actividades_pais/src/pages/widgets/widget-custom.dart';
import 'package:actividades_pais/util/busy-indicator.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class MonitoreoSupervicion extends StatefulWidget {
  const MonitoreoSupervicion({super.key});

  @override
  State<MonitoreoSupervicion> createState() => _MonitoreoSupervicionState();
}

class _MonitoreoSupervicionState extends State<MonitoreoSupervicion> {
  MainController controller = MainController();
  final _formKey = GlobalKey<FormState>();
  final _dateFecha = TextEditingController();
  List<DataRow> dataRows = [];
  late List<RegistroEntidadActividadModel> lisData = [];
  List<ActividadTamboModel> aTambo = [];
  String? _fechaca;

  var uuid = const Uuid();
  @override
  void initState() {
    super.initState();
    setState(() {});
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
        "MONITOREO Y SUPER...",
        context: context,
        iconAct: Icons.language_outlined,
      ),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          padding: const EdgeInsets.only(left: 32.0, right: 32.0, top: 32.0),
          children: [
            TextFormField(
              controller: _dateFecha,
              validator: (v) => v!.isEmpty ? 'Required'.tr : null,
              decoration: const InputDecoration(
                  labelText: 'Fecha de Monitoreo y Supervición'),
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
             * Tablas
             */
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "REGISTRO DE ACTIVIDADES:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.add_to_queue),
                  color: const Color.fromARGB(255, 69, 90, 210),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await _showMyDialog(
                        context,
                        "AGREGAR TAMBO",
                      );
                    }
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
                    headingRowColor:
                        MaterialStateProperty.all(Colors.green[100]),
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
                      DataColumn(label: Text("Tambo")),
                      DataColumn(label: Text("Ubicación")),
                      DataColumn(label: Text("Fecha")),
                      DataColumn(label: Text("Horario")),
                      DataColumn(label: Text("Descripción")),
                      DataColumn(label: Text("")),
                    ],
                    rows: dataRows),
              ),
            ),

            /**
             * Botones De Control
             */
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        if (lisData.isEmpty) {
                          showSnackbar(
                            success: false,
                            text: 'Debe llenar La tabla de Actividades',
                          );
                        } else {
                          aTambo = [];
                          BusyIndicator.show(context);
                          List<ActividadTamboModel> dto = [];
                          int count = 1;
                          for (var key in lisData) {
                            dto.add(ActividadTamboModel(
                                idTambo: count, // cambiar por id
                                descripcion:
                                    key.descripcionDeLaActividadProgramada!,
                                fecha: _fechaca!,
                                hora: "${key.horaInicio!} - ${key.horaFin!}",
                                ubicacion:
                                    "${key.distrito!} / ${key.provincia!} / ${key.departamento!}"));
                            count++;
                          }
                          aTambo.addAll(dto);
                          ProgActModel oProg = ProgActModel.empty();
                          oProg.fecha = _fechaca!;
                          oProg.aTambo = aTambo;

                          ProgramRespDto response =
                              await controller.sendMonitoreoSupervision(oProg);

                          BusyIndicator.hide(context);
                          if (response.estado!) {
                            showSnackbar(
                              success: true,
                              text: 'Datos Enviados Correctamente',
                            );
                            _formKey.currentState?.reset();
                            dataRows = [];
                            lisData = [];
                            _dateFecha.text = "";
                            setState(() {});
                          } else {
                            AnimatedSnackBar.rectangle(
                              'Error',
                              response.mensaje!,
                              type: AnimatedSnackBarType.error,
                              brightness: Brightness.light,
                              mobileSnackBarPosition:
                                  MobileSnackBarPosition.top,
                            ).show(context);
                          }
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

  final _formKey1 = GlobalKey<FormState>();
  final _timeInicio = TextEditingController();
  final _timeFinal = TextEditingController();
  final _tambo = TextEditingController();
  final _distrito = TextEditingController();
  final _provincia = TextEditingController();
  final _departamento = TextEditingController();
  final _actividad = TextEditingController();
  int index = 0;

  Column regitroEntidades() {
    return Column(
      children: [
        /**
        * Tambo
        */
        TextFormField(
          controller: _tambo,
          decoration: const InputDecoration(
            labelText: 'Tambo',
          ),
          validator: (v) => v!.isEmpty ? 'Required'.tr : null,
          enabled: true,
        ),
        /**
         * Distrito
         */
        TextFormField(
          controller: _distrito,
          decoration: const InputDecoration(
            labelText: 'Distrito',
          ),
          validator: (v) => v!.isEmpty ? 'Required'.tr : null,
          enabled: true,
        ),
        /**
         * Provincia
         */
        TextFormField(
          controller: _provincia,
          decoration: const InputDecoration(
            labelText: 'Provincia',
          ),
          validator: (v) => v!.isEmpty ? 'Required'.tr : null,
          enabled: true,
        ),
        /**
         * Departamento
         */
        TextFormField(
          controller: _departamento,
          decoration: const InputDecoration(
            labelText: 'Departamento',
          ),
          validator: (v) => v!.isEmpty ? 'Required'.tr : null,
          enabled: true,
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
              DateTime parsedTime =
                  DateFormat.jm().parse(pickedTime.format(context).toString());
              String formattedTime = DateFormat('hh:mm a').format(parsedTime);
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
              DateTime parsedTime =
                  DateFormat.jm().parse(pickedTime.format(context).toString());
              String formattedTime = DateFormat('hh:mm a').format(parsedTime);
              setState(() {
                _timeFinal.text = formattedTime;
              });
            }
          },
        ),
        /**
         * Actividad a realizar en el tambo / en la fecha
         */
        TextFormField(
          controller: _actividad,
          decoration: const InputDecoration(
            labelText: 'Actividad a realizar en el tambo / en la fecha',
          ),
          validator: (v) => v!.isEmpty ? 'Required'.tr : null,
          enabled: true,
        ),
      ],
    );
  }

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
                      if (_formKey1.currentState!.validate()) {
                        RegistroEntidadActividadModel data =
                            RegistroEntidadActividadModel.empty();
                        data.idRegistroEntidadesYActividades = uuid.v4();
                        data.tambo = _tambo.text;
                        data.distrito = _distrito.text;
                        data.provincia = _provincia.text;
                        data.departamento = _departamento.text;
                        data.fecha = _dateFecha.text;
                        data.horaInicio = _timeInicio.text;
                        data.horaFin = _timeFinal.text;
                        data.descripcionDeLaActividadProgramada =
                            _actividad.text;
                        lisData.add(data);
                        setState(() {
                          _dataRow(data);
                        });
                        _formKey1.currentState?.reset();
                        Navigator.of(context).pop();
                      }
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

  _dataRow(RegistroEntidadActividadModel data) {
    dataRows.add(
      DataRow(
        key: ValueKey(data.idRegistroEntidadesYActividades),
        cells: [
          DataCell(Text(data.tambo!)),
          DataCell(Text(
              "${data.distrito!}/${data.provincia!}/${data.departamento!}")),
          DataCell(Text(data.fecha!)),
          DataCell(Text("${data.horaInicio!} - ${data.horaFin!}")),
          DataCell(Text(data.descripcionDeLaActividadProgramada!)),
          DataCell(
            const Icon(
              Icons.delete,
              color: Color.fromARGB(255, 230, 51, 35),
            ),
            onTap: () {
              int iIndex = 0;
              for (DataRow oDataRow in dataRows) {
                LocalKey oKey = oDataRow.key!;
                String iKey =
                    oKey.toString().replaceAll(RegExp(r'[^0-9]'), '');
                if (iKey == data.idRegistroEntidadesYActividades) {
                  break;
                }
                iIndex++;
              }

              lisData.removeWhere((item) =>
                  item.idRegistroEntidadesYActividades ==
                  data.idRegistroEntidadesYActividades);
              setState(() {
                dataRows.removeAt(iIndex);
              });
            },
          ),
        ],
      ),
    );
  }
}
