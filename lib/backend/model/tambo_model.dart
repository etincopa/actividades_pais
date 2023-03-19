import 'package:actividades_pais/backend/model/dto/response_tambo_centro_poblado_dto.dart';
import 'package:actividades_pais/backend/model/dto/response_tambo_servicio_internet_dto.dart';

class TamboFld {
  static String idTambo = 'idTambo';
  static String nombreFisicoFoto = 'nombreFisicoFoto';
  static String extensionFoto = 'extensionFoto';
  static String folder = 'folder';
  static String idUT = 'idUnidadesTerritoriales';
  static String fechaCreacionImagen = 'fechaCreacionImagen';
  static String atencion = 'atencion';
  static String intervencion = 'intervencion';
  static String beneficiario = 'beneficiario';
  static String tamboPathImage = 'tamboPathImage';
  static String nombreDepartamento = 'nombreDepartamento';
  static String nombreProvincia = 'nombreProvincia';
  static String nombreDistrito = 'nombreDistrito';
  static String nombreCcpp = 'nombreCcpp';
  static String xCcpp = 'xccpp';
  static String yCcpp = 'yccpp';
  static String altitudCcpp = 'altitudCcpp';
  static String hogaresAnteriores = 'hogaresAnteriores';
  static String viviendasAnterior = 'viviendasAnterior';
  static String poblacionAnterior = 'poblacionAnterior';
  static String nSnip = 'nsnip';
  static String montoAdjudicado = 'montoAdjudicado';
  static String fechaInicioServicio = 'fechaInicioServicio';
  static String gestorId = 'gestorId';
  static String gestorNombre = 'gestorNombre';
  static String gestorApellidos = 'gestorApellidos';
  static String gestorCorreo = 'gestorCorreo';
  static String gestorDocumento = 'gestorDocumento';
  static String gestorFechaNacimiento = 'gestorFechaNacimiento';
  static String gestorSexo = 'gestorSexo';
  static String gestorCargoLaboral = 'gestorCargoLaboral';
  static String gestorDomicilioCcpp = 'gestorDomicilioCcpp';
  static String gestorDomicilioDireccion = 'gestorDomicilioDireccion';
  static String gestorDomicilioReferencia = 'gestorDomicilioReferencia';
  static String gestorRuc = 'gestorRuc';
  static String gestorBrevete = 'gestorBrevete';
  static String gestorEstadoCivil = 'gestorEstadoCivil';
  static String gestorProfession = 'gestorProfession';
  static String gestorGradoAcademico = 'gestorGradoAcademico';
  static String gestorNombreFisicoFoto = 'gestorNombreFisicoFoto';
  static String gestorFotoExtencion = 'gestorFotoExtencion';
  static String gestorTelefono = 'gestorTelefono';
  static String gestorPathImage = 'gestorPathImage';
  static String jefeNombre = 'jefeNombre';
  static String jefeDocumento = 'jefeDocumento';
  static String jefeApellidoPaterno = 'jefeApellidoPaterno';
  static String jefeApellidoMaterno = 'jefeApellidoMaterno';
  static String jefeCorreo = 'jefeCorreo';
  static String jefeTelefono = 'jefeTelefono';
  static String aCentroPoblado = 'acentroPoblado';
  static String oServicioInternet = 'oservicioInternet';
  static String gestorTipoContrato = 'gestorTipoContrato';
}

class TamboModel {
  /*
  * IMAGEN DEL TAMBO
  * */
  int? idTambo;
  String? nombreFisicoFoto;
  String? extensionFoto;
  String? folder;
  String? fechaCreacionImagen;
  String? tamboPathImage;
  int? ut;

  /*
  * DATOS GENERALES
  * */
  String? atencion;
  String? intervencion;
  String? beneficiario;

  /*
  * DATOS DE UBICACIÓN
  */
  String? nombreDepartamento;
  String? nombreProvincia;
  String? nombreDistrito;
  String? nombreCcpp;
  String? xCcpp;
  String? yCcpp;
  String? altitudCcpp;

  /*
  * DATOS DEMOGRÁFICO
  */
  String? hogaresAnteriores;
  String? viviendasAnterior;
  String? poblacionAnterior;

  /*
  * DATOS DE LA OBRA
  */
  int? nSnip;
  String? montoAdjudicado;
  String? fechaInicioServicio;

  /*
  * NUESTRO GESTOR
  */
  int? gestorId;
  String? gestorNombre;
  String? gestorApellidos;
  String? gestorCorreo;
  String? gestorDocumento;
  String? gestorFechaNacimiento;
  String? gestorSexo;
  String? gestorCargoLaboral;
  String? gestorDomicilioCcpp;
  String? gestorDomicilioDireccion;
  String? gestorDomicilioReferencia;
  String? gestorRuc;
  String? gestorBrevete;
  String? gestorEstadoCivil;
  String? gestorProfession;
  String? gestorGradoAcademico;
  String? gestorNombreFisicoFoto;
  String? gestorFotoExtencion;
  String? gestorTelefono;
  String? gestorPathImage;
  String? gestorTipoContrato;

  /*
  * NUESTRO JEFE DE UNIDAD TERRITORIAL
  */
  String? jefeNombre;
  String? jefeDocumento;
  String? jefeApellidoPaterno;
  String? jefeApellidoMaterno;
  String? jefeCorreo;
  String? jefeTelefono;

  /*
  * DATOS DE CENTROS POBLADOS
  */

  List<TamboCentroPobladoDto>? aCentroPoblado = [];
  TamboServicioInternetDto? oServicioInternet = null;

  TamboModel.empty() {}

  TamboModel({
    this.idTambo,
    this.nombreFisicoFoto,
    this.extensionFoto,
    this.folder,
    this.ut,
    this.fechaCreacionImagen,
    this.atencion,
    this.intervencion,
    this.beneficiario,
    this.nombreDepartamento,
    this.nombreProvincia,
    this.nombreDistrito,
    this.nombreCcpp,
    this.xCcpp,
    this.yCcpp,
    this.altitudCcpp,
    this.hogaresAnteriores,
    this.viviendasAnterior,
    this.poblacionAnterior,
    this.nSnip,
    this.montoAdjudicado,
    this.fechaInicioServicio,
    this.gestorId,
    this.gestorNombre,
    this.gestorApellidos,
    this.gestorCorreo,
    this.gestorDocumento,
    this.gestorFechaNacimiento,
    this.gestorSexo,
    this.gestorCargoLaboral,
    this.gestorDomicilioCcpp,
    this.gestorDomicilioDireccion,
    this.gestorDomicilioReferencia,
    this.gestorRuc,
    this.gestorBrevete,
    this.gestorEstadoCivil,
    this.gestorProfession,
    this.gestorGradoAcademico,
    this.gestorNombreFisicoFoto,
    this.gestorFotoExtencion,
    this.gestorTelefono,
    this.jefeNombre,
    this.jefeDocumento,
    this.jefeApellidoPaterno,
    this.jefeApellidoMaterno,
    this.jefeCorreo,
    this.jefeTelefono,
    this.aCentroPoblado,
    this.tamboPathImage,
    this.gestorPathImage,
    this.oServicioInternet,
    this.gestorTipoContrato,
  });

  factory TamboModel.fromJson(Map<String, dynamic> json) {
    return TamboModel(
      idTambo: json[TamboFld.idTambo],
      nombreFisicoFoto: json[TamboFld.nombreFisicoFoto],
      extensionFoto: json[TamboFld.extensionFoto],
      folder: json[TamboFld.folder],
      ut: json[TamboFld.idUT],
      fechaCreacionImagen: json[TamboFld.fechaCreacionImagen],
      atencion: json[TamboFld.atencion],
      intervencion: json[TamboFld.intervencion],
      beneficiario: json[TamboFld.beneficiario],
      nombreDepartamento: json[TamboFld.nombreDepartamento],
      nombreProvincia: json[TamboFld.nombreProvincia],
      nombreDistrito: json[TamboFld.nombreDistrito],
      nombreCcpp: json[TamboFld.nombreCcpp],
      xCcpp: json[TamboFld.xCcpp],
      yCcpp: json[TamboFld.yCcpp],
      altitudCcpp: json[TamboFld.altitudCcpp],
      hogaresAnteriores: json[TamboFld.hogaresAnteriores],
      viviendasAnterior: json[TamboFld.viviendasAnterior],
      poblacionAnterior: json[TamboFld.poblacionAnterior],
      nSnip: json[TamboFld.nSnip],
      montoAdjudicado: json[TamboFld.montoAdjudicado],
      fechaInicioServicio: json[TamboFld.fechaInicioServicio],
      gestorId: json[TamboFld.gestorId],
      gestorNombre: json[TamboFld.gestorNombre],
      gestorApellidos: json[TamboFld.gestorApellidos],
      gestorCorreo: json[TamboFld.gestorCorreo],
      gestorDocumento: json[TamboFld.gestorDocumento],
      gestorFechaNacimiento: json[TamboFld.gestorFechaNacimiento],
      gestorSexo: json[TamboFld.gestorSexo],
      gestorCargoLaboral: json[TamboFld.gestorCargoLaboral],
      gestorDomicilioCcpp: json[TamboFld.gestorDomicilioCcpp],
      gestorDomicilioDireccion: json[TamboFld.gestorDomicilioDireccion],
      gestorDomicilioReferencia: json[TamboFld.gestorDomicilioReferencia],
      gestorRuc: json[TamboFld.gestorRuc],
      gestorBrevete: json[TamboFld.gestorBrevete],
      gestorEstadoCivil: json[TamboFld.gestorEstadoCivil],
      gestorProfession: json[TamboFld.gestorProfession],
      gestorGradoAcademico: json[TamboFld.gestorGradoAcademico],
      gestorNombreFisicoFoto: json[TamboFld.gestorNombreFisicoFoto],
      gestorFotoExtencion: json[TamboFld.gestorFotoExtencion],
      gestorTelefono: json[TamboFld.gestorTelefono],
      jefeNombre: json[TamboFld.jefeNombre],
      jefeDocumento: json[TamboFld.jefeDocumento],
      jefeApellidoPaterno: json[TamboFld.jefeApellidoPaterno],
      jefeApellidoMaterno: json[TamboFld.jefeApellidoMaterno],
      jefeCorreo: json[TamboFld.jefeCorreo],
      jefeTelefono: json[TamboFld.jefeTelefono],
      tamboPathImage: json[TamboFld.tamboPathImage],
      gestorPathImage: json[TamboFld.gestorPathImage],
      aCentroPoblado: json[TamboFld.aCentroPoblado] != null
          ? (json[TamboFld.aCentroPoblado] as List)
              .map((e) => TamboCentroPobladoDto.fromJson(e))
              .toList()
          : [],
      oServicioInternet: json[TamboFld.oServicioInternet] != null
          ? TamboServicioInternetDto.fromJson(json[TamboFld.oServicioInternet])
          : null,
      gestorTipoContrato: json[TamboFld.gestorTipoContrato],
    );
  }

  static List<TamboCentroPobladoDto> parseList(List<dynamic> a) {
    if (a == null) return [];
    List<TamboCentroPobladoDto> aListFormat =
        a.map((tagJson) => TamboCentroPobladoDto.fromJson(tagJson)).toList();
    return aListFormat;
  }
}
