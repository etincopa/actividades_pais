import 'dart:convert';
import 'package:actividades_pais/src/datamodels/Clases/Intervenciones/DatosPlanMensual.dart';
import 'package:actividades_pais/src/datamodels/Clases/Intervenciones/DetalleIntervencion.dart';
import 'package:actividades_pais/src/datamodels/Clases/Intervenciones/FiltroDatosPlanesMensual.dart';
import 'package:actividades_pais/src/datamodels/Clases/Intervenciones/HistorialObservaciones.dart';
import 'package:actividades_pais/src/datamodels/Clases/Intervenciones/TambosDependientes.dart';
import 'package:actividades_pais/src/datamodels/Clases/Intervenciones/UnidadesTerritoriales.dart';
import 'package:actividades_pais/src/datamodels/Clases/ListaTipoGobierno.dart';
import 'package:actividades_pais/src/datamodels/Clases/TipoIntervencion.dart';
import 'package:actividades_pais/src/datamodels/database/DatabasePr.dart';
import 'package:actividades_pais/src/pages/Intervenciones/ProgramarPrestaciones/Event.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:actividades_pais/util/app-config.dart';

class ProviderRegistarInterv {
  List<Evento> eventos = [];
  List<TipoIntervencion> tipoIntervencion = [];
  List<TipoGobierno> tipoGobierno=[];

  Future cargarEventos() async {
    var logUser = await DatabasePr.db.loginUser();
    var headers = {
      'Authorization': 'Bearer ${logUser[0].token}',
      'Content-Type': 'application/json'
    };

    http.Response response = await http.post(
        Uri.parse(AppConfig.backendsismonitor + '/programaciongit/filtro'),
        headers: headers,
        body: '{'
            '"id": "x",'
            '"tipo": "x",'
            '"estado": "x",'
            '"ut": "x",'
            '"inicio": "",'
            '"fin": "",'
            '"mes": "",'
            '"anio": 2023'
            '}');
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return eventos = jsonList.map((json) => Evento.fromJson(json)).toList();
    } else {
      return List.empty();
    }
  }


  Future getTipoIntervencion() async {
    var logUser = await DatabasePr.db.loginUser();
    var headers = {
      'Authorization': 'Bearer ${logUser[0].token}',
      'Content-Type': 'application/json'
    };

    http.Response response = await http.get(
        Uri.parse(AppConfig.backendsismonitor + '/programaciongit/lista-tipo-intervencion'),
        headers: headers);
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return tipoIntervencion = jsonList.map((json) => TipoIntervencion.fromJson(json)).toList();
    } else {
      return List.empty();
    }
  }

  Future getlistaTipoGobierno() async {
    var logUser = await DatabasePr.db.loginUser();
    var headers = {
      'Authorization': 'Bearer ${logUser[0].token}',
      'Content-Type': 'application/json'
    };

    http.Response response = await http.get(
        Uri.parse(AppConfig.backendsismonitor + '/programaciongit/lista-tipo-gobierno'),
        headers: headers);
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return tipoGobierno = jsonList.map((json) => TipoGobierno.fromJson(json)).toList();
    } else {
      return List.empty();
    }
  }

  Future<List<Evento>> cargarEventosDesdeAPI() async {
    var logUser = await DatabasePr.db.loginUser();
    var headers = {
      'Authorization': 'Bearer ${logUser[0].token}',
      'Content-Type': 'application/json'
    };

    http.Response response = await http.post(
        Uri.parse(AppConfig.backendsismonitor + '/programaciongit/filtro'),
        headers: headers,
        body: '{'
            '"id": "x",'
            '"tipo": "x",'
            '"estado": "x",'
            '"ut": "x",'
            '"inicio": "",'
            '"fin": "",'
            '"mes": "03",'
            '"anio": 2023'
            '}');
    if (response.statusCode == 200) {
      final jsonList = json.decode(response.body) as List<dynamic>;
      return jsonList
          .map((json) => Evento(
                idProgramacion: json['id_programacion'],
                fecha: DateTime.parse(json['fecha']),
                descripcion: json['descripcion'],
                idPlataforma: json['id_plataforma'],
                plataformaDescripcion: json['plataforma_descripcion'],
                tipoProgramacion: json['tipo_programacion'],
                estadoProgramacion: (json['estado_programacion']),
                puntos: json['puntos'],
                idUnidadesTerritoriales: json['id_unidades_territoriales'],
              ))
          .toList();
    } else {
      throw Exception('Error al cargar eventos desde el API');
    }
  }
}
