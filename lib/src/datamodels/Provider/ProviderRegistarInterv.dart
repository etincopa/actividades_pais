import 'dart:convert';
import 'package:actividades_pais/src/datamodels/Clases/Actividad.dart';
import 'package:actividades_pais/src/datamodels/Clases/Categoria.dart';
import 'package:actividades_pais/src/datamodels/Clases/Convenios.dart';
import 'package:actividades_pais/src/datamodels/Clases/Entidad.dart';
import 'package:actividades_pais/src/datamodels/Clases/Funcionarios.dart';
import 'package:actividades_pais/src/datamodels/Clases/Intervenciones/DatosPlanMensual.dart';
import 'package:actividades_pais/src/datamodels/Clases/Intervenciones/DetalleIntervencion.dart';
import 'package:actividades_pais/src/datamodels/Clases/Intervenciones/FiltroDatosPlanesMensual.dart';
import 'package:actividades_pais/src/datamodels/Clases/Intervenciones/FiltroIntervencionesTambos.dart';
import 'package:actividades_pais/src/datamodels/Clases/Intervenciones/GuardarIntervencion.dart';
import 'package:actividades_pais/src/datamodels/Clases/Intervenciones/HistorialObservaciones.dart';
import 'package:actividades_pais/src/datamodels/Clases/Intervenciones/TambosDependientes.dart';
import 'package:actividades_pais/src/datamodels/Clases/Intervenciones/UnidadesTerritoriales.dart';
import 'package:actividades_pais/src/datamodels/Clases/ListaTipoGobierno.dart';
import 'package:actividades_pais/src/datamodels/Clases/ListarEntidadFuncionario.dart';
import 'package:actividades_pais/src/datamodels/Clases/LugarIntervencion.dart';
import 'package:actividades_pais/src/datamodels/Clases/Participantes.dart';
import 'package:actividades_pais/src/datamodels/Clases/RespuestaApi.dart';
import 'package:actividades_pais/src/datamodels/Clases/Sector.dart';
import 'package:actividades_pais/src/datamodels/Clases/Servicio.dart';
import 'package:actividades_pais/src/datamodels/Clases/Subcategoria.dart';
import 'package:actividades_pais/src/datamodels/Clases/TipoDocumentoAcredita.dart';
import 'package:actividades_pais/src/datamodels/Clases/TipoIntervencion.dart';
import 'package:actividades_pais/src/datamodels/database/DatabasePr.dart';
import 'package:actividades_pais/src/pages/Intervenciones/ProgramarPrestaciones/Event.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:actividades_pais/util/app-config.dart';

import '../Clases/TipoDocumentoAcredita.dart';

class ProviderRegistarInterv {
  List<Evento> eventos = [];
  List<TipoIntervencion> tipoIntervencion = [];
  List<TipoGobierno> tipoGobierno = [];
  List<TipoDocumentoAcredita> tipoDocumentoAcredita = [];

  Future cargarEventos(
      FiltroIntervencionesTambos filtroIntervencionesTambos) async {
    print(jsonEncode(filtroIntervencionesTambos));
    http.Response response = await http.post(
        Uri.parse(AppConfig.backendsismonitor + '/programaciongit/filtro'),
        headers: await headerss(),
        body: '{'
            '"id": "${filtroIntervencionesTambos.id}",'
            '"tipo": "${filtroIntervencionesTambos.tipo}",'
            '"estado": "${filtroIntervencionesTambos.estado}",'
            '"ut": "${filtroIntervencionesTambos.ut}",'
            '"inicio": "${filtroIntervencionesTambos.inicio}",'
            '"fin": "${filtroIntervencionesTambos.fin}",'
            '"mes": "${filtroIntervencionesTambos.mes}",'
            '"anio": ${filtroIntervencionesTambos.anio}'
            '}');
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return eventos = jsonList.map((json) => Evento.fromJson(json)).toList();
    } else {
      return List.empty();
    }
  }

  Future getTipoIntervencion() async {
    http.Response response = await http.get(
        Uri.parse(AppConfig.backendsismonitor +
            '/programaciongit/lista-tipo-intervencion'),
        headers: await headerss());
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return tipoIntervencion =
          jsonList.map((json) => TipoIntervencion.fromJson(json)).toList();
    } else {
      return List.empty();
    }
  }

  Future getlistaTipoGobierno() async {
    http.Response response = await http.get(
        Uri.parse(AppConfig.backendsismonitor +
            '/programaciongit/lista-tipo-gobierno'),
        headers: await headerss());
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return tipoGobierno =
          jsonList.map((json) => TipoGobierno.fromJson(json)).toList();
    } else {
      return List.empty();
    }
  }

  Future<List<Evento>> cargarEventosDesdeAPI() async {
    http.Response response = await http.post(
        Uri.parse(AppConfig.backendsismonitor + '/programaciongit/filtro'),
        headers: await headerss(),
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

  Future listaTipoDocumentoAcredita() async {
    http.Response response = await http.get(
      Uri.parse(AppConfig.backendsismonitor +
          '/programaciongit/lista-tipo-documento/1'),
      headers: await headerss(),
    );
    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      print(jsonResponse);
      return tipoDocumentoAcredita = jsonResponse
          .map((json) => TipoDocumentoAcredita.fromJson(json))
          .toList();
    } else {
      return List.empty();
    }
  }

  Future getListaLugarIntervenciona() async {
    http.Response response = await http.get(
      Uri.parse(AppConfig.backendsismonitor +
          '/programaciongit/lista-lugar-intervencion'),
      headers: await headerss(),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      print(jsonResponse);
      return jsonResponse
          .map((json) => LugarIntervencion.fromJson(json))
          .toList();
    } else {
      return List.empty();
    }
  }

  Future getlistaSector(tpUsuario) async {
    http.Response response = await http.get(
        Uri.parse(AppConfig.backendsismonitor +
            '/programaciongit/lista-sector/$tpUsuario'),
        headers: await headerss());

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      print(jsonList.length);
      return jsonList.map((json) => Sector.fromJson(json)).toList();
    } else {
      return List.empty();
    }
  }

  Future getListarEntidadFuncionario(sector) async {
    http.Response response = await http.get(
        Uri.parse(AppConfig.backendsismonitor +
            '/programaciongit/lista-entidad/$sector'),
        headers: await headerss());
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Entidad.fromJson(json)).toList();
    } else {
      return List.empty();
    }
  }

  Future getListarCategoria(pro) async {
    http.Response response = await http.get(
        Uri.parse(AppConfig.backendsismonitor +
            '/programaciongit/lista-categoria/$pro'),
        headers: await headerss());
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Categoria.fromJson(json)).toList();
    } else {
      return List.empty();
    }
  }

  Future getListarSubcategoria(pro) async {
    http.Response response = await http.get(
        Uri.parse(AppConfig.backendsismonitor +
            '/programaciongit/lista-subcategoria/$pro'),
        headers: await headerss());
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Subcategoria.fromJson(json)).toList();
    } else {
      return List.empty();
    }
  }

  Future getActividad(pro) async {
    http.Response response = await http.get(
        Uri.parse(AppConfig.backendsismonitor +
            '/programaciongit/lista-actividad/$pro'),
        headers: await headerss());
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Actividad.fromJson(json)).toList();
    } else {
      return List.empty();
    }
  }

  Future<List<Servicio>> getServicio(actividad) async {
    print("actividad $actividad");
    http.Response response = await http.get(
        Uri.parse(AppConfig.backendsismonitor +
            '/programaciongit/lista-servicios2/$actividad'),
        headers: await headerss());
    print(response.body);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Servicio.fromJson(json)).toList();
    } else {
      return List.empty();
    }
  }

  //  ListarConvenios(): Observable<any> { return this.http.get(`${environment.backendUrl}programaciongit/listar-convenios`, { headers: Headers() }); }
  Future<List<Convenios>> getListarConvenios() async {
    http.Response response = await http.get(
        Uri.parse(
            AppConfig.backendsismonitor + '/programaciongit/lista-convenios'),
        headers: await headerss());
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Convenios.fromJson(json)).toList();
    } else {
      return List.empty();
    }
  }

  Future<RespuestaApi> getGuardarIntervencions(jsona) async {
    print(json);
    http.Response response = await http.post(
        Uri.parse(AppConfig.backendsismonitor +
            '/programaciongit/guardar-intervencion-movil'),
        headers: await headerss(),
        body: jsona);
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return RespuestaApi.fromJson(jsonResponse);
    } else {
      return RespuestaApi();
    }
  }

  Future getntervencionDetalle(idIntervencion) async {
    print(json);
    http.Response response = await http.get(
        Uri.parse(AppConfig.backendsismonitor +
            '/programaciongit/intervencion-detalle/$idIntervencion'),
        headers: await headerss());
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      print(jsonResponse[0]);
      return jsonResponse[0];
    } else {
      return RespuestaApi();
    }
  }

  Future<List<Accion>> getListaAcciones(idIntervencion) async {
    print(idIntervencion);
    http.Response response = await http.get(
        Uri.parse(AppConfig.backendsismonitor +
            '/programaciongit/lista-acciones/$idIntervencion'),
        headers: await headerss());
    print(response.body);
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      print("jsonList: ${jsonList.length}");
      return jsonList.map((json) => Accion.fromJsonCargarlista(json)).toList();
    } else {
      return List.empty();
    }
  }

  Future<List<Funcionarios>> getListaFuncionarios(
      idIntervencion) async {
    print(idIntervencion);
    http.Response response = await http.get(
        Uri.parse(AppConfig.backendsismonitor +
            '/programaciongit/listar-funcionarios_BD/$idIntervencion'),
        headers: await headerss(),
      );
    print(response.body);
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      print("jsonList: ${jsonList.length}");
      return jsonList.map((json) => Funcionarios.fromJsonTabla(json)).toList();
    } else {
      return List.empty();
    }
  }

  Future<List<Participantes>> getListaParticipantes( idIntervencion, pageIndex, pageSize) async {
    print(idIntervencion);
    http.Response response = await http.post(
        Uri.parse(AppConfig.backendsismonitor +
            '/programaciongit/listar-participantes_BD'),
        headers: await headerss(), body:'''{
    "id": "792034",
    "pageIndex": 1,
    "pageSize": 15
  }
  ''');
    print("aqaqaqaaqa ${response.body}");
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      print("jsonList: ${jsonList.length}");
      return jsonList.map((json) => Participantes.fromJson(json)).toList();
    } else {
      return List.empty();
    }
  }

  headerss() async {
    var logUser = await DatabasePr.db.loginUser();
    var headers = {
      'Authorization': 'Bearer ${logUser[0].token}',
      'Content-Type': 'application/json'
    };
    return headers;
  }
}
