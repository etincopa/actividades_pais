class IndicadorCategorizacionField {
  static String idPriorizacion = "idPriorizacion";
  static String nomPriorizacion = "nomPriorizacion";
  static String numAsignados = "numAsignados";
}

class IndicadorCategorizacionModel {
  int? idPriorizacion;
  String? nomPriorizacion;
  int? numAsignados;

  IndicadorCategorizacionModel.empty() {}

  IndicadorCategorizacionModel({
    this.idPriorizacion,
    this.nomPriorizacion,
    this.numAsignados,
  });

  factory IndicadorCategorizacionModel.fromJson(Map<String, dynamic> json) {
    return IndicadorCategorizacionModel(
      idPriorizacion: json[IndicadorCategorizacionField.idPriorizacion],
      nomPriorizacion: json[IndicadorCategorizacionField.nomPriorizacion],
      numAsignados: json[IndicadorCategorizacionField.numAsignados],
    );
  }
}
