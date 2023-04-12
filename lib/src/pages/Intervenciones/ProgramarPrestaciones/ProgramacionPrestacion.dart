import 'package:actividades_pais/src/datamodels/Clases/Home/Perfiles.dart';
import 'package:actividades_pais/src/datamodels/Clases/UnidadesTerritoriales.dart';
import 'package:actividades_pais/src/datamodels/Provider/ProviderRegistarInterv.dart';
import 'package:actividades_pais/src/datamodels/Provider/ProviderServicios.dart';
import 'package:actividades_pais/src/datamodels/database/DatabasePr.dart';
import 'package:actividades_pais/src/pages/Intervenciones/ProgramarPrestaciones/Event.dart';
import 'package:actividades_pais/src/pages/Intervenciones/ProgramarPrestaciones/ReprogramarFecha.dart';
import 'package:actividades_pais/src/pages/Intervenciones/ProgramarPrestaciones/SuspenderIntervencion.dart';
import 'package:actividades_pais/util/app-config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

import '../Intervenciones.dart';

class ProgramacionPrestacion extends StatefulWidget {
  Evento event;

  ProgramacionPrestacion(this.event);

  @override
  State<ProgramacionPrestacion> createState() => _ProgramacionPrestacionState();
}

class _ProgramacionPrestacionState extends State<ProgramacionPrestacion> {
  var _controllerCooperacionInternacional = TextEditingController();
  var _controllerSector = TextEditingController();
  var _controllerEntidad = TextEditingController();
  var _controllerActividad = TextEditingController();
  var _controllerServicio = TextEditingController();
  var _controllerDescripn = TextEditingController();
  var nombreTambo = '';

  var hora_inicio = '';

  var hora_fin = '';

  var dia = '';
  var mes = '';
  var anio = '';

  var id_evaluacion = '';

  String tipoPlataforma = '';

  String unidadTerritorial = '';

  List<Perfil> roles = [];
  Perfil perfil = Perfil();

  @override
  void initState() {
    // TODO: implement initState
    _datosRol();
    CargarCampos();
    super.initState();
  }

  Future<void> _datosRol() async {
    var res = await DatabasePr.db.loginUser();
    if (res.isNotEmpty) {
      roles.addAll(res.map((e) => Perfil(idMenuPadre: e.rol)));
      perfil = roles.firstWhere((element) => element.idMenuPadre == "110");

      print(perfil != null);
      print(widget.event.estadoProgramacion == "1");
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("PROGRAMACIÓN DE PRESTACION"),
        backgroundColor: AppConfig.primaryColor,
        centerTitle: true,
      ),
      body: ListView(children: [
        Container(
          padding: const EdgeInsets.only(top: 10),
          child: SizedBox(
            height: 35,
            child: Flex(
              direction: Axis.vertical,
              children: [
                Expanded(
                    child: Marquee(
                  text:
                      'TAMBO - $nombreTambo : $dia/$mes/$anio | ($hora_inicio - $hora_fin)',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  scrollAxis: Axis.horizontal,
                  //scroll direction
                  crossAxisAlignment: CrossAxisAlignment.start,
                  blankSpace: 20.0,
                  velocity: 50.0,
                  //speed
                  pauseAfterRound: const Duration(seconds: 1),
                  startPadding: 10.0,
                  accelerationDuration: const Duration(seconds: 1),
                  accelerationCurve: Curves.linear,
                  decelerationDuration: const Duration(milliseconds: 500),
                  decelerationCurve: Curves.easeOut,
                ))
              ],
            ),
          ),
        ),
        id_evaluacion == '0'
            ? Container(
                padding: const EdgeInsets.only(top: 5),
                color: Colors.teal,
                child: SizedBox(
                  height: 35,
                  child: Flex(
                    direction: Axis.vertical,
                    children: [
                      Expanded(
                          child: Marquee(
                        text:
                            'A espera de la aprobacion del JUT, para poder ejecutar esta intervencion',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                        scrollAxis: Axis.horizontal,
                        //scroll direction
                        crossAxisAlignment: CrossAxisAlignment.start,
                        blankSpace: 20.0,
                        velocity: 50.0,
                        //speed
                        pauseAfterRound: const Duration(seconds: 1),
                        startPadding: 10.0,
                        accelerationDuration: const Duration(seconds: 1),
                        accelerationCurve: Curves.linear,
                        decelerationDuration: const Duration(milliseconds: 500),
                        decelerationCurve: Curves.easeOut,
                      ))
                    ],
                  ),
                ),
              )
            : Container(),
        Container(
          margin: EdgeInsets.all(20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            textoCampo("GOBIERNO", _controllerCooperacionInternacional),
            textoCampo("SECTOR", _controllerSector),
            textoCampo("ENTIDAD", _controllerEntidad),
            textoCampo("ACTIVIDAD", _controllerActividad),
            textoCampo("SERVICIO", _controllerServicio),
            textoCampo("DESCRIPCION", _controllerDescripn),
            SizedBox(
              height: 10,
            ),
            if (id_evaluacion == "1") ...[
            widget.event.estadoProgramacion != '5'  ? Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          var res = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  Intervenciones(widget.event.unidadTerritorialDescripcion, snip:widget.event.plataformaCodigoSnip ),
                            ),
                          );
                        },
                        child: SizedBox(
                          height: 40,
                          width: width / 3,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: const [
                                Icon(Icons.playlist_add_check),
                                Text(
                                  'EJECCUCIÓN',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    letterSpacing: 1.5,
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'OpenSans',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          var res = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                    ReprogramarFecha(widget.event),
                            ),
                          );
                        },
                        child: SizedBox(
                          height: 40,
                          width: width / 3,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: const [
                                Icon(Icons.calendar_month),
                                Text(
                                  'REPROGRAMAR',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    letterSpacing: 1.5,
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'OpenSans',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          var res = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                SuspenderIntervencion(idProgramacion: widget.event.idProgramacion),
                            )
                          );
                        },
                        child: SizedBox(
                          height: 40,
                          width: width / 3,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: const [
                                Icon(Icons.stop),
                                Text(
                                  'SUSPENDER',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    letterSpacing: 1.5,
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'OpenSans',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ):Container()
            ]
          ]),
        )
      ]),
    );
  }

  textoCampo(labelText, controller) {
    return TextFormField(
      enabled: false,
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        // hintText: labelText,
      ),
      onTap: () {},
    );
  }

  CargarCampos() async {
    var rp = await ProviderRegistarInterv()
        .getntervencionDetalle(widget.event.idProgramacion);

    print(" id_programacion ${rp["id_programacion"]}");
    _controllerCooperacionInternacional.text = rp["nombre"];
    _controllerSector.text = rp["nombre_sector"];
    _controllerEntidad.text = rp["nombre_programa"];
    _controllerActividad.text = rp["nombre_tipo_actividad"];
    _controllerServicio.text = rp["nombre_tipo_servicio"];
    _controllerDescripn.text = rp["descripcion_intervencion"];
    nombreTambo = rp["plataforma_descripcion"];
    hora_inicio = rp["hora_inicio"];
    hora_fin = rp["hora_fin"];
    dia = rp["dia"];
    mes = rp["mes"];
    anio = rp["anio"];
    id_evaluacion = rp["id_evaluacion"];
    //response[0].id_evaluacion == 0
    // nombreTambo=rp["plataforma_descripcion"];
    setState(() {});
  }
/*
  mostrarTmbo() async {
    DatabasePr.db.initDB();
    var abc = await DatabasePr.db.getAllTasksConfigInicio();

    if (abc.isNotEmpty) {
      if (abc.isNotEmpty) {
        tipoPlataforma = abc[0].tipoPlataforma;
        unidadTerritorial = abc[0].unidTerritoriales;

      }
      setState(() {});

    }
  }*/
}

/*
=======
import 'package:actividades_pais/src/datamodels/Provider/ProviderRegistarInterv.dart';
import 'package:actividades_pais/src/datamodels/database/DatabasePr.dart';
import 'package:actividades_pais/src/pages/Intervenciones/ProgramarPrestaciones/Event.dart';
import 'package:actividades_pais/util/app-config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

import '../Intervenciones.dart';

class ProgramacionPrestacion extends StatefulWidget {
  Evento event;
    ProgramacionPrestacion(this.event);

  @override
  State<ProgramacionPrestacion> createState() => _ProgramacionPrestacionState();
}

class _ProgramacionPrestacionState extends State<ProgramacionPrestacion> {
  var _controllerCooperacionInternacional = TextEditingController();
  var _controllerSector= TextEditingController();
  var _controllerEntidad = TextEditingController();
  var _controllerActividad= TextEditingController();
  var _controllerServicio= TextEditingController();
  var _controllerDescripn= TextEditingController();
var nombreTambo='';

  var hora_inicio='';

  var hora_fin='';

  var dia='';
  var mes='';
  var anio='';

  var id_evaluacion='';

  String tipoPlataforma='';

  String unidadTerritorial='';
  @override
  void initState() {
    // TODO: implement initState
    CargarCampos();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("PROGRAMACIÓN DE PRESTACION"),
        backgroundColor: AppConfig.primaryColor,
        centerTitle: true,
      ),
      body: ListView(children: [
        Container(
          padding: const EdgeInsets.only(top: 10),
          child: SizedBox(
            height: 35,
            child: Flex(
              direction: Axis.vertical,
              children: [
                Expanded(
                    child: Marquee(
                  text: 'TAMBO - $nombreTambo : $dia/$mes/$anio | ($hora_inicio - $hora_fin)',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  scrollAxis: Axis.horizontal,
                  //scroll direction
                  crossAxisAlignment: CrossAxisAlignment.start,
                  blankSpace: 20.0,
                  velocity: 50.0,
                  //speed
                  pauseAfterRound: const Duration(seconds: 1),
                  startPadding: 10.0,
                  accelerationDuration: const Duration(seconds: 1),
                  accelerationCurve: Curves.linear,
                  decelerationDuration: const Duration(milliseconds: 500),
                  decelerationCurve: Curves.easeOut,
                ))
              ],
            ),
          ),
        ),
        id_evaluacion=='0'  ? Container(
          padding: const EdgeInsets.only(top: 5),
          color: Colors.teal,
          child: SizedBox(
            height: 35,
            child: Flex(
              direction: Axis.vertical,
              children: [
                Expanded(
                    child: Marquee(
                  text:
                      'A espera de la aprobacion del JUT, para poder ejecutar esta intervencion',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  scrollAxis: Axis.horizontal,
                  //scroll direction
                  crossAxisAlignment: CrossAxisAlignment.start,
                  blankSpace: 20.0,
                  velocity: 50.0,
                  //speed
                  pauseAfterRound: const Duration(seconds: 1),
                  startPadding: 10.0,
                  accelerationDuration: const Duration(seconds: 1),
                  accelerationCurve: Curves.linear,
                  decelerationDuration: const Duration(milliseconds: 500),
                  decelerationCurve: Curves.easeOut,
                ))
              ],
            ),
          ),
        ):Container(),
        Container(
          margin: EdgeInsets.all(20),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textoCampo("GOBIERNO", _controllerCooperacionInternacional),
                textoCampo("SECTOR", _controllerSector),
                textoCampo("ENTIDAD", _controllerEntidad),
                textoCampo("ACTIVIDAD", _controllerActividad),
                textoCampo("SERVICIO", _controllerServicio),
                textoCampo("DESCRIPCION", _controllerDescripn),
                SizedBox(
              height: 10,
            ),
                widget.event.estadoProgramacion!=0?Column(children: [tipoPlataforma!=''?   Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        var res = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Intervenciones('LORETO'),
                          ),
                        );
                      },
                      child: Container(
                        height: 40,
                        width: width /3,
                        child:   Center(
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [Icon(Icons.playlist_add_check), Text(
                            'EJECCUCIÓN',
                            style: TextStyle(
                              color: Color.fromARGB(
                                  255, 255, 255, 255),
                              letterSpacing: 1.5,
                              fontSize: 10.0,
                              fontWeight:
                              FontWeight.bold,
                              fontFamily: 'OpenSans',
                            ),
                          ),],),
                        ),
                      ),
                    ),

                    tipoPlataforma!=''?  ElevatedButton(
                      onPressed: () async {
                        var res = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Intervenciones(unidadTerritorial),
                          ),
                        );
                      },
                      child: Container(
                        height: 40,
                        width: width / 3,
                        child:   Center(
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [Icon(Icons.calendar_month), Text(
                            'REPROGRAMAR',
                            style: TextStyle(
                              color: Color.fromARGB(
                                  255, 255, 255, 255),
                              letterSpacing: 1.5,
                              fontSize: 10.0,
                              fontWeight:
                              FontWeight.bold,
                              fontFamily: 'OpenSans',
                            ),
                          ),],),
                        ),
                      ),
                    ):Container(),


                  ],
                ):Container(),
                  SizedBox(height: 5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () async {},
                        child: Container(
                          height: 40,
                          width: width / 3,
                          child:   Center(
                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [Icon(Icons.stop), Text(
                              'SUSPENDER',
                              style: TextStyle(
                                color: Color.fromARGB(
                                    255, 255, 255, 255),
                                letterSpacing: 1.5,
                                fontSize: 10.0,
                                fontWeight:
                                FontWeight.bold,
                                fontFamily: 'OpenSans',
                              ),
                            ),],),
                          ),
                        ),
                      ),
                    ],)],):Container()
              ]),
        )
      ]),
    );
  }

  textoCampo(labelText,controller){
    return TextFormField(
    enabled: false,
    controller: controller,
    decoration:  InputDecoration(
      labelText: labelText,
      // hintText: labelText,
    ),
    onTap: () {
    },
  );}
  CargarCampos() async{
    var rp = await ProviderRegistarInterv().getntervencionDetalle(widget.event.idProgramacion);
    await mostrarTmbo();
    print(" id_programacion ${rp["id_programacion"]}");
    _controllerCooperacionInternacional.text=rp["nombre"];
    _controllerSector.text=rp["nombre_sector"];
    _controllerEntidad.text=rp["nombre_programa"];
    _controllerActividad.text=rp["nombre_tipo_actividad"];
    _controllerServicio.text=rp["nombre_tipo_servicio"];
    _controllerDescripn.text=rp["descripcion_intervencion"];
    nombreTambo=rp["plataforma_descripcion"];
    hora_inicio=rp["hora_inicio"];
    hora_fin=rp["hora_fin"];
    dia=rp["dia"];
    mes=rp["mes"];
    anio=rp["anio"];
    id_evaluacion=rp["id_evaluacion"];
    //response[0].id_evaluacion == 0
   // nombreTambo=rp["plataforma_descripcion"];
    setState(() {

    });
  }

  mostrarTmbo() async {
    DatabasePr.db.initDB();
    var abc = await DatabasePr.db.getAllTasksConfigInicio();
    if (abc.isNotEmpty) {
      setState(() {
        if (abc.isNotEmpty) {
          tipoPlataforma = abc[0].tipoPlataforma;
          unidadTerritorial = abc[0].unidTerritoriales;
        }
      });
    }
  }
}
>>>>>>> d3cd1a88918b183261e35fc8b0fbdc041b479366
*/
