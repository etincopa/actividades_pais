
class ListaTipoIntervencion {
  List<TipoIntervencion> items = [];
  ListaTipoIntervencion();
  ListaTipoIntervencion.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final _listarTrabajador = new TipoIntervencion.fromJson(item);
      items.add(_listarTrabajador);
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_tipo_intervencion'] = this.idTipoIntervencion;
    data['nombre_tipo_intervencion'] = this.nombreTipoIntervencion;
    return data;
  }
}