class TamboActFld {
  static String idTambo = 'idTambo';
  static String nombreTambo = 'nombreTambo';
  static String idProgramacion = 'idProgramacion';
  static String estadoProgramacion = 'estadoProgramacion';
  static String estadoEjecucion = 'estadoEjecucion';
  static String tipo = 'tipo';
  static String fecha = 'fecha';
  static String tipoUsuario = 'tipoUsuario';
  static String sector = 'sector';
  static String programa = 'programa';
  static String tipoEvento = 'tipoEvento';
  static String descripcion = 'descripcion';
  static String imagen = 'imagen';
  static String actividadPathImage = 'actividadPathImage';
  static String fechaCreacionImagen = 'fechaCreacionImagen';
}

class TamboActividadModel {
  int? idTambo = 0;
  String? nombreTambo = '';
  int? idProgramacion = 0;
  int? estadoProgramacion = 0;
  int? estadoEjecucion = 0;
  int? tipo = 0;
  String? fecha = '';
  String? tipoUsuario = '';
  String? sector = '';
  String? programa = '';
  String? tipoEvento = '';
  String? descripcion = '';
  String? imagen = '';
  String? actividadPathImage = '';
  String? fechaCreacionImagen = '';
  String? base64Temp = '';

  TamboActividadModel.empty() {}

  TamboActividadModel({
    this.idTambo,
    this.nombreTambo,
    this.idProgramacion,
    this.estadoProgramacion,
    this.estadoEjecucion,
    this.tipo,
    this.fecha,
    this.tipoUsuario,
    this.sector,
    this.programa,
    this.tipoEvento,
    this.descripcion,
    this.imagen,
    this.actividadPathImage,
    this.fechaCreacionImagen,
  });

  factory TamboActividadModel.fromJson(Map<String, dynamic> json) {
    return TamboActividadModel(
      idTambo: json[TamboActFld.idTambo],
      nombreTambo: json[TamboActFld.nombreTambo],
      idProgramacion: json[TamboActFld.idProgramacion],
      estadoProgramacion: json[TamboActFld.estadoProgramacion],
      estadoEjecucion: json[TamboActFld.estadoEjecucion],
      tipo: json[TamboActFld.tipo],
      fecha: json[TamboActFld.fecha],
      tipoUsuario: json[TamboActFld.tipoUsuario],
      sector: json[TamboActFld.sector],
      programa: json[TamboActFld.programa],
      tipoEvento: json[TamboActFld.tipoEvento],
      descripcion: json[TamboActFld.descripcion],
      imagen: json[TamboActFld.imagen],
      actividadPathImage: json[TamboActFld.actividadPathImage],
      fechaCreacionImagen: json[TamboActFld.fechaCreacionImagen],
    );
  }
}
