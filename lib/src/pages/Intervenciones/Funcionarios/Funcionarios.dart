// ignore_for_file: use_build_context_synchronously

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
    _controller = AnimationController(vsync: this);
    controllerPais.text = 'Seleccioné Pais';
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _checkInternetConnection() async {
    setState(() {});

    try {
      await Future.delayed(const Duration(seconds: 1));
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
          style: const TextStyle(fontSize: 15),
        ),
        leading: Util().iconbuton(() => Navigator.of(context).pop()),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
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
                              visibilityTag = true;
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
                      const Text("Funcionario Extranjero")
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
                      : Container(),
                  visibilityTag
                      ? FutureBuilder<List<TipoDocumento>>(
                          future: DatabasePr.db.listarTipoDocumento(),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<TipoDocumento>> snapshot) {
                            if (snapshot.hasData) {
                              return Container(
                                  child: DropdownButton<TipoDocumento>(
                                underline: const SizedBox(),
                                isExpanded: true,
                                items: snapshot.data
                                    ?.map((user) =>
                                        DropdownMenuItem<TipoDocumento>(
                                          value: user,
                                          child: Text(user.descripcion),
                                        ))
                                    .toList(),
                                onChanged: (TipoDocumento? newVal) {
                                  tipoDocumento = newVal!.descripcion;
                                  idtipoDocumento = newVal.id;

                                  setState(() {});
                                },
                                hint: Text(tipoDocumento),
                              ));
                            }
                            return const SizedBox();
                          },
                        )
                      : Container(),
                  _value
                      ? TextField(
                          controller: controllerNumeroDocExtr,
                          decoration: const InputDecoration(
                            labelText: 'Numero Documento Extrangero',
                            hintText: 'Numero Documento',
                          ),
                        )
                      : Container(),
                  !_value
                      ? TextField(
                          maxLength: 8,
                          controller: controllerNumeroDoc,
                          decoration: const InputDecoration(
                            labelText: 'Numero Documento',
                            hintText: 'Numero Documento',
                          ),
                        )
                      : Container(),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 350,
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xFF78b8cd)),
                      ),
                      onPressed: validar,
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
                              : Container(),
                          Text(
                            'Validar ' + nombreBoton,
                            style: const TextStyle(
                              color:
                                  Colors.white, // this is for your text colour
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  visibilitytipotex
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Pais : ${controllerPais.text}'),
                          ],
                        )
                      : Container(),
                  visibilityTag
                      ? FutureBuilder<List<Paises>>(
                          future: provider.listaPaises(),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<Paises>> snapshot) {
                            if (snapshot.hasData) {
                              return DropdownButton<Paises>(
                                underline: const SizedBox(),
                                isExpanded: true,
                                items: snapshot.data
                                ?.map((user) => DropdownMenuItem<Paises>(
                                      value: user,
                                      child: Text(user.paisNombre),
                                    ))
                                .toList(),
                                onChanged: (Paises? newVal) {
                              controllerPais.text = newVal!.paisNombre;
                              idPais = newVal.idPais;

                              setState(() {
                                //   ProviderServicios().getTipoDocumento();
                              });
                                },
                                hint: Text(controllerPais.text),
                              );
                            }
                            return const SizedBox();
                          },
                        )
                      : Container(),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor ingrese dato.';
                      }
                    },
                    enabled: enableController,
                    controller: controllerNombre,
                    decoration: const InputDecoration(
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
                    decoration: const InputDecoration(
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
                    decoration: const InputDecoration(
                      labelText: 'Apellido Materno',
                      hintText: 'Apellido Materno',
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 350,
                    child: FutureBuilder<List<ListarEntidadFuncionario>>(
                      future: DatabasePr.db
                          .listarEntidadFuncionario(widget.idProgramacion),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<ListarEntidadFuncionario>>
                              snapshot) {
                        if (snapshot.hasData) {
                          return Container(
                              child: DropdownButton<ListarEntidadFuncionario>(
                            underline: const SizedBox(),
                            isExpanded: true,
                            items: snapshot.data
                                ?.map((user) =>
                                    DropdownMenuItem<ListarEntidadFuncionario>(
                                      value: user,
                                      child: Text(' ${user.nombre_programa}'),
                                    ))
                                .toList(),
                            onChanged: (ListarEntidadFuncionario? newVal) {
                              entidad = newVal!.nombre_programa;
                              id_entidad = newVal.id_entidad;
                              setState(() {});
                            },
                            hint: Text(entidad),
                          ));
                        }
                        return const SizedBox();
                      },
                    ),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor ingrese dato.';
                      }
                    },
                    //  enabled: enableController,
                    controller: controllerCargo,
                    decoration: const InputDecoration(
                      labelText: 'Cargo',
                      hintText: 'Cargo',
                    ),
                  ),
                  TextField(
                    enabled: true,
                    keyboardType: TextInputType.number,
                    controller: controllerCelular,
                    decoration: const InputDecoration(
                      labelText: 'Celular',
                      hintText: 'Celular',
                    ),
                  ),
                  const SizedBox(
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
                        style: const TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        await agregar(_formKey);
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

  validar() async {
    closeTraerDni = true;
    setborrar();
    setState(() {});
    await DatabasePr.db.listarTipoDocumento();
    if (nombreBoton == 'Extrangero') {
      var usuarioex =
          await provider.pintarExtranjerosBD(controllerNumeroDocExtr.text);

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
        controllerApellidoPaterno.text = usuarioex.apellidoPaterno;
        controllerApellidoMaterno.text = usuarioex.apellidoMaterno;
        tipoDocumento = usuarioex.tipo_documento;
        idtipoDocumento = usuarioex.id_tipo_documento;
        controllerPais.text = usuarioex.pais;
        idPais = usuarioex.idPais;
        enableController = true;
        closeTraerDni = true;
        setState(() {});
      }
    } else {
      var usuario = await provider.getUsuarioDni(
          controllerNumeroDoc.text, widget.idProgramacion);

      switch (usuario?.estado_registro) {
        case "ENCONTRADO_SERVICIO_RENIEC":
          controllerNombre.text = usuario!.nombres;
          controllerApellidoPaterno.text = usuario.apellidoPaterno;
          controllerApellidoMaterno.text = usuario.apellidoMaterno;
          controllerCelular.text = usuario.telefono;
          controllerCargo.text = usuario.cargo;

          enableController = false;
          closeTraerDni = false;
          setState(() {});
          break;
        case "ENCONTRADO_SERVICIO_PAIS":
          controllerNombre.text = usuario!.nombres;
          controllerApellidoPaterno.text = usuario.apellidoPaterno;
          controllerApellidoMaterno.text = usuario.apellidoMaterno;
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
          controllerNombre.text = usuario!.nombres;
          controllerApellidoPaterno.text = usuario.apellidoPaterno;
          controllerApellidoMaterno.text = usuario.apellidoMaterno;
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
    }
  }

  agregar(formKey) async {
    if (formKey.currentState!.validate()) {
      if (nombreBoton == 'Extrangero') {
        funcionarios.idProgramacion = widget.idProgramacion;
        funcionarios.numDocExtranjero = controllerNumeroDocExtr.text;
        funcionarios.nombres = controllerNombre.text;
        funcionarios.apellidoPaterno = controllerApellidoPaterno.text;
        funcionarios.apellidoMaterno = controllerApellidoMaterno.text;
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
        var cantd = await DatabasePr.db
            .buscarDniFuncioario(controllerNumeroDoc.text, widget.idProgramacion);
        if(entidad == "Entidad"){
          return showAlertDialog(context, "Seleccionar Entidad");
        }
        if(cantd.isNotEmpty){
          return showAlertDialog(context, "Usuario ya registrado");
        }
        funcionarios.idProgramacion = widget.idProgramacion;
        funcionarios.dni = controllerNumeroDoc.text;
        funcionarios.nombres = controllerNombre.text;
        funcionarios.apellidoPaterno = controllerApellidoPaterno.text;
        funcionarios.apellidoMaterno = controllerApellidoMaterno.text;
        funcionarios.cargo = controllerCargo.text;
        funcionarios.nombreCargo = controllerCargo.text;
        funcionarios.telefono = controllerCelular.text;
        funcionarios.flgReniec = flgReniec;
        funcionarios.idEntidad = id_entidad;
        var listCpps = await DatabasePr.db.ListarCcpps();
        funcionarios.ubigeoCcpp = listCpps[0].ubigeoCcpp ?? '';
        await DatabasePr.db.insertFuncionario(funcionarios);
        Navigator.pop(context, 'funcionarios');
        setState(() {});
      }
    }
  }
  showAlertDialog(BuildContext context, text) {
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text("PAIS"),
      content: Text(text),
     /* actions: [
        okButton,
      ],*/
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );

   /* Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pop();
    });*/
  }

  setborrar() async {
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
