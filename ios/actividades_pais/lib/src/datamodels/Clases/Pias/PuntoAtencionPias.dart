class ListaPuntoAtencionPias {
  List<PuntoAtencionPias> items = [];

  ListaPuntoAtencionPias();

  ListaPuntoAtencionPias.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final listarTrabajador = PuntoAtencionPias.fromJson(item);
      items.add(listarTrabajador);
    }
  }
}

class PuntoAtencionPias {
  String? codigoUbigeo;
  int? idCampania;
  int? idPias;
  String? pias;
  String? puntoAtencion;
  String? latitud;
  String? longitud;
  int? anio;
  int? id;

  PuntoAtencionPias({
    this.codigoUbigeo = '',
    this.idCampania =0,
    this.idPias=0,
    this.pias='',
    this.puntoAtencion='',
    this.latitud='',
    this.longitud='',
    this.anio=0,
    this.id=0,
  });

  PuntoAtencionPias.fromJson(Map<String, dynamic> json) {
    codigoUbigeo = json['codigo_ubigeo'];
    idCampania = json['id_campania'];
    idPias = json['id_pias'];
    pias = json['pias'];
    puntoAtencion = json['punto_atencion'];
    latitud = json['latitud'];
    longitud = json['longitud'];
    anio = json['añ011o'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['codigo_ubigeo'] = codigoUbigeo;
    data['id_campania'] = idCampania;
    data['id_pias'] = idPias;
    data['pias'] = pias;
    data['punto_atencion'] = puntoAtencion;
    data['latitud'] = latitud;
    data['longitud'] = longitud;
    data['anio'] = anio;
    data['id'] = id;
    return data;
  }

  factory PuntoAtencionPias.fromMap(Map<String, dynamic> json) =>
      PuntoAtencionPias(
        codigoUbigeo: json['codigoUbigeo'],
        idCampania: json['id_campania'],
        idPias: json['idPias'],
        pias: json['pias'],
        puntoAtencion: json['puntoAtencion'],
        latitud: json['latitud'],
        longitud: json['longitud'],
        anio: json['anio'],
        id: json['id'],
      );

  Map<String, dynamic> toMap() {
    return {
      "codigoUbigeo": codigoUbigeo,
      "idCampania": idCampania,
      "idPias": idPias,
      "pias": pias,
      "puntoAtencion": puntoAtencion,
      "latitud": latitud,
      "longitud": longitud,
      "anio": anio,
    };
  }
}
