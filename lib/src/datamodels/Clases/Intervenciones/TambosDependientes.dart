class ListaTambosDependientes{
  List<TambosDependientes> items = [];

  ListaTambosDependientes();

  ListaTambosDependientes.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final _listarTrabajador = new TambosDependientes.fromJson(item);
      items.add(_listarTrabajador);
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_plataforma'] = this.idPlataforma;
    data['plataforma_descripcion'] = this.plataformaDescripcion;
    data['id_unidades_territoriales'] = this.idUnidadesTerritoriales;
    data['unidad_territorial_descripcion'] = this.unidadTerritorialDescripcion;
    return data;
  }
}