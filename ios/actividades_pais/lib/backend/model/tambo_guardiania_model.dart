class GuardianiaTamboFld {
  static String idTambo = 'idTambo';
  static String numSnip = 'numSnip';
  static String plataformaDescripcion = 'plataformaDescripcion';
  static String estadoGuardiania = 'estadoGuardiania';
  static String tipoDocumentoSiglas = 'tipoDocumentoSiglas';
  static String numeroDocumento = 'numeroDocumento';
  static String empleadoApellidoPaterno = 'empleadoApellidoPaterno';
  static String empleadoApellidoMaterno = 'empleadoApellidoMaterno';
  static String empleadoNombre = 'empleadoNombre';
  static String empleadoCorreo = 'empleadoCorreo';
  static String idGenero = 'idGenero';
  static String fechaNacimiento = 'fechaNacimiento';
  static String sexo = 'sexo';
  static String celular = 'celular';
  static String modalidadContratoSiglas = 'modalidadContratoSiglas';
  static String tipoContrato = 'tipoContrato';
  static String fecInicioContrato = 'fecInicioContrato';
  static String fecFinalContrato = 'fecFinalContrato';
}

class GuardianiaTamboModel {
  int? idTambo = 0;
  String? numSnip = '';
  String? plataformaDescripcion = '';
  String? estadoGuardiania = '';
  String? tipoDocumentoSiglas = '';
  String? numeroDocumento = '';
  String? empleadoApellidoPaterno = '';
  String? empleadoApellidoMaterno = '';
  String? empleadoNombre = '';
  String? empleadoCorreo = '';
  String? idGenero = '';
  String? fechaNacimiento = '';
  String? sexo = '';
  String? celular = '';
  String? modalidadContratoSiglas = '';
  String? tipoContrato = '';
  String? fecInicioContrato = '';
  String? fecFinalContrato = '';

  GuardianiaTamboModel.empty();

  GuardianiaTamboModel({
    this.idTambo,
    this.numSnip,
    this.plataformaDescripcion,
    this.estadoGuardiania,
    this.tipoDocumentoSiglas,
    this.numeroDocumento,
    this.empleadoApellidoPaterno,
    this.empleadoApellidoMaterno,
    this.empleadoNombre,
    this.empleadoCorreo,
    this.idGenero,
    this.fechaNacimiento,
    this.sexo,
    this.celular,
    this.modalidadContratoSiglas,
    this.tipoContrato,
    this.fecInicioContrato,
    this.fecFinalContrato,
  });

  GuardianiaTamboModel copy({
    int? idTambo,
    String? numSnip,
    String? plataformaDescripcion,
    String? estadoGuardiania,
    String? tipoDocumentoSiglas,
    String? numeroDocumento,
    String? empleadoApellidoPaterno,
    String? empleadoApellidoMaterno,
    String? empleadoNombre,
    String? empleadoCorreo,
    String? idGenero,
    String? fechaNacimiento,
    String? sexo,
    String? celular,
    String? modalidadContratoSiglas,
    String? tipoContrato,
    String? fecInicioContrato,
    String? fecFinalContrato,
  }) =>
      GuardianiaTamboModel(
        idTambo: idTambo ?? this.idTambo,
        numSnip: numSnip ?? this.numSnip,
        plataformaDescripcion:
            plataformaDescripcion ?? this.plataformaDescripcion,
        estadoGuardiania: estadoGuardiania ?? this.estadoGuardiania,
        tipoDocumentoSiglas: tipoDocumentoSiglas ?? this.tipoDocumentoSiglas,
        numeroDocumento: numeroDocumento ?? this.numeroDocumento,
        empleadoApellidoPaterno:
            empleadoApellidoPaterno ?? this.empleadoApellidoPaterno,
        empleadoApellidoMaterno:
            empleadoApellidoMaterno ?? this.empleadoApellidoMaterno,
        empleadoNombre: empleadoNombre ?? this.empleadoNombre,
        empleadoCorreo: empleadoCorreo ?? this.empleadoCorreo,
        idGenero: idGenero ?? this.idGenero,
        fechaNacimiento: fechaNacimiento ?? this.fechaNacimiento,
        sexo: sexo ?? this.sexo,
        celular: celular ?? this.celular,
        modalidadContratoSiglas:
            modalidadContratoSiglas ?? this.modalidadContratoSiglas,
        tipoContrato: tipoContrato ?? this.tipoContrato,
        fecInicioContrato: fecInicioContrato ?? this.fecInicioContrato,
        fecFinalContrato: fecFinalContrato ?? this.fecFinalContrato,
      );

  factory GuardianiaTamboModel.fromJson(Map<String, dynamic> json) {
    return GuardianiaTamboModel(
      idTambo: _getInt(json[GuardianiaTamboFld.idTambo]),
      numSnip: _getString(json[GuardianiaTamboFld.numSnip]),
      plataformaDescripcion:
          _getString(json[GuardianiaTamboFld.plataformaDescripcion]),
      estadoGuardiania: _getString(json[GuardianiaTamboFld.estadoGuardiania]),
      tipoDocumentoSiglas:
          _getString(json[GuardianiaTamboFld.tipoDocumentoSiglas]),
      numeroDocumento: _getString(json[GuardianiaTamboFld.numeroDocumento]),
      empleadoApellidoPaterno:
          _getString(json[GuardianiaTamboFld.empleadoApellidoPaterno]),
      empleadoApellidoMaterno:
          _getString(json[GuardianiaTamboFld.empleadoApellidoMaterno]),
      empleadoNombre: _getString(json[GuardianiaTamboFld.empleadoNombre]),
      empleadoCorreo: _getString(json[GuardianiaTamboFld.empleadoCorreo]),
      idGenero: _getString(json[GuardianiaTamboFld.idGenero]),
      fechaNacimiento: _getString(json[GuardianiaTamboFld.fechaNacimiento]),
      sexo: _getString(json[GuardianiaTamboFld.sexo]),
      celular: _getString(json[GuardianiaTamboFld.celular]),
      modalidadContratoSiglas:
          _getString(json[GuardianiaTamboFld.modalidadContratoSiglas]),
      tipoContrato: _getString(json[GuardianiaTamboFld.tipoContrato]),
      fecInicioContrato: _getString(json[GuardianiaTamboFld.fecInicioContrato]),
      fecFinalContrato: _getString(json[GuardianiaTamboFld.fecFinalContrato]),
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
