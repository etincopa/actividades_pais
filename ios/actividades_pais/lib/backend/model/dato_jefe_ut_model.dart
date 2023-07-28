class DatosJUTFld {
  static String idUnidadesTerritoriales = 'idUnidadesTerritoriales';
  static String unidadTerritorialDescripcion = 'unidadTerritorialDescripcion';
  static String idTambo = 'idTambo';
  static String snip = 'snip';
  static String idEmpleado = 'idEmpleado';
  static String nombresJut = 'nombresJut';
  static String apellidoPaternoJut = 'apellidoPaternoJut';
  static String apellidoMaternoJut = 'apellidoMaternoJut';
  static String tipoDocumento = 'tipoDocumento';
  static String nroDocumento = 'nroDocumento';
  static String fechaNacimiento = 'fechaNacimiento';
  static String correo = 'correo';
  static String correoPersonal = 'correoPersonal';
  static String genero = 'genero';
  static String telefono = 'telefono';
}

class DatosJUTTamboModel {
  String? idUnidadesTerritoriales = '';
  String? unidadTerritorialDescripcion = '';
  String? idTambo = '';
  String? snip = '';
  String? idEmpleado = '';
  String? nombresJut = '';
  String? apellidoPaternoJut = '';
  String? apellidoMaternoJut = '';
  String? tipoDocumento = '';
  String? nroDocumento = '';
  String? fechaNacimiento = '';
  String? correo = '';
  String? correoPersonal = '';
  String? genero = '';
  String? telefono = '';

  DatosJUTTamboModel.empty();

  DatosJUTTamboModel({
    this.idUnidadesTerritoriales,
    this.unidadTerritorialDescripcion,
    this.idTambo,
    this.snip,
    this.idEmpleado,
    this.nombresJut,
    this.apellidoPaternoJut,
    this.apellidoMaternoJut,
    this.tipoDocumento,
    this.nroDocumento,
    this.fechaNacimiento,
    this.correo,
    this.correoPersonal,
    this.genero,
    this.telefono,
  });

  factory DatosJUTTamboModel.fromJson(Map<String, dynamic> json) {
    return DatosJUTTamboModel(
      idUnidadesTerritoriales: json[DatosJUTFld.idUnidadesTerritoriales],
      unidadTerritorialDescripcion:
          json[DatosJUTFld.unidadTerritorialDescripcion],
      idTambo: json[DatosJUTFld.idTambo],
      snip: json[DatosJUTFld.snip],
      idEmpleado: json[DatosJUTFld.idEmpleado],
      nombresJut: json[DatosJUTFld.nombresJut],
      apellidoPaternoJut: json[DatosJUTFld.apellidoPaternoJut],
      apellidoMaternoJut: json[DatosJUTFld.apellidoMaternoJut],
      tipoDocumento: json[DatosJUTFld.tipoDocumento],
      nroDocumento: json[DatosJUTFld.nroDocumento],
      fechaNacimiento: json[DatosJUTFld.fechaNacimiento],
      correo: json[DatosJUTFld.correo],
      correoPersonal: json[DatosJUTFld.correoPersonal],
      genero: json[DatosJUTFld.genero],
      telefono: json[DatosJUTFld.telefono],
    );
  }
}
