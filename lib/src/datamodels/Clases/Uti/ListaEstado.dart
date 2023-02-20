class ListarEstado {
  List<Estado> items = [];

  ListarEstado();

  ListarEstado.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final _lista = new Estado.fromJson(item);
      items.add(_lista);
    }
  }
}

class Estado {
  String? idEstado;
  String? estado;

  Estado({this.idEstado, this.estado});

  Estado.fromJson(Map<String, dynamic> json) {
    idEstado = json['idEstado']??'';
    estado = json['estado']??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idEstado'] = this.idEstado;
    data['estado'] = this.estado;
    return data;
  }
}