import 'dart:convert';

String tableNameProgramacionActividad = 'listar_programa_actividad';

class TockenUsuariosFields {
  static String idUsuario = 'idUsuario';
  static String ipmaq = 'ipmaq';
  static String tocken = 'tocken';
}

class TockenUsuariosModel {
  String? idUsuario = '';
  String? ipmaq = '';
  String? tocken = '';

  TockenUsuariosModel.empty() {}

  TockenUsuariosModel({
    this.idUsuario,
    this.ipmaq,
    this.tocken,
  });

  TockenUsuariosModel copy({
    String? idUsuario,
    String? ipmaq,
    String? tocken,
  }) =>
      TockenUsuariosModel(
        idUsuario: idUsuario ?? this.idUsuario,
        ipmaq: ipmaq ?? this.ipmaq,
        tocken: tocken ?? this.tocken,
      );

  static TockenUsuariosModel fromJson(Map<String, Object?> json) =>
      TockenUsuariosModel(
          idUsuario: json[TockenUsuariosFields.idUsuario] as String,
          ipmaq: json[TockenUsuariosFields.ipmaq] as String,
          tocken: json[TockenUsuariosFields.tocken] as String);

  Map<String, dynamic> toJson() => {
        TockenUsuariosFields.idUsuario: idUsuario,
        TockenUsuariosFields.ipmaq: ipmaq,
        TockenUsuariosFields.tocken: tocken,
      };

  static Map<String, dynamic> toJsonObject(TockenUsuariosModel o) {
    return {
      TockenUsuariosFields.idUsuario: o.idUsuario,
      TockenUsuariosFields.ipmaq: o.ipmaq,
      TockenUsuariosFields.tocken: o.tocken,
    };
  }

  static Map<String, String> toJsonObjectApi(TockenUsuariosModel o) {
    return {
      TockenUsuariosFields.idUsuario: o.idUsuario as String,
      TockenUsuariosFields.ipmaq: o.ipmaq as String,
      TockenUsuariosFields.tocken: o.tocken as String,
    };
  }

  static List<Map<String, dynamic>> toJsonArray(
      List<TockenUsuariosModel> lista) {
    List<Map<String, dynamic>> aList = [];
    for (var item in lista) {
      aList.add(TockenUsuariosModel.toJsonObject(item));
    }
    return aList;
  }

  List<TockenUsuariosModel> userFromJson(String sOject) {
    final jsonData = json.decode(sOject);
    return List<TockenUsuariosModel>.from(
        jsonData.map((x) => TockenUsuariosModel.fromJson(x)));
  }

  String userToJson(List<TockenUsuariosModel> lista) {
    final dyn = List<dynamic>.from(lista.map((x) => x.toJson()));
    return json.encode(dyn);
  }

  static List<TockenUsuariosModel> parseList(List<dynamic> a) {
    if (a == null) return [];

    List<TockenUsuariosModel> aListFormat =
        a.map((tagJson) => TockenUsuariosModel.fromJson(tagJson)).toList();
    return aListFormat;
  }

  static String _getString(dynamic data) {
    return data != null ? data as String : '';
  }
}
