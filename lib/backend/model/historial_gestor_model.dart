class HistorialGestorField {
  static String snip = "snip";
  static String nombres = "gitNombres";
  static String dni = "gitDni";
  static String fechaInicio = "fechaInicio";
  static String fechaFin = "fechaFin";
}

class HistorialGestorModel {
  String? snip;
  String? nombres;
  String? dni;
  String? fechaInicio;
  String? fechaFin;

  HistorialGestorModel.empty() {}

  HistorialGestorModel({
    this.snip,
    this.nombres,
    this.dni,
    this.fechaInicio,
    this.fechaFin,
  });

  factory HistorialGestorModel.fromJson(Map<String, dynamic> json) {
    return HistorialGestorModel(
      snip: json[HistorialGestorField.snip],
      nombres: json[HistorialGestorField.nombres],
      dni: json[HistorialGestorField.dni],
      fechaInicio: json[HistorialGestorField.fechaInicio],
      fechaFin: json[HistorialGestorField.fechaFin],
    );
  }
}
