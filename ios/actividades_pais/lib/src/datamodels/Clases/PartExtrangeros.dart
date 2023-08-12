class ListaPartExtrangeros {
  List<PartExtrangeros> items = [];
  ListaPartExtrangeros();
  ListaPartExtrangeros.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final listarTrabajador = PartExtrangeros.fromJson(item);
      items.add(listarTrabajador);
    }
  }
}

class PartExtrangeros {
  int id;
  int id_programacion_participante;
  int id_programacion;
  int id_participante;
  String nombre;
  String nombre2;
  String apellidoPaterno;
  String apellidoMaterno;
  int edad;
  String fecha_nacimiento;
  String sexo;
  String pais;
  int idPais;
  String tipo_documento;
  int id_tipo_documento;
  String dni;
  String servicio;
  String entidad;
  String codigoIntervencion;

  PartExtrangeros(
      {this.id = 0,
      this.id_programacion_participante = 0,
      this.id_programacion = 0,
      this.id_participante = 0,
      this.nombre = '',
      this.nombre2 = '',
      this.apellidoPaterno = '',
      this.apellidoMaterno = '',
      this.edad = 0,
      this.fecha_nacimiento = '',
      this.sexo = '',
      this.pais = '',
      this.idPais = 0,
      this.tipo_documento = '',
      this.id_tipo_documento = 0,
      this.dni = '',
      this.entidad = '',
      this.servicio = '',
      this.codigoIntervencion = ''});

  factory PartExtrangeros.fromJson(Map<String, dynamic> json) {
    return PartExtrangeros(
      id: json['id']??0,
      id_programacion_participante: json['id_programacion_participante']??0,
      id_programacion: json['id_programacion']??0,
      id_participante: json['id_participante']??0,
      nombre: json['nombre']??'',
      nombre2: json['nombre2']??'',
      apellidoPaterno: json['apellidoPaterno']??'',
      apellidoMaterno: json['apellidoMaterno']??'',
      edad: json['edad']??0,
      fecha_nacimiento: json['fecha_nacimiento']??'',
      sexo: json['sexo']??'',
      pais: json['pais']??'',
      idPais: json['idPais'],
      tipo_documento: json['tipo_documento']??'',
      id_tipo_documento: json['id_tipo_documento']??0,
      dni: json['dni']??'',
      entidad: json['entidad']??'',
      servicio: json['servicio']??'',
    );
  }

  factory PartExtrangeros.fromMap(Map<String, dynamic> json) => PartExtrangeros(
        id: json['id'],
        id_programacion_participante: json['id_programacion_participante'],
        id_programacion: json['id_programacion'],
        id_participante: json['id_participante'],
        nombre: json['nombre'],
        nombre2: json['nombre2'],
        apellidoPaterno: json['apellidoPaterno'],
        apellidoMaterno: json['apellidoMaterno'],
        edad: json['edad'],
        fecha_nacimiento: json['fecha_nacimiento'],
        sexo: json['sexo'],
        pais: json['pais'],
        idPais: json['idPais'],
        tipo_documento: json['tipo_documento'],
        id_tipo_documento: json['id_tipo_documento'],
        dni: json['dni'],
        entidad: json['entidad'],
        servicio: json['servicio'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['id_programacion_participante'] = id_programacion_participante;
    data['id_programacion'] = id_programacion;
    data['id_participante'] = id_participante;
    data['nombre'] = nombre;
    data['nombre2'] = nombre2;
    data['apellidoPaterno'] = apellidoPaterno;
    data['apellidoMaterno'] = apellidoMaterno;
    data['dni'] = dni;
    data['edad'] = edad;
    data['fecha_nacimiento'] = fecha_nacimiento;
    data['sexo'] = sexo;
    data['pais'] = pais;
    data['idPais'] = idPais;
    data['tipo_documento'] = tipo_documento;
    data['id_tipo_documento'] = id_tipo_documento;
    data['entidad'] = entidad;
    data['servicio'] = servicio;

    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      "id_programacion_participante": id_programacion_participante,
      "pais": pais,
      "idPais": idPais,
      "id_participante": id_participante,
      "tipo_documento": tipo_documento,
      "id_tipo_documento": id_tipo_documento,
      "nombre": nombre,
      "nombre2": nombre2,
      "apellidoPaterno": apellidoPaterno,
      "apellidoMaterno": apellidoMaterno,
      "dni": dni,
      "edad": edad,
      "fecha_nacimiento": fecha_nacimiento,
      "sexo": sexo,
      "entidad": entidad,
      "servicio": servicio,
      "codigoIntervencion": codigoIntervencion
    };
  }
}
