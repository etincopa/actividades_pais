class ImagenJUTField {
  static String idUT = "idUnidadesTerritoriales";
  static String descUT = "unidadTerritorialDescripcion";
  static String idTambo = "idTambo";
  static String snip = "snip";
  static String idEmpleado = "idEmpleado";
  static String nombreFoto = "nombreFoto";
  static String path = "path";
  static String imagenJUT = "imagenJut";
}

class ImagenJUTModel {
  String? idUT;
  String? descUT;
  String? idTambo;
  String? snip;
  String? idEmpleado;
  String? nombreFoto;
  String? path;
  String? imagenJUT;

  ImagenJUTModel.empty() {}

  ImagenJUTModel({
    this.idUT,
    this.descUT,
    this.idTambo,
    this.snip,
    this.idEmpleado,
    this.nombreFoto,
    this.path,
    this.imagenJUT,
  });

  factory ImagenJUTModel.fromJson(Map<String, dynamic> json) {
    return ImagenJUTModel(
      idUT: json[ImagenJUTField.idUT],
      descUT: json[ImagenJUTField.descUT],
      idTambo: json[ImagenJUTField.idTambo],
      snip: json[ImagenJUTField.snip],
      idEmpleado: json[ImagenJUTField.idEmpleado],
      nombreFoto: json[ImagenJUTField.nombreFoto],
      path: json[ImagenJUTField.path],
      imagenJUT: json[ImagenJUTField.imagenJUT],
    );
  }
}
