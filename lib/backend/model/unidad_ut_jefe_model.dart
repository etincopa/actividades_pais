class UnidadTerritorialFld {
  static String idUt = 'idUt';
  static String nombreUt = 'nombreUt';
  static String unidadTerritorialDireccion = 'unidadTerritorialDireccion';
  static String unidadTerritorialPropietario = 'unidadTerritorialPropietario';
  static String departamentoUt = 'departamentoUt';
}

class UnidadTerritorialModel {
  String? idUt;
  String? nombreUt;
  String? unidadTerritorialDireccion;
  String? unidadTerritorialPropietario;
  String? departamentoUt;

  UnidadTerritorialModel.empty() {}

  UnidadTerritorialModel({
    this.idUt,
    this.nombreUt,
    this.unidadTerritorialDireccion,
    this.unidadTerritorialPropietario,
    this.departamentoUt,
  });

  factory UnidadTerritorialModel.fromJson(Map<String, dynamic> json) {
    return UnidadTerritorialModel(
      idUt: json[UnidadTerritorialFld.idUt],
      nombreUt: json[UnidadTerritorialFld.nombreUt],
      unidadTerritorialDireccion:
          json[UnidadTerritorialFld.unidadTerritorialDireccion],
      unidadTerritorialPropietario:
          json[UnidadTerritorialFld.unidadTerritorialPropietario],
      departamentoUt: json[UnidadTerritorialFld.departamentoUt],
    );
  }
}
