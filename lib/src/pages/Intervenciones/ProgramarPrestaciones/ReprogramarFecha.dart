import 'package:actividades_pais/src/datamodels/Provider/ProviderRegistarInterv.dart';
import 'package:actividades_pais/src/pages/Intervenciones/ProgramarPrestaciones/Event.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReprogramarFecha extends StatefulWidget {
  Evento evento;

  ReprogramarFecha(this.evento, {super.key});

  @override
  State<ReprogramarFecha> createState() => _ReprogramarFechaState();
}

class _ReprogramarFechaState extends State<ReprogramarFecha> {
  final _formKey = GlobalKey<FormState>();

  var controllerDescripcion = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  final _curremtime = TimeOfDay.now();
  TextEditingController controllerFecha = TextEditingController();

  var controllerHoraIni = TextEditingController();

  var controllerHoraFin = TextEditingController();

  Future<TimeOfDay?> getTimePikerwidget() {
    return showTimePicker(
        context: context,
        initialTime: _curremtime,
        builder: (context, child) {
          return Theme(data: ThemeData.dark(), child: child!);
        });
  }

  String? lugar_evento = '1';

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Reprogramar Fecha"),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.all(20),
          child: ListView(children: [
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
                    //   controllerFecha.text = outputDate.toString();
                    // guardarIntervencion.fecha = controllerFecha.text;

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
                var selectTime = await getTimePikerwidget() ?? TimeOfDay.now();

                String formattedTime = DateFormat('HH:mm').format(DateTime(
                  DateTime.now().year,
                  DateTime.now().month,
                  DateTime.now().day,
                  selectTime.hour,
                  selectTime.minute,
                ));
                controllerHoraIni.text = formattedTime;
                //  guardarIntervencion.horaInicio = controllerHoraIni.text;
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
                var selectTime = await getTimePikerwidget() ?? TimeOfDay.now();
                String formattedTime = DateFormat('HH:mm').format(DateTime(
                  DateTime.now().year,
                  DateTime.now().month,
                  DateTime.now().day,
                  selectTime.hour,
                  selectTime.minute,
                ));
                controllerHoraFin.text = formattedTime;
                //guardarIntervencion.horaFin = controllerHoraFin.text;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor seleccione una hora';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(

                      child: DropdownButtonFormField<String>(
                        value: lugar_evento,
                        onChanged: (value) {
                          setState(() {
                            lugar_evento = value;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: '¿Dónde se realizó el evento?',
                          labelStyle: TextStyle(
                            color: Colors.grey[600],
                          ),
                          border: const OutlineInputBorder(),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: '1',
                            child: Text('Local'),
                          ),
                          DropdownMenuItem(
                            value: '2',
                            child: Text('Dentro de la plataforma'),
                          ),
                          DropdownMenuItem(
                            value: '3',
                            child: Text('Fuera de la Plataforma'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4.0),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  var resp = await ProviderRegistarInterv().guardarFecha(
                      horaFin: controllerHoraFin.text,
                      id_programacion: widget.evento.idProgramacion,
                      fecha: controllerFecha.text,
                      horaInicio: controllerHoraIni.text,
                      lugar_evento: lugar_evento);
                  if (resp == 200) {
                    Navigator.pop(context);
                    Navigator.pop(context, 'refrescar');
                  }
                }
              },
              child: SizedBox(
                height: 40,
                width: width / 2,
                child: const Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.save),
                      Text(
                        'GUARDAR FECHA',
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          letterSpacing: 1.5,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'OpenSans',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
