import 'package:actividades_pais/src/Utils/utils.dart';
import 'package:actividades_pais/src/datamodels/Clases/Intervenciones/TambosDependientes.dart';
import 'package:actividades_pais/src/datamodels/Clases/Intervenciones/UnidadesTerritoriales.dart';
import 'package:actividades_pais/src/datamodels/Clases/TipoIntervencion.dart';
import 'package:actividades_pais/src/datamodels/Provider/ProviderAprobacionPlanes.dart';
import 'package:actividades_pais/src/datamodels/Provider/ProviderRegistarInterv.dart';
import 'package:actividades_pais/src/datamodels/database/DatabasePr.dart';
import 'package:actividades_pais/src/pages/Intervenciones/ProgramarPrestaciones/TablaEntidades/CrearRegistroEntidad.dart';
import 'package:actividades_pais/util/app-config.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProgramacionIntervencion extends StatefulWidget {
  const ProgramacionIntervencion({Key? key}) : super(key: key);

  @override
  _DateTimeFormState createState() => _DateTimeFormState();
}

class _DateTimeFormState extends State<ProgramacionIntervencion> {
  final _formKey = GlobalKey<FormState>();
  List<TipoIntervencion> tipoIntervencion = [];
  List<UnidadesTerritoriales> listUnidadesTerritoriales = [];
  List<TambosDependientes> listTambosDependientes = [];
  var idUnidadTerr = 0;
  bool _value = false;

  bool paraOtroTamboChk = false;
  bool cargarPlataforma = false;

  bool otroTambo = false;

  @override
  void initState() {
    // TODO: implement initState
    cargarUnidades();
    taerDB();
    super.initState();
  }

  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  TextEditingController controllerFecha = TextEditingController();
  TextEditingController controllerHoraIni = TextEditingController();
  TextEditingController controllerHoraFin = TextEditingController();
  var _curremtime = TimeOfDay.now();
  int _selectedOption = 0;

  Future<TimeOfDay?> getTimePikerwidget() {
    return showTimePicker(
        context: context,
        initialTime: _curremtime,
        builder: (context, child) {
          return Theme(data: ThemeData.dark(), child: child!);
        });
  }

  cargarUnidades() async {
    setState(() {
      // _isLoading = true;
    });
    tipoIntervencion = await ProviderRegistarInterv().getTipoIntervencion();
    listUnidadesTerritoriales =
        (await ProviderAprobacionPlanes().ListarUnidadesTerritoriales())!;

    setState(() {
      //_isLoading = false;
    });
  }

  crtamob(idUnidadesTerritoriales) async {
    setState(() {});
    setState(() {
      cargarPlataforma = false;
    });
    listTambosDependientes =
    (await ProviderAprobacionPlanes()
        .ListarTambosDependientes(
        idUnidadesTerritoriales))!;
    setState(() {
      cargarPlataforma = true;
    });

  }

  taerDB() async{
    setState(() {
      otroTambo= false;
    });
    var respuest = await DatabasePr.db.traerSnip();
    print("respuest $respuest");
    if(respuest==0){
      setState(() {
        otroTambo = true;
      });
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Intervención de prestaciones'),
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
                  otroTambo ?  Row(
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
                              /* nombreBoton = "Extrangero";

                              setborrar();*/
                            } else {
                              paraOtroTamboChk = false;
                             // cargarPlataforma = false;

                              /*nombreBoton = "";
                              visibilityTag = false;
                              visibilitytipotex = false;
                              visibilityTag = false;*/
                            }
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
                  ):Container(),
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
                                      return DropdownMenuItem<TambosDependientes>(
                                        value: user,
                                        child: Text(
                                          user.plataformaDescripcion!,
                                          style: const TextStyle(fontSize: 11),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (TambosDependientes? value) {},
                                  )
                                : Container(),
                          ],
                        )
                      : Container(),
                  TextFormField(
                    controller: controllerFecha,
                    decoration: InputDecoration(
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
                        lastDate: DateTime.now().add(Duration(days: 365)),
                      );
                      if (date != null) {
                        setState(() {
                          _selectedDate = date;
                          var outputFormat = DateFormat('MM/dd/yyyy');
                          var outputDate = outputFormat.format(date);
                          controllerFecha.text = outputDate.toString();

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
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: controllerHoraIni,
                    decoration: InputDecoration(
                      labelText: 'Hora Inicio',
                      hintText: 'Seleccione una hora',
                      prefixIcon: Icon(Icons.access_time),
                    ),
                    readOnly: true,
                    onTap: () async {
                      var selectTime =
                          await getTimePikerwidget() ?? TimeOfDay.now();

                      String formattedTime = DateFormat('HH:mm').format(DateTime(
                        DateTime.now().year,
                        DateTime.now().month,
                        DateTime.now().day,
                        selectTime.hour,
                        selectTime.minute,
                      ));
                      controllerHoraIni.text = formattedTime;
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
                    decoration: InputDecoration(
                      labelText: 'Hora Fin',
                      hintText: 'Seleccione una hora',
                      prefixIcon: Icon(Icons.access_time),
                    ),
                    readOnly: true,
                    onTap: () async {
                      var selectTime =
                          await getTimePikerwidget() ?? TimeOfDay.now();
                      String formattedTime = DateFormat('HH:mm').format(DateTime(
                        DateTime.now().year,
                        DateTime.now().month,
                        DateTime.now().day,
                        selectTime.hour,
                        selectTime.minute,
                      ));
                      controllerHoraFin.text = formattedTime;
                      print("${formattedTime}");
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
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      border: UnderlineInputBorder(),
                    ),
                    isExpanded: true,
                    items: tipoIntervencion.map((option) {
                      return DropdownMenuItem<TipoIntervencion>(
                        value: option,
                        child: Text(
                          option.nombreTipoIntervencion!,
                          style: const TextStyle(fontSize: 12),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      print(value!.idTipoIntervencion);
                      // Manejar el cambio de valor seleccionado
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text("¿La intervención responde a un convenio?"),
                  ),

              Column(
                children: <Widget>[
                 utils().tieneNtieneDni(
                   selectedOption: _selectedOption,
                    titulo: "SI",
                    valor: 0,
                    color: AppConfig.primaryColor,
                    oncalbakc: (value) {
                     /* setState(() {
                        setborrar();
                        _selectedOption = value;
                        nombreBoton = "Validar DNI";
                        visibilityTag = true;
                        validarcontroles = false;
                        participantes.tipoParticipante = 0;
                      });*/
                    },
                  ),
                  utils().tieneNtieneDni(
                    selectedOption: _selectedOption,
                      color: AppConfig.primaryColor,
                      oncalbakc: (value) {
                       /* setState(() {
                          setborrar();
                          _selectedOption = value;
                          nombreBoton = "Validar en el Padron";
                          visibilityTag = true;
                          validarcontroles = true;
                          participantes.tipoParticipante = 1;
                        });*/
                      },
                      titulo: "NO",
                      valor: 1),]),

                  CrearRegistroEntidad(),
                  /*    FutureBuilder<List<UnidadesTerritoriales>>(
                    future: ProviderAprobacionPlanes()
                        .ListarUnidadesTerritoriales(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<UnidadesTerritoriales>> snapshot) {
                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const CircularProgressIndicator(); // Muestra un indicador de carga mientras se carga la lista
                      } else if (snapshot.hasError) {
                        return const Text('Error al cargar las opciones');
                      } else {
                        List<UnidadesTerritoriales> options = snapshot.data!;
                        options.insert(
                            0,
                            UnidadesTerritoriales(
                                idUnidadesTerritoriales: 0,
                                unidadTerritorialDescripcion: 'TODOS'));

                        return Row(
                          children: [
                            const Icon(Icons.account_balance_wallet_outlined,
                                size: 15, color: Colors.grey),
                            const SizedBox(width: 13),
                            Expanded(
                              child: DropdownButtonFormField<
                                  UnidadesTerritoriales>(
                                decoration: const InputDecoration(
                                  labelText: 'Unidad Territorial',
                                ),
                                isExpanded: true,
                                items: options.map((user) {
                                  return DropdownMenuItem<
                                      UnidadesTerritoriales>(
                                    value: user,
                                    child: Text(
                                      user.unidadTerritorialDescripcion!,
                                      style: const TextStyle(fontSize: 10),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (UnidadesTerritoriales? value) {
                                  seleccionarUnidadTerritorial =
                                  value!.unidadTerritorialDescripcion!;
                                  filtroDataPlanMensual.ut =
                                      ((value.idUnidadesTerritoriales == 0)
                                          ? "x"
                                          : value.idUnidadesTerritoriales)
                                          .toString();

                                  isMostar = true;
                                  seleccionarPlataformaDescripcion =
                                  "Seleccionar plataforma";

                                  setState(() {});
                                },
                                hint: Text(
                                  seleccionarUnidadTerritorial,
                                  style: const TextStyle(fontSize: 10),
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  ),*/
                  SizedBox(height: 32.0),
                  Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.all(24),
                      height: 38,
                      //left: 10, right: 10, top: 10
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary:AppConfig.primaryColor,
                            //   shadowColor:
                            textStyle: TextStyle(fontSize: 24),
                            minimumSize: Size.fromHeight(72),
                            shape: StadiumBorder()),
                        onPressed: () async {

                        },  child: Text('Guardar'),

                      )),
                /*  Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final dateTime = DateTime(
                            _selectedDate.year,
                            _selectedDate.month,
                            _selectedDate.day,
                            _selectedTime.hour,
                            _selectedTime.minute,
                          );
                          final formData = FormData(
                            date: _selectedDate,
                            time: _selectedTime,
                            dateTime: dateTime,
                          );
                          // Enviar objeto formData al servidor o realizar otra acción aquí
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Formulario enviado con éxito'),
                            ),
                          );
                        }
                      },
                      child: Text('Guardar'),
                    ),
                  ),*/
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FormData {
  final DateTime date;
  final TimeOfDay time;
  final DateTime dateTime;

  FormData({
    required this.date,
    required this.time,
    required this.dateTime,
  });
}
