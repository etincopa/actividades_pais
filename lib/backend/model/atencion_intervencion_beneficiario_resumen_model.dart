class AtenInterBeneFLd {
  static String idTambo = 'idTambo';
  static String snip = 'snip';
  static String nombreTambo = 'nombreTambo';
  static String intervenciones = 'intervenciones';
  static String atenciones = 'atenciones';
  static String beneficiarios = 'beneficiarios';
}

class AtenInterBeneResumenModel {
  int? idTambo = 0;
  String? snip = '';
  String? nombreTambo = '';
  int? intervenciones = 0;
  int? atenciones = 0;
  int? beneficiarios = 0;

  AtenInterBeneResumenModel.empty() {}

  AtenInterBeneResumenModel({
    this.idTambo,
    this.snip,
    this.nombreTambo,
    this.intervenciones,
    this.atenciones,
    this.beneficiarios,
  });

  AtenInterBeneResumenModel copy({
    int? idTambo,
    String? snip,
    String? nombreTambo,
    int? intervenciones,
    int? atenciones,
    int? beneficiarios,
  }) =>
      AtenInterBeneResumenModel(
        idTambo: idTambo ?? this.idTambo,
        snip: snip ?? this.snip,
        nombreTambo: nombreTambo ?? this.nombreTambo,
        intervenciones: intervenciones ?? this.intervenciones,
        atenciones: atenciones ?? this.atenciones,
        beneficiarios: beneficiarios ?? this.beneficiarios,
      );

  factory AtenInterBeneResumenModel.fromJson(Map<String, dynamic> json) {
    return AtenInterBeneResumenModel(
      idTambo: _getInt(json[AtenInterBeneFLd.idTambo]),
      snip: _getString(json[AtenInterBeneFLd.snip]),
      nombreTambo: _getString(json[AtenInterBeneFLd.nombreTambo]),
      intervenciones: _getInt(json[AtenInterBeneFLd.intervenciones]),
      atenciones: _getInt(json[AtenInterBeneFLd.atenciones]),
      beneficiarios: _getInt(json[AtenInterBeneFLd.beneficiarios]),
    );
  }

  static double _getDouble(dynamic data) {
    try {
      return data != null ? double.parse(data.toString()) : 0.000;
    } catch (oError) {
      return 0.0;
    }
  }

  static String _getString(dynamic data, {String? type}) {
    String resp = data != null ? data.toString() : '';
    if (type != null && type == "I") {
      if (resp == '') resp = '0';
    } else if (type != null && type == "D") {
      if (resp == '') resp = '0.00';
    }

    return resp;
  }

  static DateTime _getDateTime(dynamic data) {
    return data != null ? DateTime.parse(data as String) : DateTime.now();
  }

  static int _getInt(dynamic data) {
    return data != null ? int.parse(data.toString()) : 0;
  }
}
