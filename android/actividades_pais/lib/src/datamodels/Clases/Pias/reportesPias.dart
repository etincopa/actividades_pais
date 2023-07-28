class ReportesPias {
  int id = 0;
  String fechaParteDiario = '';
  String puntoAtencion = '';
  String codigoUbigeo = '';
  String idPlataforma = '';
  String plataforma = '';
  int idUnidadTerritorial = 0;
  String unidadTerritorial = '';
  String clima = '';
  String idClima = '';
  String detallePuntoAtencion = '';
  String personal = '';
  String estadoEquipos = '';
  String sismonitor = '';
  String idUnicoReporte = '';
  String latitud = '';
  String longitud = '';
  String campania = '';
  int idUsuario=0;
  int idParteDiario=0;

  ReportesPias({
    this.id = 0,
    this.fechaParteDiario = '',
    this.puntoAtencion = '',
    this.codigoUbigeo = '',
    this.idPlataforma = '',
    this.plataforma = '',
    this.idUnidadTerritorial = 0,
    this.unidadTerritorial = '',
    this.clima = '',
    this.idClima = '',
    this.detallePuntoAtencion = '',
    this.personal = '',
    this.estadoEquipos = '',
    this.sismonitor = '',
    this.idUnicoReporte = '',
    this.latitud = '',
    this.longitud = '',
    this.campania = '',
    this.idUsuario =0,
    this.idParteDiario =0,
  });

  ReportesPias.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fechaParteDiario = json['fechaParteDiario'];
    codigoUbigeo = json['codigoUbigeo'];
    idPlataforma = json['idPlataforma'];
    plataforma = json['plataforma'];
    puntoAtencion = json['puntoAtencion'];
    idUnidadTerritorial = json['idUnidadTerritorial'];
    unidadTerritorial = json['unidadTerritorial'];
    clima = json['clima'];
    idClima = json['climaId'];
    detallePuntoAtencion = json['detalle'];
    personal = json['personal'];
    estadoEquipos = json['estadosEquipos'];
    sismonitor = json['sismonitor'];
    idUnicoReporte = json['idUnicoReporte'];
    latitud = json['latitud'];
    longitud = json['longitud'];
    campania = json['campania'];
    idParteDiario = json['idParteDiario'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fechaParteDiario'] = fechaParteDiario;
    data['codigoUbigeo'] = codigoUbigeo;
    data['idPlataforma'] = idPlataforma;
    data['plataforma'] = plataforma;
    data['idUnidadTerritorial'] = idUnidadTerritorial;
    data['unidadTerritorial'] = unidadTerritorial;
    data['clima'] = clima;
    data['idClima'] = idClima;
    data['detallePuntoAtencion'] = detallePuntoAtencion;
    data['personal'] = personal;
    data['estadoEquipos'] = estadoEquipos;
    data['sismonitor'] = sismonitor;
    data['idUnicoReporte'] = idUnicoReporte;
    data['latitud'] = latitud;
    data['longitud'] = longitud;
    data['campania'] = campania;
    data['puntoAtencion'] = puntoAtencion;
    data['idUsuario'] = idUsuario;
    data['idParteDiario'] = idParteDiario;

    return data;
  }

  factory ReportesPias.fromMap(Map<String, dynamic> json) => ReportesPias(
        id: json['id'],
        fechaParteDiario: json['fechaParteDiario'],
        codigoUbigeo: json['codigoUbigeo'],
        idPlataforma: json['idPlataforma'],
        plataforma: json['plataforma'],
        idUnidadTerritorial: json['idUnidadTerritorial'],
        unidadTerritorial: json['unidadTerritorial'],
        clima: json['clima'],
        idClima: json['climaId'],
        detallePuntoAtencion: json['detalle'],
        personal: json['personal'],
        estadoEquipos: json['estadoEquipos'],
        sismonitor: json['sismonitor'],
        idUnicoReporte: json['idUnicoReporte'],
        latitud: json['latitud'],
        longitud: json['longitud'],
        campania: json['campania'],
    idParteDiario: json['idParteDiario'],
      );

  Map<String, dynamic> toMap() {
    return {
      "fechaParteDiario": fechaParteDiario,
      "puntoAtencion": puntoAtencion,
      "codigoUbigeo": codigoUbigeo,
      "idPlataforma": idPlataforma,
      "plataforma": plataforma,
      "idUnidadTerritorial": idUnidadTerritorial,
      "unidadTerritorial": unidadTerritorial,
      "clima": clima,
      "climaId": idClima,
      "detalle": detallePuntoAtencion,
      "personal": personal,
      "estadosEquipos": estadoEquipos,
      "sismonitor": sismonitor,
      "idUnicoReporte": idUnicoReporte,
      "latitud": latitud,
      "longitud": longitud,
      "campania": campania,
      "idParteDiario": idParteDiario,
    };
  }
}
