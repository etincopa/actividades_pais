class TramaIntervenciones {
  List<TramaIntervencion> items = [];
  TramaIntervenciones();
  TramaIntervenciones.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final listarTrabajador = TramaIntervencion.fromJson(item);
      items.add(listarTrabajador);
    }
  }
}

class TramaIntervencion {
  String? codigoIntervencion;
  String? codigoInterno;
  String? snip;
  String? idDepartamento;
  String? departamento;
  String? provincia;
  String? distrito;
  String? tambo;
  String? tipoIntervencion;
  String? identificacionIntervencion;
  String? fecha;
  String? horaInicio;
  String? horaFin;
  String? lugarIntervencion;
  String? tipoGobierno;
  String? sector;
  String? programa;
  String? categoria;
  String? subCategoria;
  String? poblacion;
  String? atencion;
  String? estado;
  String? fechaRegistro;
  String? tipoActividad;
  String? servicio;
  String? beneficiario;
  String? descripcionEvento;
  int? estadoAppMovil;
  String? idTipoIntervencion;

  TramaIntervencion(
      {this.codigoIntervencion,
      this.codigoInterno,
      this.snip,
      this.idDepartamento,
      this.departamento,
      this.provincia,
      this.distrito,
      this.tambo,
      this.tipoIntervencion,
      this.identificacionIntervencion,
      this.fecha,
      this.horaInicio,
      this.horaFin,
      this.lugarIntervencion,
      this.tipoGobierno,
      this.sector,
      this.programa,
      this.categoria,
      this.subCategoria,
      this.poblacion,
      this.atencion,
      this.estado,
      this.fechaRegistro,
      this.tipoActividad,
      this.servicio,
      this.beneficiario,
      this.descripcionEvento,
        this.estadoAppMovil=0,
        this.idTipoIntervencion=""
      });

  TramaIntervencion.fromJson(Map<String, dynamic> json) {
    codigoIntervencion = json['codigoIntervencion'] ;
    codigoInterno = json['codigoInterno'];
    snip = json['snip'];
    idDepartamento = json['id_departamento'];
    departamento = json['departamento'];
    provincia = json['provincia'];
    distrito = json['distrito'];
    tambo = json['tambo'];
    tipoIntervencion = json['tipoIntervencion'];
    identificacionIntervencion = json['identificacionIntervencion'];
    fecha = json['fecha'];
    horaInicio = json['horaInicio'];
    horaFin = json['horaFin'];
    lugarIntervencion = json['lugarIntervencion'];
    tipoGobierno = json['tipoGobierno'];
    sector = json['sector'];
    programa = json['programa'];
    categoria = json['categoria'];
    subCategoria = json['subCategoria'];
    poblacion = json['poblacion'];
    atencion = json['atencion'];
    estado = json['estado'];
    fechaRegistro = json['fechaRegistro'];
    tipoActividad = json['tipoActividad'];
    servicio = json['servicio'];
    beneficiario = json['beneficiario'];
    descripcionEvento = json['descripcion_evento'];
    estadoAppMovil = json['estadoAppMovil'];
    idTipoIntervencion = json['idTipoIntervencion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['codigoIntervencion'] = codigoIntervencion;
    data['codigoInterno'] = codigoInterno;
    data['snip'] = snip;
    data['id_departamento'] = idDepartamento;
    data['departamento'] = departamento;
    data['provincia'] = provincia;
    data['distrito'] = distrito;
    data['tambo'] = tambo;
    data['tipoIntervencion'] = tipoIntervencion;
    data['identificacionIntervencion'] = identificacionIntervencion;
    data['fecha'] = fecha;
    data['horaInicio'] = horaInicio;
    data['horaFin'] = horaFin;
    data['lugarIntervencion'] = lugarIntervencion;
    data['tipoGobierno'] = tipoGobierno;
    data['sector'] = sector;
    data['programa'] = programa;
    data['categoria'] = categoria;
    data['subCategoria'] = subCategoria;
    data['poblacion'] = poblacion;
    data['atencion'] = atencion;
    data['estado'] = estado;
    data['fechaRegistro'] = fechaRegistro;
    data['tipoActividad'] = tipoActividad;
    data['servicio'] = servicio;
    data['beneficiario'] = beneficiario;
    data['descripcion_evento'] = descripcionEvento;
    data['estadoAppMovil'] = estadoAppMovil;
    data['idTipoIntervencion'] = idTipoIntervencion;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      "codigoIntervencion": codigoIntervencion,
      "codigoInterno": codigoInterno,
      "snip": snip,
      "id_departamento": idDepartamento,
      "departamento": departamento,
      "provincia": provincia,
      "distrito": distrito,
      "tambo": tambo,
      "tipoIntervencion": tipoIntervencion,
      "identificacionIntervencion": identificacionIntervencion,
      "fecha": fecha,
      "horaInicio": horaInicio,
      "horaFin": horaFin,
      "lugarIntervencion": lugarIntervencion,
      "tipoGobierno": tipoGobierno,
      "sector": sector,
      "servicio": servicio,
      "programa": programa,
      "categoria": categoria,
      "subCategoria": subCategoria,
      "poblacion": poblacion,
      "atencion": atencion,
      "estado": estado,
      "fechaRegistro": fechaRegistro,
      "tipoActividad": tipoActividad,
      "beneficiario": beneficiario,
      "descripcion_evento": descripcionEvento,
      "estadoAppMovil": estadoAppMovil,
      "idTipoIntervencion": idTipoIntervencion,
    };
  }

  factory TramaIntervencion.fromMap(Map<String, dynamic> json) =>
      TramaIntervencion(
        codigoIntervencion: json['codigoIntervencion'],
        codigoInterno: json['codigoInterno'],
        snip: json['snip'],
        idDepartamento: json['id_departamento'],
        departamento: json['departamento'],
        provincia: json['provincia'],
        distrito: json['distrito'],
        tambo: json['tambo'],
        tipoIntervencion: json['tipoIntervencion'],
        identificacionIntervencion: json['identificacionIntervencion'],
        fecha: json['fecha'],
        horaInicio: json['horaInicio'],
        horaFin: json['horaFin'],
        lugarIntervencion: json['lugarIntervencion'],
        tipoGobierno: json['tipoGobierno'],
        sector: json['sector'],
        programa: json['programa'],
        categoria: json['categoria'],
        subCategoria: json['subCategoria'],
        poblacion: json['poblacion'],
        atencion: json['atencion'],
        estado: json['estado'],
        fechaRegistro: json['fechaRegistro'],
        tipoActividad: json['tipoActividad'],
        servicio: json['servicio'],
        beneficiario: json['beneficiario'],
        descripcionEvento: json['descripcion_evento'],
        estadoAppMovil: json['estadoAppMovil'],
        idTipoIntervencion: json['idTipoIntervencion'],
      );
}
