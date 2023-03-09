class GuardianiaTamboFld {
  static String idTambo = 'idTambo';
  static String numSnip = 'numSnip';
  static String plataformaDescripcion = 'plataformaDescripcion';
  static String estadoGuardiania = 'estadoGuardiania';
  static String tipoDocumentoSiglas = 'tipoDocumentoSiglas';
  static String empleadoNumeroDocumento = 'empleadoNumeroDocumento';
  static String empleadoApellidoPaterno = 'empleadoApellidoPaterno';
  static String empleadoApellidoMaterno = 'empleadoApellidoMaterno';
  static String empleadoNombre = 'empleadoNombre';
  static String modalidadContratoSiglas = 'modalidadContratoSiglas';
}

class GuardianiaTamboModel {
  int? idTambo = 0;
  String? numSnip;
  String? plataformaDescripcion;
  String? estadoGuardiania;
  String? tipoDocumentoSiglas;
  String? empleadoNumeroDocumento;
  String? empleadoApellidoPaterno;
  String? empleadoApellidoMaterno;
  String? empleadoNombre;
  String? modalidadContratoSiglas;

  GuardianiaTamboModel.empty() {}

  GuardianiaTamboModel({
    this.idTambo,
    this.numSnip,
    this.plataformaDescripcion,
    this.estadoGuardiania,
    this.tipoDocumentoSiglas,
    this.empleadoNumeroDocumento,
    this.empleadoApellidoPaterno,
    this.empleadoApellidoMaterno,
    this.empleadoNombre,
    this.modalidadContratoSiglas,
  });

  GuardianiaTamboModel copy({
    int? idTambo,
    String? numSnip,
    String? plataformaDescripcion,
    String? estadoGuardiania,
    String? tipoDocumentoSiglas,
    String? empleadoNumeroDocumento,
    String? empleadoApellidoPaterno,
    String? empleadoApellidoMaterno,
    String? empleadoNombre,
    String? modalidadContratoSiglas,
  }) =>
      GuardianiaTamboModel(
        idTambo: idTambo ?? this.idTambo,
        numSnip: numSnip ?? this.numSnip,
        plataformaDescripcion:
            plataformaDescripcion ?? this.plataformaDescripcion,
        estadoGuardiania: estadoGuardiania ?? this.estadoGuardiania,
        tipoDocumentoSiglas: tipoDocumentoSiglas ?? this.tipoDocumentoSiglas,
        empleadoNumeroDocumento:
            empleadoNumeroDocumento ?? this.empleadoNumeroDocumento,
        empleadoApellidoPaterno:
            empleadoApellidoPaterno ?? this.empleadoApellidoPaterno,
        empleadoApellidoMaterno:
            empleadoApellidoMaterno ?? this.empleadoApellidoMaterno,
        empleadoNombre: empleadoNombre ?? this.empleadoNombre,
        modalidadContratoSiglas:
            modalidadContratoSiglas ?? this.modalidadContratoSiglas,
      );

  factory GuardianiaTamboModel.fromJson(Map<String, dynamic> json) {
    return GuardianiaTamboModel(
      idTambo: _getInt(json[GuardianiaTamboFld.idTambo]),
      numSnip: json[GuardianiaTamboFld.numSnip],
      plataformaDescripcion: json[GuardianiaTamboFld.plataformaDescripcion],
      estadoGuardiania: json[GuardianiaTamboFld.estadoGuardiania],
      tipoDocumentoSiglas: json[GuardianiaTamboFld.tipoDocumentoSiglas],
      empleadoNumeroDocumento: json[GuardianiaTamboFld.empleadoNumeroDocumento],
      empleadoApellidoPaterno: json[GuardianiaTamboFld.empleadoApellidoPaterno],
      empleadoApellidoMaterno: json[GuardianiaTamboFld.empleadoApellidoMaterno],
      empleadoNombre: json[GuardianiaTamboFld.empleadoNombre],
      modalidadContratoSiglas: json[GuardianiaTamboFld.modalidadContratoSiglas],
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
