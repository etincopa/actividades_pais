class ListaTambosDependientes{
  List<TambosDependientes> items = [];

  ListaTambosDependientes();

  ListaTambosDependientes.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final listarTrabajador = TambosDependientes.fromJson(item);
      items.add(listarTrabajador);
    }
  }
}
class TambosDependientes {
  String? idPlataforma;
  String? plataformaDescripcion;
  String? idUnidadesTerritoriales;
  String? unidadTerritorialDescripcion;

  TambosDependientes(
      {this.idPlataforma,
        this.plataformaDescripcion,
        this.idUnidadesTerritoriales,
        this.unidadTerritorialDescripcion});

  TambosDependientes.fromJson(Map<String, dynamic> json) {
    idPlataforma = json['id_plataforma'];
    plataformaDescripcion = json['plataforma_descripcion'];
    idUnidadesTerritoriales = json['id_unidades_territoriales'];
    unidadTerritorialDescripcion = json['unidad_territorial_descripcion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_plataforma'] = idPlataforma;
    data['plataforma_descripcion'] = plataformaDescripcion;
    data['id_unidades_territoriales'] = idUnidadesTerritoriales;
    data['unidad_territorial_descripcion'] = unidadTerritorialDescripcion;
    return data;
  }
}