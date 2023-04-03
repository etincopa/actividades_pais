class RespuestaApi {
  bool? estado;
  String? mensaje;

  RespuestaApi({this.estado, this.mensaje});

  RespuestaApi.fromJson(Map<String, dynamic> json) {
    estado = json['estado'];
    mensaje = json['mensaje'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['estado'] = this.estado;
    data['mensaje'] = this.mensaje;
    return data;
  }
}