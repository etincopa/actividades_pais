import 'dart:convert';
import 'dart:io';

import 'package:actividades_pais/backend/model/IncidentesInternetModel.dart';
import 'package:actividades_pais/backend/model/dto/response_base64_file_dto.dart';
import 'package:actividades_pais/backend/model/dto/trama_response_api_dto.dart';
import 'package:actividades_pais/backend/model/lista_trama_monitoreo_detail.dart';
import 'package:actividades_pais/backend/model/listar_combo_item.dart';
import 'package:actividades_pais/backend/model/listar_informacion_tambos.dart';
import 'package:actividades_pais/backend/model/listar_programa_actividad_model.dart';
import 'package:actividades_pais/backend/model/listar_registro_entidad_actividad_model.dart';
import 'package:actividades_pais/backend/model/listar_trama_monitoreo_model.dart';
import 'package:actividades_pais/backend/model/listar_trama_proyecto_model.dart';
import 'package:actividades_pais/backend/model/dto/response_search_tambo_dto.dart';
import 'package:actividades_pais/backend/model/obtener_metas_tambo_model.dart';
import 'package:actividades_pais/backend/model/obtener_ultimo_avance_partida_model.dart';
import 'package:actividades_pais/backend/model/tambo_activida_model.dart';
import 'package:actividades_pais/backend/model/tambo_model.dart';
import 'package:actividades_pais/helpers/http.dart';
import 'package:actividades_pais/helpers/http_responce.dart';
import 'package:actividades_pais/backend/model/listar_usuarios_app_model.dart';

class PnPaisApi {
  final Http _http;
  final String basePathApp = "/api-pnpais/app/";
  final String basePathApp2 = "/api-pnpais/monitoreo/app/";
  final String basePathApp3 = "/api-pnpais/tambook/app/";
  final String basePathApp4 = "/api-pnpais/mapa/app/";

  static String username = "username";
  static String password = "password";
  static String basicAuth =
      'Basic ${base64.encode(utf8.encode('$username:$password'))}';

  Map<String, String> headers = {
    HttpHeaders.authorizationHeader: basicAuth,
  };

  PnPaisApi(this._http);

  Future<HttpResponse<List<UserModel>>> listarUsuariosApp() async {
    return await _http.request<List<UserModel>>(
      '${basePathApp}listarUsuariosApp',
      method: "GET",
      parser: (data) {
        return (data as List).map((e) => UserModel.fromJson(e)).toList();
      },
    );
  }

  Future<HttpResponse<List<TramaProyectoModel>>> listarTramaProyecto() async {
    return await _http.request<List<TramaProyectoModel>>(
      '${basePathApp}listarTramaproyecto',
      method: "GET",
      parser: (data) {
        return (data as List)
            .map((e) => TramaProyectoModel.fromJson(e))
            .toList();
      },
    );
  }

  Future<HttpResponse<List<ComboItemModel>>> listarMaestra(String sType) async {
    return await _http.request<List<ComboItemModel>>(
      '${basePathApp2}listadoComboMonitoreo/$sType',
      method: "GET",
      parser: (data) {
        return (data as List).map((e) => ComboItemModel.fromJson_(e)).toList();
      },
    );
  }

  Future<HttpResponse<List<TramaMonitoreoModel>>> listarTramaMonitoreo() async {
    return await _http.request<List<TramaMonitoreoModel>>(
      '${basePathApp}listarTramaMonitoreo',
      method: "GET",
      parser: (data) {
        return (data as List)
            .map((e) => TramaMonitoreoModel.fromJson(e))
            .toList();
      },
    );
  }

  Future<HttpResponse<List<UltimoAvancePartidaModel>>>
      obtenerUltimoAvancePartida() async {
    return await _http.request<List<UltimoAvancePartidaModel>>(
      '${basePathApp3}obtenerUltimoAvancePartida',
      method: "GET",
      parser: (data) {
        return (data as List)
            .map((e) => UltimoAvancePartidaModel.fromJson(e))
            .toList();
      },
    );
  }

  Future<HttpResponse<List<TramaMonitoreoModel>>>
      listarTramaMonitoreoMovilPaginado(
    TramaMonitoreoModel oBody,
  ) async {
    return await _http.request<List<TramaMonitoreoModel>>(
      '${basePathApp2}listarTramaMonitoreoMovilPaginado',
      method: "POST",
      data: TramaMonitoreoModel.toJsonObjectApi3(oBody),
      parser: (data) {
        return (data as List)
            .map((e) => TramaMonitoreoModel.fromJson(e))
            .toList();
      },
    );
  }

  Future<HttpResponse<TramaRespApiDto>> insertProgramaIntervencion({
    required ProgramacionActividadModel oBody,
  }) async {
    List<Map<String, String>> aFile = [];

    if (oBody.adjuntarArchivo != '') {
      final aImgActividad = oBody.adjuntarArchivo!.split(',');
      for (var oValue in aImgActividad) {
        aFile.add({ProgramacionActividadFields.adjuntarArchivo: oValue.trim()});
      }
    }

    var prog = ProgramacionActividadModel.toJsonObjectApi(oBody);

    var aAct = (oBody.registroEntidadActividades as List)
        .map((e) => RegistroEntidadActividadModel.toJsonObjectApi(e))
        .toList();

    var aActFormat = await formDataList(
      aAct,
      ProgramacionActividadFields.registroEntidadActividades,
    );

    var oBodyFormData = {
      ...prog,
      ...aActFormat,
    };

    return _http.postMultipartFile2<TramaRespApiDto>(
      '${basePathApp}insertarProgramacionActividad',
      data: oBodyFormData,
      aFile: aFile,
      parser: (data) {
        return TramaRespApiDto.fromJson(data);
      },
    );
  }

  /*
   * POST: .../insertarMonitoreo
   */
  Future<HttpResponse<TramaRespApiDto>> insertarMonitoreoP1({
    required TramaMonitoreoModel oBody,
  }) {
    List<Map<String, String>> aFile = [];

    if (oBody.imgProblema != '') {
      final aImgProblema = oBody.imgProblema!.split(',');
      for (var oValue in aImgProblema) {
        aFile.add({MonitorFields.imgProblema: oValue.trim()});
      }
    }

    if (oBody.imgRiesgo != '') {
      final aImgRiesgo = oBody.imgRiesgo!.split(',');
      for (var oValue in aImgRiesgo) {
        aFile.add({MonitorFields.imgRiesgo: oValue.trim()});
      }
    }

    return _http.postMultipartFile2<TramaRespApiDto>(
      '${basePathApp}insertarMonitoreo',
      data: TramaMonitoreoModel.toJsonObjectApi2(oBody),
      aFile: aFile,
      parser: (data) {
        return TramaRespApiDto.fromJson(data);
      },
    );
  }

  /*
   * POST: .../registrarAvanceAcumuladoPartidaMonitereoMovil
   */
  Future<HttpResponse<TramaRespApiDto>> insertarMonitoreoP2({
    required TramaMonitoreoModel oBody,
  }) {
    List<Map<String, String>> aFile = [];

    if (oBody.imgActividad != '') {
      final aImgActividad = oBody.imgActividad!.split(',');
      for (var oValue in aImgActividad) {
        aFile.add({MonitorFields.imgActividad: oValue.trim()});
      }
    }

    return _http.postMultipartFile2<TramaRespApiDto>(
      '${basePathApp2}registrarAvanceAcumuladoPartidaMonitereoMovil',
      data: TramaMonitoreoModel.toJsonObjectApi4(oBody),
      aFile: aFile,
      parser: (data) {
        return TramaRespApiDto.fromJson(data);
      },
    );
  }

  Future<Map<String, String>> formDataList(
    List<Map<String, String>> a,
    String field,
  ) async {
    var index = 0;
    Map<String, String> mapFormData = {};
    for (var o in a) {
      o.forEach((key, value) {
        mapFormData.putIfAbsent('$field[$index].$key', () => value);
      });
      index++;
    }

    return mapFormData;
  }

  Future<HttpResponse<List<BuscarTamboDto>>> searchTambo(
    String? palabra,
  ) async {
    var sFilter = palabra != null ? '/$palabra' : '/';
    return await _http.request<List<BuscarTamboDto>>(
      '${basePathApp3}buscarTamboOrGestor$sFilter',
      method: "GET",
      parser: (data) {
        return (data as List).map((e) => BuscarTamboDto.fromJson(e)).toList();
      },
    );
  }

  Future<HttpResponse<List<MetasTamboModel>>> getMetasTambo(
    String? numSnip,
    String? anio,
    int? xMes,
  ) async {
    DateTime today = DateTime.now();
    String dateStr = "${today.year}";

    var sNumSnip = numSnip != null ? '/$numSnip' : '/';
    var sAnio = anio != null ? '/$anio' : '/$dateStr';
    var sXMes = xMes != null ? '/$xMes' : '/0';

    return await _http.request<List<MetasTamboModel>>(
      '${basePathApp3}obtenerMetasTambo$sNumSnip$sAnio$sXMes',
      method: "GET",
      parser: (data) {
        return (data as List).map((e) => MetasTamboModel.fromJson(e)).toList();
      },
    );
  }

  Future<HttpResponse<List<TamboActividadModel>>>
      tamboIntervencionAtencionIncidencia(
    String? idTambo,
    String? idTipo,
    String? anio,
    String? numMaxRegistro,
  ) async {
    return await _http.request<List<TamboActividadModel>>(
      '${basePathApp3}tamboIntervencionAtencionIncidencia/$idTambo/$idTipo/$anio/$numMaxRegistro',
      method: "GET",
      parser: (data) {
        return (data as List)
            .map((e) => TamboActividadModel.fromJson(e))
            .toList();
      },
    );
  }

  Future<HttpResponse<TamboModel>> tamboDatoGeneral(
    String? idtambo,
  ) async {
    return await _http.request<TamboModel>(
      '${basePathApp3}tamboDatoGeneral/$idtambo',
      method: "GET",
      parser: (data) {
        return TamboModel.fromJson(data);
      },
    );
  }

  Future<HttpResponse<RespBase64FileDto>> getBuildBase64PdfFichaTecnica(
    String idTambo,
  ) async {
    return await _http.request<RespBase64FileDto>(
      '${basePathApp3}buildBase64PdfFichaTecnica/$idTambo',
      method: "GET",
      parser: (data) {
        return RespBase64FileDto.fromJson(data);
      },
    );
  }

  Future<HttpResponse<List<TambosMapaModel>>> getTambosParaMapa() async {
    return await _http.request<List<TambosMapaModel>>(
      '${basePathApp4}listadarBandejaTambosInternet',
      method: "GET",
      parser: (data) {
        var tambosOperativos = (data[0] as List)
            .where((o) => o['estado'] == 'PRESTA SERVICIO')
            .toList();

        return (tambosOperativos as List)
            .map((e) => TambosMapaModel.fromJson(e))
            .toList();
      },
    );
  }

  Future<HttpResponse<List<IncidentesInternetModel>>> getIncidenciasInternet(
    int snip,
  ) async {
    return await _http.request<List<IncidentesInternetModel>>(
      '${basePathApp4}listadarBandejaTambosInternet',
      method: "GET",
      parser: (data) {
        var incidencias = (data[2] as List)
            .where((o) =>
                ((o['estado'] == 'FINALIZADO' || o['estado'] == 'EN PROCESO') &&
                    o['snip_tambo'] == snip))
            .toList();
        return (incidencias as List)
            .map((e) => IncidentesInternetModel.fromJson(e))
            .toList();
      },
    );
  }

  Future<HttpResponse<List<MonitoreoDetailModel>>> getMonitoreoDetail(
    int numSnip,
  ) async {
    return await _http.request<List<MonitoreoDetailModel>>(
      '${basePathApp3}ListaTramaMonitoreoDetail/$numSnip',
      method: "GET",
      parser: (data) {
        return (data as List)
            .map((e) => MonitoreoDetailModel.fromJson(e))
            .toList();
      },
    );
  }
}
