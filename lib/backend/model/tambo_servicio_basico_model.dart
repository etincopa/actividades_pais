class SrvBasicoTamboFld {
  static String idTambo = 'idPlataforma';
  static String codigoServicio = 'codigoServicio';
  static String nombreServicio = 'nombreServicio';
  static String tipoServicio = 'tipoServicio';
  static String proveedorServicio = 'proveedorServicio';
  static String estado = 'estado';
  static String codigoEstado = 'codigoEstado';
}

class ServicioBasicoTamboModel {
  int? idTambo = 0;
  String? codigoServicio;
  String? nombreServicio;
  String? tipoServicio;
  String? proveedorServicio;
  String? estado;

  ServicioBasicoTamboModel.empty() {}

  ServicioBasicoTamboModel({
    this.idTambo,
    this.codigoServicio,
    this.nombreServicio,
    this.tipoServicio,
    this.proveedorServicio,
    this.estado,
  });

  ServicioBasicoTamboModel copy({
    int? idTambo,
    String? codigoServicio,
    String? nombreServicio,
    String? tipoServicio,
    String? tipoDocumentoSiglas,
    String? proveedorServicio,
    String? estado,
  }) =>
      ServicioBasicoTamboModel(
        idTambo: idTambo ?? this.idTambo,
        codigoServicio: codigoServicio ?? this.codigoServicio,
        nombreServicio: nombreServicio ?? this.nombreServicio,
        tipoServicio: tipoServicio ?? this.tipoServicio,
        proveedorServicio: proveedorServicio ?? this.proveedorServicio,
        estado: estado ?? this.estado,
      );

  factory ServicioBasicoTamboModel.fromJson(Map<String, dynamic> json) {
    return ServicioBasicoTamboModel(
      idTambo: _getInt(json[SrvBasicoTamboFld.idTambo]),
      codigoServicio: _getString(json[SrvBasicoTamboFld.codigoServicio]),
      nombreServicio: _getString(json[SrvBasicoTamboFld.nombreServicio]),
      tipoServicio: _getString(json[SrvBasicoTamboFld.tipoServicio]),
      proveedorServicio: _getString(json[SrvBasicoTamboFld.proveedorServicio]),
      estado: _getString(json[SrvBasicoTamboFld.estado]),
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
