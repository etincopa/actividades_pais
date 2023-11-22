class ListaUbicacion {
  List<Ubicacion> items = [];

  ListaUbicacion();

  ListaUbicacion.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final listarasistenciaActual = Ubicacion.fromJson(item);
      items.add(listarasistenciaActual);
    }
  }
}
class Ubicacion {
  String? idUbicacion;
  String? ubicacion;

  Ubicacion({this.idUbicacion, this.ubicacion});

  Ubicacion.fromJson(Map<String, dynamic> json) {
    idUbicacion = json['id_ubicacion']?? '';
    ubicacion = json['ubicacion']?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_ubicacion'] = idUbicacion;
    data['ubicacion'] = ubicacion;
    return data;
  }
}