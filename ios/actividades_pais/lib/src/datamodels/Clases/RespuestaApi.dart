class RespuestaApi {
  bool? estado;
  String? mensaje;

  RespuestaApi({this.estado, this.mensaje});

  RespuestaApi.fromJson(Map<String, dynamic> json) {
    estado = json['estado'];
    mensaje = json['mensaje'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['estado'] = estado;
    data['mensaje'] = mensaje;
    return data;
  }
}