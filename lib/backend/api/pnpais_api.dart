import 'dart:convert';
import 'dart:io';

import 'package:actividades_pais/backend/model/listar_trama_monitoreo_model.dart';
import 'package:actividades_pais/backend/model/listar_trama_proyecto_model.dart';
import 'package:actividades_pais/helpers/http.dart';
import 'package:actividades_pais/helpers/http_responce.dart';
import 'package:actividades_pais/backend/model/listar_usuarios_app_model.dart';
import 'package:logger/logger.dart';

class PnPaisApi {
  final Http _http;
  final Logger _logger = new Logger();

  static String username = "username";
  static String password = "password";
  static String basicAuth =
      'Basic ' + base64.encode(utf8.encode('${username}:${password}'));

  Map<String, String> headers = {
    HttpHeaders.authorizationHeader: basicAuth,
  };

  PnPaisApi(this._http);

  Future<HttpResponse<List<UserModel>>> listarUsuariosApp() async {
    return await _http.request<List<UserModel>>(
      '/api-pnpais/app/listarUsuariosApp',
      method: "GET",
      //headers: headers,
      parser: (data) {
        return (data as List).map((e) => UserModel.fromJson(e)).toList();
      },
    );
  }

  Future<HttpResponse<List<TramaProyectoModel>>>
      listarTramaProyectoModel() async {
    return await _http.request<List<TramaProyectoModel>>(
      '/api-pnpais/app/listarTramaproyecto',
      method: "GET",
      //headers: headers,
      parser: (data) {
        return (data as List)
            .map((e) => TramaProyectoModel.fromJson(e))
            .toList();
      },
    );
  }

  Future<HttpResponse<List<TramaMonitoreoModel>>> listarTramaMonitoreo() async {
    return await _http.request<List<TramaMonitoreoModel>>(
      '/api-pnpais/app/listarTramaMonitoreo',
      method: "GET",
      //headers: headers,
      parser: (data) {
        return (data as List)
            .map((e) => TramaMonitoreoModel.fromJson(e))
            .toList();
      },
    );
  }

  Future<HttpResponse<TramaMonitoreoModel>> insertarMonitoreo({
    required TramaMonitoreoModel oBody,
  }) {
    return _http.request<TramaMonitoreoModel>(
      '/api-pnpais/app/insertarUsuariosApp',
      method: "POST",
      data: TramaMonitoreoModel.toJsonObject(oBody),
      parser: (data) {
        return TramaMonitoreoModel.fromJson(data);
      },
    );
  }
}
/**
 * SAMPLE USE:
final PnPaisApi _pnPaisApi = PnPaisApi();

final response = await _pnPaisApi.register(
  username: _username,
  email: _email,
  password: _password,
);

if(response != null) {
  print(response.data);
} else {
  print(response.error.message);
}
 */


