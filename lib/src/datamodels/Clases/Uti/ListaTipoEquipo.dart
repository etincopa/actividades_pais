class ListarTipoEquipo {
  List<TipoEquipo> items = [];

  ListarTipoEquipo();

  ListarTipoEquipo.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final lista = TipoEquipo.fromJson(item);
      items.add(lista);
    }
  }
}

class TipoEquipo {
  int? idTipoEquipoInformatico;
  String? descripcionTipoEquipoInformatico;

  TipoEquipo(
      {this.idTipoEquipoInformatico, this.descripcionTipoEquipoInformatico});

  TipoEquipo.fromJson(Map<String, dynamic> json) {
    idTipoEquipoInformatico = json['id_tipo_equipo_informatico'] ?? 0;
    descripcionTipoEquipoInformatico =
        json['descripcion_tipo_equipo_informatico'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_tipo_equipo_informatico'] = idTipoEquipoInformatico;
    data['descripcion_tipo_equipo_informatico'] =
        descripcionTipoEquipoInformatico;
    return data;
  }
}
