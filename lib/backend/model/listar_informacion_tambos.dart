class TambosMapaField {
  static int num_snip = 0;
  static double longitud = 0;
  static double latitud = 0;
}

class TambosMapaModel {
  int? num_snip;
  double? longitud;
  double? latitud;

  TambosMapaModel.empty() {}

  TambosMapaModel({this.num_snip, this.longitud, this.latitud});

  factory TambosMapaModel.fromJson(Map<String, dynamic> json) {
    return TambosMapaModel(
        num_snip: json[TambosMapaField.num_snip],
        longitud: json[TambosMapaField.longitud],
        latitud: json[TambosMapaField.latitud]);
  }
}
