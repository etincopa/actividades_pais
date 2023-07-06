class TambosEstadoInternetField {
  static String cantidad = "cantidad";
  static String codigo = "codEstado";
  static String estado = "nomEstado";
}

class TambosEstadoInternetModel {
  int? cantidad;
  String? codigo;
  String? estado;

  TambosEstadoInternetModel.empty();

  TambosEstadoInternetModel({
    this.cantidad,
    this.codigo,
    this.estado,
  });

  factory TambosEstadoInternetModel.fromJson(Map<String, dynamic> json) {
    return TambosEstadoInternetModel(
      cantidad: json[TambosEstadoInternetField.cantidad],
      codigo: json[TambosEstadoInternetField.codigo],
      estado: json[TambosEstadoInternetField.estado],
    );
  }
}
