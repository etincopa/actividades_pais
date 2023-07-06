import 'package:flutter/material.dart';

class RegistroCronograma extends StatelessWidget {
  const RegistroCronograma({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const fem = 1.05;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    const tam = 0.75;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Acción cuando se presiona el botón
        },
        backgroundColor: Colors.blue,
        child: const Icon(
          Icons.check,
          color: Colors.white,
        ),
      ),
      backgroundColor: const Color(0xFF8BBFD1),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 10, top: 30, right: 5),
              height: height * 0.95,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16 * fem),
                color: const Color(0xffffffff),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x3f000000),
                    offset: Offset(0 * fem, 4 * fem),
                    blurRadius: 2 * fem,
                  ),
                ],
              ),
              child: Container(
                margin: const EdgeInsets.all(30),
                child: Column(
                  children: [
                    Container(
                      width: width * 1,
                      height: height * 0.07,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0, 5),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: const Center(
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
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Align(
                          child: SizedBox(
                            width: width * tam,
                            child: TextFormField(
                              decoration: const InputDecoration(
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
                              decoration: const InputDecoration(
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
                                decoration: const InputDecoration(
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
                              decoration: const InputDecoration(
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
                              decoration: const InputDecoration(
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
                              decoration: const InputDecoration(
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
                              decoration: const InputDecoration(
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
                              decoration: const InputDecoration(
                                  hintText: "Responsable",
                                  labelText: "Responsable"),
                            ),
                          ),
                        )
                      ],
                    ),
                    const Row(
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
