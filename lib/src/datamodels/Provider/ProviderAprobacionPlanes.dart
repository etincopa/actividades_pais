import 'dart:convert';
import 'package:actividades_pais/src/datamodels/Clases/Intervenciones/DatosPlanMensual.dart';
import 'package:actividades_pais/src/datamodels/Clases/Intervenciones/DetalleIntervencion.dart';
import 'package:actividades_pais/src/datamodels/Clases/Intervenciones/FiltroDatosPlanesMensual.dart';
import 'package:actividades_pais/src/datamodels/Clases/Intervenciones/HistorialObservaciones.dart';
import 'package:actividades_pais/src/datamodels/Clases/Intervenciones/TambosDependientes.dart';
import 'package:actividades_pais/src/datamodels/Clases/Intervenciones/UnidadesTerritoriales.dart';
import 'package:actividades_pais/src/datamodels/database/DatabasePr.dart';
import 'package:http/http.dart' as http;
import 'package:actividades_pais/util/app-config.dart';

class ProviderAprobacionPlanes {
  Future<List<DatosPlanMensual>>? ListarAprobacionPlanTrabajo(
      FiltroDataPlanMensual filtro) async {
    var logUser = await DatabasePr.db.loginUser();
    var headers = {
      'Authorization': 'Bearer ${logUser[0].token}',
      'Content-Type': 'application/json'
    };

    print(json.encode(filtro));
    http.Response response = await http.post(
        Uri.parse(AppConfig.backendsismonitor +
            '/programaciongit/datos-plan-mensual'),
        headers: headers,
        body: json.encode(filtro));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final listado =
          new ListaDatosPlanMensual.fromJsonList(jsonResponse["data"]);
      return listado.items;
    } else {
      return List.empty();
    }
  }

  Future<DetalleIntervencion> DetalleIntervencionService(idProgramacion) async {
    var logUser = await DatabasePr.db.loginUser();
    var headers = {
      'Authorization': 'Bearer ${logUser[0].token}',
      'Content-Type': 'application/json'
    };
    print(Uri.parse(AppConfig.backendsismonitor +
        '/programaciongit/datosparaevaluar/$idProgramacion'));
    http.Response response = await http.get(
      Uri.parse(AppConfig.backendsismonitor +
          '/programaciongit/datosparaevaluar/$idProgramacion'),
      headers: headers,
    );

    print(response);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      print(jsonResponse[0]);
      final listado = new DetalleIntervencion.fromJson(jsonResponse[0]);

      return listado;
    } else {
      return DetalleIntervencion();
    }
  }

  Future Aprobar({idProgramacion}) async {
    var logUser = await DatabasePr.db.loginUser();
    var headers = {
      'Authorization': 'Bearer ${logUser[0].token}',
      'Content-Type': 'application/json'
    };
    http.Response response = await http.post(
        Uri.parse(AppConfig.backendsismonitor +
            '/programaciongit/aprobandointervencion'),
        headers: headers,
        body: '{"id_programacion": "$idProgramacion"}');
    if (response.statusCode == 200) {
      return response.statusCode;
    } else {
      return response.statusCode;
    }
  }

  Future Observar({idProgramacion, observacion}) async {
    var logUser = await DatabasePr.db.loginUser();
    var headers = {
      'Authorization': 'Bearer ${logUser[0].token}',
      'Content-Type': 'application/json'
    };
    http.Response response = await http.post(
        Uri.parse(AppConfig.backendsismonitor +
            '/programaciongit/observandointervencion'),
        headers: headers,
        body:
            '{"id_programacion": "$idProgramacion","observacion":"$observacion"}');
    if (response.statusCode == 200) {
      return response.statusCode;
    } else {
      return response.statusCode;
    }
  }

  Future<List<Historialobservaciones>>? ListarHistorialobservaciones(
      {idProgramacion}) async {
    var logUser = await DatabasePr.db.loginUser();
    var headers = {
      'Authorization': 'Bearer ${logUser[0].token}',
      'Content-Type': 'application/json'
    };
    http.Response response = await http.get(
      Uri.parse(AppConfig.backendsismonitor +
          '/programaciongit/historialobservaciones/$idProgramacion'),
      headers: headers,
    );
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final listado =
          new ListaHistorialobservaciones.fromJsonList(jsonResponse);
      return listado.items;
    } else {
      return List.empty();
    }
  }

  Future<List<Historialobservaciones>>? ListarHistorialSubsanacion(
      {idProgramacion}) async {
    var logUser = await DatabasePr.db.loginUser();
    var headers = {
      'Authorization': 'Bearer ${logUser[0].token}',
      'Content-Type': 'application/json'
    };
    http.Response response = await http.get(
      Uri.parse(AppConfig.backendsismonitor +
          '/programaciongit/historialsubsanacion/$idProgramacion'),
      headers: headers,
    );
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final listado =
          new ListaHistorialobservaciones.fromJsonList(jsonResponse);
      return listado.items;
    } else {
      return List.empty();
    }
  }

  Future<List<UnidadesTerritoriales>>? ListarUnidadesTerritoriales() async {
    var logUser = await DatabasePr.db.loginUser();
    var headers = {
      'Authorization': 'Bearer ${logUser[0].token}',
      'Content-Type': 'application/json'
    };
    http.Response response = await http.get(
      Uri.parse(AppConfig.backendsismonitor +
          '/programaciongit/Listar-unidades-territoriales'),
      headers: headers,
    );
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final listado =
          new ListaUnidadesTerritoriales.fromJsonList(jsonResponse["lista"]);
      print(listado.items[0].idUnidadesTerritoriales);
      return listado.items;
    } else {
      return List.empty();
    }
  }

  Future<List<TambosDependientes>>? ListarTambosDependientes(ut) async {
    var logUser = await DatabasePr.db.loginUser();
    var headers = {
      'Authorization': 'Bearer ${logUser[0].token}',
      'Content-Type': 'application/json'
    };
    if (ut != "x") {
      http.Response response = await http.get(
        Uri.parse(AppConfig.backendsismonitor +
            '/programaciongit/ListarTambosDependientes/$ut'),
        headers: headers,
      );
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final listado = new ListaTambosDependientes.fromJsonList(jsonResponse);
        print(listado.items[0].idUnidadesTerritoriales);
        return listado.items;
      } else {
        return List.empty();
      }
    } else {
      http.Response response = await http.get(
        Uri.parse(
            AppConfig.backendsismonitor + '/programaciongit/ListarTambos'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final listado = new ListaTambosDependientes.fromJsonList(jsonResponse);
        print(listado.items[0].idUnidadesTerritoriales);
        return listado.items;
      } else {
        return List.empty();
      }
    }
    return List.empty();
  }

//https://www.pais.gob.pe/backendsismonitor/public
}
