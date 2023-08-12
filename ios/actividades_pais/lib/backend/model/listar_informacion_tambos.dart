class TambosMapaField {
  static String snip = "num_snip";
  static String longitud = "longitud";
  static String latitud = "latitud";
  static String tambo = "nom_tambo";
  static String departamento = "departamento";
  static String provincia = "provincia";
  static String distrito = "distrito";
  static String localidad = "localidad";
}

class TambosMapaModel {
  int? snip;
  double? longitud;
  double? latitud;
  String? tambo;
  String? departamento;
  String? provincia;
  String? distrito;
  String? localidad;

  TambosMapaModel.empty();

  TambosMapaModel(
      {this.snip,
      this.longitud,
      this.latitud,
      this.tambo,
      this.departamento,
      this.provincia,
      this.distrito,
      this.localidad});

  factory TambosMapaModel.fromJson(Map<String, dynamic> json) {
    return TambosMapaModel(
        snip: json[TambosMapaField.snip],
        longitud: json[TambosMapaField.longitud],
        latitud: json[TambosMapaField.latitud],
        tambo: json[TambosMapaField.tambo],
        departamento: json[TambosMapaField.departamento],
        provincia: json[TambosMapaField.provincia],
        distrito: json[TambosMapaField.distrito],
        localidad: json[TambosMapaField.localidad]);
  }
}
