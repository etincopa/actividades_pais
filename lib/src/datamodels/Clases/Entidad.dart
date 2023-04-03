class ListarEntidad {
  List<Entidad> items = [];

  ListarEntidad();

  ListarEntidad.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final _listarasistenciaActual =
      new Entidad.fromJson(item);
      items.add(_listarasistenciaActual);
    }
  }
}

class Entidad {
  int id = 0;
  int id_accion_programacion = 0;
  int id_tipo_actividad = 0;
  String nombre_tipo_actividad = '';
  String id_entidad = '';
  String nombre_programa = '';
  int id_programacion = 0;

  Entidad({
    this.id = 0,
    this.id_accion_programacion = 0,
    this.id_tipo_actividad = 0,
    this.nombre_tipo_actividad = '',
    this.id_entidad = '',
    this.nombre_programa = '',
    this.id_programacion =0,
  });

  Map<String, dynamic> toMap() {
    return {
      "id_accion_programacion": id_accion_programacion,
      "id_tipo_actividad": id_tipo_actividad,
      "nombre_tipo_actividad": nombre_tipo_actividad,
      "id_entidad": id_entidad,
      "nombre_programa": nombre_programa,
      "id_programacion": id_programacion,
    };
  }

  factory Entidad.fromJson(Map<String, dynamic> parsedJson) =>
      new Entidad(

        //id: parsedJson['id'],
        id_accion_programacion: parsedJson['id_accion_programacion'],
        id_tipo_actividad: parsedJson['id_tipo_actividad'],
        nombre_tipo_actividad: parsedJson['nombre_tipo_actividad'],
        id_entidad: parsedJson['id_entidad']??'',
        nombre_programa: parsedJson['nombre_programa'],
        id_programacion: parsedJson['id_programacion'],
      );

  Entidad.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    id_accion_programacion = map['id_accion_programacion'];
    id_tipo_actividad = map['id_tipo_actividad'];
    nombre_tipo_actividad = map['nombre_tipo_actividad'];
    id_entidad = map['id_entidad'];
    nombre_programa = map['nombre_programa'];
    id_programacion = map['id_programacion'];
  }
}
