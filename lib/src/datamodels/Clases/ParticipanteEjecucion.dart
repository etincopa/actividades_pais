// ignore_for_file: non_constant_identifier_names

class ParticipanteEjecucions {
  List<ParticipanteEjecucion> items = [];

  ParticipanteEjecucions();

  ParticipanteEjecucions.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final listarTrabajador = ParticipanteEjecucion.fromJson(item);
      items.add(listarTrabajador);
    }
  }
}

class ParticipanteEjecucion {
  int? id_entidad;
  int? id_servicio;
  String? nombre_servicio;
  int? id_programacion;

  ParticipanteEjecucion(
      {this.id_entidad,
      this.id_servicio,
      this.nombre_servicio,
      this.id_programacion});

  ParticipanteEjecucion.fromJson(Map<String, dynamic> json) {
    id_entidad = json['id_entidad'];
    id_servicio = json['id_servicio'];
    nombre_servicio = json['nombre_servicio'];
    id_programacion = json['id_programacion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_entidad'] = id_entidad;
    data['id_servicio'] = id_servicio;
    data['nombre_servicio'] = nombre_servicio;
    data['id_programacion'] = id_programacion;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      "id_entidad": id_entidad,
      "id_servicio": id_servicio,
      "nombre_servicio": nombre_servicio,
      "id_programacion": id_programacion
    };
  }

  factory ParticipanteEjecucion.fromMap(Map<String, dynamic> json) =>
      ParticipanteEjecucion(
        id_entidad: json['id_entidad'],
        id_servicio: json['id_servicio'],
        nombre_servicio: json['nombre_servicio'],
        id_programacion: json['id_programacion'],
      );
}
