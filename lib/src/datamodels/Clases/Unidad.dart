class ListarUnidad {
  List<Unidad> items = [];

  ListarUnidad();

  ListarUnidad.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final listar = Unidad.fromJson(item);
      items.add(listar);
    }
  }
}

class Unidad {
  int id;
  String descripcion;

  Unidad({this.id = 0, this.descripcion = ""});

  factory Unidad.fromJson(Map<String, dynamic> obj) {
    return Unidad(
      id: obj['id'],
      descripcion: obj['descripcion'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "descripcion": descripcion,
    };
  }

  factory Unidad.fromMap(Map<String, dynamic> json) => Unidad(
        id: json['id'],
        descripcion: json['descripcion'],
      );
}
