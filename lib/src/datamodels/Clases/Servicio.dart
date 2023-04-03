class Servicio {
  String? idServicio;
  String? nombreServicio;
  String? idActividad;

  Servicio({this.idServicio, this.nombreServicio, this.idActividad});

  Servicio.fromJson(Map<String, dynamic> json) {
    idServicio = json['id_servicio'];
    nombreServicio = json['nombre_servicio'];
    idActividad = json['id_actividad'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_servicio'] = this.idServicio;
    data['nombre_servicio'] = this.nombreServicio;
    data['id_actividad'] = this.idActividad;
    return data;
  }
}