class EstadoGuardar {
  bool? estado;
  String? mensaje;

  EstadoGuardar({this.estado, this.mensaje});

  EstadoGuardar.fromJson(Map<String, dynamic> json) {
    estado = json['estado']??false;
    mensaje = json['mensaje']??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['estado'] = this.estado;
    data['mensaje'] = this.mensaje;
    return data;
  }
}