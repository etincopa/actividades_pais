class EstadoGuardar {
  bool? estado;
  String? mensaje;

  EstadoGuardar({this.estado, this.mensaje});

  EstadoGuardar.fromJson(Map<String, dynamic> json) {
    estado = json['estado']??false;
    mensaje = json['mensaje']??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['estado'] = estado;
    data['mensaje'] = mensaje;
    return data;
  }
}