class UnidadTerritorialFld {
  static String idUt = 'idUt';
  static String nombreUt = 'nombreUt';
  static String unidadTerritorialDireccion = 'unidadTerritorialDireccion';
  static String unidadTerritorialPropietario = 'unidadTerritorialPropietario';
  static String departamentoUt = 'departamentoUt';

  static String provinciaUt = 'provinciaUt';
  static String distritooUt = 'distritooUt';
  static String tipoDocumentoUt = 'tipoDocumentoUt';
  static String nroDocumentoUt = 'nroDocumentoUt';
  static String fechaNacimientoUt = 'fechaNacimientoUt';
  static String correoUt = 'correoUt';
  static String generoUt = 'generoUt';
  static String celularUt = 'celularUt';
}

class UnidadTerritorialModel {
  String? idUt;
  String? nombreUt;
  String? unidadTerritorialDireccion;
  String? unidadTerritorialPropietario;
  String? departamentoUt;

  String? provinciaUt;
  String? distritooUt;
  String? tipoDocumentoUt;
  String? nroDocumentoUt;
  String? fechaNacimientoUt;
  String? correoUt;
  String? generoUt;
  String? celularUt;

  UnidadTerritorialModel.empty();

  UnidadTerritorialModel(
      {this.idUt,
      this.nombreUt,
      this.unidadTerritorialDireccion,
      this.unidadTerritorialPropietario,
      this.departamentoUt,
      this.provinciaUt,
      this.distritooUt,
      this.tipoDocumentoUt,
      this.nroDocumentoUt,
      this.fechaNacimientoUt,
      this.correoUt,
      this.celularUt});

  factory UnidadTerritorialModel.fromJson(Map<String, dynamic> json) {
    return UnidadTerritorialModel(
      idUt: json[UnidadTerritorialFld.idUt],
      nombreUt: json[UnidadTerritorialFld.nombreUt],
      unidadTerritorialDireccion:
          json[UnidadTerritorialFld.unidadTerritorialDireccion],
      unidadTerritorialPropietario:
          json[UnidadTerritorialFld.unidadTerritorialPropietario],
      departamentoUt: json[UnidadTerritorialFld.departamentoUt],
      provinciaUt: json[UnidadTerritorialFld.provinciaUt],
      distritooUt: json[UnidadTerritorialFld.distritooUt],
      tipoDocumentoUt: json[UnidadTerritorialFld.tipoDocumentoUt],
      nroDocumentoUt: json[UnidadTerritorialFld.nroDocumentoUt],
      fechaNacimientoUt: json[UnidadTerritorialFld.fechaNacimientoUt],
      correoUt: json[UnidadTerritorialFld.correoUt],
      celularUt: json[UnidadTerritorialFld.celularUt],
    );
  }
}
