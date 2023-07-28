import 'package:flutter/material.dart';
import 'package:actividades_pais/src/datamodels/Clases/ListarEntidadFuncionario.dart';
import 'package:actividades_pais/src/datamodels/Clases/Paises.dart';

//import 'package:actividades_pais/src/datamodels/Clases/PartExtrangeros.dart';
import 'package:actividades_pais/src/datamodels/Clases/ParticipanteEjecucion.dart';
import 'package:actividades_pais/src/datamodels/Clases/Participantes.dart';
import 'package:actividades_pais/src/datamodels/Clases/ServicioProgramacionParticipante.dart';
import 'package:actividades_pais/src/datamodels/Clases/Sexo.dart';
import 'package:actividades_pais/src/datamodels/Clases/TipoDocumento.dart';
import 'package:actividades_pais/src/datamodels/Provider/Provider.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:actividades_pais/src/datamodels/Provider/ProviderServicios.dart';
import 'package:actividades_pais/src/datamodels/database/DatabasePr.dart';
import 'package:actividades_pais/src/pages/Intervenciones/util/utils.dart';
import 'package:intl/intl.dart';

enum BestTutorSite { javatpoint, w3schools, tutorialandexample }

class ExtrangerosPage extends StatefulWidget {
  int idProgramacion = 0;

  ExtrangerosPage({super.key, this.idProgramacion = 0});

  @override
  State<ExtrangerosPage> createState() => _ExtrangerosPageState();
}

class _ExtrangerosPageState extends State<ExtrangerosPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  ProviderDatos provider = ProviderDatos();
  var tipoDoc = "Seleccione documento de Indentidad";
  var nombreBoton = "Validar DNI";
  bool visibilityTag = true;
  final BestTutorSite _site = BestTutorSite.javatpoint;
  bool validarcontroles = true;
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
  TextEditingController controllerPais = TextEditingController();

  late List<ParticipanteEjecucion> listas = [];
  var entidad = "Entidad";
  var id_entidad = 0;

  var paises = 'Paises';
  var tipoDocumento = 'Tipo';
  int idtipoDocumento = 0;
  ServicioProgramacionParticipante participanteSr =
      ServicioProgramacionParticipante();

  var formatter = DateFormat('yyyy-MM-dd');

  DateTime? nowfec = DateTime.now();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _traerCampos();
    controllerPais.text = 'Seleccioné';
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
    _traerCampos();
    ProviderServicios().getTipoDocumento();
  }

  _traerCampos() async {
    // await ProviderServicios().getSexo();
    // await ProviderServicios().getTipoDocumento();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF78b8cd),
        title: Text("AGREGAR EXTRANGEROS - ${widget.idProgramacion}",style: const TextStyle(fontSize: 15),),
        leading: Util().iconbuton(() => Navigator.of(context).pop()),
        actions: const [],
      ),
      body: Container(
        child: ListView(
          children: [
            Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                        child: const Text('Pais : '),
                      ),
                    ],
                  ),
                  !visibilityTag
                      ? SizedBox(
                          width: 350,
                          child: Text(" ${controllerPais.text}"),
                        )
                      : Container(),
                  visibilityTag
                      ? SizedBox(
                          width: 350,
                          child: FutureBuilder<List<Paises>>(
                            future: provider.listaPaises(),
                            builder: (BuildContext context,
                                AsyncSnapshot<List<Paises>> snapshot) {
                              if (snapshot.hasData) {
                                return Container(
                                    child: DropdownButton<Paises>(
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

                                    setState(() {
                                      //   ProviderServicios().getTipoDocumento();
                                    });
                                  },
                                  hint: Text(controllerPais.text),
                                ));
                              }
                              return const SizedBox();
                            },
                          ),
                        )
                      : Container(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                        child: const Text('Tipo Documento: '),
                      ),
                    ],
                  ),
                  !visibilityTag
                      ? SizedBox(
                          width: 350,
                          child: Text(" $tipoDocumento"),
                        )
                      : Container(),
                  visibilityTag
                      ? SizedBox(
                          width: 350,
                          child: FutureBuilder<List<TipoDocumento>>(
                            future: ProviderServicios().getTipoDocumento(),
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
                          ),
                        )
                      : Container(),
                  Container(),
                  SizedBox(
                    width: 350,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: controllerNumeroDoc,
                      decoration: const InputDecoration(
                        labelText: 'Numero Documento',
                        hintText: 'Numero Documento',
                      ),
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
                            MaterialStateProperty.all(const Color(0xFF78b8cd)),
                      ),
                      child: const Text(
                        "Validar",
                        style: TextStyle(
                          color: Colors.white, // this is for your text colour
                        ),
                      ),
                      onPressed: () async {
                        setborrar();
                        var usuario = await provider
                            .pintarExtranjerosBD(controllerNumeroDoc.text);
                        visibilityTag = false;
                        controllerPrimerNombre.text = usuario!.nombre;
                        controllerSegundoNombre.text = usuario.nombre2;
                        controllerApellidoPaterno.text =
                            usuario.apellidoPaterno;
                        controllerApellidoMaterno.text =
                            usuario.apellidoMaterno;
                        controllerPrimerNombre.text = usuario.nombre;
                        controllerSexo.text = usuario.sexo;
                        controllerfechaNacimiento.text =
                            usuario.fecha_nacimiento;
                        controllerEdad.text = usuario.edad.toString();
                        controllerPais.text = usuario.pais;
                        tipoDocumento = usuario.tipo_documento;

                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(
                    width: 350,
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Por favor ingrese dato.';
                        }
                        return null;
                      },
                      enabled: validarcontroles,
                      controller: controllerPrimerNombre,
                      decoration: const InputDecoration(
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
                      decoration: const InputDecoration(
                        labelText: 'Segundo Nombre',
                        hintText: 'Segundo Nombre',
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 350,
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Por favor ingrese dato.';
                        }
                        return null;
                      },
                      controller: controllerApellidoPaterno,
                      enabled: validarcontroles,
                      decoration: const InputDecoration(
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
                      decoration: const InputDecoration(
                        labelText: 'Apellido Materno',
                        hintText: 'Apellido Materno',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  !visibilityTag
                      ? SizedBox(
                          width: 350,
                          child: Row(
                            children: [
                              const Text('Sexo: '),
                              Text(controllerSexo.text)
                            ],
                          ),
                        )
                      : Container(),
                  visibilityTag
                      ? SizedBox(
                          width: 350,
                          child: FutureBuilder<List<Sexo>>(
                            future: ProviderServicios().getSexo(),
                            builder: (BuildContext context,
                                AsyncSnapshot<List<Sexo>> snapshot) {
                              if (snapshot.hasData) {
                                return Container(
                                    child: DropdownButton<Sexo>(
                                  underline: const SizedBox(),
                                  isExpanded: true,
                                  items: snapshot.data
                                      ?.map((user) => DropdownMenuItem<Sexo>(
                                            value: user,
                                            child: Text(user.descripcion),
                                          ))
                                      .toList(),
                                  onChanged: (Sexo? newVal) {
                                    controllerSexo.text = newVal!.cod;
                                    setState(() {});
                                  },
                                  hint: Text(
                                    "Sexo ${controllerSexo.text}",
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ));
                              }
                              return const SizedBox();
                            },
                          ),
                        )
                      : Container(),
                  SizedBox(
                      width: 350,
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Por favor ingrese dato.';
                          }
                          return null;
                        },
                        enabled: validarcontroles,
                        //cursorColor: Colors.blueAccent,
                        controller: controllerfechaNacimiento,
                        //obscureText: false,
                        decoration: const InputDecoration(
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
                          nowfec = await showDatePicker(
                              context: context,
                              initialDate: nowfec!,
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2100));

                          setState(() {
                            controllerfechaNacimiento.text
                                .replaceAll('', formatter.format(nowfec!));
                            controllerfechaNacimiento.text =
                                formatter.format(nowfec!);
                          });
                        },
                      )),
                  SizedBox(
                    width: 350,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: controllerEdad,
                      enabled: validarcontroles,
                      decoration: const InputDecoration(
                        labelText: 'Edad',
                        hintText: 'Edad',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                        child: const Text('Seleccioné Entidad'),
                      ),
                    ],
                  ),
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
                              DatabasePr.db.ListarParticipanteEjecucion(
                                  widget.idProgramacion, id_entidad);
                              setState(() {});
                            },
                            hint: Text(entidad),
                          ));
                        }
                        return const SizedBox();
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
                            selectedColor: const Color(0xFF78b8cd),
                            //activeColor: Colors.blue[800],
                            //focusColor: Colors.blue[800],
                            items: snapshot.data!
                                .map((animal) =>
                                    MultiSelectItem<ParticipanteEjecucion>(
                                        animal, animal.nombre_servicio!))
                                .toList(),
                            title: const Text("Servicios"),
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.0),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(40)),
                            ),
                            buttonIcon: const Icon(
                              Icons.search,
                              color: Colors.grey,
                            ),
                            buttonText: const Text(
                              "Servicios",
                              style: TextStyle(
                                // color: Colors.blue[800],
                                fontSize: 16,
                              ),
                            ),
                            onConfirm: (results) {
                              listas.addAll(results);
                              print(results[0].nombre_servicio);
                              //_selectedAnimals = results;
                            },
                          ));
                        }
                        return const SizedBox();
                      },
                    ),
                  ),
                  SizedBox(
                    width: 350,
                    // ignore: deprecated_member_use
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xFF78b8cd)),
                      ),
                      child:const Text(
                        "Agregar ",
                        style: TextStyle(
                          color: Colors.white, // this is for your text colour
                        ),
                      ),
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          participantes.primerNombre =
                              controllerPrimerNombre.text;
                          participantes.segundoNombre =
                              controllerSegundoNombre.text;
                          participantes.apellidoPaterno =
                              controllerApellidoPaterno.text;
                          participantes.apellidoMaterno =
                              controllerApellidoMaterno.text;
                          participantes.numDocExtranjero =
                              controllerNumeroDoc.text;
                          participantes.idProgramacion = widget.idProgramacion;
                          //  participantes. controllerCargo.text;
                          participantes.fechaNacimiento =
                              controllerfechaNacimiento.text;
                          participantes.sexo = controllerSexo.text;
                          participantes.idProgramacion = widget.idProgramacion;
                          participantes.edad = int.parse(controllerEdad.text);
                          participantes.pais = controllerPais.text;
                          participantes.tipoDocumento = tipoDocumento;
                          participantes.idTipoDocumento = idtipoDocumento;
                          participantes.tipo = 'extrangeros';
                          participantes.idEntidad = id_entidad;

                          var a = await DatabasePr.db
                              .insertParticipantes(participantes);

                          for (var i = 0; i < listas.length; i++) {
                            participanteSr
                                .id_programacion_participante_servicio = a;
                            participanteSr.idServicio = listas[i].id_servicio!;
                            participanteSr.id_programacion =
                                widget.idProgramacion;
                            participanteSr.tipo = 'extrangeros';
                            await DatabasePr.db.insertServicio(participanteSr);
                          }
                          setState(() {
                            Navigator.pop(context, 'participantes');
                          });
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
