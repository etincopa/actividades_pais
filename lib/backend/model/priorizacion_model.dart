class PriorizacionFld {
  static String idPlataforma = 'idPlataforma';
  static String tipoPriorizacion = 'tipoPriorizacion';
  static String nombrePriorizacion = 'nombrePriorizacion';
  static String abreviatura = 'abreviatura';
}

class PriorizacionModel {
  String? idPlataforma;
  String? tipoPriorizacion;
  String? nombrePriorizacion;
  String? abreviatura;

  PriorizacionModel.empty();

  PriorizacionModel({
    this.idPlataforma,
    this.tipoPriorizacion,
    this.nombrePriorizacion,
    this.abreviatura,
  });

  factory PriorizacionModel.fromJson(Map<String, dynamic> json) {
    return PriorizacionModel(
      idPlataforma: json[PriorizacionFld.idPlataforma],
      tipoPriorizacion: json[PriorizacionFld.tipoPriorizacion],
      nombrePriorizacion: json[PriorizacionFld.nombrePriorizacion],
      abreviatura: json[PriorizacionFld.abreviatura],
    );
  }
}
