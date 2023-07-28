class ListaModelos {
  List<Modelo> items = [];

  ListaModelos();

  ListaModelos.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final listarasistenciaActual = Modelo.fromJson(item);
      items.add(listarasistenciaActual);
    }
  }
}

class Modelo {
  int? idModelo;
  String? descripcionModelo;
  String? idMarca;

  Modelo({this.idModelo, this.descripcionModelo, this.idMarca});

  Modelo.fromJson(Map<String, dynamic> json) {
    idModelo = json['id_modelo'] ?? 0;
    descripcionModelo = json['descripcion_modelo']?? 0;
    idMarca = json['id_marca']?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_modelo'] = idModelo;
    data['descripcion_modelo'] = descripcionModelo;
    data['id_marca'] = idMarca;
    return data;
  }
}
