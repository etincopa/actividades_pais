class ListaAtencion {
  List<Atencion> items = [];

  ListaAtencion();

  ListaAtencion.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final listarTrabajador = Atencion.fromJson(item);
      items.add(listarTrabajador);
    }
  }
}

class Atencion {
  int? id;
  int? atendidos;
  int? atenciones;
  int? idParteDiario;
  int? idUsuario;
  String? tipo;
  String? tipoDescripcion;
  String? idUnicoReporte;

  Atencion(
      {this.id,
      this.tipo,
      this.idUsuario,
      this.tipoDescripcion,
      this.atenciones,
      this.idParteDiario,
      this.atendidos,
      this.idUnicoReporte});

  Atencion.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tipo = json['tipo'];
    idUsuario = json['idUsuario'];
    idParteDiario = json['idParteDiario'];
    tipoDescripcion = json['tipoDescripcion'];
    idUnicoReporte = json['idUnicoReporte'];
    atenciones = json['atenciones'];
    atendidos = json['atendidos'];
  }

  factory Atencion.fromMap(Map<String, dynamic> json) => Atencion(
        id: json['id'],
        tipo: json['tipo'],
    idUsuario: json['idUsuario'],
    idParteDiario: json['idParteDiario'],
        tipoDescripcion: json['tipoDescripcion'],
        idUnicoReporte: json['idUnicoReporte'],
        atenciones: json['atenciones'],
        atendidos: json['atendidos'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['tipo'] = tipo;
    data['idUsuario'] = idUsuario;
    data['idParteDiario'] = idParteDiario;
    data['tipoDescripcion'] = tipoDescripcion;
    data['idUnicoReporte'] = idUnicoReporte;
    data['atenciones'] = atenciones;
    data['atendidos'] = atendidos;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      "tipo": tipo,
      "tipoDescripcion": tipoDescripcion,
      "idUnicoReporte": idUnicoReporte,
      "atenciones": atenciones,
      "atendidos": atendidos,
    };
  }
}
