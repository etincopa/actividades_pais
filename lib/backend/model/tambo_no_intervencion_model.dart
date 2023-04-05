class SinIntervencionFld {
  static String idTambo = 'idTambo';
  static String nomTambo = 'nomTambo';
  static String region = 'region';
  static String snip = 'snip';
  static String idProgramacion = 'idProgramacion';
  static String tipoProgramacion = 'tipoProgramacion';
  static String cantidadIntervencionesEjecutadas =
      'cantidadIntervencionesEjecutadas';
}

class SinIntervencionModel {
  int? idTambo = 0;
  String? nomTambo = '';
  String? region = '';
  String? snip = '';
  String? idProgramacion = '';
  String? tipoProgramacion = '';
  int? cantidadIntervencionesEjecutadas = 0;

  SinIntervencionModel.empty() {}

  SinIntervencionModel({
    this.idTambo,
    this.nomTambo,
    this.region,
    this.snip,
    this.idProgramacion,
    this.tipoProgramacion,
    this.cantidadIntervencionesEjecutadas,
  });

  factory SinIntervencionModel.fromJson(Map<String, dynamic> json) {
    return SinIntervencionModel(
      idTambo: json[SinIntervencionFld.idTambo],
      nomTambo: json[SinIntervencionFld.nomTambo],
      region: json[SinIntervencionFld.region],
      snip: json[SinIntervencionFld.snip],
      idProgramacion: json[SinIntervencionFld.idProgramacion],
      tipoProgramacion: json[SinIntervencionFld.tipoProgramacion],
      cantidadIntervencionesEjecutadas:
          json[SinIntervencionFld.cantidadIntervencionesEjecutadas],
    );
  }
}
