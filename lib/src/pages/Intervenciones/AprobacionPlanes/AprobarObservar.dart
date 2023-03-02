import 'package:actividades_pais/src/Utils/utils.dart';
import 'package:actividades_pais/src/datamodels/Clases/Intervenciones/DatosPlanMensual.dart';
import 'package:actividades_pais/src/datamodels/Provider/ProviderAprobacionPlanes.dart';
import 'package:actividades_pais/util/app-config.dart';

import 'package:flutter/material.dart';

class AprobarObservar extends StatefulWidget {
  DatosPlanMensual datosPlanMensual;

  AprobarObservar(this.datosPlanMensual);

  @override
  State<AprobarObservar> createState() => _AprobarObservarState();
}

class _AprobarObservarState extends State<AprobarObservar> {
  var controllerPlataforma = TextEditingController();
  var controllerFECHA = TextEditingController();
  var controllerHORAINICIO = TextEditingController();
  var controllerHORAFIN = TextEditingController();
  var controllerLUGAR_INTERVENCION = TextEditingController();
  var controllerDOCUMENTO_ACREDITA = TextEditingController();
  var controllerTIPO_INTERVENCION = TextEditingController();
  var controllerGOBIERNO = TextEditingController();
  var controllerSUBCATEGORIA = TextEditingController();
  var controllerSECTOR = TextEditingController();
  var controllerACTIVIDAD = TextEditingController();
  var controllerPROGRAMA = TextEditingController();
  var controllerSERVICIO = TextEditingController();
  var controllerCATEGORIA = TextEditingController();
  var controllerDESCRIPCION = TextEditingController();
  var controllerTIPO_PLAN = TextEditingController();
  var controllerCODIGO_PLAN = TextEditingController();
  var controllerObservar = TextEditingController();

  int maxLines = 0;

  bool mostrarboton = true;

  @override
  void initState() {
    // TODO: implement initState
    cargarCampos();
    super.initState();
  }

  cargarCampos() async {
    var resp = await ProviderAprobacionPlanes()
        .DetalleIntervencionService(widget.datosPlanMensual.idProgramacion);
    controllerPlataforma.text = resp.plataformaDescripcion.toString();

    controllerFECHA.text = resp.fecha.toString();
    controllerHORAINICIO.text = resp.horaInicio.toString();
    controllerHORAFIN.text = resp.horaFin.toString();
    controllerLUGAR_INTERVENCION.text = resp.nombreLugarIntervencion.toString();
    controllerDOCUMENTO_ACREDITA.text = resp.nombreDocumentoAcredita.toString();
    controllerTIPO_INTERVENCION.text = resp.nombreTipoIntervencion.toString();
    controllerGOBIERNO.text = resp.nombre.toString();
    controllerSECTOR.text = resp.nombreSector.toString();
    controllerPROGRAMA.text = resp.nombrePrograma.toString();
    controllerCATEGORIA.text = resp.nombreCategoria.toString();
    controllerSUBCATEGORIA.text = resp.nombreSubcategoria.toString();
    controllerACTIVIDAD.text = resp.nombreTipoActividad.toString();
    controllerSERVICIO.text = resp.nombreTipoServicio.toString();
    controllerDESCRIPCION.text = resp.descripcionIntervencion.toString();
   // controllerTIPO_PLAN.text = resp.tipoPlan.toString();
    if (resp.tipoPlan.toString() == 'null') {
      controllerTIPO_PLAN.text = "";
    } else {
      controllerTIPO_PLAN.text = resp.tipoPlan.toString();
    }
    controllerCODIGO_PLAN.text = resp.codigoPlan.toString();
    if (resp.idEvaluacion == "0") {
      this.mostrarboton = true;
    } else {
      this.mostrarboton = false;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppConfig.primaryColor,
          title: Text(
            "DETALLE DE LA INTERVENCION ${widget.datosPlanMensual.idProgramacion}",
            style: TextStyle(fontSize: 12),
          )),
      body: Container(
        margin: EdgeInsets.all(20),
        child: ListView(
          children: [
            TextField(
              controller: controllerTIPO_PLAN,
              enabled: false,
              decoration: InputDecoration(
                labelText: 'TIPO PLAN',
                hintText: 'TIPO PLAN',
              ),
            ),
            TextField(
              controller: controllerCODIGO_PLAN,
              enabled: false,
              decoration: InputDecoration(
                labelText: 'CODIGO PLAN',
                hintText: 'CODIGO PLAN',
              ),
            ),
            TextField(
              controller: controllerPlataforma,
              enabled: false,
              decoration: InputDecoration(
                labelText: 'PLATAFORMA',
                hintText: 'PLATAFORMA',
              ),
            ),
            TextField(
              controller: controllerFECHA,
              enabled: false,
              decoration: InputDecoration(
                labelText: 'FECHA',
                hintText: 'FECHA',
              ),
            ),
            TextField(
              controller: controllerHORAINICIO,
              enabled: false,
              decoration: InputDecoration(
                labelText: 'HORA INICIO',
                hintText: 'HORA INICIO',
              ),
            ),
            TextField(
              controller: controllerHORAFIN,
              enabled: false,
              decoration: InputDecoration(
                labelText: 'HORA FIN',
                hintText: 'HORA FIN',
              ),
            ),
            TextField(
              controller: controllerLUGAR_INTERVENCION,
              enabled: false,
              decoration: InputDecoration(
                labelText: 'LUGAR_INTERVENCION',
                hintText: 'LUGAR_INTERVENCION',
              ),
            ),
            TextField(
              controller: controllerDOCUMENTO_ACREDITA,
              enabled: false,
              decoration: InputDecoration(
                labelText: 'DOCUMENTO_ACREDITA',
                hintText: 'DOCUMENTO_ACREDITA',
              ),
            ),
            TextField(
              controller: controllerTIPO_INTERVENCION,
              enabled: false,
              decoration: InputDecoration(
                labelText: 'TIPO DE INTERVENCION',
                hintText: 'TIPO DE INTERVENCION',
              ),
            ),
            TextField(
              controller: controllerGOBIERNO,
              enabled: false,
              decoration: InputDecoration(
                labelText: 'GOBIERNO',
                hintText: 'GOBIERNO',
              ),
            ),
            TextField(
              controller: controllerSECTOR,
              enabled: false,
              decoration: InputDecoration(
                labelText: 'SECTOR',
                hintText: 'SECTOR',
              ),
            ),
            TextField(
              controller: controllerPROGRAMA,
              enabled: false,
              decoration: InputDecoration(
                labelText: 'PROGRAMA',
                hintText: 'PROGRAMA',
              ),
            ),
            TextField(
              controller: controllerCATEGORIA,
              enabled: false,
              decoration: InputDecoration(
                labelText: 'CATEGORIA',
                hintText: 'CATEGORIA',
              ),
            ),
            TextField(
              controller: controllerSUBCATEGORIA,
              enabled: false,
              decoration: InputDecoration(
                labelText: 'SUBCATEGORIA',
                hintText: 'SUBCATEGORIA',
              ),
            ),
            TextField(
              controller: controllerACTIVIDAD,
              enabled: false,
              decoration: InputDecoration(
                labelText: 'ACTIVIDAD',
                hintText: 'ACTIVIDAD',
              ),
            ),
            TextField(
              controller: controllerSERVICIO,
              enabled: false,
              decoration: InputDecoration(
                labelText: 'SERVICIO',
                hintText: 'SERVICIO',
              ),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'DESCRIPCION',
                hintText: 'DESCRIPCION',
              ),
              controller: controllerDESCRIPCION,
              maxLines: null,
              // establecer en null para permitir cualquier cantidad de líneas
              onChanged: (text) {
                // contar la cantidad de líneas en el texto
                int lines = text.split('\n').length;
                // actualizar la cantidad máxima de líneas
                if (lines > 1) {
                  setState(() {
                    maxLines = lines;
                  });
                }
              },
            ),
            SizedBox(
              height: 18,
            ),
            mostrarboton
                ? Column(
                    children: [
                      Text(
                        "¿ QUE ACCION DESEA EJECUTAR ?",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              await utils().showAlertDialogAprobar(
                                  "Confirmación", context, () async {
                                var resp = await ProviderAprobacionPlanes()
                                    .Aprobar(
                                        idProgramacion: widget
                                            .datosPlanMensual.idProgramacion);

                                if (resp == 200) {
                                  Navigator.pop(context);
                                  Navigator.pop(context, "R");
                                }
                              }, () {
                                Navigator.pop(context);
                              }, "¿Está seguro de aprobar essta programación?");
                            },
                            child: Container(
                              height: 40,
                              width: width / 3.5,
                              child: const Center(
                                child: Text(
                                  'APROBAR',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    letterSpacing: 1.5,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'OpenSans',
                                  ),
                                ),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 237, 82, 68),
                              onPrimary: Colors.white,
                              shadowColor:
                                  const Color.fromARGB(255, 53, 53, 53),
                              elevation: 5,
                            ),
                            onPressed: () async {
                              await utils().showAlertDialogGC(
                                  "Detalle los puntos que se estan observando:",
                                  context, () async {
                                var resp = await ProviderAprobacionPlanes()
                                    .Observar(
                                        idProgramacion: widget
                                            .datosPlanMensual.idProgramacion,
                                        observacion: controllerObservar.text);

                                if (resp == 200) {
                                  Navigator.pop(context);
                                  Navigator.pop(context, "R");
                                }
                              }, () {
                                Navigator.pop(context);
                              }, controllerObservar);
                            },
                            child: Container(
                              height: 40,
                              width: width / 3.5,
                              child: const Center(
                                child: Text(
                                  'OBSERVAR',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    letterSpacing: 1.5,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'OpenSans',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                : new Container(),
            ButtonBar()
          ],
        ),
      ),
    );
  }
}
