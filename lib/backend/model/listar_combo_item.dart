import 'dart:convert';

import 'package:actividades_pais/backend/model/listar_registro_entidad_actividad_model.dart';

String tableNameComboItem = 'listar_combo_item';

class ComboItemFields {
  static final List<String> values = [
    id,
    isEdit,
    time,
    idTypeItem,
    codigo1,
    codigo2,
    descripcion,
  ];

  static String id = '_id';
  static String isEdit = 'isEdit';
  static String time = 'time';

  static String idTypeItem = 'idTypeItem';
  static String codigo1 = 'codigo1';
  static String codigo2 = 'codigo2';
  static String descripcion = 'descripcion';

  /// Propiedades Servicio REST

  static String codigo1_ = 'ID_CODIGO';
  static String codigo2_ = 'CID_CODIGO';
  static String descripcion_ = 'CID_NOMBRE';
}

class ComboItemModel {
  static const sOptDropdownDefault = 'Seleccione una opción';

  static const cbNRIES = 'NIVEL_RIESGO';
  static const cbRIDEN = 'RIESGO_IDENTIFICADO';
  static const cbASOLU = 'ALTERNATIVA_SOLUCION';
  static const cbPIDEO = 'PROBLEMA_IDENTIFICADO_OBRA';
  static const cbPEJEC = 'PARTIDA_EJECUTADA';
  static const cbEAVAN = 'ESTADO_AVANCE';
  static const cbEMONI = 'ESTADO_MONITOREO';

  int? id = 0;
  int? isEdit = 0;
  DateTime? createdTime;

  String? idTypeItem = '';
  String? codigo1 = '';
  String? codigo2 = '';
  String? descripcion = '';

  ComboItemModel.empty();

  ComboItemModel({
    this.id,
    this.isEdit,
    this.createdTime,
    this.idTypeItem,
    this.codigo1,
    this.codigo2,
    this.descripcion,
  });

  ComboItemModel copy({
    int? id,
    int? isEdit,
    DateTime? createdTime,
    String? idTypeItem,
    String? codigo1,
    String? codigo2,
    String? descripcion,
  }) =>
      ComboItemModel(
        id: id ?? this.id,
        isEdit: isEdit ?? this.isEdit,
        createdTime: createdTime ?? this.createdTime,
        idTypeItem: idTypeItem ?? this.idTypeItem,
        codigo1: codigo1 ?? this.codigo1,
        codigo2: codigo2 ?? this.codigo2,
        descripcion: descripcion ?? this.descripcion,
      );

  static ComboItemModel fromJson(Map<String, Object?> json) => ComboItemModel(
        id: json[ComboItemFields.id] as int?,
        isEdit: json[ComboItemFields.isEdit] == null
            ? 0
            : json[ComboItemFields.isEdit] as int,
        createdTime: json[ComboItemFields.time] != null
            ? DateTime.parse(json[ComboItemFields.time] as String)
            : null,
        idTypeItem: _getString(json[ComboItemFields.idTypeItem]),
        codigo1: _getString(json[ComboItemFields.codigo1]),
        codigo2: _getString(json[ComboItemFields.codigo2]),
        descripcion: _getString(json[ComboItemFields.descripcion]),
      );

  static ComboItemModel fromJson_(Map<String, Object?> json) => ComboItemModel(
        id: json[ComboItemFields.id] as int?,
        isEdit: json[ComboItemFields.isEdit] == null
            ? 0
            : json[ComboItemFields.isEdit] as int,
        createdTime: json[ComboItemFields.time] != null
            ? DateTime.parse(json[ComboItemFields.time] as String)
            : null,
        idTypeItem: _getString(json[ComboItemFields.idTypeItem]),
        codigo1: json[ComboItemFields.codigo1_].toString(),
        codigo2: _getString(json[ComboItemFields.codigo2_]),
        descripcion: _getString(json[ComboItemFields.descripcion_]),
      );

  Map<String, dynamic> toJson() => {
        //ProgramacionIntervencionesFields.id: id,
        ComboItemFields.isEdit: isEdit,
        //ProgramacionIntervencionesFields.time: createdTime.toIso8601String(),

        ComboItemFields.idTypeItem: idTypeItem,
        ComboItemFields.codigo1: codigo1,
        ComboItemFields.codigo2: codigo2,
        ComboItemFields.descripcion: descripcion,
      };

  static Map<String, dynamic> toJsonObject(ComboItemModel o) {
    return {
      ComboItemFields.idTypeItem: o.idTypeItem,
      ComboItemFields.codigo1: o.codigo1,
      ComboItemFields.codigo2: o.codigo2,
      ComboItemFields.descripcion: o.descripcion,
    };
  }

  static Map<String, String> toJsonObjectApi(ComboItemModel o) {
    return {
      ComboItemFields.idTypeItem: o.idTypeItem as String,
      ComboItemFields.codigo1: o.codigo1 as String,
      ComboItemFields.codigo2: o.codigo2 as String,
      ComboItemFields.descripcion: o.descripcion as String,
    };
  }

  static List<Map<String, dynamic>> toJsonArray(
      List<ComboItemModel> aTramaMonitoreo) {
    List<Map<String, dynamic>> aList = [];
    for (var item in aTramaMonitoreo) {
      aList.add(ComboItemModel.toJsonObject(item));
    }
    return aList;
  }

  List<ComboItemModel> userFromJson(String sOject) {
    final jsonData = json.decode(sOject);
    return List<ComboItemModel>.from(
        jsonData.map((x) => ComboItemModel.fromJson(x)));
  }

  String userToJson(List<ComboItemModel> aTramaMonitoreo) {
    final dyn = List<dynamic>.from(aTramaMonitoreo.map((x) => x.toJson()));
    return json.encode(dyn);
  }

  static List<RegistroEntidadActividadModel> parseList(List<dynamic> a) {
    if (a == null) return [];

    List<RegistroEntidadActividadModel> aListFormat = a
        .map((tagJson) => RegistroEntidadActividadModel.fromJson(tagJson))
        .toList();
    return aListFormat;
  }

  static String _getString(dynamic data) {
    return data != null ? data as String : '';
  }
}
