class Categoria {
  String? idCategoria;
  String? nombreCategoria;

  Categoria({this.idCategoria, this.nombreCategoria});

  Categoria.fromJson(Map<String, dynamic> json) {
    idCategoria = json['id_categoria'];
    nombreCategoria = json['nombre_categoria'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_categoria'] = this.idCategoria;
    data['nombre_categoria'] = this.nombreCategoria;
    return data;
  }
}