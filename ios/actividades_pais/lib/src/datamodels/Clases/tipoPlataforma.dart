
class TipoPlataformas {
  List<TipoPlataforma> items = [];
  TipoPlataformas();
  TipoPlataformas.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final listarTrabajador = TipoPlataforma.fromJson(item);
      items.add(listarTrabajador);
    }
  }
}


class TipoPlataforma{
int? id;
String? cod;
String? descripcion;

TipoPlataforma({this.id,this.cod, this.descripcion});
TipoPlataforma.fromJson(Map<String, dynamic> json) {

  id = json['id'];
  cod = json['cod'];
  descripcion = json['descripcion'];
}

Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = id;
  data['cod'] = cod;
  data['descripcion'] = descripcion;
  return data;
}

factory TipoPlataforma.fromMap(Map<String, dynamic> json) => TipoPlataforma(
  id: json['id'],
  cod: json['cod'],
  descripcion: json['descripcion'],
);
Map<String, dynamic> toMap() {
  return {
    "cod": cod,
    "descripcion": descripcion,
  };
}}