
class ListaTipoIntervencion {
  List<TipoIntervencion> items = [];
  ListaTipoIntervencion();
  ListaTipoIntervencion.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final listarTrabajador = TipoIntervencion.fromJson(item);
      items.add(listarTrabajador);
    }
  }
}
class TipoIntervencion {
  int? idTipoIntervencion;
  String? nombreTipoIntervencion;

  TipoIntervencion({this.idTipoIntervencion, this.nombreTipoIntervencion});

  TipoIntervencion.fromJson(Map<String, dynamic> json) {
    idTipoIntervencion = json['id_tipo_intervencion'];
    nombreTipoIntervencion = json['nombre_tipo_intervencion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_tipo_intervencion'] = idTipoIntervencion;
    data['nombre_tipo_intervencion'] = nombreTipoIntervencion;
    return data;
  }
}