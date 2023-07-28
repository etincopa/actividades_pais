class ListaUnidadesTerritoriales{
  List<UnidadesTerritoriales> items = [];

  ListaUnidadesTerritoriales();

  ListaUnidadesTerritoriales.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final listarTrabajador = UnidadesTerritoriales.fromJson(item);
      items.add(listarTrabajador);
    }
  }
}

class UnidadesTerritoriales {
  int? idUnidadesTerritoriales;
  String? unidadTerritorialDescripcion;

  UnidadesTerritoriales({this.idUnidadesTerritoriales, this.unidadTerritorialDescripcion});

  UnidadesTerritoriales.fromJson(Map<String, dynamic> json) {
    idUnidadesTerritoriales = json['id_unidades_territoriales']??0;
    unidadTerritorialDescripcion = json['unidad_territorial_descripcion']??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_unidades_territoriales'] = idUnidadesTerritoriales;
    data['unidad_territorial_descripcion'] = unidadTerritorialDescripcion;
    return data;
  }
}