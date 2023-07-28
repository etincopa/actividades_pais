
class ConsultarTambosPiasxUnidadTerritorial {
  String? codResultado;
  String? msgResultado;
  int? total;
  List<RspoTambosPiasxUnidadTerritorial>? response;
  int? idPerfil;

  ConsultarTambosPiasxUnidadTerritorial(
      {this.codResultado,
        this.msgResultado,
        this.total,
        this.response,
        this.idPerfil});

  ConsultarTambosPiasxUnidadTerritorial.fromJson(Map<String, dynamic> json) {
    codResultado = json['codResultado'];
    msgResultado = json['msgResultado'];
    total = json['total'];
    if (json['response'] != null) {
      response = <RspoTambosPiasxUnidadTerritorial>[];
      json['response'].forEach((v) {
        response!.add(RspoTambosPiasxUnidadTerritorial.fromJson(v));
      });
    }
    idPerfil = json['idPerfil'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['codResultado'] = codResultado;
    data['msgResultado'] = msgResultado;
    data['total'] = total;
    if (response != null) {
      data['response'] = response!.map((v) => v.toJson()).toList();
    }
    data['idPerfil'] = idPerfil;
    return data;
  }
}

class RspoTambosPiasxUnidadTerritorial {
  int? idPlataforma;
  int? snip;
  String? ubigeoCcpp;
  String? ubigeoTambo;
  String? nombreDepartamento;
  String? nombreProvincia;
  String? nombreDistrito;
  String? nombreCcpp;
  String? nombreTambo;
  String? clasificacionPais;
  String? poblacionCcpp;
  String? viviendasCcpp;
  String? fuenteCcpp;
  String? prestaServicio;
  String? ambitoInfluencia;
  String? resolucionDirectorial;
  String? xCcpp;
  String? yCcpp;
  double? altitudCcpp;
  String? regionNatural;
  String? rangoRegionNatural;
  String? ubigeoCcppAnterior;
  String? ubigeoDistritoAnterior;
  String? provinciaAnterior;
  String? distritoAnterior;
  String? codCapita;
  String? capital;
  String? codCategoria;
  String? categoria;
  String? codArea;
  String? area;
  String? poblacionAnterior;
  String? viviendasAnterior;
  String? hogaresAnteriores;
  String? ubigeoCreadoUps;
  String? estadoAvanceAnterior;
  String? grupo504;
  String? grupo510;
  int? idDepartamento;
  String? unidadTerritorialDescripcion;
  String? modalidad;

  RspoTambosPiasxUnidadTerritorial(
      {this.idPlataforma,
        this.snip,
        this.ubigeoCcpp,
        this.ubigeoTambo,
        this.nombreDepartamento,
        this.nombreProvincia,
        this.nombreDistrito,
        this.nombreCcpp,
        this.nombreTambo,
        this.clasificacionPais,
        this.poblacionCcpp,
        this.viviendasCcpp,
        this.fuenteCcpp,
        this.prestaServicio,
        this.ambitoInfluencia,
        this.resolucionDirectorial,
        this.xCcpp,
        this.yCcpp,
        this.altitudCcpp,
        this.regionNatural,
        this.rangoRegionNatural,
        this.ubigeoCcppAnterior,
        this.ubigeoDistritoAnterior,
        this.provinciaAnterior,
        this.distritoAnterior,
        this.codCapita,
        this.capital,
        this.codCategoria,
        this.categoria,
        this.codArea,
        this.area,
        this.poblacionAnterior,
        this.viviendasAnterior,
        this.hogaresAnteriores,
        this.ubigeoCreadoUps,
        this.estadoAvanceAnterior,
        this.grupo504,
        this.grupo510,
        this.idDepartamento,
        this.unidadTerritorialDescripcion,
        this.modalidad,
      });

  RspoTambosPiasxUnidadTerritorial.fromJson(Map<String, dynamic> json) {
    idPlataforma = json['idPlataforma'];
    snip = json['snip'];
    ubigeoCcpp = json['ubigeoCcpp'];
    ubigeoTambo = json['ubigeoTambo'];
    nombreDepartamento = json['nombreDepartamento'];
    nombreProvincia = json['nombreProvincia'];
    nombreDistrito = json['nombreDistrito'];
    nombreCcpp = json['nombreCcpp'];
    nombreTambo = json['nombreTambo'];
    clasificacionPais = json['clasificacionPais'];
    poblacionCcpp = json['poblacionCcpp'];
    viviendasCcpp = json['viviendasCcpp'];
    fuenteCcpp = json['fuenteCcpp'];
    prestaServicio = json['prestaServicio'];
    ambitoInfluencia = json['ambitoInfluencia'];
    resolucionDirectorial = json['resolucionDirectorial'];
    xCcpp = json['xCcpp'];
    yCcpp = json['yCcpp'];
    altitudCcpp = json['altitudCcpp'];
    regionNatural = json['regionNatural'];
    rangoRegionNatural = json['rangoRegionNatural'];
    ubigeoCcppAnterior = json['ubigeoCcppAnterior'];
    ubigeoDistritoAnterior = json['ubigeoDistritoAnterior'];
    provinciaAnterior = json['provinciaAnterior'];
    distritoAnterior = json['distritoAnterior'];
    codCapita = json['codCapita'];
    capital = json['capital'];
    codCategoria = json['codCategoria'];
    categoria = json['categoria'];
    codArea = json['codArea'];
    area = json['area'];
    poblacionAnterior = json['poblacionAnterior'];
    viviendasAnterior = json['viviendasAnterior'];
    hogaresAnteriores = json['hogaresAnteriores'];
    ubigeoCreadoUps = json['ubigeoCreadoUps'];
    estadoAvanceAnterior = json['estadoAvanceAnterior'];
    grupo504 = json['grupo504'];
    grupo510 = json['grupo510'];
    idDepartamento = json['idDepartamento'];
    unidadTerritorialDescripcion = json['unidadTerritorialDescripcion'];
    modalidad = json['modalidad'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idPlataforma'] = idPlataforma;
    data['snip'] = snip;
    data['ubigeoCcpp'] = ubigeoCcpp;
    data['ubigeoTambo'] = ubigeoTambo;
    data['nombreDepartamento'] = nombreDepartamento;
    data['nombreProvincia'] = nombreProvincia;
    data['nombreDistrito'] = nombreDistrito;
    data['nombreCcpp'] = nombreCcpp;
    data['nombreTambo'] = nombreTambo;
    data['clasificacionPais'] = clasificacionPais;
    data['poblacionCcpp'] = poblacionCcpp;
    data['viviendasCcpp'] = viviendasCcpp;
    data['fuenteCcpp'] = fuenteCcpp;
    data['prestaServicio'] = prestaServicio;
    data['ambitoInfluencia'] = ambitoInfluencia;
    data['resolucionDirectorial'] = resolucionDirectorial;
    data['xCcpp'] = xCcpp;
    data['yCcpp'] = yCcpp;
    data['altitudCcpp'] = altitudCcpp;
    data['regionNatural'] = regionNatural;
    data['rangoRegionNatural'] = rangoRegionNatural;
    data['ubigeoCcppAnterior'] = ubigeoCcppAnterior;
    data['ubigeoDistritoAnterior'] = ubigeoDistritoAnterior;
    data['provinciaAnterior'] = provinciaAnterior;
    data['distritoAnterior'] = distritoAnterior;
    data['codCapita'] = codCapita;
    data['capital'] = capital;
    data['codCategoria'] = codCategoria;
    data['categoria'] = categoria;
    data['codArea'] = codArea;
    data['area'] = area;
    data['poblacionAnterior'] = poblacionAnterior;
    data['viviendasAnterior'] = viviendasAnterior;
    data['hogaresAnteriores'] = hogaresAnteriores;
    data['ubigeoCreadoUps'] = ubigeoCreadoUps;
    data['estadoAvanceAnterior'] = estadoAvanceAnterior;
    data['grupo504'] = grupo504;
    data['grupo510'] = grupo510;
    data['idDepartamento'] = idDepartamento;
    data['unidadTerritorialDescripcion'] = unidadTerritorialDescripcion;
    data['modalidad'] = modalidad;
    return data;
  }
}