import 'dart:io';

import 'package:flutter/material.dart';
import 'package:actividades_pais/src/datamodels/Clases/Funcionarios.dart';
import 'package:actividades_pais/src/datamodels/Clases/ListarEntidadFuncionario.dart';
import 'package:actividades_pais/src/datamodels/Clases/Paises.dart';
import 'package:actividades_pais/src/datamodels/Clases/TipoDocumento.dart';
import 'package:actividades_pais/src/datamodels/Provider/Provider.dart';
import 'package:actividades_pais/src/datamodels/database/DatabasePr.dart';
import 'package:actividades_pais/src/pages/Intervenciones/util/utils.dart';

import '../../../../util/app-config.dart';

class FuncionariosPage extends StatefulWidget {
  int idProgramacion;
  String programa;

  FuncionariosPage({this.idProgramacion = 0, this.programa = ''});

  @override
  State<FuncionariosPage> createState() => _FuncionariosPageState();
}

class _FuncionariosPageState extends State<FuncionariosPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  ProviderDatos provider = ProviderDatos();
  var tipoDoc = "Seleccione documento de Indentidad";
  var Entidad = "Seleccione Entidad";
  var nombreBoton = "";
  bool visibilityTag = false;
  bool visibilitytipotex = false;
  bool enableController = false;
  TextEditingController controllerNombre = TextEditingController();
  TextEditingController controllerApellidoPaterno = TextEditingController();
  TextEditingController controllerApellidoMaterno = TextEditingController();
  TextEditingController controllerNumeroDoc = TextEditingController();
  TextEditingController controllerCargo = TextEditingController();
  TextEditingController controllerCelular = TextEditingController();
  TextEditingController controllerPais = TextEditingController();
  TextEditingController controllerNumeroDocExtr = TextEditingController();

  Funcionarios funcionarios = Funcionarios();
  Util util = Util();

  // ignore: unused_field
  bool _isOnline = true;
  bool _isActive = false;
  String flgReniec = '';
  var tipoDocumento = 'Tipo';
  int idtipoDocumento = 0;
  int idPais = 0;
  var entidad = "Entidad";
  var id_entidad = 0;
  bool closeTraerDni = false;

  @override
  void initState() {
    super.initState();
    _checkInternetConnection();
    ;
    _controller = AnimationController(vsync: this);
    controllerPais.text = 'Seleccioné Pais';
    _isActive = true;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _checkInternetConnection() async {
    setState(() {});

    try {
      await Future.delayed(Duration(seconds: 1));
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        _isOnline = true;
      } else {
        _isOnline = false;
      }
    } on SocketException catch (_) {
      _isOnline = false;
    }
  }

  bool _value = false;

  @override
  Widget build(BuildContext context) {
    _checkInternetConnection();
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF78b8cd),
        title: Text(
          "AGREGAR FUNCIONARIOS - ${widget.idProgramacion}",
          style: TextStyle(fontSize: 15),
        ),
        leading: Util().iconbuton(() => Navigator.of(context).pop()),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: ListView(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                        activeColor: const Color(0xFF78b8cd),
                        focusColor: const Color(0xFF78b8cd),
                        onChanged: (value) {
                          setState(() {
                            _value = value!;
                            if (_value == true) {
                              nombreBoton = "Extrangero";
                              // ProviderServicios().getTipoDocumento();
                              visibilityTag = true;
                              //visibilitytipotex = false;
                              setborrar();
                            } else {
                              nombreBoton = "";
                              visibilityTag = false;
                              visibilitytipotex = false;
                              visibilityTag = false;
                            }
                          });
                        },
                        value: _value,
                      ),
                      Text("Funcionario Extranjero")
                    ],
                  ),
                  Container(),
                  visibilitytipotex
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('TipoDocumento : $tipoDocumento'),
                          ],
                        )
                      : new Container(),
                  visibilityTag
                      ? new FutureBuilder<List<TipoDocumento>>(
                          future: DatabasePr.db.listarTipoDocumento(),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<TipoDocumento>> snapshot) {
                            if (snapshot.hasData) {
                              return Container(
                                  child: DropdownButton<TipoDocumento>(
                                underline: SizedBox(),
                                isExpanded: true,
                                items: snapshot.data
                                    ?.map((user) =>
                                        DropdownMenuItem<TipoDocumento>(
                                          child: Text(user.descripcion),
                                          value: user,
                                        ))
                                    .toList(),
                                onChanged: (TipoDocumento? newVal) {
                                  tipoDocumento = newVal!.descripcion;
                                  idtipoDocumento = newVal.id;

                                  setState(() {});
                                },
                                hint: Text("$tipoDocumento"),
                              ));
                            }
                            return SizedBox();
                          },
                        )
                      : new Container(),
                  _value
                      ? TextField(
                          controller: controllerNumeroDocExtr,
                          decoration: InputDecoration(
                            labelText: 'Numero Documento Extrangero',
                            hintText: 'Numero Documento',
                          ),
                        )
                      : new Container(),
                  !_value
                      ? TextField(
                          maxLength: 8,
                          controller: controllerNumeroDoc,
                          decoration: InputDecoration(
                            labelText: 'Numero Documento',
                            hintText: 'Numero Documento',
                          ),
                        )
                      : new Container(),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 350,
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xFF78b8cd)),
                      ),
                      /*  child: Row(
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
                      ],*/
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
                            'Validar ' + nombreBoton,
                            style: TextStyle(
                              color:
                                  Colors.white, // this is for your text colour
                            ),
                          ),
                          /* Text(
                        'Validar ' + nombreBoton,
                        style: TextStyle(color: Colors.white),
                      )*/
                        ],
                      ),
                      onPressed: () async {
                        closeTraerDni = true;
                        setborrar();
                        setState(() {});
                        // if (_isOnline == true) {
                        await DatabasePr.db.listarTipoDocumento();
                        if (nombreBoton == 'Extrangero') {
                          var usuarioex = await provider.pintarExtranjerosBD(
                              controllerNumeroDocExtr.text);
                          print("::: ${usuarioex}");

                          if (usuarioex == null) {
                            showAlertDialog(context,
                                "Datos no encontrados en nuestra base de datos, registrar los datos manualmente.");
                            closeTraerDni = false;
                            enableController = true;
                            setState(() {});
                          } else {
                            //  showAlertDialog(context);
                            visibilitytipotex = true;
                            visibilityTag = false;
                            controllerNombre.text = usuarioex.nombre;
                            controllerApellidoPaterno.text =
                                usuarioex.apellidoPaterno;
                            controllerApellidoMaterno.text =
                                usuarioex.apellidoMaterno;
                            tipoDocumento = usuarioex.tipo_documento;
                            idtipoDocumento = usuarioex.id_tipo_documento;
                            controllerPais.text = usuarioex.pais;
                            idPais = usuarioex.idPais;
                            enableController = true;
                            closeTraerDni = true;
                            setState(() {});
                          }
                        } else {
                          print("::: ${controllerNumeroDoc.text}");

                          var usuario = await provider.getUsuarioDni(
                              controllerNumeroDoc.text, widget.idProgramacion);
                          print(usuario!.estado_registro);

                          switch (usuario.estado_registro) {
                            case "ENCONTRADO_SERVICIO_RENIEC":
                              controllerNombre.text = usuario.nombres;
                              controllerApellidoPaterno.text =
                                  usuario.apellidoPaterno;
                              controllerApellidoMaterno.text =
                                  usuario.apellidoMaterno;
                              controllerCelular.text = usuario.telefono;
                              controllerCargo.text = usuario.cargo;

                              enableController = false;
                              closeTraerDni = false;
                              setState(() {});
                              break;
                            case "ENCONTRADO_SERVICIO_PAIS":
                              controllerNombre.text = usuario.nombres;
                              controllerApellidoPaterno.text =
                                  usuario.apellidoPaterno;
                              controllerApellidoMaterno.text =
                                  usuario.apellidoMaterno;
                              controllerCelular.text = usuario.telefono;
                              controllerCargo.text = usuario.cargo;

                              enableController = false;
                              closeTraerDni = false;
                              setState(() {});
                              break;
                            case "NO_ENCONTRADO":
                              showAlertDialog(context,
                                  "Datos no encontrados en nuestra base de datos, registrar los datos manualmente.");
                              enableController = true;
                              closeTraerDni = false;
                              setState(() {});
                              break;
                            //
                            case "ENCONTRADO_JSON":
                              controllerNombre.text = usuario.nombres;
                              controllerApellidoPaterno.text =
                                  usuario.apellidoPaterno;
                              controllerApellidoMaterno.text =
                                  usuario.apellidoMaterno;
                              controllerCelular.text = usuario.telefono;
                              controllerCargo.text = usuario.cargo;

                              enableController = false;
                              closeTraerDni = false;
                              setState(() {});
                              enableController = false;
                              closeTraerDni = false;
                              setState(() {});
                              break;
                            case "FALLECIDO":
                              showAlertDialog(
                                context,
                                "!Funcionario Fallecido!, El funcionario a registrar tiene el estado de fallecido por lo que no puede ser registrado.",
                              );
                              enableController = false;
                              closeTraerDni = false;
                              setState(() {});
                              break;
                            default:
                          }
                          /*  // ignore: unnecessary_null_comparison
                            if (usuario!.nombres == "") {
                              showAlertDialog(context);
                              enableController = true;
                              closeTraerDni= false;
                              setState(() {
                              });
                            } else {
                              controllerNombre.text = usuario.nombres;
                              controllerApellidoPaterno.text =
                                  usuario.apellidoPaterno;
                              controllerApellidoMaterno.text =
                                  usuario.apellidoMaterno;
                              controllerCelular.text = usuario.telefono;
                              controllerCargo.text = usuario.cargo;
                              closeTraerDni = false;
                              setState(() {});
                            }*/
                        }
                      },
                    ),
                  ),
                  visibilitytipotex
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Pais : ${controllerPais.text}'),
                          ],
                        )
                      : new Container(),
                  visibilityTag
                      ? new FutureBuilder<List<Paises>>(
                          future: provider.listaPaises(),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<Paises>> snapshot) {
                            if (snapshot.hasData) {
                              return Container(
                                  child: DropdownButton<Paises>(
                                underline: SizedBox(),
                                isExpanded: true,
                                items: snapshot.data
                                    ?.map((user) => DropdownMenuItem<Paises>(
                                          child: Text(user.paisNombre),
                                          value: user,
                                        ))
                                    .toList(),
                                onChanged: (Paises? newVal) {
                                  controllerPais.text = newVal!.paisNombre;
                                  idPais = newVal.idPais;

                                  setState(() {
                                    //   ProviderServicios().getTipoDocumento();
                                  });
                                },
                                hint: Text("${controllerPais.text}"),
                              ));
                            }
                            return SizedBox();
                          },
                        )
                      : new Container(),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor ingrese dato.';
                      }
                    },
                    enabled: enableController,
                    controller: controllerNombre,
                    decoration: InputDecoration(
                      labelText: 'Nombre',
                      hintText: 'Nombre',
                    ),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor ingrese dato.';
                      }
                    },
                    enabled: enableController,
                    controller: controllerApellidoPaterno,
                    decoration: InputDecoration(
                      labelText: 'Apellido Paterno',
                      hintText: 'Apellido Paterno',
                    ),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor ingrese dato.';
                      }
                    },
                    enabled: enableController,
                    controller: controllerApellidoMaterno,
                    decoration: InputDecoration(
                      labelText: 'Apellido Materno',
                      hintText: 'Apellido Materno',
                    ),
                  ),
                  SizedBox(height: 10),
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
                              setState(() {});
                            },
                            hint: Text('$entidad'),
                          ));
                        }
                        return SizedBox();
                      },
                    ),
                  ),
                  //    Text("${widget.programa}"),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor ingrese dato.';
                      }
                    },
                    //  enabled: enableController,
                    controller: controllerCargo,
                    decoration: InputDecoration(
                      labelText: 'Cargo',
                      hintText: 'Cargo',
                    ),
                  ),
                  TextField(
                    enabled: true,
                    keyboardType: TextInputType.number,
                    controller: controllerCelular,
                    decoration: InputDecoration(
                      labelText: 'Celular',
                      hintText: 'Celular',
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 350,
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppConfig.primaryColor),
                      ),
                      child: Text(
                        "Agregar " + nombreBoton,
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          if (nombreBoton == 'Extrangero') {
                            funcionarios.idProgramacion = widget.idProgramacion;
                            funcionarios.numDocExtranjero =
                                controllerNumeroDocExtr.text;
                            funcionarios.nombres = controllerNombre.text;
                            funcionarios.apellidoPaterno =
                                controllerApellidoPaterno.text;
                            funcionarios.apellidoMaterno =
                                controllerApellidoMaterno.text;
                            funcionarios.cargo = controllerCargo.text;
                            funcionarios.telefono = controllerCelular.text;
                            funcionarios.flgReniec = flgReniec;
                            funcionarios.idPais = idPais;
                            funcionarios.idTipoDocumento = idtipoDocumento;
                            funcionarios.tipoDocumento = tipoDocumento;
                            funcionarios.pais = controllerPais.text;
                            funcionarios.nombreCargo = controllerCargo.text;
                            funcionarios.idEntidad = id_entidad;

                            await DatabasePr.db.insertFuncionario(funcionarios);
                            Navigator.pop(context, 'funcionarios');
                            setState(() {});
                          } else {
                            funcionarios.idProgramacion = widget.idProgramacion;
                            funcionarios.dni = controllerNumeroDoc.text;
                            funcionarios.nombres = controllerNombre.text;
                            funcionarios.apellidoPaterno =
                                controllerApellidoPaterno.text;
                            funcionarios.apellidoMaterno =
                                controllerApellidoMaterno.text;
                            funcionarios.cargo = controllerCargo.text;
                            funcionarios.nombreCargo = controllerCargo.text;
                            funcionarios.telefono = controllerCelular.text;
                            funcionarios.flgReniec = flgReniec;
                            funcionarios.idEntidad = id_entidad;
                            var listCpps = await DatabasePr.db.ListarCcpps();
                            funcionarios.ubigeoCcpp =
                                listCpps[0].ubigeoCcpp ?? '';
                            await DatabasePr.db.insertFuncionario(funcionarios);
                            Navigator.pop(context, 'funcionarios');
                            setState(() {});
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    // ignore: dead_code
  }

  showAlertDialog(BuildContext context, text) {
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        setState(() {});
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
    // nombreBoton = "Extrangero";
    if (nombreBoton == "Extrangero") {
      controllerNumeroDoc.text = "";
    }
    controllerNombre.text = "";
    controllerApellidoPaterno.text = "";
    controllerApellidoMaterno.text = "";
    controllerNombre.text = "";
    controllerCelular.text = "";
    controllerCargo.text = "";
  }
}
