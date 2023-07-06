import 'package:actividades_pais/src/datamodels/Clases/EquipoMantenimiento.dart';
import 'package:actividades_pais/src/datamodels/Clases/TipoMantenimiento.dart';
import 'package:actividades_pais/src/datamodels/Provider/ProviderSeguimientoParqueInformatico.dart';
import 'package:actividades_pais/src/datamodels/Provider/ProviderServicios.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../datamodels/Servicios/Servicios.dart';

class CrearMantenimiento extends StatefulWidget {
  int idEquipoInformatico = 0;

  CrearMantenimiento(this.idEquipoInformatico);

  @override
  State<CrearMantenimiento> createState() => _CrearMantenimientoState();
}

class _CrearMantenimientoState extends State<CrearMantenimiento> {
  TextEditingController controladorFechaMantenimiento = TextEditingController();
  TextEditingController controladorTipoMantenimiento = TextEditingController();
  TextEditingController controladorFalla = TextEditingController();
  TextEditingController controladorCausa = TextEditingController();
  TextEditingController controladorSolucion = TextEditingController();
  TextEditingController controladorObservacion = TextEditingController();
  TextEditingController controladorTecnologia = TextEditingController();
  TextEditingController controladorProcesador = TextEditingController();
  TextEditingController controladorRam = TextEditingController();
  TextEditingController controladorDiscoDuro = TextEditingController();
  TextEditingController controladorSistemaOperativo = TextEditingController();
  TipoMantenimiento? selectedTipoMantenimiento;
  EquipoMantenimiento equipoMantenimiento = EquipoMantenimiento();
  String seleccionarTipoMantenimiento = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    equipoMantenimiento.idEquipo = widget.idEquipoInformatico.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            "REGISTRAR MANTENIMIENTO EQUIPO INFORMATICO",
            style: TextStyle(fontSize: 13),
          )),
      body: Container(
          margin: EdgeInsets.all(15),
          child: ListView(
            children: [
              /*{
    "fechaMantenimiento": "2023-06-02T20:34:04.745Z",
    "tipoMantenimiento": 1,
    "descripcion": "2121",
    "falla": "1221",
    "causa": "21212",
    "solucion": "212",
    "tecnologia": "2121",
    "procesador": "2",
    "ram": "2121",
    "disco_duro": "2121",
    "sist_operativo": "2121",
    "archivos": [],
    "idEquipo": "7168",
    "idTicket": "23093"
}*/
              _textFormField(
                controlador: controladorFechaMantenimiento,
                labelText: 'FECHA MANTENIMIENTO',
                icon: Icon(Icons.note_add, size: 15),
                onTab: () {
                  _selectDate(context, controladorFechaMantenimiento);
                  print(controladorFechaMantenimiento.text);
                },
                onChanged: (value) {
                  print("aquii");
                  equipoMantenimiento.fechaMantenimiento = value;
                },
              ),
              tipoMantenimiento(),
              _textFormField(
                lineas: 2,
                controlador: controladorFalla,
                labelText: 'FALLA',
                icon: Icon(Icons.note_add, size: 15),
                onChanged: (value) {
                  equipoMantenimiento.falla = value;
                },
              ),
              _textFormField(
                lineas: 2,
                controlador: controladorCausa,
                labelText: 'CAUSA',
                icon: Icon(Icons.note_add, size: 15),
                onChanged: (value) {
                  equipoMantenimiento.causa = value;
                },
              ),
              _textFormField(
                lineas: 3,
                controlador: controladorSolucion,
                labelText: 'SOLUCION',
                icon: Icon(Icons.note_add, size: 15),
                onChanged: (value) {
                  equipoMantenimiento.solucion = value;
                },
              ),
              _textFormField(
                lineas: 4,
                controlador: controladorObservacion,
                labelText: 'OBSERVACION',
                icon: Icon(Icons.note_add, size: 15),
                onChanged: (value) {
                  equipoMantenimiento.descripcion = value;
                },
              ),
              _textFormField(
                controlador: controladorTecnologia,
                labelText: 'TECNOLOGIA',
                icon: Icon(Icons.note_add, size: 15),
                onChanged: (value) {
                  equipoMantenimiento.tecnologia = value;
                },
              ),
              _textFormField(
                controlador: controladorProcesador,
                labelText: 'PROCESADOR',
                icon: Icon(Icons.note_add, size: 15),
                onChanged: (value) {
                  equipoMantenimiento.procesador = value;
                },
              ),
              _textFormField(
                controlador: controladorRam,
                labelText: 'RAM',
                icon: Icon(Icons.note_add, size: 15),
                onChanged: (value) {
                  equipoMantenimiento.ram = value;
                },
              ),
              _textFormField(
                controlador: controladorDiscoDuro,
                labelText: 'DISCO DURO',
                icon: Icon(Icons.note_add, size: 15),
                onChanged: (value) {
                  equipoMantenimiento.discoDuro = value;
                },
              ),
              _textFormField(
                controlador: controladorSistemaOperativo,
                labelText: 'SISTEMA OPERATIVO',
                icon: Icon(Icons.note_add, size: 15),
                onChanged: (value) {
                  equipoMantenimiento.sistOperativo = value;
                },
              ),
              Container(
                  decoration: Servicios().myBoxDecoration(),
                  margin: const EdgeInsets.only(right: 10, left: 10, top: 10),
                  height: 40.0,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue[600],
                    ),
                    onPressed: () async {
                      equipoMantenimiento.fechaMantenimiento =
                          controladorFechaMantenimiento.text;
                      var resp = await ProviderSeguimientoParqueInformatico()
                          .guardarMantenimiento(equipoMantenimiento);
                      if (resp.estado = true) {
                        Navigator.pop(context, 'OK');
                      }
                      setState(() {});
                    },
                    child: const Text("GUARDAR"),
                  ))
            ],
          )),
    );
  }

  Widget _textFormField(
      {String labelText = '',
      required Icon icon,
      required Function(String) onChanged,
      controlador,
      onTab,
      lineas}) {
    return TextFormField(
      maxLines: lineas,
      controller: controlador,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: labelText,
        icon: icon,
      ),
      style: const TextStyle(fontSize: 10),
      onChanged: onChanged,
      onTap: onTab,
    );
  }

  Widget tipoMantenimiento() {
    return FutureBuilder<List<TipoMantenimiento>>(
      future: ProviderSeguimientoParqueInformatico().ListarTipoMantenimientos(),
      builder: (BuildContext context,
          AsyncSnapshot<List<TipoMantenimiento>> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final preguntas = snapshot.data;
        if (preguntas!.isEmpty) {
          return const Center(
            child: Text("sin dato"),
          );
        } else {
          return Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "          TIPO MANTENIMIENTO",
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5),
                child: Row(
                  children: [
                    const Icon(Icons.account_balance_wallet_outlined,
                        size: 15, color: Colors.grey),
                    const SizedBox(width: 13),
                    Expanded(
                      child: DropdownButton<TipoMantenimiento>(
                        underline: ProviderServicios().underline(),
                        isExpanded: true,
                        items: snapshot.data
                            ?.map((user) => DropdownMenuItem<TipoMantenimiento>(
                                  child:
                                      Text(user.descripcionTipoMantenimiento!),
                                  value: user,
                                ))
                            .toList(),
                        onChanged: (TipoMantenimiento? value) async {
                          setState(() {
                            seleccionarTipoMantenimiento =
                                value!.descripcionTipoMantenimiento!;
                            equipoMantenimiento.tipoMantenimiento =
                                value.idTipoMantenimiento.toString();
                          });
                        },
                        hint: Text(
                          "$seleccionarTipoMantenimiento",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }
      },
    );
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2025),
    );

    if (picked != null) {
      final formattedDate = DateFormat('dd/MM/yyyy').format(picked);
      controller.text =
          formattedDate; // Aquí puedes darle formato a la fecha según tus necesidades
    }
  }
}
