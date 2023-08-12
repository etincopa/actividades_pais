import 'dart:convert';

class ActividadTamboFld {
  static String idTambo = 'idTambo';
  static String ubicacion = 'ubicacion';
  static String fecha = 'fecha';
  static String hora = 'hora';
  static String descripcion = 'descripcion';
}

class ActividadTamboModel {
  int? idTambo = 0;
  String? ubicacion = '';
  String? fecha = '';
  String? hora = '';
  String? descripcion = '';

  ActividadTamboModel.empty();

  ActividadTamboModel({
    this.idTambo,
    this.ubicacion,
    this.fecha,
    this.hora,
    this.descripcion,
  });

  ActividadTamboModel copy({
    int? idTambo,
    String? ubicacion,
    String? fecha,
    String? hora,
    String? descripcion,
  }) =>
      ActividadTamboModel(
        idTambo: idTambo ?? this.idTambo,
        ubicacion: ubicacion ?? this.ubicacion,
        fecha: fecha ?? this.fecha,
        hora: hora ?? this.hora,
        descripcion: descripcion ?? this.descripcion,
      );

  static ActividadTamboModel fromJson(Map<String, Object?> json) =>
      ActividadTamboModel(
        idTambo: json[ActividadTamboFld.idTambo] as int?,
        ubicacion: _getString(json[ActividadTamboFld.ubicacion]),
        fecha: _getString(json[ActividadTamboFld.fecha]),
        hora: _getString(json[ActividadTamboFld.hora]),
        descripcion: _getString(json[ActividadTamboFld.descripcion]),
      );

  Map<String, dynamic> toJson() => {
        ActividadTamboFld.idTambo: idTambo,
        ActividadTamboFld.ubicacion: ubicacion,
        ActividadTamboFld.fecha: fecha,
        ActividadTamboFld.hora: hora,
        ActividadTamboFld.descripcion: descripcion,
      };

  static Map<String, dynamic> toJsonObject(ActividadTamboModel o) {
    return {
      ActividadTamboFld.idTambo: o.idTambo,
      ActividadTamboFld.ubicacion: o.ubicacion,
      ActividadTamboFld.fecha: o.fecha,
      ActividadTamboFld.hora: o.hora,
      ActividadTamboFld.descripcion: o.descripcion,
    };
  }

  static Map<String, String> toJsonObjectApi(ActividadTamboModel o) {
    return {
      ActividadTamboFld.idTambo: o.idTambo as String,
      ActividadTamboFld.ubicacion: o.ubicacion as String,
      ActividadTamboFld.fecha: o.fecha as String,
      ActividadTamboFld.hora: o.hora as String,
      ActividadTamboFld.descripcion: o.descripcion as String,
    };
  }

  static List<Map<String, dynamic>> toJsonArray(List<ActividadTamboModel> o) {
    List<Map<String, dynamic>> aList = [];
    for (var item in o) {
      aList.add(ActividadTamboModel.toJsonObject(item));
    }
    return aList;
  }

  List<ActividadTamboModel> userFromJson(String sOject) {
    final jsonData = json.decode(sOject);
    return List<ActividadTamboModel>.from(
        jsonData.map((x) => ActividadTamboModel.fromJson(x)));
  }

  String userToJson(List<ActividadTamboModel> o) {
    final dyn = List<dynamic>.from(o.map((x) => x.toJson()));
    return json.encode(dyn);
  }

  static String _getString(dynamic data) {
    return data != null ? data as String : '';
  }
}
