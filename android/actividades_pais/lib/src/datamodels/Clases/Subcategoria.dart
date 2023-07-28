class Subcategoria {
  String? idSubcategoria;
  String? nombreSubcategoria;
  String? idEntidad;

  Subcategoria({this.idSubcategoria, this.nombreSubcategoria, this.idEntidad});

  Subcategoria.fromJson(Map<String, dynamic> json) {
    idSubcategoria = json['id_subcategoria'];
    nombreSubcategoria = json['nombre_subcategoria'];
    idEntidad = json['id_entidad'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_subcategoria'] = idSubcategoria;
    data['nombre_subcategoria'] = nombreSubcategoria;
    data['id_entidad'] = idEntidad;
    return data;
  }
}