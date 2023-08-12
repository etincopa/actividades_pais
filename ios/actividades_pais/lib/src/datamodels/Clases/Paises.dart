class ListarPaises {
  List<Paises> items = [];
  ListarPaises();
  ListarPaises.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final listarTrabajador = Paises.fromJson(item);
      items.add(listarTrabajador);
    }
  }
}

class Paises {
  int idPais;
  String paisNombre;

  Paises({this.idPais = 0, this.paisNombre = ''});

  factory Paises.fromJson(Map<String, dynamic> json) {
    return Paises(idPais: json['id_pais']??0, paisNombre: json['pais_nombre']??'');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_pais'] = idPais;
    data['pais_nombre'] = paisNombre;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      "id_pais": idPais,
      "pais_nombre": paisNombre,
    };
  }
}
