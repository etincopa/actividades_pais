
import 'package:actividades_pais/src/datamodels/Provider/ProviderRegistarInterv.dart';
import 'package:actividades_pais/util/app-config.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ActividadesGit extends StatefulWidget {
  const ActividadesGit({Key? key}) : super(key: key);

  @override
  State<ActividadesGit> createState() => _ActividadesGitState();
}

class _ActividadesGitState extends State<ActividadesGit> {
  String? id_actividad='';
  //String? id_servicio;
  final _formKey = GlobalKey<FormState>();
  TextEditingController controllerFecha = TextEditingController();
  TextEditingController controllerHoraIni = TextEditingController();
  TextEditingController controllerHoraFin = TextEditingController();
  var controllerDescripcion = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  final _curremtime = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
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
                  TextFormField(
                    controller: controllerFecha,
                    decoration: const InputDecoration(
                      labelText: 'Fecha',
                      hintText: 'Seleccione una fecha',
                      prefixIcon: Icon(Icons.calendar_today),
                    ),
                    readOnly: true,
                    onTap: () => _selectDate(context),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor seleccione una fecha';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  buildTimeFormField(
                    controller: controllerHoraIni,
                    labelText: 'Hora Inicio',
                    hintText: 'Seleccione una hora',
                    prefixIcon: Icons.access_time,
                  ),
                  const SizedBox(height: 16.0),
                  buildTimeFormField(
                    controller: controllerHoraFin,
                    labelText: 'Hora Fin',
                    hintText: 'Seleccione una hora',
                    prefixIcon: Icons.access_time,
                  ),
                  buildActividadesDropdown(),
                 id_actividad==''?Container(): buildServiciosDropdown(),

                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor ingrese la descripción del evento';
                      }
                      return null;
                    },
                    controller: controllerDescripcion,
                    maxLines: 8,
                    maxLength: 500,
                    decoration: InputDecoration(
                      hintText:
                          "¿QUÉ SE HIZO? ¿CUÁL ES LA FINALIDAD? ¿QUIÉN LO HIZO? ¿A QUIÉN ESTA DIRIGIDO? ",
                      labelText: 'DESCRIPCIÓN DEL EVENTO',
                      counterText: "${controllerDescripcion.text.length} / 500",
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.all(5),
                      height: 38,
                      //left: 10, right: 10, top: 10
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.save),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppConfig.primaryColor,
                            //   shadowColor:
                            textStyle: const TextStyle(fontSize: 16),
                            minimumSize: const Size.fromHeight(72),
                            shape: const StadiumBorder()),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {}
                        },
                        label: const Text('GUARDAR PROGRMACION'),
                      )),
                  Container(
                    margin: const EdgeInsets.all(5),
                    height: 38,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.settings_backup_restore),
                      label: const Text('CANCELAR'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppConfig.primaryColor,
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

  Future<void> _selectDate(BuildContext context) async {
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
        print(DateFormat("EEEE, d MMMM 'de' yyyy", 'es').format(_selectedDate));
      });
    }
  }

  Widget buildTimeFormField({
    required TextEditingController controller,
    required String labelText,
    required String hintText,
    required IconData prefixIcon,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: Icon(prefixIcon),
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
        controller.text = formattedTime;
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor seleccione una hora';
        }
        return null;
      },
    );
  }

  Future<TimeOfDay?> getTimePikerwidget() {
    return showTimePicker(
        context: context,
        initialTime: _curremtime,
        builder: (context, child) {
          return Theme(data: ThemeData.dark(), child: child!);
        });
  }

  Widget buildActividadesDropdown() {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: ProviderRegistarInterv().fetchActividades(),
      builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }
        final List<Map<String, dynamic>> actividades = snapshot.data!;
        return DropdownButtonFormField<String>(
          isExpanded: true,
          items: actividades.map((actividad) {
            return DropdownMenuItem<String>(

              value: actividad['id_actividad'].toString(),
              child: Text(actividad['nombre_tipo_actividad']),
            );
          }).toList(),
          onChanged: (String? newValue) {
            id_actividad ="";
            id_actividad =newValue;
            setState(() {

            });
            // Do something with the selected value
          },
          decoration: const InputDecoration(
            labelText: 'Tipo de actividad',

          ),
        );
      },
    );
  }
  Widget buildServiciosDropdown() {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future:  ProviderRegistarInterv().fetchServicios(id_actividad),
      builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }
        final List<Map<String, dynamic>> actividades = snapshot.data!;
        return DropdownButtonFormField<String>(
          isExpanded: true,
          items: actividades.map((actividad) {
            return DropdownMenuItem<String>(
              value: actividad['id_servicio'].toString(),
              child: Text(actividad['nombre_servicio']),
            );
          }).toList(),
          onChanged: (String? newValue) {
            // Do something with the selected value
          },
          decoration: const InputDecoration(
            labelText: 'Servicios',

          ),
        );
      },
    );
  }

  /*Widget buildDropdownButtonFormField(
      Future<List<Map<String, dynamic>>> future,
      String idField,
      String textField,
      String labelText,
      Function(String?) onChanged,
      String? value, // agregar un parámetro para mantener el valor seleccionado
      ) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }

        final List<Map<String, dynamic>> data = snapshot.data!;
        final List<String> values = data.map((item) => item[idField].toString()).toList();

        if (values.toSet().length != values.length) {
          return Text('Error: Duplicate values found in data');
        }

        return DropdownButtonFormField<String>(
          items: data
              .map((item) => DropdownMenuItem<String>(
            key: UniqueKey(),
            value: item[idField].toString(),
            child: Text(item[textField]),
          ))
              .toList(),
          onChanged: onChanged,
          value: value, // establecer el valor seleccionado
          decoration: InputDecoration(
            labelText: labelText,
          ),
        );
      },
    );
  }*/

}
