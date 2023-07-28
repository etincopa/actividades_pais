class CategorizacionTambosField {
  static String idTambo = "idTambo";
  static String nomTambo = "nomTambo";
  static String region = "region";
  static String snip = "snip";
  static String idCategorizacion = "idCategorizacion";
  static String nomCategorizacion = "nomCategorizacion";
  static String provincia = "provincia";
  static String distrito = "distrito";
}

class CategorizacionTambosModel {
  int? idTambo;
  String? nomTambo;
  String? region;
  String? snip;
  int? idCategoria;
  String? nomCategoria;
  String? provincia;
  String? distrito;

  CategorizacionTambosModel.empty();

  CategorizacionTambosModel(
      {this.idTambo,
      this.nomTambo,
      this.region,
      this.snip,
      this.idCategoria,
      this.nomCategoria,
      this.provincia,
      this.distrito});

  factory CategorizacionTambosModel.fromJson(Map<String, dynamic> json) {
    return CategorizacionTambosModel(
      idTambo: json[CategorizacionTambosField.idTambo],
      nomTambo: json[CategorizacionTambosField.nomTambo],
      region: json[CategorizacionTambosField.region],
      snip: json[CategorizacionTambosField.snip],
      idCategoria: json[CategorizacionTambosField.idCategorizacion],
      nomCategoria: json[CategorizacionTambosField.nomCategorizacion],
      provincia: json[CategorizacionTambosField.provincia],
      distrito: json[CategorizacionTambosField.distrito],
    );
  }
}
