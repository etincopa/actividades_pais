import 'package:actividades_pais/src/pages/Intervenciones/ProgramarPrestaciones/PlanesDeTrabajo/CrearPlan.dart';
import 'package:actividades_pais/src/pages/Intervenciones/ProgramarPrestaciones/PlanesDeTrabajo/Cronograma/Cronogramas.dart';
import 'package:flutter/material.dart';

class PlanesDeTrabajo extends StatelessWidget {
  PlanesDeTrabajo({Key? key}) : super(key: key);
  var fem = 1.05;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return GestureDetector(
      // onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
      child: Scaffold(
        // key: scaffoldKey,

        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF8BBFD1),
                Color(0xFF5A90AC),
              ],
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(10, 55, 10, 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: TextFormField(
                          obscureText: false,
                          decoration: InputDecoration(
                            // labelText: 'Buscar',
                            hintText: 'Buscar',

                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            suffixIcon: const Icon(
                              Icons.search_rounded,
                              color: Color(0xFF000000),
                              size: 50,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(105 * fem, 0, 79 * fem, 0),
                  width: double.infinity,
                  height: 167 * fem,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Align(
                          child: SizedBox(
                            width: 163 * fem,
                            height: 150 * fem,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16 * fem),
                                color: const Color(0xffffffff),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0x3f000000),
                                    offset: Offset(0, 4),
                                    blurRadius: 2,
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'NUEVO PLAN DE TRABAJO',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14 * fem,
                                      fontWeight: FontWeight.w500,
                                      height: 1.2125 * fem,
                                      color: const Color(0xff000000),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 60 * fem,
                                    height: 100 * fem,
                                    child: Image.asset(
                                      'assets/icons/intervenciones/repetir1.png',
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 135 * fem,
                        top: 125 * fem,
                        child: Align(
                          child: SizedBox(
                            width: 40 * fem,
                            height: 42 * fem,
                            child: FloatingActionButton(
                              backgroundColor: Colors.blue,
                              onPressed: () async {
                                var res = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const CrearPlan(),
                                  ),
                                );
                                if (res == 'OK') {}
                              },
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                    height: height * 0.65,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5, // Número de elementos en la lista
                        itemBuilder: (context, index) {
                          return SizedBox(
                            width: 361 * fem,
                            height: 534 * fem,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 17 * fem,
                                  top: 0,
                                  child: SizedBox(
                                    width: 318 * fem,
                                    height: 495 * fem,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(16 * fem),
                                        color: const Color(0xffffffff),
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color(0x3f000000),
                                            offset: Offset(0, 4 * fem),
                                            blurRadius: 2 * fem,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  // rectangle6C11 (1177:1303)
                                  left: 125 * fem,
                                  top: 28 * fem,
                                  child: Align(
                                    child: SizedBox(
                                      width: 210 * fem,
                                      height: 32 * fem,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4 * fem),
                                          color: const Color(0xffd9d9d9),
                                          boxShadow: [
                                            BoxShadow(
                                              color: const Color(0x3f000000),
                                              offset: Offset(0 * fem, 4 * fem),
                                              blurRadius: 2 * fem,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  // nplan0012023pYB (1177:1304)
                                  left: 136 * fem,
                                  top: 34 * fem,
                                  child: Align(
                                    child: SizedBox(
                                      width: 181 * fem,
                                      height: 25 * fem,
                                      child: const Text(
                                        'N° Plan 001 - 2023',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 207 * fem,
                                  top: 361 * fem,
                                  child: SizedBox(
                                    width: 91 * fem,
                                    height: 85 * fem,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(16 * fem),
                                        color: const Color(0xffffffff),
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color(0x3f000000),
                                            offset: Offset(0, 4 * fem),
                                            blurRadius: 2 * fem,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 197 * fem,
                                  top: 74 * fem,
                                  child: SizedBox(
                                    width: 80 * fem,
                                    height: 20 * fem,
                                    child: const Text(
                                      'REGIONAL',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        height: 1.2125,
                                        color: Color(0xff000000),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 101 * fem,
                                  top: 154 * fem,
                                  child: SizedBox(
                                    width: 141 * fem,
                                    height: 25 * fem,
                                    child: const Text(
                                      'NECESIDADES',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        height: 1.2125,
                                        color: Color(0xff000000),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  // brindarasistenciatcnicolegalgr (1175:1299)
                                  left: 44 * fem,
                                  top: 195 * fem,
                                  child: Align(
                                    child: SizedBox(
                                      width: 259 * fem,
                                      height: 119 * fem,
                                      child: const Text(
                                        'Brindar asistencia técnico legal gratuita y/o patrocinio en materia familia, civil, penal y defensa de víctimas, desde las Plataformas de Servicios Fijas - Tambos del PNPAIS, hacia la población de escasos recursos y zonas alejadas',
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 133 * fem,
                                  top: 74 * fem,
                                  child: SizedBox(
                                    width: 42 * fem,
                                    height: 20 * fem,
                                    child: const Text(
                                      'TIPO:',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        height: 1.2125,
                                        color: Color(0xff000000),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 220 * fem,
                                  top: 422 * fem,
                                  child: SizedBox(
                                    width: 59 * fem,
                                    height: 10 * fem,
                                    child: const Text(
                                      'CRONOGRAMA',
                                      style: TextStyle(
                                        fontSize: 8,
                                        fontWeight: FontWeight.w500,
                                        height: 1.2125,
                                        color: Color(0xff000000),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  // agregar1epj (1175:1284)
                                  left: 287 * fem,
                                  top: 419 * fem,
                                  child: Align(
                                      child: InkWell(
                                    onTap: () async {
                                      var res = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const Cronogramas(),
                                        ),
                                      );
                                      if (res == 'OK') {}
                                      //RegistroCronograma
                                      print("Hola");
                                    },
                                    child: SizedBox(
                                      width: 33 * fem,
                                      height: 37 * fem,
                                      child: Image.asset(
                                        'assets/icons/intervenciones/agregar1.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )),
                                ),
                                Positioned(
                                  // cronograma11or3 (1175:1297)
                                  left: 234 * fem,
                                  top: 381 * fem,
                                  child: Align(
                                    child: SizedBox(
                                      width: 36 * fem,
                                      height: 34 * fem,
                                      child: Image.asset(
                                        'assets/icons/intervenciones/cronograma_ 1.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  // image1sFg (1180:1310)
                                  left: 20 * fem,
                                  top: 20 * fem,
                                  child: Align(
                                    child: SizedBox(
                                      width: 90 * fem,
                                      height: 66 * fem,
                                      child: Image.asset(
                                        'assets/icons/intervenciones/image1.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  // lapiz1en7 (1179:1346)
                                  left: 44 * fem,
                                  top: 373 * fem,
                                  child: Align(
                                    child: SizedBox(
                                      width: 18 * fem,
                                      height: 17 * fem,
                                      child: Image.asset(
                                        'assets/icons/intervenciones/lapiz1.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  // eliminar13JT (1179:1347)
                                  left: 41 * fem,
                                  top: 395 * fem,
                                  child: Align(
                                    child: SizedBox(
                                      width: 21 * fem,
                                      height: 20 * fem,
                                      child: Image.asset(
                                        'assets/icons/intervenciones/eliminar1.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  // pdf1ybR (1182:1262)
                                  left: 41 * fem,
                                  top: 422 * fem,
                                  child: Align(
                                    child: SizedBox(
                                      width: 25 * fem,
                                      height: 23 * fem,
                                      child: Image.asset(
                                        'assets/icons/intervenciones/pdf1.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  // descargar1K15 (1179:1348)
                                  left: 44 * fem,
                                  top: 451 * fem,
                                  child: Align(
                                    child: SizedBox(
                                      width: 18 * fem,
                                      height: 18 * fem,
                                      child: Image.asset(
                                        'assets/icons/intervenciones/descargar1.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }))
                /*SizedBox(height: 15,),
          SizedBox(
          width: 361 * fem,
          height: 534 * fem,
          child: Stack(
            children: [

          Positioned(
            left: 17 * fem,
            top: 0,
            child: SizedBox(
              width: 318 * fem,
              height: 495 * fem,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16 * fem),
                  color: const Color(0xffffffff),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x3f000000),
                      offset: Offset(0, 4 * fem),
                      blurRadius: 2 * fem,
                    ),
                  ],
                ),
              ),
            ),
          ),
              Positioned(
                // rectangle6C11 (1177:1303)
                left:  125*fem,
                top:  28*fem,
                child:
                Align(
                  child:
                  SizedBox(
                    width:  210*fem,
                    height:  32*fem,
                    child:
                    Container(
                      decoration:  BoxDecoration (
                        borderRadius:  BorderRadius.circular(4*fem),
                        color:  Color(0xffd9d9d9),
                        boxShadow:  [
                          BoxShadow(
                            color:  Color(0x3f000000),
                            offset:  Offset(0*fem, 4*fem),
                            blurRadius:  2*fem,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                // nplan0012023pYB (1177:1304)
                left:  136*fem,
                top:  34*fem,
                child:
                Align(
                  child:
                  SizedBox(
                    width:  181*fem,
                    height:  25*fem,
                    child:
                    Text(
                      'N° Plan 001 - 2023',
                      textAlign:  TextAlign.center,


                    ),
                  ),
                ),
              ),
          Positioned(
            left: 207 * fem,
            top: 361 * fem,
            child: SizedBox(
              width: 91 * fem,
              height: 85 * fem,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16 * fem),
                  color: const Color(0xffffffff),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x3f000000),
                      offset: Offset(0, 4 * fem),
                      blurRadius: 2 * fem,
                    ),
                  ],
                ),
              ),
            ),
          ),
            Positioned(
            left: 197 * fem,
            top: 74 * fem,
            child: SizedBox(
              width: 80 * fem,
              height: 20 * fem,
              child: Text(
                'REGIONAL',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  height: 1.2125,
                  color: Color(0xff000000),
                ),
              ),
            ),
          ),
          Positioned(
            left: 101 * fem,
            top: 154 * fem,
            child: SizedBox(
              width: 141 * fem,
              height: 25 * fem,
              child: Text(
                'NECESIDADES',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  height: 1.2125,
                  color: const Color(0xff000000),
                ),
              ),
            ),
          ),
              Positioned(
                // brindarasistenciatcnicolegalgr (1175:1299)
                left:  44*fem,
                top:  195*fem,
                child:
                Align(
                  child:
                  SizedBox(
                    width:  259*fem,
                    height:  119*fem,
                    child:
                    Text(
                      'Brindar asistencia técnico legal gratuita y/o patrocinio en materia familia, civil, penal y defensa de víctimas, desde las Plataformas de Servicios Fijas - Tambos del PNPAIS, hacia la población de escasos recursos y zonas alejadas',

                    ),
                  ),
                ),
              ),
          Positioned(
            left: 133 * fem,
            top: 74 * fem,
            child: SizedBox(
              width: 42 * fem,
              height: 20 * fem,
              child: Text(
                'TIPO:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  height: 1.2125,
                  color: const Color(0xff000000),
                ),
              ),
            ),
          ),
          Positioned(
            left: 220 * fem,
            top: 422 * fem,
            child: SizedBox(
              width: 59 * fem,
              height: 10 * fem,
              child: Text(
                'CRONOGRAMA',
                style: TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.w500,
                  height: 1.2125,
                  color: const Color(0xff000000),
                ),
              ),
            ),
          ),
              Positioned(
                // agregar1epj (1175:1284)
                left:  287*fem,
                top:  419*fem,
                child:
                Align(
                  child:
                  InkWell(
                    onTap: (){print("Hola");},
                    child: SizedBox(
                    width:  33*fem,
                    height:  37*fem,
                    child:
                    Image.asset(
                      'assets/icons/intervenciones/agregar1.png',
                      fit:  BoxFit.cover,
                    ),
                  ),)
                ),
              ),
              Positioned(
                // cronograma11or3 (1175:1297)
                left:  234*fem,
                top:  381*fem,
                child:
                Align(
                  child:
                  SizedBox(
                    width:  36*fem,
                    height:  34*fem,
                    child: Image.asset(
                      'assets/icons/intervenciones/cronograma_ 1.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                // image1sFg (1180:1310)
                left: 20 * fem,
                top: 20 * fem,
                child: Align(
                  child: SizedBox(
                    width: 90 * fem,
                    height: 66 * fem,
                    child: Image.asset(
                      'assets/icons/intervenciones/image1.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                // lapiz1en7 (1179:1346)
                left:  44*fem,
                top:  373*fem,
                child:
                Align(
                  child:
                  SizedBox(
                    width:  18*fem,
                    height:  17*fem,
                    child: Image.asset(
                    'assets/icons/intervenciones/lapiz1.png',
                    fit: BoxFit.cover,
                  ),
                  ),
                ),
              ),
              Positioned(
                // eliminar13JT (1179:1347)
                left:  41*fem,
                top:  395*fem,
                child:
                Align(
                  child:
                  SizedBox(
                    width:  21*fem,
                    height:  20*fem,
                    child: Image.asset(
                    'assets/icons/intervenciones/eliminar1.png',
                    fit: BoxFit.cover,
                  ),
                  ),
                ),
              ),
              Positioned(
                // pdf1ybR (1182:1262)
                left:  41*fem,
                top:  422*fem,
                child:
                Align(
                  child:
                  SizedBox(
                    width:  25*fem,
                    height:  23*fem,
                    child: Image.asset(
                      'assets/icons/intervenciones/pdf1.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                // descargar1K15 (1179:1348)
                left:  44*fem,
                top:  451*fem,
                child:
                Align(
                  child:
                  SizedBox(
                    width:  18*fem,
                    height:  18*fem,
                    child: Image.asset(
                      'assets/icons/intervenciones/descargar1.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
          ),
*/
                // add your widgets here
              ],
            ),
          ),
        ),
      ),
    );

    /* return Container(
      // androidlarge1KP9 (1173:1263)
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xff89bfd2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            // autogroupassvoJK (EepBDscHdPCTXcSR8SaSsV)
            padding: const EdgeInsets.fromLTRB(
                20 * fem, 49 * fem, 21 * fem, 30 * fem),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  // autogroupc7ypXEK (EepATyhm5Yyhr3GychC7YP)
                  margin: const EdgeInsets.fromLTRB(
                      0 * fem, 0 * fem, 0 * fem, 21 * fem),
                  padding: const EdgeInsets.fromLTRB(
                      280 * fem, 5 * fem, 8 * fem, 5 * fem),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xffffffff),
                    borderRadius: BorderRadius.circular(16 * fem),
                    boxShadow: [
                      const BoxShadow(
                        color: Color(0x3f000000),
                        offset: Offset(0 * fem, 4 * fem),
                        blurRadius: 2 * fem,
                      ),
                    ],
                  ),
                  child: const Align(
                    // vidriodeaumento1ZqD (1179:1307)
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                        width: 31 * fem,
                        height: 31 * fem,
                        child: Icon(
                          Icons.search_rounded,
                          color: Color(0xFF000000),
                          size: 50,
                        )),
                  ),
                ),
                Container(
                  // autogroup9en7UxB (EepAbiyrUECC2SBpUJ9EN7)
                  margin: const EdgeInsets.fromLTRB(
                      71 * fem, 0 * fem, 73 * fem, 0 * fem),
                  width: double.infinity,
                  height: 125 * fem,
                  child: Stack(
                    children: [
                      Positioned(
                        // rectangle2pFM (1174:1265)
                        left: 0 * fem,
                        top: 0 * fem,
                        child: Align(
                          child: SizedBox(
                            width: 163 * fem,
                            height: 114 * fem,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16 * fem),
                                color: const Color(0xffffffff),
                                boxShadow: [
                                  const BoxShadow(
                                    color: Color(0x3f000000),
                                    offset: Offset(0 * fem, 4 * fem),
                                    blurRadius: 2 * fem,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Positioned(
                        // nuevoplandetrabajotm1 (1175:1291)
                        left: 25 * fem,
                        top: 8 * fem,
                        child: Align(
                          child: SizedBox(
                            width: 113 * fem,
                            height: 34 * fem,
                            child: Text(
                              'NUEVO PLAN DE TRABAJO',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14 * fem,
                                fontWeight: FontWeight.w500,
                                height: 1.2125 * fem / fem,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        // repetir1ZMM (1175:1296)
                        left: 59 * fem,
                        top: 45 * fem,
                        child: Align(
                          child: SizedBox(
                            width: 52 * fem,
                            height: 54 * fem,
                            child: Image.asset(
                              'assets/icons/intervenciones/repetir1.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        // agregar2GmZ (1175:1295)
                        left: 135 * fem,
                        top: 83 * fem,
                        child: Align(
                          child: SizedBox(
                            width: 40 * fem,
                            height: 42 * fem,
                            child: Image.asset(
                              'assets/icons/intervenciones/repetir1.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            // autogroupahfhmyD (EepApYwpAtwKQ1m4e6AhFh)
            width: 361 * fem,
            height: 534 * fem,
            child: Stack(
              children: [
                Positioned(
                  // vector95hrs (1179:1341)
                  left: 0 * fem,
                  top: 142 * fem,
                  child: Align(
                    child: SizedBox(
                      width: 361 * fem,
                      height: 392 * fem,
                      child: Image.asset(
                        'assets/icons/intervenciones/repetir1.png',
                        width: 361 * fem,
                        height: 392 * fem,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  // rectangle1cD9 (1174:1264)
                  left: 17 * fem,
                  top: 0 * fem,
                  child: Align(
                    child: SizedBox(
                      width: 318 * fem,
                      height: 495 * fem,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16 * fem),
                          color: const Color(0xffffffff),
                          boxShadow: [
                            const BoxShadow(
                              color: Color(0x3f000000),
                              offset: Offset(0 * fem, 4 * fem),
                              blurRadius: 2 * fem,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  // rectangle3i1H (1174:1266)
                  left: 207 * fem,
                  top: 361 * fem,
                  child: Align(
                    child: SizedBox(
                      width: 91 * fem,
                      height: 85 * fem,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16 * fem),
                          color: const Color(0xffffffff),
                          boxShadow: [
                            const BoxShadow(
                              color: Color(0x3f000000),
                              offset: Offset(0 * fem, 4 * fem),
                              blurRadius: 2 * fem,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const Positioned(
                  // regional1FH (1174:1271)
                  left: 197 * fem,
                  top: 74 * fem,
                  child: Align(
                    child: SizedBox(
                      width: 80 * fem,
                      height: 20 * fem,
                      child: Text(
                        'REGIONAL',
                        style: TextStyle(
                          fontSize: 16 * fem,
                          fontWeight: FontWeight.w400,
                          height: 1.2125 * fem / fem,
                          color: Color(0xff000000),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  // necesidadesubZ (1177:1306)
                  left: 101 * fem,
                  top: 154 * fem,
                  child: Align(
                    child: SizedBox(
                      width: 141 * fem,
                      height: 25 * fem,
                      child: Text(
                        'NECESIDADES',
                        style: TextStyle(
                          fontSize: 20 * fem,
                          fontWeight: FontWeight.w600,
                          height: 1.2125 * fem / fem,
                          color: const Color(0xff000000),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  // tipoR47 (1177:1305)
                  left: 133 * fem,
                  top: 74 * fem,
                  child: Align(
                    child: SizedBox(
                      width: 42 * fem,
                      height: 20 * fem,
                      child: Text(
                        'TIPO:',
                        style: TextStyle(
                          fontSize: 16 * fem,
                          fontWeight: FontWeight.w400,
                          height: 1.2125 * fem / fem,
                          color: const Color(0xff000000),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  // cronogramajKh (1174:1273)
                  left: 220 * fem,
                  top: 422 * fem,
                  child: Align(
                    child: SizedBox(
                      width: 59 * fem,
                      height: 10 * fem,
                      child: Text(
                        'CRONOGRAMA',
                        style: TextStyle(
                          fontSize: 8 * fem,
                          fontWeight: FontWeight.w500,
                          height: 1.2125 * fem / fem,
                          color: const Color(0xff000000),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  // agregar1qtX (1175:1284)
                  left: 287 * fem,
                  top: 419 * fem,
                  child: Align(
                    child: SizedBox(
                      width: 33 * fem,
                      height: 37 * fem,
                      child: Image.asset(
                        'assets/icons/intervenciones/image1.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  // image1aLK (1175:1294)
                  left: 20 * fem,
                  top: 18 * fem,
                  child: Align(
                    child: SizedBox(
                      width: 90 * fem,
                      height: 66 * fem,
                      child: Image.asset(
                        'assets/icons/intervenciones/image1.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  // cronograma11KHu (1175:1297)
                  left: 234 * fem,
                  top: 381 * fem,
                  child: Align(
                    child: SizedBox(
                      width: 36 * fem,
                      height: 34 * fem,
                      child: Image.asset(
                        'assets/icons/intervenciones/image1.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  // brindarasistenciatcnicolegalgr (1175:1299)
                  left: 44 * fem,
                  top: 195 * fem,
                  child: Align(
                    child: SizedBox(
                      width: 259 * fem,
                      height: 119 * fem,
                      child: Text(
                        'Brindar asistencia técnico legal gratuita y/o patrocinio en materia familia, civil, penal y defensa de víctimas, desde las Plataformas de Servicios Fijas - Tambos del PNPAIS, hacia la población de escasos recursos y zonas alejadas',
                        style: TextStyle(
                          fontSize: 14 * fem,
                          fontWeight: FontWeight.w400,
                          height: 1.2125 * fem / fem,
                          color: const Color(0xff000000),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  // rectangle6eUb (1177:1303)
                  left: 125 * fem,
                  top: 28 * fem,
                  child: Align(
                    child: SizedBox(
                      width: 210 * fem,
                      height: 32 * fem,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4 * fem),
                          color: const Color(0xffd9d9d9),
                          boxShadow: [
                            const BoxShadow(
                              color: Color(0x3f000000),
                              offset: Offset(0 * fem, 4 * fem),
                              blurRadius: 2 * fem,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  // nplan00120239RM (1177:1304)
                  left: 136 * fem,
                  top: 34 * fem,
                  child: Align(
                    child: SizedBox(
                      width: 181 * fem,
                      height: 25 * fem,
                      child: Text(
                        'N° Plan 001 - 2023',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20 * fem,
                          fontWeight: FontWeight.w400,
                          height: 1.2125 * fem / fem,
                          color: const Color(0xff000000),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  // lapiz1eN7 (1179:1346)
                  left: 44 * fem,
                  top: 373 * fem,
                  child: Align(
                    child: SizedBox(
                      width: 18 * fem,
                      height: 17 * fem,
                      child: Image.asset(
                        'assets/icons/intervenciones/image1.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  // eliminar1yQP (1179:1347)
                  left: 41 * fem,
                  top: 395 * fem,
                  child: Align(
                    child: SizedBox(
                      width: 21 * fem,
                      height: 20 * fem,
                      child: Image.asset(
                        'assets/icons/intervenciones/lapiz1.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  // descargar1h5V (1179:1348)
                  left: 44 * fem,
                  top: 451 * fem,
                  child: Align(
                    child: SizedBox(
                      width: 18 * fem,
                      height: 18 * fem,
                      child: Image.asset(
                        'assets/icons/intervenciones/lapiz1.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  // pdf1D3q (1182:1262)
                  left: 41 * fem,
                  top: 422 * fem,
                  child: Align(
                    child: SizedBox(
                      width: 25 * fem,
                      height: 23 * fem,
                      child: Image.asset(
                        'assets/icons/intervenciones/lapiz1.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );*/
  }
}
