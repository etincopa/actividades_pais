import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

enum IntervencionISOK { si, no }

class IntervencionCreate extends StatefulWidget {
  const IntervencionCreate({super.key});

  @override
  State<IntervencionCreate> createState() => _IntervencionCreateState();
}

class _IntervencionCreateState extends State<IntervencionCreate> {
  bool? _chekIPOtambo = false;
  final _formKey = GlobalKey<FormState>();
  final _dateFechaInter = TextEditingController();
  final _timeInicio = TextEditingController();
  final _timeFinal = TextEditingController();
  final _numPersonas = TextEditingController();
  final _descripEvento = TextEditingController();
  final _numPlanTrabajo = TextEditingController();
  final _detalleNecesidades = TextEditingController();

  static final _itemUnidadTerritorial = ["Seleccionar"];
  static final _itemPlataforma = ["Selecionar", "Plataforma"];
  static final _itemIntervencion = ["Seleccionar", "UNO", "DOS"];
  static final _itemConvenio = ["Seleccionar", "UNO", "DOS"];
  static final _itemAcreEvento = ["Seleccionar", "UNO", "DOS"];
  static final _itemRealizoEvento = ["Seleccionar", "UNO", "DOS"];
  static final _itemTPlanTrabajo = ["Seleccionar", "UNO", "DOS"];
  static final _itemAnioPT = ["Seleccionar", "2022", "2021"];
  static final _itemTipoAccion = ["Seleccionar", "2022", "2021"];

  String? _valueUniTerritorial = _itemUnidadTerritorial[0];
  String? _valuePlataforma = _itemPlataforma[0];
  String? _valueIntervencion = _itemIntervencion[0];
  String? _valueConvenio = _itemConvenio[0];
  String? _valueAcreEvento = _itemAcreEvento[0];
  String? _valueRealizoEvento = _itemRealizoEvento[0];
  String? _valueTPlanTrabajo = _itemTPlanTrabajo[0];
  final String _valueAnioPT = _itemAnioPT[0];
  String? _valueTipoAccion = _itemTipoAccion[0];

  IntervencionISOK? _charIsOK = IntervencionISOK.si;

  @override
  void initState() {
    super.initState();
    // readJson();
    setState(() {});
  }

  // Future<void> readJson() async {
  //   final String response =
  //       await rootBundle.loadString('assets/dummy/data.json');
  //   Map<String, dynamic> data = await json.decode(response);
  //   itemUnidadTerritorial = data['lista-tipo-gobierno'];
  // }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: const Center(
          child: Text(
            "INTERVENCION",
            style: TextStyle(
              color: Color(0xfffefefe),
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.normal,
              fontSize: 18.0,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              iconSize: 30,
              onPressed: () {},
              icon: const Icon(
                Icons.integration_instructions_outlined,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
          )
        ],
      ),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          padding: const EdgeInsets.only(left: 32.0, right: 32.0),
          children: [
            CheckboxListTile(
              contentPadding: const EdgeInsets.all(0.0),
              value: _chekIPOtambo,
              title: const Text("PROGRAMA PARA OTRO TAMBO"),
              onChanged: (val) {
                setState(() {
                  _chekIPOtambo = val!;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            /**
             * Unidad Territorial
             */
            _chekIPOtambo!
                ? DropdownButtonFormField(
                    decoration:
                        const InputDecoration(labelText: "Unidad Territorial"),
                    value: _valueUniTerritorial,
                    onChanged: (value) {
                      setState(() {
                        _valueUniTerritorial = value!;
                      });
                    },
                    items: _itemUnidadTerritorial
                        .map<DropdownMenuItem<String>>((value) {
                      return DropdownMenuItem<String>(
                        value: value[0],
                        child: Text(value),
                      );
                    }).toList(),
                  )
                : const Center(),
            _chekIPOtambo!
                ? DropdownButtonFormField(
                    decoration: const InputDecoration(labelText: "Plataforma"),
                    value: _valuePlataforma,
                    onChanged: (String? value) {
                      setState(() {
                        _valuePlataforma = value!;
                      });
                    },
                    items: _itemPlataforma
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )
                : const Center(),
            /**
             * Fecha de Intervenciones
             */
            TextFormField(
              controller: _dateFechaInter,
              validator: (v) => v!.isEmpty ? 'Required'.tr : null,
              decoration: const InputDecoration(
                  // icon: Icon(Icons.calendar_today), //icon of text field
                  labelText: 'Fecha de Intervención' //label text of field
                  ),
              enabled: true,
              readOnly:
                  true, //set it true, so that user will not able to edit text
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(
                        2000), //DateTime.now() - not to allow to choose before today.
                    lastDate: DateTime(2101));

                if (pickedDate != null) {
                  print(
                      pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                  String formattedDate =
                      DateFormat('dd/MM/yyyy').format(pickedDate);
                  print(
                      formattedDate); //formatted date output using intl package =>  2021-03-16
                  //you can implement different kind of Date Format here according to your requirement

                  setState(() {
                    _dateFechaInter.text =
                        formattedDate; //set output date to TextField value.
                  });
                }
              },
            ),
            /**
             * Hora de Inicio
             */
            TextFormField(
              controller: _timeInicio, //editing controller of this TextField
              validator: (v) => v!.isEmpty ? 'Required'.tr : null,
              decoration: const InputDecoration(
                  // icon: Icon(Icons.timer), //icon of text field
                  labelText: "Hora Inicio" //label text of field
                  ),
              readOnly:
                  true, //set it true, so that user will not able to edit text
              onTap: () async {
                TimeOfDay? pickedTime = await showTimePicker(
                  initialTime: TimeOfDay.now(),
                  context: context,
                );

                if (pickedTime != null) {
                  print(pickedTime.format(context)); //output 10:51 PM
                  DateTime parsedTime = DateFormat.jm()
                      .parse(pickedTime.format(context).toString());
                  //converting to DateTime so that we can further format on different pattern.
                  print(parsedTime); //output 1970-01-01 22:53:00.000
                  String formattedTime =
                      DateFormat('HH:mm:ss').format(parsedTime);
                  print(formattedTime); //output 14:59:00
                  //DateFormat() is from intl package, you can format the time on any pattern you need.

                  setState(() {
                    _timeInicio.text =
                        formattedTime; //set the value of text field.
                  });
                } else {
                  print("Time is not selected");
                }
              },
            ),
            /**
             * Hora Final
             */
            TextFormField(
              controller: _timeFinal, //editing controller of this TextField
              validator: (v) => v!.isEmpty ? 'Required'.tr : null,
              decoration: const InputDecoration(
                  // icon: Icon(Icons.timer), //icon of text field
                  labelText: "Hora Final" //label text of field
                  ),
              readOnly:
                  true, //set it true, so that user will not able to edit text
              onTap: () async {
                TimeOfDay? pickedTime = await showTimePicker(
                  initialTime: TimeOfDay.now(),
                  context: context,
                );

                if (pickedTime != null) {
                  print(pickedTime.format(context)); //output 10:51 PM
                  DateTime parsedTime = DateFormat.jm()
                      .parse(pickedTime.format(context).toString());
                  //converting to DateTime so that we can further format on different pattern.
                  print(parsedTime); //output 1970-01-01 22:53:00.000
                  String formattedTime =
                      DateFormat('HH:mm:ss').format(parsedTime);
                  print(formattedTime); //output 14:59:00
                  //DateFormat() is from intl package, you can format the time on any pattern you need.

                  setState(() {
                    _timeFinal.text =
                        formattedTime; //set the value of text field.
                  });
                } else {
                  print("Time is not selected");
                }
              },
            ),
            /**
             * 
             */
            DropdownButtonFormField(
              decoration: const InputDecoration(
                  labelText: "La INTERVENCION PERTENECE A:"),
              value: _valueIntervencion,
              onChanged: (String? value) {
                setState(() {
                  _valueIntervencion = value!;
                });
              },
              items: _itemIntervencion
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            /**
             * ¿La Intepencion Pertenece a un convenio? SI NO
             */
            const SizedBox(height: 20),
            const Text(
              "¿La Intervención pertenece a un convenio?",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<IntervencionISOK>(
                    contentPadding: const EdgeInsets.all(0.0),
                    title: const Text('SI'),
                    value: IntervencionISOK.si,
                    groupValue: _charIsOK,
                    onChanged: (value) {
                      setState(() {
                        _charIsOK = value;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile<IntervencionISOK>(
                    contentPadding: const EdgeInsets.all(0.0),
                    title: const Text('NO'),
                    value: IntervencionISOK.no,
                    groupValue: _charIsOK,
                    onChanged: (value) {
                      setState(() {
                        _charIsOK = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            /**
             * Convenio
             */
            DropdownButtonFormField(
              decoration: const InputDecoration(labelText: "Convenio"),
              value: _valueConvenio,
              onChanged: (String? value) {
                setState(() {
                  _valueConvenio = value!;
                });
              },
              items:
                  _itemConvenio.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            /**
             * Tabla Registro de Actividades
             */
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "REGISTRO DE ENTIDADES:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.add_to_queue),
                  color: const Color.fromARGB(255, 69, 90, 210),
                  onPressed: () async {
                    await _showMyDialog(
                      context,
                      "REGISTRO DE ENTIDADES",
                    );
                  },
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
                  headingRowColor: MaterialStateProperty.all(Colors.green[100]),
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
                    DataColumn(label: Text("Tipo Usuario")),
                    DataColumn(label: Text("Sector")),
                    DataColumn(label: Text("Programa")),
                    DataColumn(label: Text("Categoria")),
                    DataColumn(label: Text("Sub Categoria")),
                    DataColumn(label: Text("Tipo Actividad")),
                    DataColumn(label: Text("Servicio")),
                    DataColumn(label: Text("Descripción Actividad Programada")),
                  ],
                  rows: const [
                    DataRow(selected: true, cells: [
                      DataCell(Text("Admin")),
                      DataCell(Text("Publico")),
                      DataCell(Text("Alta")),
                      DataCell(Text("Ayu")),
                      DataCell(Text("999")),
                      DataCell(Text("Alta")),
                      DataCell(Text("Ayu")),
                      DataCell(Text("999")),
                    ]),
                    DataRow(cells: [
                      DataCell(Text("Ramos")),
                      DataCell(Text("Ayu")),
                      DataCell(Text("999")),
                      DataCell(Text("Ayu")),
                      DataCell(Text("999")),
                      DataCell(Text("Alta")),
                      DataCell(Text("Ayu")),
                      DataCell(Text("999")),
                    ])
                  ],
                ),
              ),
            ),
            /**
             * Documento que ACredita el Evento
             */
            DropdownButtonFormField(
              decoration: const InputDecoration(
                  labelText: "Documento que Acredita el Evento"),
              value: _valueAcreEvento,
              onChanged: (String? value) {
                setState(() {
                  _valueAcreEvento = value!;
                });
              },
              items:
                  _itemAcreEvento.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            /**
             * ¿Donde se Realizo el Evento?
             */
            DropdownButtonFormField(
              decoration: const InputDecoration(
                  labelText: "¿Donde se Realizo el Evento?"),
              value: _valueRealizoEvento,
              onChanged: (String? value) {
                setState(() {
                  _valueRealizoEvento = value!;
                });
              },
              items: _itemRealizoEvento
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            /**
             * Numero de Personas
             */
            TextFormField(
              controller: _numPersonas,
              maxLength: 4,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Número de Personas',
              ),
              enabled: true,
            ),
            /**
             * Descripcion del Evento
             */
            TextFormField(
              controller: _descripEvento,
              decoration: const InputDecoration(
                labelText: 'Descripción del Evento',
              ),
              validator: (v) => v!.isEmpty ? 'Required'.tr : null,
              enabled: true,
            ),
            /**
             * Tipo Plan Trabajo
             */
            DropdownButtonFormField(
              decoration: const InputDecoration(labelText: "Tipo Plan Trabajo"),
              value: _valueTPlanTrabajo,
              onChanged: (String? value) {
                setState(() {
                  _valueTPlanTrabajo = value!;
                });
              },
              items: _itemTPlanTrabajo
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            /**
             * Nº Plan de Trabajo
             */
            TextFormField(
              controller: _numPlanTrabajo,
              maxLength: 4,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Nº Plan de Trabajo',
              ),
              enabled: true,
            ),
            /**
             * Año
             */
            DropdownButtonFormField(
              decoration: const InputDecoration(labelText: "Año"),
              value: _valueAnioPT,
              onChanged: (String? value) {
                setState(() {
                  _valueTPlanTrabajo = value!;
                });
              },
              items: _itemAnioPT.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            /**
             * Tabla Registro de Actividades
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
                    await _showMyDialog(
                      context,
                      "REGISTRO DE ACTIVIDADES",
                    );
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
                  headingRowColor: MaterialStateProperty.all(Colors.green[100]),
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
                    DataColumn(label: Text("Usuario")),
                    DataColumn(label: Text("Sector")),
                    DataColumn(label: Text("Programa")),
                  ],
                  rows: const [
                    DataRow(selected: true, cells: [
                      DataCell(Text("Admin")),
                      DataCell(Text("Publico")),
                      DataCell(Text("Alta")),
                    ]),
                    DataRow(cells: [
                      DataCell(Text("Ramos")),
                      DataCell(Text("Ayu")),
                      DataCell(Text("999")),
                    ])
                  ],
                ),
              ),
            ),

            /**
             * Tipo Acción
             */
            DropdownButtonFormField(
              decoration: const InputDecoration(labelText: "Tipo Acción"),
              value: _valueTipoAccion,
              onChanged: (String? value) {
                setState(() {
                  _valueTipoAccion = value!;
                });
              },
              items:
                  _itemTipoAccion.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            /**
            * Detalle de Necesidades
            */
            TextFormField(
              controller: _detalleNecesidades,
              decoration: const InputDecoration(
                labelText: 'Detalle de Necesidades',
              ),
              validator: (v) => v!.isEmpty ? 'Required'.tr : null,
              enabled: true,
            ),
            /**
             * Adjuntar Archivo
             */
            const SizedBox(height: 20.0),
            const Text("Adjuntar Archivos"),
            /**
             * Bonones De Control
             */
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: const Color.fromARGB(255, 12, 124, 205),
                    shadowColor: const Color.fromARGB(255, 53, 53, 53),
                    elevation: 5,
                  ),
                  onPressed: () {},
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
                    foregroundColor: Colors.white, backgroundColor: const Color.fromARGB(255, 226, 82, 30),
                    shadowColor: const Color.fromARGB(255, 53, 53, 53),
                    elevation: 5,
                  ),
                  onPressed: () {},
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
  static final _itemUsuario = [
    "SELECCIONE UNA OPCIÓN",
    "User1 User1 User1 User1 User1 User1 User1",
    "User2"
  ];
  static final _itemSector = ["Seleccionar", "User1", "User2"];
  static final _itemPrograma = ["Seleccionar", "User1", "User2"];

  String? _valueUsuario = _itemUsuario[0];
  String? _valueSector = _itemSector[0];
  String? _valuePrograma = _itemPrograma[0];

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
              child: title == 'REGISTRO DE ACTIVIDADES'
                  ? regitroActividades()
                  : regitroEntidades(),
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
                      if (_formKey1.currentState!.validate()) {}
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

  static final _itemTipoUser = [
    "SELECCIONE UNA OPCIÓN",
    "User1 User1 User1 User1 User1 User1 User1",
    "User2"
  ];
  static final _itemESector = ["Seleccionar", "User1", "User2"];
  static final _itemEPrograma = ["Seleccionar", "User1", "User2"];
  static final _itemECategoria = ["Seleccionar", "User1", "User2"];
  static final _itemSubCategoria = ["Seleccionar", "User1", "User2"];
  static final _itemTActividad = ["Seleccionar", "User1", "User2"];
  static final _itemServicio = ["Seleccionar", "User1", "User2"];
  final _descripcionE = TextEditingController();

  String? _valueTipoUser = _itemTipoUser[0];
  String? _valueESector = _itemESector[0];
  String? _valueEPrograma = _itemEPrograma[0];
  String? _valueECategoria = _itemECategoria[0];
  String? _valueSubCategoria = _itemSubCategoria[0];
  String? _valueTActividad = _itemTActividad[0];
  String? _valueServico = _itemServicio[0];

  Column regitroEntidades() {
    return Column(
      children: [
        /**
        * Usuario
        */
        DropdownButtonFormField(
          decoration: const InputDecoration(labelText: "Tipo Usuario"),
          value: _valueTipoUser,
          isDense: true,
          isExpanded: true,
          validator: (value) => value!.toUpperCase() == "SELECCIONE UNA OPCIÓN"
              ? 'Requerido *'
              : null,
          onChanged: (String? value) {
            setState(() {
              _valueTipoUser = value!;
            });
          },
          items: _itemTipoUser.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: const TextStyle(fontSize: 12),
              ),
            );
          }).toList(),
        ),
        /**
        * Sector
        */
        DropdownButtonFormField(
          decoration: const InputDecoration(labelText: "Sector"),
          value: _valueESector,
          isDense: true,
          isExpanded: true,
          onChanged: (String? value) {
            setState(() {
              _valueESector = value!;
            });
          },
          items: _itemESector.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: const TextStyle(fontSize: 12),
              ),
            );
          }).toList(),
        ),
        /**
        * Programa
        */
        DropdownButtonFormField(
          decoration: const InputDecoration(labelText: "Programa"),
          value: _valueEPrograma,
          isDense: true,
          isExpanded: true,
          onChanged: (String? value) {
            setState(() {
              _valueEPrograma = value!;
            });
          },
          items: _itemEPrograma.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: const TextStyle(fontSize: 12),
              ),
            );
          }).toList(),
        ),
        /**
         * Categoria
         */
        DropdownButtonFormField(
          decoration: const InputDecoration(labelText: "Categoria"),
          value: _valueECategoria,
          isDense: true,
          isExpanded: true,
          onChanged: (String? value) {
            setState(() {
              _valueECategoria = value!;
            });
          },
          items: _itemECategoria.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: const TextStyle(fontSize: 12),
              ),
            );
          }).toList(),
        ),
        /**
         * Sub Categoria
         */
        DropdownButtonFormField(
          decoration: const InputDecoration(labelText: "Sub Categoria"),
          value: _valueSubCategoria,
          isDense: true,
          isExpanded: true,
          onChanged: (String? value) {
            setState(() {
              _valueSubCategoria = value!;
            });
          },
          items:
              _itemSubCategoria.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: const TextStyle(fontSize: 12),
              ),
            );
          }).toList(),
        ),
        /**
         * Tipo Actividad
         */
        DropdownButtonFormField(
          decoration: const InputDecoration(labelText: "Tipo Actividad"),
          value: _valueTActividad,
          isDense: true,
          isExpanded: true,
          onChanged: (String? value) {
            setState(() {
              _valueTActividad = value!;
            });
          },
          items: _itemTActividad.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: const TextStyle(fontSize: 12),
              ),
            );
          }).toList(),
        ),
        /**
         * Servicio
         */
        DropdownButtonFormField(
          decoration: const InputDecoration(labelText: "Servicio"),
          value: _valueServico,
          isDense: true,
          isExpanded: true,
          onChanged: (String? value) {
            setState(() {
              _valueServico = value!;
            });
          },
          items: _itemServicio.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: const TextStyle(fontSize: 12),
              ),
            );
          }).toList(),
        ),
        /**
         * Descripción de Actividad Programada
         */
        TextFormField(
          controller: _descripcionE,
          decoration: const InputDecoration(
            labelText: 'Descripción de Actividad Programada',
          ),
          validator: (v) => v!.isEmpty ? 'Required'.tr : null,
          enabled: true,
        ),
      ],
    );
  }

  Column regitroActividades() {
    return Column(
      children: [
        /**
        * Usuario
        */
        DropdownButtonFormField(
          decoration: const InputDecoration(labelText: "Usuario"),
          value: _valueUsuario,
          isDense: true,
          isExpanded: true,
          validator: (value) => value!.toUpperCase() == "SELECCIONE UNA OPCIÓN"
              ? 'Requerido *'
              : null,
          onChanged: (String? value) {
            setState(() {
              _valueUsuario = value!;
            });
          },
          items: _itemUsuario.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: const TextStyle(fontSize: 12),
              ),
            );
          }).toList(),
        ),
        /**
                 * Sector
                 */
        DropdownButtonFormField(
          decoration: const InputDecoration(labelText: "Sector"),
          value: _valueSector,
          isDense: true,
          isExpanded: true,
          onChanged: (String? value) {
            setState(() {
              _valueSector = value!;
            });
          },
          items: _itemSector.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: const TextStyle(fontSize: 12),
              ),
            );
          }).toList(),
        ),
        /**
                 * Programa
                 */
        DropdownButtonFormField(
          decoration: const InputDecoration(labelText: "Programa"),
          value: _valuePrograma,
          isDense: true,
          isExpanded: true,
          onChanged: (String? value) {
            setState(() {
              _valuePrograma = value!;
            });
          },
          items: _itemPrograma.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: const TextStyle(fontSize: 12),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
