import 'package:actividades_pais/backend/model/dto/response_tambo_servicio_internet_incidencia_dto.dart';

class TamboSrvInterFld {
  static String idTambo = "idTambo";
  static String numSnip = "numSnip";
  static String nombreTambo = "nombreTambo";
  static String nombreCcpp = "nombreCcpp";
  static String ubigeoPrincipal = "ubigeoPrincipal";
  static String longitud = "longitud";
  static String latitud = "latitud";
  static String nombreDepartamento = "nombreDepartamento";
  static String nombreProvincia = "nombreProvincia";
  static String nombreDistrito = "nombreDistrito";
  static String estado = "estado";
  static String cdInternet = "cdInternet";
  static String internet = "internet";
  static String estadoInternet = "estadoInternet";
  static String veloMinBajaPtje = "veloMinBajaPtje";
  static String veloMinSubePtje = "veloMinSubePtje";
  static String tecnologia = "tecnologia";
  static String fecInstalacion = "fecInstalacion";
  static String veloBaja = "veloBaja";
  static String veloSube = "veloSube";
  static String operadorTelefonia = "operadorTelefonia";
  static String estadoTelefonia = "estadoTelefonia";
  static String cdTelefonia = "cdTelefonia";
  static String txtAnexo = "txtAnexo";
  static String txtNumTelefono = "txtNumTelefono";
  static String allinone = "allinone";
  static String txtPlanPiloto = "txtPlanPiloto";
  static String pmhf = "pmhf";
  static String pmlca = "pmlca";
  static String servBasIndispensable = "servBasIndispensable";
  static String tipoConexionElectrica = "tipoConexionElectrica";
  static String proveedorConexionElectrica = "proveedorConexionElectrica";
  static String aincidencia = "aincidencia";
}

class TamboServicioInternetDto {
  int? idTambo = 0;
  int? numSnip = 0;
  String? nombreTambo = "";
  String? nombreCcpp = "";
  String? ubigeoPrincipal = "";
  String? longitud = "";
  String? latitud = "";
  String? nombreDepartamento = "";
  String? nombreProvincia = "";
  String? nombreDistrito = "";
  String? estado = "";
  String? cdInternet = "";
  String? internet = "";
  String? estadoInternet = "";
  String? veloMinBajaPtje = "";
  String? veloMinSubePtje = "";
  String? tecnologia = "";
  String? fecInstalacion = "";
  String? veloBaja = "";
  String? veloSube = "";
  String? operadorTelefonia = "";
  String? estadoTelefonia = "";
  String? cdTelefonia = "";
  String? txtAnexo = "";
  String? txtNumTelefono = "";
  String? allinone = "";
  String? txtPlanPiloto = "";
  String? pmhf = "";
  String? pmlca = "";
  String? servBasIndispensable = "";
  String? tipoConexionElectrica = "";
  String? proveedorConexionElectrica = "";

  /*
  * DATOS DE CENTROS POBLADOS
  */

  List<TamboServicioInternetIncidenciaDto>? aincidencia = [];

  TamboServicioInternetDto.empty();

  TamboServicioInternetDto({
    this.idTambo,
    this.numSnip,
    this.nombreTambo,
    this.nombreCcpp,
    this.ubigeoPrincipal,
    this.longitud,
    this.latitud,
    this.nombreDepartamento,
    this.nombreProvincia,
    this.nombreDistrito,
    this.estado,
    this.cdInternet,
    this.internet,
    this.estadoInternet,
    this.veloMinBajaPtje,
    this.veloMinSubePtje,
    this.tecnologia,
    this.fecInstalacion,
    this.veloBaja,
    this.veloSube,
    this.operadorTelefonia,
    this.estadoTelefonia,
    this.cdTelefonia,
    this.txtAnexo,
    this.txtNumTelefono,
    this.allinone,
    this.txtPlanPiloto,
    this.pmhf,
    this.pmlca,
    this.servBasIndispensable,
    this.tipoConexionElectrica,
    this.proveedorConexionElectrica,
    this.aincidencia,
  });

  factory TamboServicioInternetDto.fromJson(Map<String, dynamic> json) {
    return TamboServicioInternetDto(
      idTambo: json[TamboSrvInterFld.idTambo],
      numSnip: json[TamboSrvInterFld.numSnip],
      nombreTambo: json[TamboSrvInterFld.nombreTambo],
      nombreCcpp: json[TamboSrvInterFld.nombreCcpp],
      ubigeoPrincipal: json[TamboSrvInterFld.ubigeoPrincipal],
      longitud: json[TamboSrvInterFld.longitud],
      latitud: json[TamboSrvInterFld.latitud],
      nombreDepartamento: json[TamboSrvInterFld.nombreDepartamento],
      nombreProvincia: json[TamboSrvInterFld.nombreProvincia],
      nombreDistrito: json[TamboSrvInterFld.nombreDistrito],
      estado: json[TamboSrvInterFld.estado],
      cdInternet: json[TamboSrvInterFld.cdInternet],
      internet: json[TamboSrvInterFld.internet],
      estadoInternet: json[TamboSrvInterFld.estadoInternet],
      veloMinBajaPtje: json[TamboSrvInterFld.veloMinBajaPtje],
      veloMinSubePtje: json[TamboSrvInterFld.veloMinSubePtje],
      tecnologia: json[TamboSrvInterFld.tecnologia],
      fecInstalacion: json[TamboSrvInterFld.fecInstalacion],
      veloBaja: json[TamboSrvInterFld.veloBaja],
      veloSube: json[TamboSrvInterFld.veloSube],
      operadorTelefonia: json[TamboSrvInterFld.operadorTelefonia],
      estadoTelefonia: json[TamboSrvInterFld.estadoTelefonia],
      cdTelefonia: json[TamboSrvInterFld.cdTelefonia],
      txtAnexo: json[TamboSrvInterFld.txtAnexo],
      txtNumTelefono: json[TamboSrvInterFld.txtNumTelefono],
      allinone: json[TamboSrvInterFld.allinone],
      txtPlanPiloto: json[TamboSrvInterFld.txtPlanPiloto],
      pmhf: json[TamboSrvInterFld.pmhf],
      pmlca: json[TamboSrvInterFld.pmlca],
      servBasIndispensable: json[TamboSrvInterFld.servBasIndispensable],
      tipoConexionElectrica: json[TamboSrvInterFld.tipoConexionElectrica],
      proveedorConexionElectrica:
          json[TamboSrvInterFld.proveedorConexionElectrica],
      aincidencia: json[TamboSrvInterFld.aincidencia] != null
          ? (json[TamboSrvInterFld.aincidencia] as List)
              .map((e) => TamboServicioInternetIncidenciaDto.fromJson(e))
              .toList()
          : [],
    );
  }

  static List<TamboServicioInternetIncidenciaDto> parseList(List<dynamic> a) {
    if (a == null) return [];
    List<TamboServicioInternetIncidenciaDto> aListFormat = a
        .map((tagJson) => TamboServicioInternetIncidenciaDto.fromJson(tagJson))
        .toList();
    return aListFormat;
  }
}
