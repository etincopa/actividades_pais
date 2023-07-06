class Actividad {
  String? idActividad;
  String? nombreTipoActividad;
  String? idEntidad;

  Actividad({this.idActividad, this.nombreTipoActividad, this.idEntidad});

  Actividad.fromJson(Map<String, dynamic> json) {
    idActividad = json['id_actividad'];
    nombreTipoActividad = json['nombre_tipo_actividad'];
    idEntidad = json['id_entidad'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_actividad'] = idActividad;
    data['nombre_tipo_actividad'] = nombreTipoActividad;
    data['id_entidad'] = idEntidad;
    return data;
  }
}