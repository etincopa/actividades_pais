import 'package:actividades_pais/src/pages/Intervenciones/ProgramarPrestaciones/TablaEntidades/CrearRegistroEntidad.dart';
import 'package:flutter/material.dart';

class CrearPlan extends StatefulWidget {
  CrearPlan({Key? key}) : super(key: key);

  @override
  State<CrearPlan> createState() => _CrearPlanState();
}

class _CrearPlanState extends State<CrearPlan> {
  var items = [
    {"value": 'x', "descripcion": 'Seleccionar'},
    {"value": 'Local', "descripcion": 'Local'},
    {"value": 'Regional', "descripcion": 'Regional'},
    {"value": 'Nacional', "descripcion": 'Nacional'},
  ];
  var itemsTipoAccion = [
    {"value": '0', "descripcion": 'Seleccionar'},
    {"value": '1', "descripcion": 'Necesidades que atiende el Plan de Trabajo'},
    {"value": '2', "descripcion": 'Potencialidades identificadas que atiende el Plan de Trabajo'},

  ];
  String? selectedTipoProgramacion = "x";
  String? selectedTipoAccion = "0";

  @override
  Widget build(BuildContext context) {
    final fem = 1.05;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final tam = 0.75;

    return Scaffold(
      backgroundColor: Color(0xFF8BBFD1),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 10, top: 30, right: 5),
              height: height * 0.95,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16 * fem),
                color: Color(0xffffffff),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x3f000000),
                    offset: Offset(0 * fem, 4 * fem),
                    blurRadius: 2 * fem,
                  ),
                ],
              ),
              child: Container(
                margin: EdgeInsets.all(25),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Align(
                          child: SizedBox(
                            width: 16 * fem,
                            height: 15 * fem,
                            child: Image.asset(
                              'assets/icons/intervenciones/alineacion1.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Align(
                          child: SizedBox(
                            width: width * tam,
                            child: DropdownButtonFormField<String>(
                              value: selectedTipoProgramacion,
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedTipoProgramacion = newValue;
                                });
                              },
                              decoration: const InputDecoration(
                                labelText: 'Tipo Programacion',
                              ),
                              items:
                                  items.map<DropdownMenuItem<String>>((item) {
                                return DropdownMenuItem<String>(
                                  value: item["value"],
                                  child: Text(
                                    item["descripcion"]!,
                                    style: const TextStyle(fontSize: 10),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Align(
                          child: SizedBox(
                            width: 16 * fem,
                            height: 15 * fem,
                            child: Image.asset(
                              'assets/icons/intervenciones/alineacion1.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Align(
                          child: SizedBox(
                            width: width * tam,
                            child: TextFormField(
                              decoration: InputDecoration(
                                  hintText: "N° Plan de trabajo",
                                  labelText: "N° Plan de trabajo"),
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Align(
                          child: SizedBox(
                            width: 16 * fem,
                            height: 15 * fem,
                            child: Image.asset(
                              'assets/icons/intervenciones/alineacion1.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Align(
                          child: SizedBox(
                            width: width * tam,
                            child: TextFormField(
                              decoration: InputDecoration(
                                  hintText: "Año", labelText: "Año"),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20 * fem,
                    ),
                    Row(
                      children: [
                        Align(
                          child: SizedBox(
                            width: width * tam + 26,
                            child: CrearRegistroEntidad(true),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Align(
                          child: SizedBox(
                            width: 16 * fem,
                            height: 15 * fem,
                            child: Image.asset(
                              'assets/icons/intervenciones/alineacion1.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Align(
                          child: SizedBox(
                            width: width * tam,
                            child: DropdownButtonFormField<String>(
                              value: selectedTipoAccion,
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedTipoAccion = newValue;
                                });
                              },
                              decoration: const InputDecoration(
                                labelText: 'Tipo Accion',
                              ),
                              items:
                              itemsTipoAccion.map<DropdownMenuItem<String>>((item) {
                                return DropdownMenuItem<String>(
                                  value: item["value"],
                                  child: Text(
                                    item["descripcion"]!,
                                    style: const TextStyle(fontSize: 10),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Align(
                          child: SizedBox(
                            width: 16 * fem,
                            height: 15 * fem,
                            child: Image.asset(
                              'assets/icons/intervenciones/alineacion1.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Align(
                          child: SizedBox(
                              width: width * tam,
                              child: TextFormField(
                                maxLines: 2,
                              )),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                    Positioned(
                      // adjuntar1Dfy (1179:1343)
                      left: 150 * fem,
                      top: 1000 * fem,
                      child: Align(
                        child: SizedBox(
                          width: 51 * fem,
                          height: 51 * fem,
                          child: Image.asset(
                            'assets/icons/intervenciones/adjuntar1.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Acción a realizar cuando se presione el botón
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Color(0xFF8BBFD1)),
                      ),
                      child: Text(
                        'CREAR PLAN',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
