// ignore_for_file: non_constant_identifier_names

import 'package:actividades_pais/src/datamodels/Provider/ProviderServicios.dart';
import 'package:flutter/material.dart';
import 'package:actividades_pais/src/datamodels/Clases/Ccpp.dart';
import 'package:actividades_pais/src/datamodels/Clases/CentroPoblado.dart';
import 'package:actividades_pais/src/datamodels/Clases/Distritos.dart';
import 'package:actividades_pais/src/datamodels/Clases/ListarEntidadFuncionario.dart';
import 'package:actividades_pais/src/datamodels/Clases/LugarPrestacion.dart';
import 'package:actividades_pais/src/datamodels/Clases/ParticipanteEjecucion.dart';
import 'package:actividades_pais/src/datamodels/Clases/Participantes.dart';
import 'package:actividades_pais/src/datamodels/Clases/Provincia.dart';
import 'package:actividades_pais/src/datamodels/Clases/ServicioProgramacionParticipante.dart';
import 'package:actividades_pais/src/datamodels/Clases/Sexo.dart';
import 'package:actividades_pais/src/datamodels/Clases/TipoDocumento.dart';
import 'package:actividades_pais/src/datamodels/Provider/Provider.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:actividades_pais/src/datamodels/database/DatabasePr.dart';
import 'package:actividades_pais/src/pages/Intervenciones/util/utils.dart';
import 'package:intl/intl.dart';

import '../../../../util/app-config.dart';
import '../../../datamodels/database/DatabaseProvincia.dart';

enum BestTutorSite { javatpoint, w3schools, tutorialandexample }

class Animal {
  final int id;
  final String name;

  Animal({
    this.id = 0,
    this.name = '',
  });
}

class ParticipantesPage extends StatefulWidget {
  int idProgramacion = 0;
  int snip = 0;

  ParticipantesPage({this.idProgramacion = 0, this.snip = 0});

  @override
  State<ParticipantesPage> createState() => _ParticipantesPageState();
}

class _ParticipantesPageState extends State<ParticipantesPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  ProviderDatos provider = ProviderDatos();
  var tipoDoc = "Seleccione documento de Indentidad";
  var nombreBoton = "Validar DNI";
  bool visibilityTag = true;
  BestTutorSite _site = BestTutorSite.javatpoint;
  bool validarcontroles = false;
  Participantes participantes = Participantes();
  TextEditingController controllerPrimerNombre = TextEditingController();
  TextEditingController controllerSegundoNombre = TextEditingController();

  TextEditingController controllerApellidoPaterno = TextEditingController();
  TextEditingController controllerApellidoMaterno = TextEditingController();
  TextEditingController controllerNumeroDoc = TextEditingController();
  TextEditingController controllerCargo = TextEditingController();
  TextEditingController controllerCelular = TextEditingController();
  TextEditingController controllerfechaNacimiento = TextEditingController();
  TextEditingController controllerSexo = TextEditingController();
  TextEditingController controllerEdad = TextEditingController();

  String ubigeoCpp = '';
  String nombreResidencia = '';
  String provinciaUbigeo = '';
  static List<ParticipanteEjecucion> _animals = [
    ParticipanteEjecucion(
        id_servicio: 1, nombre_servicio: "PARTICIPAR EssN REUNION MENSUAL UT"),
  ];

  //final _items =

  late int fueraAmbito = 0;
  var formatter = new DateFormat('yyyy-MM-dd');

  DateTime? nowfec = new DateTime.now();
  late List<ParticipanteEjecucion> listas = [];
  ServicioProgramacionParticipante participanteSr =
      ServicioProgramacionParticipante();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool _value = false;
  var cppText = "CC PP Residente";

  var provinciaDescripcion = "Provincia";
  var ubigeoProvincia = "";
  var distritoDescripcion = "Distrito";
  var ubigeoDistrito = '';
  var centroPblado = "Centro Poblado";
  var ubigeoCentroPoblado = "0";
  var entidad = "Entidad";
  var id_entidad = 0;
  bool closeTraerDni = false;
  final _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConfig.primaryColor,
        leading: Util().iconbuton(() => Navigator.of(context).pop()),
        title: Text(
          "AGREGAR PARTICIPANTES  - ${widget.idProgramacion}",
          style: TextStyle(fontSize: 15),
        ),
      ),
      body: Container(
        child: ListView(
          children: [
            Column(
              children: <Widget>[
                ListTile(
                  title: const Text('Tiene DNI'),
                  leading: Radio(
                    activeColor: AppConfig.primaryColor,
                    focusColor: AppConfig.primaryColor,
                    value: BestTutorSite.javatpoint,
                    groupValue: _site,
                    onChanged: (BestTutorSite? value) {
                      setState(() {
                        setborrar();
                        _site = value!;
                        nombreBoton = "Validar DNI";
                        visibilityTag = true;
                        validarcontroles = false;
                        participantes.tipoParticipante = 0;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Menor de Edad Datos no encontrados'),
                  leading: Radio(
                    activeColor: AppConfig.primaryColor,
                    focusColor: AppConfig.primaryColor,
                    value: BestTutorSite.w3schools,
                    groupValue: _site,
                    onChanged: (BestTutorSite? value) {
                      setState(() {
                        setborrar();
                        _site = value!;
                        nombreBoton = "Validar en el Padron";
                        visibilityTag = true;
                        validarcontroles = true;
                        participantes.tipoParticipante = 1;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('No tiene DNI'),
                  leading: Radio(
                    activeColor: AppConfig.primaryColor,
                    focusColor: AppConfig.primaryColor,
                    value: BestTutorSite.tutorialandexample,
                    groupValue: _site,
                    onChanged: (BestTutorSite? value) {
                      setState(() {
                        setborrar();
                        _site = value!;
                        visibilityTag = false;
                        validarcontroles = true;
                        participantes.tipoParticipante = 2;
                      });
                    },
                  ),
                ),
                Container(),
                SizedBox(
                  width: 350,
                  child: TextField(
                    focusNode: _focusNode,
                    maxLength: 8,
                    keyboardType: TextInputType.number,
                    controller: controllerNumeroDoc,
                    decoration: InputDecoration(
                      labelText: 'DNI',
                      hintText: 'DNI',
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                visibilityTag
                    ? SizedBox(
                        width: 350,
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                AppConfig.primaryColor),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              closeTraerDni
                                  ? Image.asset(
                                      "assets/loaderios.gif",
                                      height: 40.0,
                                      width: 50.0,
                                      //color: Colors.transparent,
                                    )
                                  : new Container(),
                              Text(
                                nombreBoton,
                                style: TextStyle(
                                  color: Colors
                                      .white, // this is for your text colour
                                ),

                              ),
                            ],
                          ),
                          onPressed: () async {
                            _focusNode.unfocus();
                            setborrar();
                            closeTraerDni = true;
                            setState(() {});
                            var usuario =
                                await provider.getUsuarioParticipanteDni(
                                    controllerNumeroDoc.text,
                                    widget.idProgramacion);

                            switch (usuario!.estado) {
                              case 'FALLECIDO':
                                showAlertDialog(
                                  context,
                                  "!Participante Fallecido!, El participante a registrar tiene el estado de fallecido por lo que no puede ser registrado.",
                                );
                                validarcontroles = false;
                                closeTraerDni = false;
                                setState(() {});
                                break;
                              case 'ENCONTRADO_SERV_RENIEC':
                                print(usuario.edad.toString());
                                String micadena = "${usuario.primerNombre!}";
                                var longitud = micadena.split(' ');

                                if (longitud.length > 1) {
                                  controllerPrimerNombre.text = longitud[0];
                                  controllerSegundoNombre.text = longitud[1];
                                } else {
                                  controllerPrimerNombre.text =
                                      usuario.primerNombre!;
                                  controllerSegundoNombre.text =
                                      usuario.primerNombre!;
                                }
                                controllerApellidoPaterno.text =
                                    usuario.apellidoPaterno!;
                                controllerApellidoMaterno.text =
                                    usuario.apellidoMaterno!;
                                if (usuario.sexo == "1") {
                                  controllerSexo.text = "M";
                                } else if (usuario.sexo == "2") {
                                  controllerSexo.text = "F";
                                }
                                controllerfechaNacimiento.text =
                                    usuario.fechaNacimiento!;

                                controllerEdad.text = controllerEdad
                                    .text = DateTime(DateTime.now().year -
                                        DateTime.parse(usuario.fechaNacimiento!)
                                            .year)
                                    .year
                                    .toString();
                                setState(() {});
                                validarcontroles = false;
                                closeTraerDni = false;
                                break;
                              case 'ENCONTRADO_JSON':
                                print(usuario.sexo);
                                String micadena = "${usuario.primerNombre!}";
                                controllerPrimerNombre.text =
                                    usuario.primerNombre!;
                                controllerSegundoNombre.text =
                                    usuario.segundoNombre!;
                                controllerApellidoPaterno.text =
                                    usuario.apellidoPaterno!;
                                controllerApellidoMaterno.text =
                                    usuario.apellidoMaterno!;
                                controllerSexo.text = usuario.sexo!;
                                controllerfechaNacimiento.text =
                                    usuario.fechaNacimiento!;
                                controllerEdad.text = controllerEdad
                                    .text = DateTime(DateTime.now().year -
                                        DateTime.parse(usuario.fechaNacimiento!)
                                            .year)
                                    .year
                                    .toString();
                                validarcontroles = false;
                                closeTraerDni = false;
                                setState(() {});
                                break;
                              case 'NO_ENCONTRADO':
                                showAlertDialog(context,
                                    "Datos no encontrados en nuestra base de datos, registrar los datos manualmente.");

                                validarcontroles = true;
                                closeTraerDni = false;
                                setState(() {});

                                break;
                              default:
                            }

                            /*   print("usuario!.dni");
                       if ( usuario == null) {
                        showAlertDialog(context,
                            "Datos no encontrados en nuestra base de datos, registrar los datos manualmente.");

                        ///_fetchData(context);
                        closeTraerDni = false;
                        setState(() {});
                      }
                      if ( usuario!.dni == '') {
                        showAlertDialog(context,
                            "Datos no encontrados en nuestra base de datos, registrar los datos manualmente.");

                        ///_fetchData(context);
                        closeTraerDni = false;
                        setState(() {});
                      } else {
                        //_fetchData(context);
                        closeTraerDni = false;
                        setState(() {});
                        if (usuario.segundoNombre != null) {
                          controllerPrimerNombre.text =
                          usuario.primerNombre!;
                          controllerSegundoNombre.text =
                          usuario.segundoNombre!;
                        } else {
                          String micadena = "${usuario.primerNombre!}";
                          int longitud = micadena.split(' ').length;

                          if (longitud == 1) {
                            controllerPrimerNombre.text =
                            usuario.primerNombre!;
                          } else {
                            final datos =
                            usuario.primerNombre!.split(" ");

                            controllerPrimerNombre.text = datos[0];
                            controllerSegundoNombre.text = datos[1];
                          }
                        }
/*  if (controllerPrimerNombre.text != "") {
                                print("aqui");
                                closeTraerDni = false;
                               // closeTraerDni = false;
                                setState(() {});
                              }*/
                        controllerApellidoPaterno.text =
                        usuario.apellidoPaterno!;
                        controllerApellidoMaterno.text =
                        usuario.apellidoMaterno!;

                        if (usuario.sexo == "1") {
                          controllerSexo.text = "M";
                        } else if (usuario.sexo == "2") {
                          controllerSexo.text = "F";
                        } else {
                          controllerSexo.text = usuario.sexo!;
                        }
                        controllerfechaNacimiento.text =
                        usuario.fechaNacimiento!;
                        if (usuario.fechaNacimiento != '') {
                          controllerEdad.text = DateTime(DateTime.now()
                              .year -
                              DateTime.parse(usuario.fechaNacimiento!)
                                  .year)
                              .year
                              .toString();
                        }
                      }*/

                            //   setState(() {});
                          },
                        ),
                      )
                    : new Container(),
                SizedBox(
                  width: 350,
                  child: TextField(
                    enabled: validarcontroles,
                    controller: controllerPrimerNombre,
                    decoration: InputDecoration(
                      labelText: 'Primer Nombre',
                      hintText: 'Primer Nombre',
                    ),
                  ),
                ),
                SizedBox(
                  width: 350,
                  child: TextField(
                    enabled: validarcontroles,
                    controller: controllerSegundoNombre,
                    decoration: InputDecoration(
                      labelText: 'Segundo Nombre',
                      hintText: 'Segundo Nombre',
                    ),
                  ),
                ),
                SizedBox(
                  width: 350,
                  child: TextField(
                    controller: controllerApellidoPaterno,
                    enabled: validarcontroles,
                    decoration: InputDecoration(
                      labelText: 'Apellido Paterno',
                      hintText: 'Apellido Paterno',
                    ),
                  ),
                ),
                SizedBox(
                  width: 350,
                  child: TextField(
                    controller: controllerApellidoMaterno,
                    enabled: validarcontroles,
                    decoration: InputDecoration(
                      labelText: 'Apellido Materno',
                      hintText: 'Apellido Materno',
                    ),
                  ),
                ),
                !validarcontroles
                    ? SizedBox(
                        width: 350,
                        child: TextField(
                          controller: controllerSexo,
                          enabled: validarcontroles,
                          decoration: InputDecoration(
                            labelText: 'Sexo',
                            hintText: 'Sexo',
                          ),
                        ),
                      )
                    : new Container(),
                validarcontroles
                    ? SizedBox(
                        width: 350,
                        child: FutureBuilder<List<Sexo>>(
                          future: ProviderServicios().getSexo(),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<Sexo>> snapshot) {
                            if (snapshot.hasData) {
                              return Container(
                                  child: DropdownButton<Sexo>(
                                underline: SizedBox(),
                                isExpanded: true,
                                items: snapshot.data
                                    ?.map((user) => DropdownMenuItem<Sexo>(
                                          child: Text(user.descripcion),
                                          value: user,
                                        ))
                                    .toList(),
                                onChanged: (Sexo? newVal) {
                                  controllerSexo.text = newVal!.cod;
                                  setState(() {});
                                },
                                hint: Text(
                                  "Sexo ${controllerSexo.text}",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ));
                            }
                            return SizedBox();
                          },
                        ),
                      )
                    : new Container(),
                SizedBox(
                    width: 350,
                    child: TextField(
                      enabled: validarcontroles,
                      //cursorColor: Colors.blueAccent,
                      controller: controllerfechaNacimiento,
                      //obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Fecha Nacimiento',
                        hintText: 'Fecha Nacimiento',
                        /*   fillColor: Colors.blueAccent,
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0), */
                        /* border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)) */
                      ),
                      onTap: () async {
                        //print(formattedDate); // 2016-01-25
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: nowfec!,
                          firstDate: DateTime(1900, 8),
                          lastDate: DateTime(2101),
                        );

                        if (picked != null) {}

                        setState(() {
                          controllerfechaNacimiento.text
                              .replaceAll('', formatter.format(picked!));
                          controllerfechaNacimiento.text =
                              formatter.format(picked);

                          var rest = DateTime(DateTime.now().year -
                              DateTime.parse(controllerfechaNacimiento.text)
                                  .year);
                          controllerEdad.text = rest.year.toString();
                        });
                      },
                    )),
                SizedBox(
                  width: 350,
                  child: TextField(
                    controller: controllerEdad,
                    enabled: validarcontroles,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Edad',
                      hintText: 'Edad',
                    ),
                  ),
                ),
                (_value == false)
                    ? Container(
                        width: 350,
                        child: FutureBuilder<List<ListarCcpp>>(
                          future: DatabasePr.db.ListarCcpps(),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<ListarCcpp>> snapshot) {
                            ListarCcpp depatalits;

                            if (!snapshot.hasData) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            final preguntas = snapshot.data;

                            if (preguntas!.length == 0) {
                              return Center(
                                child: Text("sin dato"),
                              );
                            } else {
                              return Container(
                                  // decoration: servicios.myBoxDecoration(),
                                  child: DropdownButton<ListarCcpp>(
                                underline: SizedBox(),
                                isExpanded: true,
                                items: snapshot.data
                                    ?.map(
                                        (user) => DropdownMenuItem<ListarCcpp>(
                                              child: Text(user.nombreCcpp!),
                                              value: user,
                                            ))
                                    .toList(),
                                onChanged: (ListarCcpp? newVal) {
                                  cppText = newVal!.nombreCcpp!;
                                  ubigeoCpp = newVal.ubigeoCcpp!;
                                  print(ubigeoCpp);
                                  setState(() {});
                                },
                                //value: depatalits.,
                                hint: Text("$cppText $ubigeoCpp"),
                              ));
                            }
                          },
                        ),
                      )
                    : new Container(),
                (_value == true)
                    ? Container(
                        width: 350,
                        child: FutureBuilder<List<Provincia>>(
                          future: DatabaseProvincia.db.getProvincias(),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<Provincia>> snapshot) {
                            if (!snapshot.hasData) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            final preguntas = snapshot.data;

                            if (preguntas!.length == 0) {
                              return Center(
                                child: Text("sin dato"),
                              );
                            } else {
                              return Container(
                                  // decoration: servicios.myBoxDecoration(),
                                  child: DropdownButton<Provincia>(
                                underline: SizedBox(),
                                isExpanded: true,
                                items: snapshot.data
                                    ?.map((user) => DropdownMenuItem<Provincia>(
                                          child:
                                              Text(user.provinciaDescripcion!),
                                          value: user,
                                        ))
                                    .toList(),
                                onChanged: (Provincia? newVal) {
                                  provinciaDescripcion =
                                      newVal!.provinciaDescripcion!;
                                  ubigeoProvincia = newVal.provinciaUbigeo!;
                                  setState(() {});
                                },
                                hint: Text("$provinciaDescripcion"),
                              ));
                            }
                          },
                        ),
                      )
                    : new Container(),
                (_value == true)
                    ? Container(
                        width: 350,
                        child: FutureBuilder<List<Distrito>>(
                          future:
                              DatabaseProvincia.db.getDistrito(ubigeoProvincia),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<Distrito>> snapshot) {
                            Distrito depatalits;

                            if (!snapshot.hasData) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            final preguntas = snapshot.data;

                            if (preguntas!.length == 0) {
                              return Center(
                                child: Text("sin dato"),
                              );
                            } else {
                              return Container(
                                  // decoration: servicios.myBoxDecoration(),
                                  child: DropdownButton<Distrito>(
                                underline: SizedBox(),
                                isExpanded: true,
                                items: snapshot.data
                                    ?.map((user) => DropdownMenuItem<Distrito>(
                                          child:
                                              Text(user.distritoDescripcion!),
                                          value: user,
                                        ))
                                    .toList(),
                                onChanged: (Distrito? newVal) {
                                  distritoDescripcion =
                                      newVal!.distritoDescripcion!;
                                  ubigeoDistrito = newVal.distritoUbigeo!;

                                  setState(() {
                                    centroPblado = 'Centro Poblado';
                                  });
                                },
                                //value: depatalits.,
                                hint: Text("$distritoDescripcion"),
                              ));
                            }
                          },
                        ),
                      )
                    : new Container(),
                (_value == true)
                    ? Container(
                        width: 350,
                        child: FutureBuilder<List<CentroPoblado>>(
                          future: DatabaseProvincia.db
                              .getCentroPoblado(ubigeoDistrito),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<CentroPoblado>> snapshot) {
                            CentroPoblado depatalits;

                            if (!snapshot.hasData) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            final preguntas = snapshot.data;

                            if (preguntas!.length == 0) {
                              return Center(
                                child: Text("sin dato"),
                              );
                            } else {
                              return Container(
                                  // decoration: servicios.myBoxDecoration(),
                                  child: DropdownButton<CentroPoblado>(
                                underline: SizedBox(),
                                isExpanded: true,
                                items: snapshot.data
                                    ?.map((user) =>
                                        DropdownMenuItem<CentroPoblado>(
                                          child: Text(
                                              user.centroPobladoDescripcion!),
                                          value: user,
                                        ))
                                    .toList(),
                                onChanged: (CentroPoblado? newVal) {
                                  centroPblado =
                                      newVal!.centroPobladoDescripcion!;
                                  ubigeoCentroPoblado =
                                      newVal.centroPobladoUbigeo!;

                                  setState(() {});
                                },
                                //value: depatalits.,
                                hint: Text("$centroPblado"),
                              ));
                            }
                          },
                        ),
                      )
                    : new Container(),
                Row(
                  children: [
                    Checkbox(
                      activeColor: AppConfig.primaryColor,
                      focusColor: AppConfig.primaryColor,
                      onChanged: (value) {
                        setState(() {
                          _value = value!;
                          fueraAmbito = 1;
                        });
                      },
                      value: _value,
                    ),
                    Text("Fuera de Ambito")
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                      child: Text('Seleccioné Entidad'),
                    ),
                  ],
                ),
                SizedBox(
                  width: 350,
                  child: new FutureBuilder<List<ListarEntidadFuncionario>>(
                    future: DatabasePr.db
                        .listarEntidadFuncionario(widget.idProgramacion),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<ListarEntidadFuncionario>>
                            snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                            child: DropdownButton<ListarEntidadFuncionario>(
                          underline: SizedBox(),
                          isExpanded: true,
                          items: snapshot.data
                              ?.map((user) =>
                                  DropdownMenuItem<ListarEntidadFuncionario>(
                                    child: Text(' ${user.nombre_programa}'),
                                    value: user,
                                  ))
                              .toList(),
                          onChanged: (ListarEntidadFuncionario? newVal) {
                            entidad = newVal!.nombre_programa;
                            id_entidad = newVal.id_entidad;
                            DatabasePr.db.ListarParticipanteEjecucion(
                                widget.idProgramacion, id_entidad);
                            setState(() {});
                          },
                          hint: Text('$entidad'),
                        ));
                      }
                      return SizedBox();
                    },
                  ),
                ),
                SizedBox(
                  width: 365,
                  child: FutureBuilder<List<ParticipanteEjecucion>>(
                    future: DatabasePr.db.ListarParticipanteEjecucion(
                        widget.idProgramacion, id_entidad),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<ParticipanteEjecucion>> snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                            child:
                                MultiSelectDialogField<ParticipanteEjecucion>(
                          selectedColor: Colors.blue[800],
                          //activeColor: Colors.blue[800],
                          //focusColor: Colors.blue[800],
                          items: snapshot.data!
                              .map((animal) =>
                                  MultiSelectItem<ParticipanteEjecucion>(
                                      animal, animal.nombre_servicio!))
                              .toList(),
                          title: Text("Servicios"),
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.0),
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                          ),
                          buttonIcon: Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          buttonText: Text(
                            "Servicios",
                            style: TextStyle(
                              // color: Colors.blue[800],
                              fontSize: 16,
                            ),
                          ),
                          onConfirm: (results) {
                            listas.addAll(results);
                            //_selectedAnimals = results;
                          },
                        ));
                      }
                      return SizedBox();
                    },
                  ),
                ),
                SizedBox(
                  width: 350,
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(AppConfig.primaryColor),
                    ),
                    child: const Text(
                      "Agregar ",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () async {
                      var cantd = await DatabasePr.db.buscarDni(
                          controllerNumeroDoc.text, widget.idProgramacion);
                      setState(() {});
                      if (cantd.length >= 1) {
                        showAlertDialog(context, "Usuario ya registrado");
                      } else {
                        participantes.ubigeoCcpp = ubigeoCpp;
                        //participantes.nombreResidencia = nombreResidencia;
                        participantes.flatResidencia = fueraAmbito.toString();
                        //  participantes.distrito = ubigeoDistrito;
                        //participantes.provincia = ubigeoProvincia;
                        participantes.idCentroPoblado =
                            int.parse(ubigeoCentroPoblado);
                        participantes.primerNombre =
                            controllerPrimerNombre.text;
                        participantes.segundoNombre =
                            controllerSegundoNombre.text;
                        participantes.idProgramacion = widget.idProgramacion;

                        participantes.apellidoPaterno =
                            controllerApellidoPaterno.text;
                        participantes.apellidoMaterno =
                            controllerApellidoMaterno.text;
                        participantes.dni = controllerNumeroDoc.text;
                        //  participantes. controllerCargo.text;
                        participantes.fechaNacimiento =
                            controllerfechaNacimiento.text;
                        participantes.sexo = controllerSexo.text;
                        participantes.edad = int.parse(controllerEdad.text);
                        participantes.tipo = 'participantes';
                        participantes.idEntidad = id_entidad;

                        participantes.nombreCcpp = cppText;

                        if (provinciaDescripcion != "Provincia") {
                          participantes.provincia = provinciaDescripcion;
                          participantes.distrito = distritoDescripcion;
                        }

                        if (centroPblado == "Centro Poblado") {
                          participantes.nombreResidencia = cppText;
                          participantes.centroPoblado = "";
                        } else {
                          participantes.nombreResidencia = centroPblado;
                          participantes.centroPoblado = centroPblado;
                        }

                        ///participantes.nombreResidencia = nombreResidencia;
                        var a = await DatabasePr.db
                            .insertParticipantes(participantes);
                        print("luistasss ${listas.length}");
                        for (var i = 0; i < listas.length; i++) {
                          print(" aawwww $a");
                          participanteSr.id_programacion_participante_servicio =
                              a;
                          /*participanteSr.id_programacion_participante =
                              a;*/
                          participanteSr.idServicio = listas[i].id_servicio!;
                          participanteSr.id_programacion =
                              widget.idProgramacion;
                          participanteSr.tipo = 'participantes';
                          await DatabasePr.db.insertServicio(participanteSr);
                        }
                        setState(() {
                          Navigator.pop(context, 'participantes');
                          //idProgramacion
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context, text) {
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("PAIS"),
      content: Text(text),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  setborrar() async {
    // controllerNumeroDoc.text = "";
    controllerPrimerNombre.text = "";
    controllerSegundoNombre.text = "";
    controllerApellidoPaterno.text = "";
    controllerApellidoMaterno.text = "";
    controllerSexo.text = "";
    controllerfechaNacimiento.text = "";
    controllerEdad.text = "";
    controllerCelular.text = "";
  }
}
