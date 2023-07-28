
class ListarUnidadesTablaPlataforma {
  List<UnidadesTablaPlataforma> items = [];
  ListarUnidadesTablaPlataforma();
  ListarUnidadesTablaPlataforma.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final listarasistenciaActual =
          UnidadesTablaPlataforma.fromJson(item);
      items.add(listarasistenciaActual);
    }
  }
}

class UnidadesTablaPlataforma {
  int ID_UNIDAD_TERRITORIAL = 0;
  int SNIP = 0;
  String UBIGEO_CCPP = '';
  String UBIGEO_TAMBO = '';
  String DEPARTAMENTO = '';
  String PROVINCIA = '';
  String DISTRITO = '';
  String CCPP = '';
  String TAMBO = '';
  double LONGITUD = 0;
  double LATITUD = 0;
  int ALTITUD = 0;

  UnidadesTablaPlataforma(
      {this.ID_UNIDAD_TERRITORIAL = 0,
      this.SNIP = 0,
      this.ALTITUD = 0,
      this.CCPP = '',
      this.DEPARTAMENTO = '',
      this.DISTRITO = '',
      this.LATITUD = 0,
      this.LONGITUD = 0,
      this.PROVINCIA = '',
      this.TAMBO = '',
      this.UBIGEO_CCPP = '',
      this.UBIGEO_TAMBO = ''});

  Map<String, dynamic> toMap() {
    return {
      "ID_UNIDAD_TERRITORIAL": ID_UNIDAD_TERRITORIAL,
      "SNIP": SNIP,
      "UBIGEO_CCPP": UBIGEO_CCPP,
      "UBIGEO_TAMBO": UBIGEO_TAMBO,
      "DEPARTAMENTO": DEPARTAMENTO,
      "PROVINCIA": PROVINCIA,
      "DISTRITO": DISTRITO,
      "CCPP": CCPP,
      "TAMBO": TAMBO,
      "LONGITUD": LONGITUD,
      "LATITUD": LATITUD,
      "ALTITUD": ALTITUD,
    };
  }

  factory UnidadesTablaPlataforma.fromJson(Map<String, dynamic> parsedJson) =>
      UnidadesTablaPlataforma(
        ID_UNIDAD_TERRITORIAL: parsedJson['ID_UNIDAD_TERRITORIAL'],
        SNIP: parsedJson['SNIP'],
        UBIGEO_CCPP: parsedJson['UBIGEO_CCPP'],
        UBIGEO_TAMBO: parsedJson['UBIGEO_TAMBO'],
        DEPARTAMENTO: parsedJson['DEPARTAMENTO'],
        PROVINCIA: parsedJson['PROVINCIA'],
        DISTRITO: parsedJson['DISTRITO'],
        CCPP: parsedJson['CCPP'],
        TAMBO: parsedJson['TAMBO'],
        LONGITUD: parsedJson['LONGITUD'],
        LATITUD: parsedJson['LATITUD'],
        ALTITUD: parsedJson['ALTITUD'],
      );

  UnidadesTablaPlataforma.fromMap(Map<String, dynamic> map) {
    ID_UNIDAD_TERRITORIAL = map['ID_UNIDAD_TERRITORIAL'];
    SNIP = map['SNIP'];
    UBIGEO_CCPP = map['UBIGEO_CCPP'];
    UBIGEO_TAMBO = map['UBIGEO_TAMBO'];
    DEPARTAMENTO = map['DEPARTAMENTO'];
    PROVINCIA = map['PROVINCIA'];
    DISTRITO = map['DISTRITO'];
    CCPP = map['CCPP'];
    TAMBO = map['TAMBO'];
    LONGITUD = map['LONGITUD'];
    LATITUD = map['LATITUD'];
    ALTITUD = map['ALTITUD'];
  }
}
