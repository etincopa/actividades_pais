class DatosJUTFld {
  static String correoPersonal = 'correoPersonal';
  static String apellidoMaternoJut = 'apellidoMaternoJut';
  static String apellidoPaternoJut = 'apellidoPaternoJut';
  static String nroDocumento = 'nroDocumento';
  static String tipoDocumento = 'tipoDocumento';
  static String correo = 'correo';
  static String idEmpleado = 'idEmpleado';
  static String genero = 'genero';
  static String nombresJut = 'nombresJut';
  static String idUt = 'idUt';
  static String telefono = 'telefono';
  static String estado = 'estado';
  static String fechaNacimiento = 'fechaNacimiento';
}

class HistorialJUTModel {
  String? correoPersonal = '';
  String? apellidoMaternoJut = '';
  String? apellidoPaternoJut = '';
  String? nroDocumento = '';
  String? tipoDocumento = '';
  String? correo = '';
  String? idEmpleado = '';
  String? genero = '';
  String? nombresJut = '';
  String? idUt = '';
  String? telefono = '';
  String? estado = '';
  String? fechaNacimiento = '';

  HistorialJUTModel.empty();

  HistorialJUTModel({
    this.correoPersonal,
    this.apellidoMaternoJut,
    this.apellidoPaternoJut,
    this.nroDocumento,
    this.tipoDocumento,
    this.correo,
    this.idEmpleado,
    this.genero,
    this.nombresJut,
    this.idUt,
    this.telefono,
    this.estado,
    this.fechaNacimiento,
  });

  factory HistorialJUTModel.fromJson(Map<String, dynamic> json) {
    return HistorialJUTModel(
      correoPersonal: json[DatosJUTFld.correoPersonal],
      apellidoMaternoJut: json[DatosJUTFld.apellidoMaternoJut],
      apellidoPaternoJut: json[DatosJUTFld.apellidoPaternoJut],
      nroDocumento: json[DatosJUTFld.nroDocumento],
      tipoDocumento: json[DatosJUTFld.tipoDocumento],
      correo: json[DatosJUTFld.correo],
      idEmpleado: json[DatosJUTFld.idEmpleado],
      genero: json[DatosJUTFld.genero],
      nombresJut: json[DatosJUTFld.nombresJut],
      idUt: json[DatosJUTFld.idUt],
      telefono: json[DatosJUTFld.telefono],
      estado: json[DatosJUTFld.estado],
      fechaNacimiento: json[DatosJUTFld.fechaNacimiento],
    );
  }
}
