import 'dart:io';
import 'package:actividades_pais/src/datamodels/Clases/Uti/EstadoGuardar.dart';
import 'package:actividades_pais/src/datamodels/Clases/Uti/FiltroListaEquipos.dart';
import 'package:actividades_pais/src/datamodels/Clases/Uti/FiltroTicketEquipo.dart';
import 'package:actividades_pais/src/datamodels/Clases/Uti/ListaEquipoInformatico.dart';
import 'package:actividades_pais/src/datamodels/Clases/Uti/ListaEstado.dart';
import 'package:actividades_pais/src/datamodels/Clases/Uti/ListaMarca.dart';
import 'package:actividades_pais/src/datamodels/Clases/Uti/ListaModelo.dart';
import 'package:actividades_pais/src/datamodels/Clases/Uti/ListaPersonalSoporte.dart';
import 'package:actividades_pais/src/datamodels/Clases/Uti/ListaTicketEquipos.dart';
import 'package:actividades_pais/src/datamodels/Clases/Uti/ListaTicketEstado.dart';
import 'package:actividades_pais/src/datamodels/Clases/Uti/ListaTipoEquipo.dart';
import 'package:actividades_pais/src/datamodels/Clases/Uti/ListaUbicacion.dart';
import 'package:actividades_pais/src/datamodels/Clases/Uti/ListarProveedores.dart';
import 'package:actividades_pais/src/datamodels/database/DatabasePr.dart';
import 'package:actividades_pais/util/app-config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:logger/logger.dart';

class ProviderSeguimientoParqueInformatico {
  final Logger _log = Logger();

  Future<List<ListaEquipoInformatico>>? listaParqueInformatico(
      FiltroParqueInformatico filtroParqueInformatico) async {
    var logUser = await DatabasePr.db.loginUser();
    var headers = {
      'Authorization': 'Bearer ${logUser[0].token}',
      'Content-Type': 'application/json'
    };

    http.Response response = await http.post(
        Uri.parse(AppConfig.backendsismonitor +
            '/seguimientoequipo/listaEquipoInformatico'),
        headers: headers,
        body: json.encode(filtroParqueInformatico));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final listadoEquipos =
          new ListaEquipoInformaticos.fromJsonList(jsonResponse["data"]);
      return listadoEquipos.items;
    } else {
      return List.empty();
    }
  }

  Future<List<Marca>>? listaMarcas() async {
    var logUser = await DatabasePr.db.loginUser();
    var headers = {
      'Authorization': 'Bearer ${logUser[0].token}',
      'Content-Type': 'application/json'
    };
    http.Response response = await http.get(
        Uri.parse(AppConfig.backendsismonitor + '/seguimientoequipo/marcas'),
        headers: headers);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final listadoMarcas = new ListaMarcas.fromJsonList(jsonResponse);
      return listadoMarcas.items;
    } else {
      return List.empty();
    }
  }

  Future<List<Modelo>>? listaModelos() async {
    var logUser = await DatabasePr.db.loginUser();
    var headers = {
      'Authorization': 'Bearer ${logUser[0].token}',
      'Content-Type': 'application/json'
    };
    http.Response response = await http.get(
        Uri.parse(AppConfig.backendsismonitor + '/seguimientoequipo/modelo'),
        headers: headers);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final listadoModelo = new ListaModelos.fromJsonList(jsonResponse);
      return listadoModelo.items;
    } else {
      return List.empty();
    }
  }

  Future<List<Ubicacion>>? listaUbicacion() async {
    var logUser = await DatabasePr.db.loginUser();
    var headers = {
      'Authorization': 'Bearer ${logUser[0].token}',
      'Content-Type': 'application/json'
    };
    http.Response response = await http.get(
        Uri.parse(
            AppConfig.backendsismonitor + '/seguimientoequipo/listasUbicacion'),
        headers: headers);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final listaUbicacion = new ListaUbicacion.fromJsonList(jsonResponse);
      return listaUbicacion.items;
    } else {
      return List.empty();
    }
  }

  Future<String> consultaEquipo(idEquipo) async {
    var logUser = await DatabasePr.db.loginUser();
    var headers = {
      'Authorization': 'Bearer ${logUser[0].token}',
      'Content-Type': 'application/json'
    };
    http.Response response = await http.post(
        Uri.parse(
            AppConfig.backendsismonitor + '/seguimientoequipo/consultaEquipo'),
        headers: headers,
        body: json.encode({"id_equipo": idEquipo}));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      if (jsonResponse[0]["path"] == null) {
        return '0';
      } else {
        return jsonResponse[0]["path"];
      }
    } else {
      return "0";
    }
  }

  Future<String> ConsultaMarca(idModelo) async {
    var logUser = await DatabasePr.db.loginUser();
    var headers = {
      'Authorization': 'Bearer ${logUser[0].token}',
      'Content-Type': 'application/json'
    };
    http.Response response = await http.post(
        Uri.parse(
            AppConfig.backendsismonitor + '/seguimientoequipo/consultaMarca'),
        headers: headers,
        body: json.encode({"idModelo": idModelo}));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      if (jsonResponse[0]["descripcion_marca"] == null) {
        return '0';
      } else {
        return jsonResponse[0]["descripcion_marca"];
      }
    } else {
      return "0";
    }
  }

  Future<List<ListaPersonalSoporte>>? getListaPersonalSoporte() async {
    var logUser = await DatabasePr.db.loginUser();
    var headers = {
      'Authorization': 'Bearer ${logUser[0].token}',
      'Content-Type': 'application/json'
    };

    http.Response response = await http.get(
      Uri.parse(AppConfig.backendsismonitor +
          '/seguimientoequipo/listaPersonalSoporte'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final listaPersonalSoporte =
          new ListaPersonalSoportes.fromJsonList(jsonResponse);
      return listaPersonalSoporte.items;
    } else {
      return List.empty();
    }
  }

  Future<List<ListaTicketEstado>>? getListaTicketEstado() async {
    var logUser = await DatabasePr.db.loginUser();
    var headers = {
      'Authorization': 'Bearer ${logUser[0].token}',
      'Content-Type': 'application/json'
    };

    http.Response response = await http.get(
      Uri.parse(
          AppConfig.backendsismonitor + '/seguimientoequipo/ticketEstado'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final listaTicketEstados =
          new ListaTicketEstados.fromJsonList(jsonResponse);
      return listaTicketEstados.items;
    } else {
      return List.empty();
    }
  }

  //
  Future<List<ListaEquiposInformaticosTicket>>?
      getListaEquiposInformaticosTicket(
          {required FiltroTicketEquipo filtroTicketEquipo}) async {
    var logUser = await DatabasePr.db.loginUser();
    var headers = {
      'Authorization': 'Bearer ${logUser[0].token}',
      'Content-Type': 'application/json'
    };
    print(json.encode(filtroTicketEquipo));
    http.Response response = await http.post(
        Uri.parse(AppConfig.backendsismonitor +
            '/seguimientoequipo/listaEquiposInformaticosTicket'),
        headers: headers,
        body: json.encode(filtroTicketEquipo));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final listadoEquiposInformaticosTickets =
          new ListaEquiposInformaticosTickets.fromJsonList(jsonResponse);
      return listadoEquiposInformaticosTickets.items;
    } else {
      return List.empty();
    }
  }

  Future<List<Proveedores>>? getListarProveedores() async {
    var logUser = await DatabasePr.db.loginUser();
    var headers = {
      'Authorization': 'Bearer ${logUser[0].token}',
      'Content-Type': 'application/json'
    };
    http.Response response = await http.get(
        Uri.parse(AppConfig.backendsismonitor +
            '/seguimientoequipo/listarProveedores'),
        headers: headers);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final listarProveedores =
          new ListarProveedores.fromJsonList(jsonResponse);
      return listarProveedores.items;
    } else {
      return List.empty();
    }
  }

  Future<List<TipoEquipo>>? getListarTipoEquipo() async {
    var logUser = await DatabasePr.db.loginUser();
    var headers = {
      'Authorization': 'Bearer ${logUser[0].token}',
      'Content-Type': 'application/json'
    };
    http.Response response = await http.get(
        Uri.parse(
            AppConfig.backendsismonitor + '/seguimientoequipo/tipoEquipo'),
        headers: headers);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final listar = new ListarTipoEquipo.fromJsonList(jsonResponse);
      return listar.items;
    } else {
      return List.empty();
    }
  }

  Future<List<Estado>>? getEstadoEquipo() async {
    var estado = [
      {"idEstado": "0", "estado": "INACTIVO"},
      {"idEstado": "1", "estado": "ACTIVO"}
    ];
    final jsonResponse = json.decode(json.encode(estado));
    final listar = new ListarEstado.fromJsonList(jsonResponse);
    return listar.items;
  }

  Future<EstadoGuardar> guardarEdEquipoInformatico(
      ListaEquipoInformatico listaEquipoInformatico) async {
    var logUser = await DatabasePr.db.loginUser();

    var headers = {
      'Authorization': 'Bearer ${logUser[0].token}',
      'Content-Type': 'application/json'
    };

    http.Response response = await http.post(
        Uri.parse(
            AppConfig.backendsismonitor + '/seguimientoequipo/editarMovil'),
        headers: headers,
        body: json.encode(listaEquipoInformatico));
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final listar = new EstadoGuardar.fromJson(jsonResponse);
      return listar;
    } else {
      return EstadoGuardar();
    }
  }

  Future<EstadoGuardar> guardarEquipoInformatico(
      ListaEquipoInformatico listaEquipoInformatico) async {
    var logUser = await DatabasePr.db.loginUser();

    var headers = {
      'Authorization': 'Bearer ${logUser[0].token}',
      'Content-Type': 'application/json'
    };

    http.Response response = await http.post(
        Uri.parse(
            AppConfig.backendsismonitor + '/seguimientoequipo/crearMovil'),
        headers: headers,
        body: json.encode(listaEquipoInformatico));
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final listar = new EstadoGuardar.fromJson(jsonResponse);
      return listar;
    } else {
      return EstadoGuardar();
    }
  }

  Future EliminarEquipoInformatico(
      ListaEquipoInformatico listaEquipoInformatico) async {
    var logUser = await DatabasePr.db.loginUser();
    var headers = {
      'Authorization': 'Bearer ${logUser[0].token}',
      'Content-Type': 'application/json'
    };

    http.Response response = await http.get(
      Uri.parse(AppConfig.backendsismonitor +
          '/seguimientoequipo/eliminarEquipoInfo/${listaEquipoInformatico.idEquipoInformatico}'),
      headers: headers,
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return EstadoGuardar();
    }
  }

  Future EnvioArchivo(path) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse(AppConfig.backendsismonitor + '/upload/*'));
    request.fields.addAll({'storage': 'equipo/archivos'});
    request.files.add(await http.MultipartFile.fromPath('file', path));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var jsonResponse;
      await response.stream.bytesToString().then((value) {
        jsonResponse = json.decode(value.toString());
      });
      return jsonResponse;
    }
  }

  Future EliminarArchivoTemp(path) async {
    var logUser = await DatabasePr.db.loginUser();
    var headers = {
      'Authorization': 'Bearer ${logUser[0].token}',
      'Content-Type': 'application/json'
    };
    final msg = jsonEncode({"file": "$path"});

    http.Response response = await http.post(
        Uri.parse(AppConfig.backendsismonitor + '/unlink'),
        headers: headers,
        body: msg);
    var jsonResponse;
    jsonResponse = json.decode(response.body.toString());

    return jsonResponse;
  }

  Future ArchivoEliminar(id_archivo) async {
    var logUser = await DatabasePr.db.loginUser();
    var headers = {
      'Authorization': 'Bearer ${logUser[0].token}',
      'Content-Type': 'application/json'
    };

    http.Response response = await http.get(
      Uri.parse(AppConfig.backendsismonitor +
          '/seguimientoequipo/eliminarArchivo/${id_archivo}'),
      headers: headers,
    );
    if (response.statusCode == 200) {
      var jsonResponse;
      jsonResponse = json.decode(response.body.toString());

      return jsonResponse;
    } else {
      return "";
    }
  }

  Future consultaArchivoEquipo(idEquipo) async {
    var logUser = await DatabasePr.db.loginUser();
    var headers = {
      'Authorization': 'Bearer ${logUser[0].token}',
      'Content-Type': 'application/json'
    };
    http.Response response = await http.get(
        Uri.parse(AppConfig.backendsismonitor +
            '/seguimientoequipo/archivo-equipo/$idEquipo'),
        headers: headers);
    if (response.statusCode == 200) {
      if (response.body != "") {
        var jsonResponse;
        jsonResponse = json.decode(response.body.toString());
        return jsonResponse;
      } else {
        return "";
      }
    } else {
      return "0";
    }
  }

  ///REPORTE

  Future<int> ReporteEquipos(idTipo) async {
    var logUser = await DatabasePr.db.loginUser();
    var headers = {
      'Authorization': 'Bearer ${logUser[0].token}',
      'Content-Type': 'application/json'
    };

    http.Response response = await http.get(
        Uri.parse(AppConfig.backendsismonitor +
            '/seguimientoequipo/reportActivoInactivo/$idTipo'),
        headers: headers);
    if (response.statusCode == 200) {
      if (response.body != "") {
        var jsonResponse;
        jsonResponse = json.decode(response.body.toString());
        return int.parse(jsonResponse[0]["cantidad"]);
      } else {
        return 0;
      }
    } else {
      return 0;
    }
  }

  Future<int> estadosTickePie(tipo) async {
    var logUser = await DatabasePr.db.loginUser();
    var headers = {
      'Authorization': 'Bearer ${logUser[0].token}',
      'Content-Type': 'application/json'
    };

    http.Response response = await http.get(
        Uri.parse(AppConfig.backendsismonitor +
            '/seguimientoequipo/listaTickect/$tipo'),
        headers: headers);
    if (response.statusCode == 200) {
      var jsonResponse;
      jsonResponse = json.decode(response.body.toString());

      return jsonResponse["contar"];
    } else {
      return 0;
    }
  }

  Future<List<ListaEquiposInformaticosTicket>> ListaEstadosTickeDatos(
      {required FiltroTicketEquipo filtroTicketEquipo}) async {
    var logUser = await DatabasePr.db.loginUser();
    var headers = {
      'Authorization': 'Bearer ${logUser[0].token}',
      'Content-Type': 'application/json'
    };

    http.Response response = await http.get(
        Uri.parse(AppConfig.backendsismonitor +
            '/seguimientoequipo/listaTickect/${filtroTicketEquipo.estado}'),
        headers: headers);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final listadoEquiposInformaticosTickets =
          new ListaEquiposInformaticosTickets.fromJsonList(
              jsonResponse["data"]);

      return listadoEquiposInformaticosTickets.items;
    } else {
      return List.empty();
    }
  }
}
