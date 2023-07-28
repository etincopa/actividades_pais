class ListarActividadesPias {
  List<ActividadesPias> items = [];
  ListarActividadesPias();
  ListarActividadesPias.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final listarTrabajador = ActividadesPias.fromJson(item);
      items.add(listarTrabajador);
    }
  }
}

class ActividadesPias {
  int? id;
  String? plataforma;
  String? descripcion;
  String? idUnicoReporte;
  int? idUsuario;
  int? idParteDiario;


  ActividadesPias({this.id,this.plataforma, this.descripcion, this.idUnicoReporte, this.idUsuario, this.idParteDiario});
  ActividadesPias.fromJson(Map<String, dynamic> json) {
    plataforma = json['plataforma'];
    descripcion = json['descripcion'];
    idUnicoReporte = json['idUnicoReporte'];
    idUsuario = json['idUsuario'];
    idParteDiario = json['idParteDiario'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['plataforma'] = plataforma;
    data['descripcion'] = descripcion;
    data['idUnicoReporte'] = idUnicoReporte;
    data['idUsuario'] = idUsuario;
    data['idParteDiario'] = idParteDiario;
    return data;
  }

  factory ActividadesPias.fromMap(Map<String, dynamic> json) => ActividadesPias(
    id: json['id'],
    plataforma: json['cod'],
    descripcion: json['descripcion'],
    idUnicoReporte: json['idUnicoReporte'],
    idUsuario: json['idUsuario'],
    idParteDiario: json['idParteDiario'],
  );
  Map<String, dynamic> toMap() {
    return {
      "plataforma": plataforma,
      "descripcion": descripcion,
      "idUnicoReporte": idUnicoReporte,
    };
  }
}
