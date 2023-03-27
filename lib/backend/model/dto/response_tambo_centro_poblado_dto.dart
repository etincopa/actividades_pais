class TamboCentroPobladoFld {
  static String nombreCcpp = 'nombreCcpp';
  static String idTambo = 'idTambo';
  static String poblacionCcpp = 'poblacionCcpp';
  static String viviendasCcpp = 'viviendasCcpp';
  static String xCcpp = 'xccpp';
  static String yCcpp = 'yccpp';
  static String altitudCcpp = 'altitudCcpp';
  static String regionCatural = 'regionCatural';
  static String distrito = 'distrito';
}

class TamboCentroPobladoDto {
  int? idTambo;
  String? nombreCcpp;
  String? poblacionCcpp;
  String? viviendasCcpp;
  String? xCcpp;
  String? yCcpp;
  String? altitudCcpp;
  String? regionCatural;
  String? distrito;

  TamboCentroPobladoDto.empty() {}

  TamboCentroPobladoDto({
    this.nombreCcpp,
    this.idTambo,
    this.poblacionCcpp,
    this.viviendasCcpp,
    this.xCcpp,
    this.yCcpp,
    this.distrito,
    this.altitudCcpp,
    this.regionCatural,
  });

  factory TamboCentroPobladoDto.fromJson(Map<String, dynamic> json) {
    return TamboCentroPobladoDto(
      nombreCcpp: json[TamboCentroPobladoFld.nombreCcpp],
      idTambo: json[TamboCentroPobladoFld.idTambo],
      poblacionCcpp: json[TamboCentroPobladoFld.poblacionCcpp],
      viviendasCcpp: json[TamboCentroPobladoFld.viviendasCcpp],
      xCcpp: json[TamboCentroPobladoFld.xCcpp],
      yCcpp: json[TamboCentroPobladoFld.yCcpp],
      altitudCcpp: json[TamboCentroPobladoFld.altitudCcpp],
      regionCatural: json[TamboCentroPobladoFld.regionCatural],
      distrito: json[TamboCentroPobladoFld.distrito],
    );
  }
}
