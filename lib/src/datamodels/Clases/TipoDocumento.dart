class ListarTipoDocumento {
  List<TipoDocumento> items = [];
  ListarTipoDocumento();
  ListarTipoDocumento.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final listarTrabajador = TipoDocumento.fromJson(item);
      items.add(listarTrabajador);
    }
  }
}

class TipoDocumento {
  int id;
  int idTipoDocumento;
  String descripcion;
  TipoDocumento({this.id = 0, this.descripcion = "", this.idTipoDocumento = 0});
  factory TipoDocumento.fromJson(Map<String, dynamic> obj) {
    return TipoDocumento(
      id: obj['id'],
      idTipoDocumento: obj['idTipoDocumento'] ?? 0,
      descripcion: obj['descripcion'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      // "id": id,
      "idTipoDocumento": idTipoDocumento,
      "descripcion": descripcion,
    };
  }

  factory TipoDocumento.fromMap(Map<String, dynamic> json) => TipoDocumento(
        id: json['id'],
        descripcion: json['descripcion'],
        idTipoDocumento: json['idTipoDocumento'],
      );
}
