// ignore_for_file: must_be_immutable

import 'package:actividades_pais/src/datamodels/Clases/Uti/ListaEquipoInformatico.dart';
import 'package:actividades_pais/src/datamodels/Clases/Uti/ListaEstado.dart';
import 'package:actividades_pais/src/datamodels/Clases/Uti/ListaModelo.dart';
import 'package:actividades_pais/src/datamodels/Clases/Uti/ListaTipoEquipo.dart';
import 'package:actividades_pais/src/datamodels/Clases/Uti/ListarProveedores.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../datamodels/Provider/ProviderSeguimientoParqueInformatico.dart';
import '../../../datamodels/Provider/ProviderServicios.dart';
import '../../../datamodels/Servicios/Servicios.dart';

class EditarParqueInformatico extends StatefulWidget {
  ListaEquipoInformatico listaEquipoInformatico;
  String titulo = "";
  int tipo = 0;

  EditarParqueInformatico(
      {super.key,
      required this.listaEquipoInformatico,
      this.titulo = "",
      this.tipo = 0});

  @override
  State<EditarParqueInformatico> createState() =>
      _EditarParqueInformaticoState();
}

class _EditarParqueInformaticoState extends State<EditarParqueInformatico> {
  TextEditingController controllerCodigoPatrimonial = TextEditingController();
  TextEditingController controllerDenominacion = TextEditingController();
  TextEditingController controllerMarca = TextEditingController();
  TextEditingController controllerColor = TextEditingController();
  TextEditingController controllerSerie = TextEditingController();
  TextEditingController controllerProveedor = TextEditingController();
  TextEditingController controllerFechaFinGarantia = TextEditingController();
  TextEditingController controllerFechaIngreso = TextEditingController();
  Modelo? modelo = Modelo();
  final _formKey = GlobalKey<FormState>();

  String seleccionarModelo = "SELECCIONAR";

  String seleccionarProveedor = "SELECCIONAR";

  DateTime? nowfec = DateTime.now();
  var formatter = DateFormat('yyyy-MM-dd');

  String seleccionarEstado = "SELECCIONAR";

  var textoBoton = "GUARDAR";

  var seleccionarTipoEquipo = "SELECCIONAR";
  var archivos = [];
  var nombreArchivo = "";

  var directorio = "";

  var idArchivo = 0;

  var mostarBotonGuardar = true;
  @override
  void initState() {
    // TODO: implement initState
    if (widget.tipo == 0) {
      Cargar();
    }
    super.initState();
  }

  consultaArchivo() async {
    var consultaArchivo = await ProviderSeguimientoParqueInformatico()
        .consultaArchivoEquipo(widget.listaEquipoInformatico.idArchivo);
    if (consultaArchivo != "") {
      idArchivo = consultaArchivo["id_archivo"];
      nombreArchivo = consultaArchivo["nombre"];
      archivos.add(consultaArchivo);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.titulo,
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
        ),
        actions: [
          InkWell(
            child: const Icon(Icons.file_copy_rounded),
            onTap: () async {
              await readCounter();
            },
          ),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 20, right: 20, top: 5),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextForm("Codigo Patrimonial", true, controllerCodigoPatrimonial),
              TextForm("Denominacion", true, controllerDenominacion),
              ModeloCombo(),
              TextForm("Marca", true, controllerMarca),
              TipoEquipoCombo(),
              TextForm("Color", true, controllerColor),
              TextForm("Serie", true, controllerSerie),
              ProveedoresCombo(),
              TextoConFecha(
                  "Fecha Fin Garantia", true, controllerFechaFinGarantia),
              TextoConFecha("Fecha de Ingreso", true, controllerFechaIngreso),
              EstadoCombo(),
              if (archivos.isNotEmpty) ...[mostarArchivo()],
              if (mostarBotonGuardar == true)
                Container(
                    decoration: Servicios().myBoxDecoration(),
                    margin: const EdgeInsets.only(top: 15, bottom: 20),
                    height: 40.0,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[600],
                      ),
                      onPressed: () async {
                        if (mostarBotonGuardar == true) guardar();
                      },
                      child: Text(textoBoton),
                    ))
            ],
          ),
        ),
      ),
    );
  }

  guardar() async {
    if (widget.tipo == 0) {
      setState(() {
        textoBoton = "GUARDANDO";
      });
      anidarDatos();
      var respuesta = await ProviderSeguimientoParqueInformatico()
          .guardarEdEquipoInformatico(widget.listaEquipoInformatico);

      if (respuesta.estado == true) {
        await showAddNoteDialog(context, respuesta.mensaje);
        Navigator.pop(context, "OK");
      } else if (respuesta.estado == false) {
        await showAddNoteDialog(context, respuesta.mensaje);
      }
      setState(() {
        textoBoton = "GUARDAR";
      });
    } else if (widget.tipo == 1) {
      setState(() {
        textoBoton = "GUARDANDO";
      });
      anidarDatos();
      var respuesta = await ProviderSeguimientoParqueInformatico()
          .guardarEquipoInformatico(widget.listaEquipoInformatico);

      if (respuesta.estado == true) {
        await showAddNoteDialog(context, respuesta.mensaje);
        Navigator.pop(context, "OK");
      } else if (respuesta.estado == false) {
        await showAddNoteDialog(context, respuesta.mensaje);
      }
      setState(() {
        textoBoton = "GUARDAR";
      });
    }
  }

  Cargar() {
    controllerCodigoPatrimonial.text =
        widget.listaEquipoInformatico.codigoPatrimonial!;
    controllerDenominacion.text =
        widget.listaEquipoInformatico.descripcionEquipoInformatico!;
    controllerMarca.text = widget.listaEquipoInformatico.descripcionMarca!;
    controllerColor.text = widget.listaEquipoInformatico.color!;
    controllerSerie.text = widget.listaEquipoInformatico.serie!;
    controllerFechaFinGarantia.text =
        widget.listaEquipoInformatico.fecFinGarantiaProveedor!;
    controllerFechaIngreso.text = widget.listaEquipoInformatico.fecIngreso!;
    if (widget.listaEquipoInformatico.descripcionModelo != '') {
      seleccionarModelo = widget.listaEquipoInformatico.descripcionModelo!;
    }
    if (widget.listaEquipoInformatico.descripcionTipoEquipoInformatico != '') {
      seleccionarTipoEquipo =
          widget.listaEquipoInformatico.descripcionTipoEquipoInformatico!;
    }

    seleccionarEstado = widget.listaEquipoInformatico.estado!;

    if (widget.listaEquipoInformatico.proveedor != '') {
      seleccionarProveedor = widget.listaEquipoInformatico.proveedor!;
    }
    if (widget.listaEquipoInformatico.archivos == null) {
      consultaArchivo();
      widget.listaEquipoInformatico.archivos = archivos;
    }
  }

  Future readCounter() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    mostarBotonGuardar = false;
    setState(() {});
    if (result != null) {
      var repuesta = await ProviderSeguimientoParqueInformatico()
          .EnvioArchivo(result.files.single.path);
      nombreArchivo = "";
      nombreArchivo = result.files.single.name;
      directorio = repuesta["path"];

      archivos = [];
      archivos.add({
        "directorio": repuesta["path"],
        "nombre": repuesta["name"] + '.' + repuesta["extension"],
        "id_archivo": 0,
      });
      idArchivo = archivos[0]["id_archivo"];
      mostarBotonGuardar = true;
      setState(() {});
    } else {
      return '';
    }
  }

  mostarArchivo() {
    return Container(
      child: Center(
        child: Stack(
          alignment: const Alignment(0.9, 1.1),
          children: <Widget>[
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                color: Colors.black87,
                child: GestureDetector(
                  onTap: () async {
                    if (idArchivo == 0) {
                      var resEliminar =
                          await ProviderSeguimientoParqueInformatico()
                              .EliminarArchivoTemp(directorio);
                      if (resEliminar["result"] == true) {
                        archivos = [];
                      }
                      setState(() {});
                    } else if (idArchivo > 0) {
                      var resEliminar =
                          await ProviderSeguimientoParqueInformatico()
                              .ArchivoEliminar(idArchivo);
                      if (resEliminar == 1) {
                        archivos = [];
                      }
                      setState(() {});
                    }
                  },
                  child: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
            Container(
              height: 120,
              width: 120,
              margin: const EdgeInsets.only(right: 10.0, top: 30, left: 10.2),
              child: Material(
                  elevation: 4.0,
                  borderRadius: BorderRadius.circular(25.0),
                  // ignore: unnecessary_new
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: const Icon(Icons.file_copy_sharp, size: 80),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Text(nombreArchivo)],
                      ),
                    ],
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  showAddNoteDialog(BuildContext context, titulo) => showDialog(
      context: context,
      builder: (context) {
        Widget okButton = TextButton(
            child: const Text("OK"),
            onPressed: () {
              Navigator.pop(context);
            });
        return AlertDialog(
            actions: [okButton],
            title: Text(titulo),
            content: SingleChildScrollView(
                child: Container(
              width: double.infinity,
            )));
      });

  anidarDatos() {
    widget.listaEquipoInformatico.codigoPatrimonial =
        controllerCodigoPatrimonial.text;
    widget.listaEquipoInformatico.descripcionEquipoInformatico =
        controllerDenominacion.text;
    widget.listaEquipoInformatico.descripcionMarca = controllerMarca.text;
    widget.listaEquipoInformatico.color = controllerColor.text;
    widget.listaEquipoInformatico.serie = controllerSerie.text;
    widget.listaEquipoInformatico.fecFinGarantiaProveedor =
        controllerFechaFinGarantia.text;
    widget.listaEquipoInformatico.fecIngreso = controllerFechaIngreso.text;
    widget.listaEquipoInformatico.archivos = archivos;
  }

  TextoConFecha(labelText, enabled, controller) {
    return Container(
        margin: const EdgeInsets.only(top: 3),
        child: TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'Por favor Ingrese dato.';
            }
            return null;
          },
          enabled: enabled,
          controller: controller,
          decoration: InputDecoration(
            labelText: labelText,
            hintText: labelText,
          ),
          onTap: () {
            FechaSeleccionar(controller: controller);
          },
        ));
  }

  FechaSeleccionar({controller}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: nowfec!,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      setState(() {
        controller.text = formatter.format(picked);
        return controller;
      });
    }
  }

  TextForm(labelText, enabled, controller) {
    return Container(
        margin: const EdgeInsets.only(top: 0),
        child: TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'Por favor ingrese dato.';
            }
            return null;
          },
          enabled: enabled,
          controller: controller,
          decoration: InputDecoration(
            labelText: labelText,
            hintText: labelText,
          ),
        ));
  }

  ModeloCombo() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: FutureBuilder<List<Modelo>>(
        future: ProviderSeguimientoParqueInformatico().listaModelos(2),
        builder: (BuildContext context, AsyncSnapshot<List<Modelo>> snapshot) {
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
            return Stack(children: [
              const Text(
                "Modelo",
                style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                  margin: const EdgeInsets.only(top: 5),
                  child: DropdownButton<Modelo>(
                    underline: ProviderServicios().underline(),
                    isExpanded: true,
                    items: snapshot.data
                        ?.map((user) => DropdownMenuItem<Modelo>(
                              value: user,
                              child: Text(user.descripcionModelo!),
                            ))
                        .toList(),
                    onChanged: (Modelo? value) async {
                      setState(() {
                        modelo = value;
                        seleccionarModelo = value!.descripcionModelo!;
                        widget.listaEquipoInformatico.idModelo =
                            value.idModelo.toString();
                        widget.listaEquipoInformatico.idMarca =
                            value.idMarca.toString();
                      });

                      var consultaMarca =
                          await ProviderSeguimientoParqueInformatico()
                              .ConsultaMarca(
                                  widget.listaEquipoInformatico.idModelo);
                      setState(() {
                        widget.listaEquipoInformatico.descripcionMarca =
                            consultaMarca.toString();
                        controllerMarca.text = consultaMarca.toString();
                      });
                    },
                    //  value:  snapshot.data![0],
                    hint: Text(seleccionarModelo,
                        style: const TextStyle(color: Colors.black)),
                  )),
            ]);
          }
        },
      ),
    );
  }

  ProveedoresCombo() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: FutureBuilder<List<Proveedores>>(
        future: ProviderSeguimientoParqueInformatico().getListarProveedores(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Proveedores>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final data = snapshot.data;
          if (data!.isEmpty) {
            return const Center(
              child: Text("sin dato"),
            );
          } else {
            return Stack(children: [
              const Text("Proveedor",
                  style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey,
                      fontWeight: FontWeight.w700)),
              Container(
                  margin: const EdgeInsets.only(top: 5),
                  child: DropdownButton<Proveedores>(
                    underline: ProviderServicios().underline(),
                    isExpanded: true,
                    items: snapshot.data
                        ?.map((dat) => DropdownMenuItem<Proveedores>(
                              value: dat,
                              child: Text(dat.proveedor!),
                            ))
                        .toList(),
                    onChanged: (Proveedores? value) async {
                      setState(() {
                        seleccionarProveedor = value!.proveedor!;
                        widget.listaEquipoInformatico.idProveedor =
                            value.idProveedor.toString();
                        widget.listaEquipoInformatico.proveedor =
                            value.proveedor.toString();
                      });
                    },
                    hint: Text(seleccionarProveedor,
                        style: const TextStyle(color: Colors.black)),
                  ))
            ]);
          }
        },
      ),
    );
  }

  EstadoCombo() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: FutureBuilder<List<Estado>>(
        future: ProviderSeguimientoParqueInformatico().getEstadoEquipo(),
        builder: (BuildContext context, AsyncSnapshot<List<Estado>> snapshot) {
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
            return Stack(children: [
              const Text("Estado",
                  style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold)),
              Container(
                  margin: const EdgeInsets.only(top: 5),
                  child: DropdownButton<Estado>(
                    underline: ProviderServicios().underline(),
                    isExpanded: true,
                    items: snapshot.data
                        ?.map((dat) => DropdownMenuItem<Estado>(
                              value: dat,
                              child: Text(dat.estado!),
                            ))
                        .toList(),
                    onChanged: (Estado? value) async {
                      setState(() {
                        seleccionarEstado = value!.estado!;
                        widget.listaEquipoInformatico.flgActivo =
                            value.idEstado.toString();
                        widget.listaEquipoInformatico.estado =
                            value.estado.toString();
                      });
                    },
                    hint: Text(seleccionarEstado,
                        style: const TextStyle(color: Colors.black)),
                  ))
            ]);
          }
        },
      ),
    );
  }

  TipoEquipoCombo() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: FutureBuilder<List<TipoEquipo>>(
        future: ProviderSeguimientoParqueInformatico().getListarTipoEquipo(),
        builder:
            (BuildContext context, AsyncSnapshot<List<TipoEquipo>> snapshot) {
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
            return Stack(children: [
              const Text("Tipo Equipo",
                  style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey,
                      fontWeight: FontWeight.w600)),
              Container(
                  margin: const EdgeInsets.only(top: 5),
                  child: DropdownButton<TipoEquipo>(
                    underline: ProviderServicios().underline(),
                    isExpanded: true,
                    items: snapshot.data
                        ?.map((dat) => DropdownMenuItem<TipoEquipo>(
                              value: dat,
                              child:
                                  Text(dat.descripcionTipoEquipoInformatico!),
                            ))
                        .toList(),
                    onChanged: (TipoEquipo? value) async {
                      setState(() {
                        seleccionarTipoEquipo =
                            value!.descripcionTipoEquipoInformatico!;
                        widget.listaEquipoInformatico.idTipoEquipoInformatico =
                            value.idTipoEquipoInformatico.toString();
                      });
                    },
                    hint: Text(seleccionarTipoEquipo,
                        style: const TextStyle(color: Colors.black)),
                  ))
            ]);
          }
        },
      ),
    );
  }
}
