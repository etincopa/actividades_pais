class BuscarTamboFld {
  static String nombreFisicoFoto = 'nombreFisicoFoto';
  static String idTambo = 'idTambo';
  static String nombreTambo = 'nombreTambo';
  static String idDepartamento = 'idDepartamento';
  static String nombreDepartamento = 'nombreDepartamento';
  static String gestor = 'gestor';
  static String extensionFoto = 'extensionFoto';
  static String clase = 'clase';
  static String value = 'value';
  static String label = 'label';
}

class BuscarTamboDto {
  int? idTambo;
  String? nombreFisicoFoto;
  String? nombreTambo;
  int? idDepartamento;
  String? nombreDepartamento;
  String? gestor;
  String? extensionFoto;

  BuscarTamboDto.empty();

  BuscarTamboDto({
    this.nombreFisicoFoto,
    this.idTambo,
    this.nombreTambo,
    this.idDepartamento,
    this.nombreDepartamento,
    this.gestor,
    this.extensionFoto,
  });

  factory BuscarTamboDto.fromJson(Map<String, dynamic> json) {
    return BuscarTamboDto(
      nombreFisicoFoto: json[BuscarTamboFld.nombreFisicoFoto],
      idTambo: json[BuscarTamboFld.idTambo],
      nombreTambo: json[BuscarTamboFld.nombreTambo],
      idDepartamento: json[BuscarTamboFld.idDepartamento],
      nombreDepartamento: json[BuscarTamboFld.nombreDepartamento],
      gestor: json[BuscarTamboFld.gestor],
      extensionFoto: json[BuscarTamboFld.extensionFoto],
    );
  }
}
