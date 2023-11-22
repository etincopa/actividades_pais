import 'dart:convert';

import 'package:actividades_pais/src/datamodels/Clases/Actividad.dart';
import 'package:actividades_pais/src/datamodels/Clases/Categoria.dart';
import 'package:actividades_pais/src/datamodels/Clases/Entidad.dart';
import 'package:actividades_pais/src/datamodels/Clases/Intervenciones/GuardarIntervencion.dart';
import 'package:actividades_pais/src/datamodels/Clases/Sector.dart';
import 'package:actividades_pais/src/datamodels/Clases/Servicio.dart';
import 'package:actividades_pais/src/datamodels/Clases/Subcategoria.dart';
import 'package:actividades_pais/src/datamodels/Provider/ProviderRegistarInterv.dart';
import 'package:actividades_pais/src/datamodels/database/DatabasePr.dart';
import 'package:actividades_pais/util/app-config.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../../../../datamodels/Clases/ListaTipoGobierno.dart';

class AgregarEntidad extends StatefulWidget {
  //const AgregarEntidad(ismostar, {Key? key}) : super(key: key);
  bool ismostrar = false;

  AgregarEntidad(this.ismostrar, {super.key});

  @override
  State<AgregarEntidad> createState() => _AgregarEntidadState();
}

class _AgregarEntidadState extends State<AgregarEntidad> {
  TextEditingController controllerDescripcion = TextEditingController();
  Accion agregarEntidad = Accion();

  List<TipoGobierno> tipoGobierno = [];
  List<Sector> listaSector = [];
  List<Entidad> listEntidad = [];
  List<Categoria> listCategoria = [];
  List<Subcategoria> listSubcategoria = [];
  List<Actividad> listActividad = [];
  List<Servicio> _servicios = [];
  List<Servicio> _serviciosSeleccionados = [];
  final List<String> _idServiciosSeleccionados = [];
  final List<String> _nombreServiciosSeleccionados = [];


//  Accion() ;
  @override
  void initState() {
    cargarComboInicial();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: AppConfig.primaryColor,
            title: const Text("AGREGAR ENTIDAD")),
        body: registroEntidades());
  }

  Container registroEntidades() {
    return Container(
      margin: const EdgeInsets.all(20),
      child: ListView(
        children: [
          comboSeleccionar(
            labelTexts: "TIPO DE USUARIO",
            items: tipoGobierno.map((value) {
              return DropdownMenuItem<TipoGobierno>(
                value: value,
                child: Text(
                  value.nombre!,
                  style: const TextStyle(fontSize: 12),
                ),
              );
            }).toList(),
            onchanged: (value) async {
              await cargarComboSector(value.idTipoGobierno);
              agregarEntidad.idGobierno = value.idTipoGobierno;
              agregarEntidad.usuario = value.nombre;
            },
          ),
          listaSector.isNotEmpty
              ? comboSeleccionar(
                  labelTexts: "SECTOR",
                  items: listaSector.map((value) {
                    return DropdownMenuItem<Sector>(
                      value: value,
                      child: Text(
                        value.nombreSector!,
                        style: const TextStyle(fontSize: 12),
                      ),
                    );
                  }).toList(),
                  onchanged: (value) async {
                    await cargarEntidad(value.idSector);
                    agregarEntidad.idSector = value.idSector;
                    agregarEntidad.sector = value.nombreSector;
                  },
                )
              : Container(),
          listEntidad.isNotEmpty
              ? comboSeleccionar(
                  labelTexts: "PROGRAMA",
                  items: listEntidad.map((value) {
                    return DropdownMenuItem<Entidad>(
                      value: value,
                      child: Text(
                        value.nombre_programa,
                        style: const TextStyle(fontSize: 12),
                      ),
                    );
                  }).toList(),
                  onchanged: (value) async {
                    await cargarCategoria(value.id_entidad);
                    agregarEntidad.idEntidad = value.id_entidad.toString();
                    agregarEntidad.programa = value.nombre_programa;
                  },
                )
              : Container(),
          listCategoria.isNotEmpty
              ? comboSeleccionar(
                  labelTexts: "CATEGORIA",
                  items: listCategoria.map((value) {
                    return DropdownMenuItem<Categoria>(
                      value: value,
                      child: Text(
                        value.nombreCategoria!,
                        style: const TextStyle(fontSize: 12),
                      ),
                    );
                  }).toList(),
                  onchanged: (value) {
                    agregarEntidad.idCategoria = value.idCategoria;
                    agregarEntidad.categoria = value.nombreCategoria!;
                  },
                )
              : Container(),
          listSubcategoria.isNotEmpty
              ? comboSeleccionar(
                  labelTexts: "SUB CATEGORIA",
                  items: listSubcategoria.map((value) {
                    return DropdownMenuItem<Subcategoria>(
                      value: value,
                      child: Text(
                        value.nombreSubcategoria!,
                        style: const TextStyle(fontSize: 12),
                      ),
                    );
                  }).toList(),
                  onchanged: (value) {
                    agregarEntidad.idSubcategoria = value.idSubcategoria;
                    agregarEntidad.subcategoria = value.nombreSubcategoria;
                  },
                )
              : Container(),
          listActividad.isNotEmpty
              ? comboSeleccionar(
                  labelTexts: "TIPO ACTIVIDAD",
                  items: listActividad.map((value) {
                    return DropdownMenuItem<Actividad>(
                      value: value,
                      child: Text(
                        value.nombreTipoActividad!,
                        style: const TextStyle(fontSize: 12),
                      ),
                    );
                  }).toList(),
                  onchanged: (value) {
                    _cargarServicios(int.parse(value.idActividad));
                    _serviciosSeleccionados.clear();
                    agregarEntidad.idActividad = value.idActividad;
                    agregarEntidad.actividad = value.nombreTipoActividad;
                    setState(() {});
                  },
                )
              : Container(),
          _servicios.isNotEmpty
              ? MultiSelectDialogField<Servicio>(
                  selectedColor: Colors.blue[800],
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.0),
                    borderRadius: const BorderRadius.all(Radius.circular(40)),
                  ),
                  dialogHeight: _servicios.length * 45,
                  items: _servicios
                      .map((servicio) => MultiSelectItem<Servicio>(
                          servicio, servicio.nombreServicio!))
                      .toList(),
                  title: const Text('Seleccione los servicios'),
                  selectedItemsTextStyle: const TextStyle(color: Colors.blue),
                  buttonText: const Text('Servicios seleccionados'),
                  onConfirm: (selectedItems) {
                    _serviciosSeleccionados = selectedItems;
                    for (int i = 0; i < _serviciosSeleccionados.length; i++) {
                      _idServiciosSeleccionados
                          .add(_serviciosSeleccionados[i].idServicio!);
                      _nombreServiciosSeleccionados
                          .add(_serviciosSeleccionados[i].nombreServicio!);
                    }
                    setState(() {});
                    agregarEntidad.idServicio =
                        jsonEncode(_idServiciosSeleccionados);
                    agregarEntidad.servicio =
                        jsonEncode(_nombreServiciosSeleccionados);
                  },
                  buttonIcon: const Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  chipDisplay: MultiSelectChipDisplay(
                    onTap: (item) {
                      setState(() {
                        _serviciosSeleccionados.remove(item);
                        agregarEntidad.idServicio = '';
                        _idServiciosSeleccionados.clear();
                      });
                    },
                  ),
                )
              : Container(),
          widget.ismostrar
              ?   TextField(
            controller: controllerDescripcion,
            maxLines: 8,
            maxLength: 255,
            decoration: const InputDecoration(
              hintText:
              "",
              labelText: 'DESCRIPCIÓN DE LA ACTIVIDAD PROGRAMADA',
            ),
          )
              : Container(),
          _serviciosSeleccionados.isNotEmpty
              ? Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(5),
                  height: 38,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.save),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppConfig.primaryColor,
                        //   shadowColor:
                        textStyle: const TextStyle(fontSize: 16),
                        minimumSize: const Size.fromHeight(72),
                        shape: const StadiumBorder()),
                    onPressed: () async {
                      agregarEntidad.descripcionEntidad = controllerDescripcion.text;
                      var rsp = await DatabasePr.db
                          .insertEntidadAccion(agregarEntidad);
                      if (rsp > 0) {
                        Navigator.pop(context, 'OK');
                      }
                    },
                    label: const Text('GUARDAR'),
                  ))
              : Container(),

        ],
      ),
    );
  }

  Future<void> _cargarServicios(actividad1) async {
    List<Servicio> servicios =
        await ProviderRegistarInterv().getServicio(actividad1);
    setState(() {
      _servicios = servicios;
    });
  }

  reset() {
    listaSector = [];
    listEntidad = [];
    listCategoria = [];
    listSubcategoria = [];
    listActividad = [];
    _servicios = [];
    _serviciosSeleccionados = [];
    setState(() {});
  }

  cargarComboInicial() async {
    tipoGobierno = await ProviderRegistarInterv().getlistaTipoGobierno();
    setState(() {});
  }

  cargarComboSector(tipoGob) async {
    reset();
    listaSector = await ProviderRegistarInterv().getlistaSector(tipoGob);
    listEntidad = [];
    setState(() {});
  }

  cargarEntidad(sector) async {
    setState(() {
      listEntidad = [];
    });
    listEntidad =
        await ProviderRegistarInterv().getListarEntidadFuncionario(sector);
    setState(() {});
  }

  cargarCategoria(pro) async {
    setState(() {
      listCategoria = [];
      listSubcategoria = [];
      listActividad = [];
      _servicios = [];
      _serviciosSeleccionados = [];
    });
    listCategoria = await ProviderRegistarInterv().getListarCategoria(pro);
    listSubcategoria =
        await ProviderRegistarInterv().getListarSubcategoria(pro);
    listActividad = await ProviderRegistarInterv().getActividad(pro);
    setState(() {});
  }

  comboSeleccionar({String? labelTexts, items, onchanged}) {
    return DropdownButtonFormField<Object>(
        decoration: InputDecoration(
          isCollapsed: false,
          labelText: labelTexts,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          border: const UnderlineInputBorder(),
        ),
        isExpanded: true,
        items: items,
        onChanged: onchanged);
  }
}
