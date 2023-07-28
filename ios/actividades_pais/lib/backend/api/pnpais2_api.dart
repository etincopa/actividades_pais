import 'dart:convert';
import 'dart:io';

import 'package:actividades_pais/backend/model/dto/dropdown_dto.dart';
import 'package:actividades_pais/backend/model/dto/login_dto.dart';
import 'package:actividades_pais/backend/model/dto/response_program_dto.dart';
import 'package:actividades_pais/backend/model/dto/response_token_dto.dart';
import 'package:actividades_pais/backend/model/programa_actividad_model.dart';
import 'package:actividades_pais/backend/model/dto/response_search_tambo_dto.dart';
import 'package:actividades_pais/backend/service/main_serv.dart';
import 'package:actividades_pais/helpers/http.dart';
import 'package:actividades_pais/helpers/http_responce.dart';
import 'package:actividades_pais/util/throw-exception.dart';

class PnPaisApi2 {
  final Http _http;
  final String basePathTambook = "/tambook/tambo/default/";
  final String basePathSec = "/backendsismonitor/public/seguridad/";
  final String basePathProg = "/backendsismonitor/public/programacionjut/";

  static String username = "username";
  static String password = "password";
  static String basicAuth =
      'Basic ${base64.encode(utf8.encode('$username:$password'))}';

  Map<String, String> headers = {
    HttpHeaders.authorizationHeader: basicAuth,
  };

  PnPaisApi2(this._http);

  Future<HttpResponse<List<BuscarTamboDto>>> searchTambo(String? palabra) async {
    var sFilter = palabra != null ? '?term=$palabra' : '';
    return await _http.request<List<BuscarTamboDto>>(
      '${basePathTambook}buscarportambo$sFilter',
      method: "GET",
      parser: (data) {
        return (data as List).map((e) => BuscarTamboDto.fromJson(e)).toList();
      },
    );
  }

  /*
   * POST: .../login
   */
  Future<HttpResponse<RespTokenDto>> postLogin(
    LoginDto oBody,
  ) async {
    return await _http.request<RespTokenDto>(
      '${basePathSec}login',
      method: "POST",
      data: LoginDto.toJsonObjectApi(oBody),
      parser: (data) {
        return RespTokenDto.fromJson(data);
      },
    );
  }

  Future<Map<String, String>> getHeader() async {
    RespTokenDto oResp = await MainService().getToken();

    Map<String, String> o = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer ${oResp.token}'
    };
    return o;
  }

  Future<HttpResponse<List<CombosDto>>> getListDropDown(
    String resource, {
    int? key,
  }) async {
    String sResource = '';
    if (resource == CombosDto.cbCod001) {
      sResource = resource;
    } else if (resource == CombosDto.cbCod002) {
      sResource = '$resource/$key';
    } else if (resource == CombosDto.cbCod003) {
      sResource = '$resource/$key';
    } else if (resource == CombosDto.cbCod004) {
      sResource = resource;
    } else if (resource == CombosDto.cbCod005) {
      sResource = resource;
    } else if (resource == CombosDto.cbCod006) {
      sResource = resource;
    } else {
      throw ThrowCustom(
        type: 'E',
        msg:
            'No se encontro el recurso para ejecutar la solicitud del servicio REST.',
      );
    }

    return await _http.request<List<CombosDto>>(
      '$basePathProg$sResource',
      method: "GET",
      headers: await getHeader(),
      parser: (data) {
        return (data as List)
            .map((e) => CombosDto.fromJson(e, type: resource))
            .toList();
      },
    );
  }

  /*
   * POST: .../programacion-coordinacion
   */
  Future<HttpResponse<ProgramRespDto>> postCoordinacionArticulacion(
    ProgActModel oBody,
  ) async {
    return await _http.request<ProgramRespDto>(
      '${basePathProg}programacion-coordinacion',
      method: "POST",
      headers: await getHeader(),
      data: ProgActModel.toJsonObjectApi1(oBody),
      parser: (data) {
        return ProgramRespDto.fromJson(data);
      },
    );
  }

  /*
   * POST: .../programacion-monitoreo
   */
  Future<HttpResponse<ProgramRespDto>> postMonitoreoSupervision(
    ProgActModel oBody,
  ) async {
    return await _http.request<ProgramRespDto>(
      '${basePathProg}programacion-monitoreo',
      method: "POST",
      headers: await getHeader(),
      data: ProgActModel.toJsonObjectApi2(oBody),
      parser: (data) {
        return ProgramRespDto.fromJson(data);
      },
    );
  }

  /*
   * POST: .../programacion-actividad
   */
  Future<HttpResponse<ProgramRespDto>> postActividadesPNPAIS(
    ProgActModel oBody,
  ) async {
    return await _http.request<ProgramRespDto>(
      '${basePathProg}programacion-actividad',
      method: "POST",
      headers: await getHeader(),
      data: ProgActModel.toJsonObjectApi3(oBody),
      parser: (data) {
        return ProgramRespDto.fromJson(data);
      },
    );
  }
}
