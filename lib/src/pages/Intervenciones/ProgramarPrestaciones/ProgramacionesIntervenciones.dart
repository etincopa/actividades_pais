import 'dart:convert';

import 'package:actividades_pais/src/Utils/utils.dart';
import 'package:actividades_pais/src/datamodels/Clases/Convenios.dart';
import 'package:actividades_pais/src/datamodels/Clases/Intervenciones/GuardarIntervencion.dart';
import 'package:actividades_pais/src/datamodels/Clases/Intervenciones/TambosDependientes.dart';
import 'package:actividades_pais/src/datamodels/Clases/Intervenciones/UnidadesTerritoriales.dart';
import 'package:actividades_pais/src/datamodels/Clases/LugarIntervencion.dart';
import 'package:actividades_pais/src/datamodels/Clases/TipoDocumentoAcredita.dart';
import 'package:actividades_pais/src/datamodels/Clases/TipoIntervencion.dart';
import 'package:actividades_pais/src/datamodels/Provider/ProviderAprobacionPlanes.dart';
import 'package:actividades_pais/src/datamodels/Provider/ProviderRegistarInterv.dart';
import 'package:actividades_pais/src/datamodels/database/DatabasePr.dart';
import 'package:actividades_pais/src/pages/Intervenciones/ProgramarPrestaciones/TablaEntidades/CrearRegistroEntidad.dart';
import 'package:actividades_pais/util/app-config.dart';
import 'package:actividades_pais/util/busy-indicator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProgramacionIntervencion extends StatefulWidget {
  const ProgramacionIntervencion({Key? key}) : super(key: key);

  @override
  _DateTimeFormState createState() => _DateTimeFormState();
}

class _DateTimeFormState extends State<ProgramacionIntervencion> {
  final _formKey = GlobalKey<FormState>();
  GuardarIntervencion guardarIntervencion = GuardarIntervencion();
  List<TipoIntervencion> tipoIntervencion = [];
  List<TipoDocumentoAcredita> tipoDocumentoAcredita = [];
  List<LugarIntervencion> lugarIntervencion = [];
  List<UnidadesTerritoriales> listUnidadesTerritoriales = [];
  List<Convenios> listConvenipos = [];
  List<TambosDependientes> listTambosDependientes = [];
  var idUnidadTerr = 0;
  bool _value = false;

  bool paraOtroTamboChk = false;
  bool isGestor = false;
  bool cargarPlataforma = false;

  bool otroTambo = false;
  bool _ismostar = false;

  //var valor = 255;
  var controllerNumeroPersonas = TextEditingController();

  var controllerDescripcion = TextEditingController();
  List<Accion> listAcc = [];

  int _currentLength = 0; // longitud actual del texto

  @override
  void initState() {
    // TODO: implement initState
    controllerNumeroPersonas.text = 1.toString();
    cargarUnidades();
    taerDB();
    cargarTabla();
    super.initState();
  }

  cargarTabla() async {
    listAcc = await DatabasePr.db.ListarEntidadesReg();

    setState(() {});
  }

  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  TextEditingController controllerFecha = TextEditingController();
  TextEditingController controllerHoraIni = TextEditingController();
  TextEditingController controllerHoraFin = TextEditingController();
  var _curremtime = TimeOfDay.now();
  int _selectedOption = 0;
  int _valorOption = 1;

  Future<TimeOfDay?> getTimePikerwidget() {
    return showTimePicker(
        context: context,
        initialTime: _curremtime,
        builder: (context, child) {
          return Theme(data: ThemeData.dark(), child: child!);
        });
  }

  void _onTextChanged() {
    setState(() {
      _currentLength = controllerDescripcion.text.length;
    });
  }

  cargarUnidades() async {
    setState(() {
      // _isLoading = true;
    });
    tipoIntervencion = await ProviderRegistarInterv().getTipoIntervencion();
    listUnidadesTerritoriales =
        (await ProviderAprobacionPlanes().ListarUnidadesTerritoriales())!;
    listConvenipos = (await ProviderRegistarInterv().getListarConvenios());

    tipoDocumentoAcredita =
        (await ProviderRegistarInterv().listaTipoDocumentoAcredita())!;

    lugarIntervencion =
        (await ProviderRegistarInterv().getListaLugarIntervenciona())!;
    setState(() {
      //_isLoading = false;
    });
  }

  crtamob(idUnidadesTerritoriales) async {
    setState(() {});
    setState(() {
      cargarPlataforma = false;
    });
    listTambosDependientes = (await ProviderAprobacionPlanes()
        .ListarTambosDependientes(idUnidadesTerritoriales))!;
    setState(() {
      cargarPlataforma = true;
    });
  }

  taerDB() async {
    setState(() {
      otroTambo = false;
    });
    var respuest = await DatabasePr.db.traerSnip();
    if (respuest == 0) {
      setState(() {
        otroTambo = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Intervención de prestaciones'),
        backgroundColor: AppConfig.primaryColor,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  otroTambo
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(
                              activeColor: const Color(0xFF78b8cd),
                              focusColor: const Color(0xFF78b8cd),
                              onChanged: (value) {
                                setState(() {
                                  _value = value!;
                                  if (_value == true) {
                                    paraOtroTamboChk = true;
                                    cargarPlataforma = false;
                                  } else {
                                    paraOtroTamboChk = false;
                                  }
                                  guardarIntervencion.progOtroTambo =
                                      paraOtroTamboChk;
                                });
                              },
                              value: _value,
                            ),
                            const Text(
                              "PROGRAMACION PARA OTRO TAMBO",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        )
                      : Container(),
                  paraOtroTamboChk
                      ? Column(
                          children: [
                            DropdownButtonFormField<UnidadesTerritoriales>(
                              decoration: const InputDecoration(
                                labelText: 'Unidad Territorial',
                              ),
                              isExpanded: true,
                              items: listUnidadesTerritoriales.map((user) {
                                return DropdownMenuItem<UnidadesTerritoriales>(
                                  value: user,
                                  child: Text(
                                    user.unidadTerritorialDescripcion!,
                                    style: const TextStyle(fontSize: 11),
                                  ),
                                );
                              }).toList(),
                              onChanged: (UnidadesTerritoriales? value) async {
                                idUnidadTerr = int.parse(
                                    value!.idUnidadesTerritoriales.toString());
                                guardarIntervencion.idUnidadesTerritoriales =
                                    value.idUnidadesTerritoriales;
                                crtamob(value.idUnidadesTerritoriales);
                              },
                            ),
                            cargarPlataforma
                                ? DropdownButtonFormField<TambosDependientes>(
                                    decoration: const InputDecoration(
                                      labelText: 'Plataforma',
                                    ),
                                    isExpanded: true,
                                    items: listTambosDependientes.map((user) {
                                      return DropdownMenuItem<
                                          TambosDependientes>(
                                        value: user,
                                        child: Text(
                                          user.plataformaDescripcion!,
                                          style: const TextStyle(fontSize: 11),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (TambosDependientes? value) {
                                      guardarIntervencion.idPlataforma =
                                          value?.idPlataforma;
                                    },
                                  )
                                : Container(),
                          ],
                        )
                      : Container(),
                  TextFormField(
                    controller: controllerFecha,
                    decoration: const InputDecoration(
                      labelText: 'Fecha',
                      hintText: 'Seleccione una fecha',
                      prefixIcon: Icon(Icons.calendar_today),
                    ),
                    readOnly: true,
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: _selectedDate,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );
                      if (date != null) {
                        setState(() {
                          _selectedDate = date;
                          var outputFormat = DateFormat('yyyy-MM-dd');
                          var outputDate = outputFormat.format(date);
                          controllerFecha.text = outputDate.toString();
                          controllerFecha.text = outputDate.toString();
                          guardarIntervencion.fecha = controllerFecha.text;

                          print(DateFormat("EEEE, d MMMM 'de' yyyy", 'es')
                              .format(_selectedDate));
                        });
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor seleccione una fecha';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: controllerHoraIni,
                    decoration: const InputDecoration(
                      labelText: 'Hora Inicio',
                      hintText: 'Seleccione una hora',
                      prefixIcon: Icon(Icons.access_time),
                    ),
                    readOnly: true,
                    onTap: () async {
                      var selectTime =
                          await getTimePikerwidget() ?? TimeOfDay.now();

                      String formattedTime =
                          DateFormat('HH:mm').format(DateTime(
                        DateTime.now().year,
                        DateTime.now().month,
                        DateTime.now().day,
                        selectTime.hour,
                        selectTime.minute,
                      ));
                      controllerHoraIni.text = formattedTime;
                      guardarIntervencion.horaInicio = controllerHoraIni.text;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor seleccione una hora';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: controllerHoraFin,
                    decoration: const InputDecoration(
                      labelText: 'Hora Fin',
                      hintText: 'Seleccione una hora',
                      prefixIcon: Icon(Icons.access_time),
                    ),
                    readOnly: true,
                    onTap: () async {
                      var selectTime =
                          await getTimePikerwidget() ?? TimeOfDay.now();
                      String formattedTime =
                          DateFormat('HH:mm').format(DateTime(
                        DateTime.now().year,
                        DateTime.now().month,
                        DateTime.now().day,
                        selectTime.hour,
                        selectTime.minute,
                      ));
                      controllerHoraFin.text = formattedTime;
                      guardarIntervencion.horaFin = controllerHoraFin.text;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor seleccione una hora';
                      }
                      return null;
                    },
                  ),
                  DropdownButtonFormField<TipoIntervencion>(
                    decoration: const InputDecoration(
                      isCollapsed: false,
                      labelText: 'LA INTERVENCIONES PERTENECE A:',
                      labelStyle:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                      border: UnderlineInputBorder(),
                    ),
                    isExpanded: true,
                    items: tipoIntervencion.map((option) {
                      return DropdownMenuItem<TipoIntervencion>(
                        value: option,
                        child: Text(
                          option.nombreTipoIntervencion!,
                          style: const TextStyle(fontSize: 11),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value!.idTipoIntervencion == 2 ||
                          value.idTipoIntervencion == 3) {
                        _ismostar = true;
                      } else {
                        _ismostar = false;
                      }
                      guardarIntervencion.tipoIntervencion =
                          value.idTipoIntervencion;
                      setState(() {});
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Debe seleccionar una opción';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Center(
                    child: Text("¿La intervención responde a un convenio?"),
                  ),
                  Column(children: <Widget>[
                    utils().tieneNtieneDni(
                      selectedOption: _selectedOption,
                      titulo: "SI",
                      valor: 1,
                      color: AppConfig.primaryColor,
                      oncalbakc: (value) {
                        guardarIntervencion.vConvenio = value.toString();
                        setState(() {
                          _selectedOption = value;
                        });
                      },
                    ),
                    utils().tieneNtieneDni(
                        selectedOption: _selectedOption,
                        color: AppConfig.primaryColor,
                        oncalbakc: (value) {
                          setState(() {
                            guardarIntervencion.vConvenio = value.toString();
                            _selectedOption = value;
                          });
                        },
                        titulo: "NO",
                        valor: 0),
                  ]),
                  _selectedOption == 1
                      ? DropdownButtonFormField<Convenios>(
                          decoration: const InputDecoration(
                            isCollapsed: false,
                            labelText: 'CONVENIO',
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 13),
                            border: UnderlineInputBorder(),
                          ),
                          isExpanded: true,
                          items: listConvenipos.map((option) {
                            return DropdownMenuItem<Convenios>(
                              value: option,
                              child: Text(
                                option.nombrePrograma!,
                                style: const TextStyle(fontSize: 11),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            guardarIntervencion.vConvenio =
                                value!.idConvenio.toString();
                          },
                        )
                      : Container(),
                  CrearRegistroEntidad(_ismostar),
                  DropdownButtonFormField<TipoDocumentoAcredita>(
                    decoration: const InputDecoration(
                      isCollapsed: false,
                      labelText: 'DOCUMENTO QUE ACREDITA EL EVENTO',
                      labelStyle:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                      border: UnderlineInputBorder(),
                    ),
                    isExpanded: true,
                    items: tipoDocumentoAcredita.map((option) {
                      return DropdownMenuItem<TipoDocumentoAcredita>(
                        value: option,
                        child: Text(
                          option.nombreDocumentoAcredita!,
                          style: const TextStyle(fontSize: 11),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      guardarIntervencion.documento =
                          value?.idDocumentoAcredita;
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Debe seleccionar una opción';
                      }
                      return null;
                    },
                  ),
                  DropdownButtonFormField<LugarIntervencion>(
                    decoration: const InputDecoration(
                      isCollapsed: false,
                      labelText: ' ¿DÓNDE SE REALIZÓ EL EVENTO?',
                      labelStyle:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                      border: UnderlineInputBorder(),
                    ),
                    isExpanded: true,
                    items: lugarIntervencion.map((option) {
                      return DropdownMenuItem<LugarIntervencion>(
                        value: option,
                        child: Text(
                          option.nombreLugarIntervencion!,
                          style: const TextStyle(fontSize: 11),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      guardarIntervencion.realizo = value?.idLugarIntervencion;
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Debe seleccionar una opción';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null) {
                        return 'Por favor ingregse el numero de personas a participar';
                      }
                      return null;
                    },
                    controller: controllerNumeroPersonas,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: "",
                      labelText:
                          'N° DE PERSONAS CONVOCADAS A PARTICIPAR EN EL EVENTO',
                    ),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor ingrese la descripción del evento';
                      }
                      return null;
                    },
                    controller: controllerDescripcion,
                    maxLines: 8,
                    decoration: InputDecoration(
                      hintText:
                          "¿QUÉ SE HIZO? ¿CUÁL ES LA FINALIDAD? ¿QUIÉN LO HIZO? ¿A QUIÉN ESTA DIRIGIDO? ",
                      labelText: 'DESCRIPCIÓN DEL EVENTO',
                      counterText: "$_currentLength",
                    ),
                    onChanged: (value) {
                      _currentLength = value.length;
                      setState(() {});
                    },
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  (paraOtroTamboChk || !otroTambo)
                      ?Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.all(5),
                      height: 38,
                      //left: 10, right: 10, top: 10
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.save),
                        style: ElevatedButton.styleFrom(
                            primary: AppConfig.primaryColor,
                            //   shadowColor:
                            textStyle: const TextStyle(fontSize: 16),
                            minimumSize: const Size.fromHeight(72),
                            shape: const StadiumBorder()),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            if (_selectedOption != 1) {
                              guardarIntervencion.nConvenio = 0;
                            }
                            await cargarTabla();
                            guardarIntervencion.convocadas =
                                int.parse(controllerNumeroPersonas.text);
                            guardarIntervencion.descripcion =
                                controllerDescripcion.text;
                            guardarIntervencion.vConvenio =
                                _selectedOption.toString();
                            guardarIntervencion.accion = listAcc;

                            if (listAcc.length <= 0) {
                               return showSimpleDialogWithText(
                                  context, "Entidad no Registrada");
                            }
                            BusyIndicator.show(context);
                            var respu = await ProviderRegistarInterv()
                                .getGuardarIntervencions(
                                jsonEncode(guardarIntervencion));

                            if (respu.estado == true) {
                              await DatabasePr.db.eliminarAccion();

                              BusyIndicator.hide(context);
                              _displaySnackBar(context, respu.mensaje);
                              Navigator.pop(context, "OK");
                            }

                            print("respu ${respu.mensaje}");
                          }
                        },
                        label: const Text('GUARDAR PROGRMACION'),
                      ))
                      : new Container(),
                  Container(
                    margin: const EdgeInsets.all(5),
                    height: 38,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.settings_backup_restore),
                      label: const Text('CANCELAR'),
                      style: ElevatedButton.styleFrom(
                        primary: AppConfig.primaryColor,
                        textStyle: const TextStyle(fontSize: 16),
                        minimumSize: const Size.fromHeight(72),
                        shape: const StadiumBorder(),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _displaySnackBar(BuildContext context, mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$mensaje'),
        /*  action: SnackBarAction(
          label: 'Action',
          onPressed: () {
            // Code to execute.
          },
        ),*/
      ),
    );
  }
}

showSimpleDialogWithText(BuildContext context, String text) {
  Widget acceptButton = TextButton(
    child: const Text("Aceptar"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  AlertDialog dialog = AlertDialog(
    title: const Text("PAIS"),
    content: Text(text),
    actions: [
      acceptButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return dialog;
    },
  );
}
