import 'dart:convert';

import 'package:actividades_pais/backend/model/actividad_tambo_model.dart';

String tableNameProgramacionActividad = 'listar_programa_actividad';

class ProgActFld {
  static String tipoGobierno = 'tipoGobierno';
  static String sector = 'sector';
  static String programa = 'programa';
  static String documento = 'documento';
  static String articulacion = 'articulacion';
  static String fecha = 'fecha';
  static String horaInicio = 'horaInicio';
  static String horaFin = 'horaFin';
  static String descripcion = 'descripcion';
  static String accion = 'accion';
  static String realizo = 'realizo';
  static String tipoActividad = 'tipoActividad';
  static String tambos = 'tambos';
}

class ProgActModel {
  /*
   * Coordinación y Articulación
   {
      "fecha": "2023-01-04T05:00:00.000Z",
      "horaInicio": "00:00 AM",
      "horaFin": "01:00 AM",
      "tipoGobierno": 1,
      "sector": 21,
      "programa": 4,
      "documento": 1,
      "articulacion": 1,
      "accion": "Coordinación con entidades",
      "realizo": "TEST PAIS LUGAR",
      "descripcion": "TEST PAIS"
    }
   */

  /*
   * Monitoreo y Supervisión
   {
      "fecha": "2023-01-11T05:00:00.000Z",
      "tambos": [
          {
            "idTambo" : 12,
              "ubicacion": "undefined / undefined / undefined",
              "descripcion": "TEST PAIS TAMBO SOLEDAD",
              "hora": "01:00 AM - 02:00 AM",
              "fecha": "2023-01-11T05:00:00.000Z"
          }
      ]
    }
   */

  /*
   * Actividades PNPAIS
   {
      "fecha": "2023-01-12T05:00:00.000Z",
      "descripcion": "TEST PAIS ACTIVIDADES",
      "tipoActividad": 13,
      "horaInicio": "10:00 AM",
      "horaFin": "11:00 AM",
      "tipoGobierno": "",
      "sector": "",
      "programa": ""
    }
   */

  int? tipoGobierno = 0;
  int? sector = 0;
  int? programa = 0;
  int? documento = 0;
  int? articulacion = 0;
  String? fecha = '';
  String? horaInicio = '';
  String? horaFin = '';
  String? descripcion = '';
  String? accion = '';
  String? realizo = '';
  int? tipoActividad = 0;
  List<ActividadTamboModel>? aTambo = [];

  ProgActModel.empty();

  ProgActModel({
    this.tipoGobierno,
    this.sector,
    this.programa,
    this.documento,
    this.articulacion,
    this.fecha,
    this.horaInicio,
    this.horaFin,
    this.descripcion,
    this.accion,
    this.realizo,
    this.tipoActividad,
    this.aTambo,
  });

  ProgActModel copy({
    int? tipoGobierno,
    int? sector,
    int? programa,
    int? documento,
    int? articulacion,
    String? fecha,
    String? horaInicio,
    String? horaFin,
    String? descripcion,
    String? accion,
    String? realizo,
    String? tipoActividad,
  }) =>
      ProgActModel(
        tipoGobierno: tipoGobierno ?? this.tipoGobierno,
        sector: sector ?? this.sector,
        programa: programa ?? this.programa,
        documento: documento ?? this.documento,
        articulacion: articulacion ?? this.articulacion,
        fecha: fecha ?? this.fecha,
        horaInicio: horaInicio ?? this.horaInicio,
        horaFin: horaFin ?? this.horaFin,
        descripcion: descripcion ?? this.descripcion,
        accion: accion ?? this.accion,
        realizo: realizo ?? this.realizo,
        tipoActividad: this.tipoActividad,
      );

  static ProgActModel fromJson(Map<String, Object?> o) => ProgActModel(
        tipoGobierno: _getInt(o[ProgActFld.tipoGobierno]),
        sector: _getInt(o[ProgActFld.sector]),
        programa: _getInt(o[ProgActFld.programa]),
        documento: _getInt(o[ProgActFld.documento]),
        articulacion: _getInt(o[ProgActFld.articulacion]),
        fecha: _getString(o[ProgActFld.fecha]),
        horaInicio: _getString(o[ProgActFld.horaInicio]),
        horaFin: _getString(o[ProgActFld.horaFin]),
        descripcion: _getString(o[ProgActFld.descripcion]),
        accion: _getString(o[ProgActFld.accion]),
        realizo: _getString(o[ProgActFld.realizo]),
        tipoActividad: _getInt(o[ProgActFld.tipoActividad]),
        /*aTambo: o[ProgActFld.registroEntidadActividades] != null
            ? parseList(o[ProgActFld.registroEntidadActividades]
                as List<ActividadTamboModel>)
            : [],*/
      );

  Map<String, dynamic> toJson() => {
        ProgActFld.tipoGobierno: tipoGobierno,
        ProgActFld.sector: sector,
        ProgActFld.programa: programa,
        ProgActFld.documento: documento,
        ProgActFld.articulacion: articulacion,
        ProgActFld.fecha: fecha,
        ProgActFld.horaInicio: horaInicio,
        ProgActFld.horaFin: horaFin,
        ProgActFld.descripcion: descripcion,
        ProgActFld.accion: accion,
        ProgActFld.realizo: realizo,
        ProgActFld.tipoActividad: tipoActividad,
      };

  static Map<String, dynamic> toJsonObject(ProgActModel o) {
    return {
      ProgActFld.tipoGobierno: o.tipoGobierno,
      ProgActFld.sector: o.sector,
      ProgActFld.programa: o.programa,
      ProgActFld.documento: o.documento,
      ProgActFld.articulacion: o.articulacion,
      ProgActFld.fecha: o.fecha,
      ProgActFld.horaInicio: o.horaInicio,
      ProgActFld.horaFin: o.horaFin,
      ProgActFld.descripcion: o.descripcion,
      ProgActFld.accion: o.accion,
      ProgActFld.realizo: o.realizo,
      ProgActFld.tipoActividad: o.tipoActividad,
    };
  }

  static Map<String, dynamic> toJsonObjectApi1(ProgActModel o) {
    return {
      ProgActFld.tipoGobierno: _getInt(o.tipoGobierno),
      ProgActFld.sector: _getInt(o.sector),
      ProgActFld.programa: _getInt(o.programa),
      ProgActFld.documento: _getInt(o.documento),
      ProgActFld.articulacion: _getInt(o.articulacion),
      ProgActFld.fecha: _getString(o.fecha),
      ProgActFld.horaInicio: _getString(o.horaInicio),
      ProgActFld.horaFin: _getString(o.horaFin),
      ProgActFld.descripcion: _getString(o.descripcion),
      ProgActFld.accion: _getString(o.accion),
      ProgActFld.realizo: _getString(o.realizo),
    };
  }

  static Map<String, dynamic> toJsonObjectApi2(ProgActModel o) {
    return {
      ProgActFld.fecha: _getString(o.fecha),
      ProgActFld.tambos: o.aTambo ?? []
    };
  }

  static Map<String, dynamic> toJsonObjectApi3(ProgActModel o) {
    return {
      ProgActFld.tipoGobierno: _getInt(o.tipoGobierno),
      ProgActFld.sector: _getInt(o.sector),
      ProgActFld.programa: _getInt(o.programa),
      ProgActFld.fecha: _getString(o.fecha),
      ProgActFld.horaInicio: _getString(o.horaInicio),
      ProgActFld.horaFin: _getString(o.horaFin),
      ProgActFld.descripcion: _getString(o.descripcion),
      ProgActFld.tipoActividad: _getInt(o.tipoActividad),
    };
  }

  static List<Map<String, dynamic>> toJsonArray(
      List<ProgActModel> aTramaMonitoreo) {
    List<Map<String, dynamic>> aList = [];
    for (var item in aTramaMonitoreo) {
      aList.add(ProgActModel.toJsonObject(item));
    }
    return aList;
  }

  List<ProgActModel> userFromJson(String sOject) {
    final jsonData = json.decode(sOject);
    return List<ProgActModel>.from(
        jsonData.map((x) => ProgActModel.fromJson(x)));
  }

  String userToJson(List<ProgActModel> aTramaMonitoreo) {
    final dyn = List<dynamic>.from(aTramaMonitoreo.map((x) => x.toJson()));
    return json.encode(dyn);
  }

  static List<ActividadTamboModel> parseList(List<dynamic> a) {
    if (a == null) return [];

    List<ActividadTamboModel> aListFormat =
        a.map((tagJson) => ActividadTamboModel.fromJson(tagJson)).toList();
    return aListFormat;
  }

  static String _getString(dynamic data) {
    return data != null ? data as String : '';
  }

  static int _getInt(dynamic data) {
    return data != null ? int.parse(data.toString()) : 0;
  }
}
