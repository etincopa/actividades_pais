import 'package:flutter/material.dart';

class RegistroCronograma extends StatelessWidget {
  const RegistroCronograma({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    final fem = 1.05;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final tam = 0.75;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Acción cuando se presiona el botón
        },
        backgroundColor: Colors.blue,
        child: Icon(
          Icons.check,
          color: Colors.white,
        ),
      ),
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
                margin: EdgeInsets.all(30),
                child: Column(
                  children: [
                    Container(
                      width: width * 1,
                      height: height * 0.07,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0, 5),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            'REGISTRO DE CRONOGRAMA',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Align(
                          child: SizedBox(
                            width: width * tam,
                            child: TextFormField(
                              decoration: InputDecoration(
                                  hintText: "¿Qué se hará?",
                                  labelText: "¿Qué se hará?"),
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Align(
                          child: SizedBox(
                            width: width * tam,
                            child: TextFormField(
                              decoration: InputDecoration(
                                  hintText: "¿Cuál es la finalidad?",
                                  labelText: "¿Cuál es la finalidad?"),
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Align(
                          child: SizedBox(
                              width: width * tam,
                              child: TextFormField(
                                maxLines: 2,
                                decoration: InputDecoration(
                                    hintText: "¿Quien lo hara?",
                                    labelText: "¿Quien lo hara?"),
                              )),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Align(
                          child: SizedBox(
                            width: width * tam,
                            child: TextFormField(
                              decoration: InputDecoration(
                                  hintText: "¿A quien esta dirigido?",
                                  labelText: "¿A quien esta dirigido?"),
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Align(
                          child: SizedBox(
                            width: width * tam,
                            child: TextFormField(
                              decoration: InputDecoration(
                                  hintText: "Población Objetivo",
                                  labelText: "Población Objetivo"),
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Align(
                          child: SizedBox(
                            width: width * tam,
                            child: TextFormField(
                              decoration: InputDecoration(
                                  hintText: "Unidad Medida",
                                  labelText: "Unidad Medida"),
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Align(
                          child: SizedBox(
                            width: width * tam,
                            child: TextFormField(
                              decoration: InputDecoration(
                                  hintText: "Meta", labelText: "Meta"),
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Align(
                          child: SizedBox(
                            width: width * tam,
                            child: TextFormField(
                              decoration: InputDecoration(
                                  hintText: "Responsable",
                                  labelText: "Responsable"),
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
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
