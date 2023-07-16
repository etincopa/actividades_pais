class RutaTamboFld {
  static String idTambo = 'FID_PLATAFORMA';
  static String numSnip = 'PLATAFORMA_CODIGO_SNIP';
  static String plataformaDescripcion = 'PLATAFORMA_DESCRIPCION';
  static String cidNombre = 'CID_NOMBRE';
  static String txtDescripcion = 'TXT_DESCRIPCION';
  static String txtEncuenta = 'TXT_ENCUENTA';
}

class RutaTamboModel {
  int? idTambo = 0;
  String? numSnip;
  String? plataformaDescripcion;
  String? cidNombre;
  String? txtDescripcion;
  String? txtEncuenta;

  RutaTamboModel.empty();

  RutaTamboModel({
    this.idTambo,
    this.numSnip,
    this.plataformaDescripcion,
    this.cidNombre,
    this.txtDescripcion,
    this.txtEncuenta,
  });

  RutaTamboModel copy({
    int? idTambo,
    String? numSnip,
    String? plataformaDescripcion,
    String? cidNombre,
    String? tipoDocumentoSiglas,
    String? txtDescripcion,
    String? txtEncuenta,
  }) =>
      RutaTamboModel(
        idTambo: idTambo ?? this.idTambo,
        numSnip: numSnip ?? this.numSnip,
        plataformaDescripcion:
            plataformaDescripcion ?? this.plataformaDescripcion,
        cidNombre: cidNombre ?? this.cidNombre,
        txtDescripcion: txtDescripcion ?? this.txtDescripcion,
        txtEncuenta: txtEncuenta ?? this.txtEncuenta,
      );

  factory RutaTamboModel.fromJson(Map<String, dynamic> json) {
    return RutaTamboModel(
      idTambo: _getInt(json[RutaTamboFld.idTambo]),
      numSnip: _getString(json[RutaTamboFld.numSnip]),
      plataformaDescripcion:
          _getString(json[RutaTamboFld.plataformaDescripcion]),
      cidNombre: _getString(json[RutaTamboFld.cidNombre]),
      txtDescripcion: _getString(json[RutaTamboFld.txtDescripcion]),
      txtEncuenta: _getString(json[RutaTamboFld.txtEncuenta]),
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
