import 'dart:convert';
import 'package:actividades_pais/src/datamodels/Clases/Actividad.dart';
import 'package:actividades_pais/src/datamodels/Clases/Categoria.dart';
import 'package:actividades_pais/src/datamodels/Clases/Convenios.dart';
import 'package:actividades_pais/src/datamodels/Clases/Entidad.dart';
import 'package:actividades_pais/src/datamodels/Clases/Funcionarios.dart';
import 'package:actividades_pais/src/datamodels/Clases/Intervenciones/FiltroIntervencionesTambos.dart';
import 'package:actividades_pais/src/datamodels/Clases/Intervenciones/GuardarIntervencion.dart';
import 'package:actividades_pais/src/datamodels/Clases/ListaTipoGobierno.dart';
import 'package:actividades_pais/src/datamodels/Clases/LugarIntervencion.dart';
import 'package:actividades_pais/src/datamodels/Clases/ParticipantesIntranet.dart';
import 'package:actividades_pais/src/datamodels/Clases/RespuestaApi.dart';
import 'package:actividades_pais/src/datamodels/Clases/Sector.dart';
import 'package:actividades_pais/src/datamodels/Clases/Servicio.dart';
import 'package:actividades_pais/src/datamodels/Clases/Subcategoria.dart';
import 'package:actividades_pais/src/datamodels/Clases/TipoDocumentoAcredita.dart';
import 'package:actividades_pais/src/datamodels/Clases/TipoIntervencion.dart';
import 'package:actividades_pais/src/datamodels/database/DatabasePr.dart';
import 'package:actividades_pais/src/pages/Intervenciones/ProgramarPrestaciones/Event.dart';
import 'package:http/http.dart' as http;
import 'package:actividades_pais/util/app-config.dart';


class ProviderRegistarInterv {
  List<Evento> eventos = [];
  List<TipoIntervencion> tipoIntervencion = [];
  List<TipoGobierno> tipoGobierno = [];
  List<TipoDocumentoAcredita> tipoDocumentoAcredita = [];

  Future cargarEventos(
      FiltroIntervencionesTambos filtroIntervencionesTambos) async {
    print(jsonEncode(filtroIntervencionesTambos));
    http.Response response = await http.post(
        Uri.parse('${AppConfig.backendsismonitor}/programaciongit/filtro'),
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
  }  Future cargarEventosTamb(
      FiltroIntervencionesTambos filtroIntervencionesTambos) async {
     http.Response response = await http.post(
        Uri.parse('${AppConfig.backendsismonitor}/programaciongit/filtroTambook'),
        headers:  {
          'Content-Type': 'application/json'
        },
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
        Uri.parse('${AppConfig.backendsismonitor}/programaciongit/lista-tipo-intervencion'),
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
        Uri.parse('${AppConfig.backendsismonitor}/programaciongit/lista-tipo-gobierno'),
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
        Uri.parse('${AppConfig.backendsismonitor}/programaciongit/filtro'),
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
                plataformaCodigoSnip: json['plataforma_codigo_snip'],
                unidadTerritorialDescripcion:
                    json['unidad_territorial_descripcion'],
              ))
          .toList();
    } else {
      throw Exception('Error al cargar eventos desde el API');
    }
  }

  Future listaTipoDocumentoAcredita() async {
    http.Response response = await http.get(
      Uri.parse('${AppConfig.backendsismonitor}/programaciongit/lista-tipo-documento/1'),
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
      Uri.parse('${AppConfig.backendsismonitor}/programaciongit/lista-lugar-intervencion'),
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
        Uri.parse('${AppConfig.backendsismonitor}/programaciongit/lista-sector/$tpUsuario'),
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
        Uri.parse('${AppConfig.backendsismonitor}/programaciongit/lista-entidad/$sector'),
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
        Uri.parse('${AppConfig.backendsismonitor}/programaciongit/lista-categoria/$pro'),
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
        Uri.parse('${AppConfig.backendsismonitor}/programaciongit/lista-subcategoria/$pro'),
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
        Uri.parse('${AppConfig.backendsismonitor}/programaciongit/lista-actividad/$pro'),
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
        Uri.parse('${AppConfig.backendsismonitor}/programaciongit/lista-servicios2/$actividad'),
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
            '${AppConfig.backendsismonitor}/programaciongit/lista-convenios'),
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
        Uri.parse('${AppConfig.backendsismonitor}/programaciongit/guardar-intervencion-movil'),
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
        Uri.parse('${AppConfig.backendsismonitor}/programaciongit/intervencion-detalle/$idIntervencion'),
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
        Uri.parse('${AppConfig.backendsismonitor}/programaciongit/lista-acciones/$idIntervencion'),
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

  Future<List<Funcionarios>> getListaFuncionarios(idIntervencion) async {
    print(idIntervencion);
    http.Response response = await http.get(
      Uri.parse('${AppConfig.backendsismonitor}/programaciongit/listar-funcionarios_BD/$idIntervencion'),
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

  Future<PariticipantesIntranet> getListaParticipantes(
      idIntervencion, pageIndex, pageSize) async {
    http.Response response = await http.post(
        Uri.parse('${AppConfig.backendsismonitor}/programaciongit/listar-participantes_BD'),
        headers: await headerss(),
        body: '''{
    "id": "$idIntervencion",
    "pageIndex": $pageIndex,
    "pageSize": $pageSize
  }
  ''');
    print("aqaqaqaaqa ${response.body}");
    if (response.statusCode == 200) {
      final jsonList = json.decode(response.body);
      final listadostraba = PariticipantesIntranet.fromJson(jsonList);
      return listadostraba;
      // print("jsonList: ${jsonList.length}");
      //  return jsonList.map((json) => PariticipantesIntranet.fromJson(json)).toList();
    } else {
      return PariticipantesIntranet();
    }
  }

  Future<List<Archivo>> getListaImagenes(idIntervencion) async {
    http.Response response = await http.get(
      Uri.parse('${AppConfig.backendsismonitor}/programaciongit/detalle-imagenes/$idIntervencion'),
      headers: await headerss(),
    );
    print("aqaqaqaaqa ${response.body}");
    if (response.statusCode == 200) {
      //  var jsonList = json.decode(response.body);
      List<Archivo> archivos = (jsonDecode(response.body) as List)
          .map((archivoJson) => Archivo.fromJson(archivoJson))
          .toList();
      return archivos;
    } else {
      return List.empty();
    }
  }

  Future Observar(
      {idProgramacion,
      observacion,
      tipoIntervencion,
      descripcion,
      horaInicio,
      horaFin}) async {
    var logUser = await DatabasePr.db.loginUser();
    var headers = {
      'Authorization': 'Bearer ${logUser[0].token}',
      'Content-Type': 'application/json'
    };
    http.Response response = await http.post(
        Uri.parse(
            '${AppConfig.backendsismonitor}/programaciongit/observacion-jut'),
        headers: headers,
        body: '''{
    "tipoIntervencion": $tipoIntervencion,
    "descripcion": "$descripcion",
    "horaInicio": "$horaInicio",
    "horaFin": "$horaFin",
    "observacion": null,
    "observacion_del_jut": null,
    "respuesta_git": null,
    "id_programacion": "$idProgramacion",
    "observacionfinal": "$observacion"
}'''
            '{"id_programacion": "$idProgramacion"');
    if (response.statusCode == 200) {
      return response.statusCode;
    } else {
      return response.statusCode;
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

  Future suspender(idProgramacion, observacion) async {
    var logUser = await DatabasePr.db.loginUser();
    var headers = {
      'Authorization': 'Bearer ${logUser[0].token}',
      'Content-Type': 'application/json'
    };
    print("response 11122121");
    http.Response response = await http.post(
        Uri.parse('${AppConfig.backendsismonitor}/programaciongit/suspender-programacion-actividad'),
        headers: headers,
        body: ''' {
                      "id_programacion": "$idProgramacion",
                      "observacion": "$observacion"
                    }''');

    if (response.statusCode == 200) {
      return response.statusCode;
    } else {
      return response.statusCode;
    }
  }

  Future guardarFecha(
      {id_programacion, fecha, horaInicio, horaFin, lugar_evento}) async {
    var logUser = await DatabasePr.db.loginUser();
    var headers = {
      'Authorization': 'Bearer ${logUser[0].token}',
      'Content-Type': 'application/json'
    };
    print("response 11122121");
    http.Response response = await http.post(
        Uri.parse(
            '${AppConfig.backendsismonitor}/programaciongit/reprogramar-plan'),
        headers: headers,
        body: ''' {
    "fecha": "$fecha",
    "horaInicio": "$horaInicio",
    "horaFin": "$horaFin",
    "tipoIntervencion": "",
    "descripcion": "",
    "documento": "",
    "realizo": "",
    "convocadas": "",
    "lugar_evento": "$lugar_evento",
    "id_programacion": "$id_programacion"
}''');

    if (response.statusCode == 200) {
      return response.statusCode;
    } else {
      return response.statusCode;
    }
  }

  Future<List<Map<String, dynamic>>> fetchActividades() async {
    final response = await http.get(
        Uri.parse(
            'http://192.168.1.45/backendsismonitor/public/programaciongit/lista-tipo-actividad-proggit'),
        headers: await ProviderRegistarInterv().headerss());

    if (response.statusCode == 200) {
      final List<dynamic> decoded = jsonDecode(response.body);
      final List<Map<String, dynamic>> actividades =
          decoded.cast<Map<String, dynamic>>();
      return actividades;
    } else {
      throw Exception('Failed to fetch data');
    }
  }
  Future<List<Map<String, dynamic>>> fetchServicios(idActividad) async {
    final response = await http.get(
        Uri.parse(
            '${AppConfig.backendsismonitor}/programaciongit/lista-servicios-proggit/$idActividad'),
        headers: await ProviderRegistarInterv().headerss());
print("response.bodyy::: ${response.body}");
    if (response.statusCode == 200) {
      final List<dynamic> decoded = jsonDecode(response.body);
      final List<Map<String, dynamic>> actividades =
      decoded.cast<Map<String, dynamic>>();
      return actividades;
    } else {
      throw Exception('Failed to fetch data');
    }
  }
  Future<List<Map<String, dynamic>>> fetchTipogobiernos(idActividad) async {
    final response = await http.get(
        Uri.parse(
            '${AppConfig.backendsismonitor}/programaciongit/lista-tipogobiernos-proggit/$idActividad'),
        headers: await ProviderRegistarInterv().headerss());

    if (response.statusCode == 200) {
      final List<dynamic> decoded = jsonDecode(response.body);
      final List<Map<String, dynamic>> actividades =
      decoded.cast<Map<String, dynamic>>();
      return actividades;
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}

class Archivo {
  final String idArchivo;
  final String idProgramacion;
  final String nombre;
  final String directorio;

  Archivo({
    required this.idArchivo,
    required this.idProgramacion,
    required this.nombre,
    required this.directorio,
  });

  factory Archivo.fromJson(Map<String, dynamic> json) {
    return Archivo(
      idArchivo: json['id_archivo'],
      idProgramacion: json['id_programacion'],
      nombre: json['nombre'],
      directorio: json['directorio'],
    );
  }
}
