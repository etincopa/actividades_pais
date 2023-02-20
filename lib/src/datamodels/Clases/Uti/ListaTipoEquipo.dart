class ListarTipoEquipo {
  List<TipoEquipo> items = [];

  ListarTipoEquipo();

  ListarTipoEquipo.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final _lista = new TipoEquipo.fromJson(item);
      items.add(_lista);
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_tipo_equipo_informatico'] = this.idTipoEquipoInformatico;
    data['descripcion_tipo_equipo_informatico'] =
        this.descripcionTipoEquipoInformatico;
    return data;
  }
}
