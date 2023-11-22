class ListarSexo {
  List<Sexo> items = [];
  ListarSexo();
  ListarSexo.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final listarTrabajador = Sexo.fromJson(item);
      items.add(listarTrabajador);
    }
  }
}

class Sexo {
  int id;
  String cod;
  String descripcion;
  Sexo({this.id = 0, this.cod = '', this.descripcion = ""});
  factory Sexo.fromJson(Map<String, dynamic> obj) {
    return Sexo(
      id: obj['id'],
      cod: obj['cod'],
      descripcion: obj['descripcion'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "cod": cod,
      "descripcion": descripcion,
    };
  }

  factory Sexo.fromMap(Map<String, dynamic> json) => Sexo(
        id: json['id'],
        cod: json['cod'],
        descripcion: json['descripcion'],
      );
}
