
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProgramacionIntervencion extends StatefulWidget {
  const ProgramacionIntervencion({Key? key}) : super(key: key);

  @override
  _DateTimeFormState createState() => _DateTimeFormState();
}

class _DateTimeFormState extends State<ProgramacionIntervencion> {
  final _formKey = GlobalKey<FormState>();
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
   TextEditingController controllerFecha =TextEditingController();
   TextEditingController controllerHoraIni =TextEditingController();
   TextEditingController controllerHoraFin =TextEditingController();
  var _curremtime = TimeOfDay.now();

  Future<TimeOfDay?> getTimePikerwidget() {
    return showTimePicker(
        context: context,
        initialTime: _curremtime,
        builder: (context, child) {
          return Theme(data: ThemeData.dark(), child: child!);
        });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Ingresar fecha y hora'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(controller: controllerFecha,
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

                       print( DateFormat("EEEE, d MMMM 'de' yyyy", 'es').format(_selectedDate)
                       );
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

                  var selectTime = await getTimePikerwidget() ?? TimeOfDay.now();

                  String formattedTime = DateFormat('HH:mm').format( DateTime(
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
                  var selectTime = await getTimePikerwidget() ?? TimeOfDay.now();
                  String formattedTime = DateFormat('HH:mm').format( DateTime(
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
              Center(
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
              ),
            ],
          ),
        ),
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