import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:actividades_pais/src/datamodels/Clases/IncidentesNovedadesPias.dart';
import 'package:actividades_pais/src/datamodels/Clases/Pias/ArchivosEvidencia.dart';
import 'package:actividades_pais/src/datamodels/Clases/Pias/Atencion.dart';
import 'package:actividades_pais/src/datamodels/Clases/Pias/Nacimiento.dart';
import 'package:actividades_pais/src/datamodels/Clases/Pias/PuntoAtencionPias.dart';
import 'package:actividades_pais/src/datamodels/Clases/Pias/reportesPias.dart';
import 'package:actividades_pais/src/datamodels/Clases/actividadesPias.dart';
import 'package:actividades_pais/src/datamodels/database/DatabasePias.dart';
import 'package:actividades_pais/src/datamodels/database/DatabasePr.dart';
import 'package:actividades_pais/util/app-config.dart';
import 'package:logger/logger.dart';

class ProviderServiciosRest {
  Dio dio = new Dio();
  final Logger _log = Logger();

  // ignore: non_constant_identifier_names
  static Map<String, String> get headers {
    return {
      'Content-Type': 'application/json',
    };
  }

  Future<int> user() async {
    DatabasePr.db.initDB();
    var abc = await DatabasePr.db.getAllConfigPersonal();
    http.Response usuariodb = await http.get(
        Uri.parse(AppConfig.urlBackndServicioSeguro +
            '/api-pnpais/app/consultaIdUsuarioxDni/${abc[0].numeroDni}'),
        headers: headers);
    final jsonResponse = json.decode(usuariodb.body);
    var usu = jsonResponse["response"][0]["id_usuario"];

    return usu;
  }

  Future<List<PuntoAtencionPias>> listarPuntoAtencionPias(
      String idCampania, int idPlataforma, int idPeriodo) async {

    final url = '${AppConfig.urlBackndServicioSeguro}/api-pnpais/app/listarPuntoAtencionPiasMovil/$idCampania/$idPlataforma/0';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      await DatabasePias.db.deletePuntoAtencionPias();

      final jsonResponse = json.decode(response.body);
      if (jsonResponse["codResultado"] != 2) {
        final listadostraba =
        ListaPuntoAtencionPias.fromJsonList(jsonResponse["response"]);
        listadostraba.items.forEach((item) async {
          final rspt = PuntoAtencionPias(
            longitud: item.longitud,
            puntoAtencion: item.puntoAtencion,
            codigoUbigeo: item.codigoUbigeo,
            anio: item.anio,
            idCampania: item.idCampania,
            idPias: item.idPias,
            latitud: item.latitud,
            pias: item.pias,
          );
          await DatabasePias.db.insertPuntoAtencionPias(rspt);
        });
        return listadostraba.items;
      } else {
        return [];
      }
    }
    // si la respuesta no es 200, lanzar una excepción
    throw Exception('Error al obtener los puntos de atención Pias');
  }

  Future<int> guardar(ReportesPias reportePias) async {
    reportePias.idUsuario = await user();
    print(jsonEncode(reportePias));
    http.Response response = await http.post(
        Uri.parse(AppConfig.urlBackndServicioSeguro +
            '/api-pnpais/pias/app/registrarParteDiarioPiasMovil'),
        body: jsonEncode(reportePias),
        headers: headers);
    if (response.statusCode == 200) {
      var resp = jsonDecode(response.body);
      reportePias.idParteDiario = int.parse(resp["response"].toString());
      await DatabasePias.db.updateTask(reportePias);
      return response.statusCode;
    }
    return response.statusCode;
  }

  Future<int> guardarActividades(ActividadesPias actividadesPias) async {
    print("aquii ${actividadesPias.idParteDiario}");

    var listaParticipantes =
        await DatabasePias.db.reportePias(actividadesPias.idUnicoReporte);
    print("dsadsad ${listaParticipantes[0].idParteDiario}");
    actividadesPias.idUsuario = await user();
    actividadesPias.idParteDiario = listaParticipantes[0].idParteDiario;
    http.Response response = await http.post(
        Uri.parse(AppConfig.urlBackndServicioSeguro +
            '/api-pnpais/pias/app/registrarParteDiarioActividadMovil'),
        body: jsonEncode(actividadesPias),
        headers: headers);
    print("aquii ${response.body}");
    if (response.statusCode == 200) {
      return response.statusCode;
    }
    return response.statusCode;
  }

  Future<int> guardarAtenciones(Atencion atencion) async {
    print("aquii ${atencion.idParteDiario}");

    var listareportePias =
        await DatabasePias.db.reportePias(atencion.idUnicoReporte);
    print("dsadsad ${listareportePias[0].idParteDiario}");
    atencion.idUsuario = await user();
    atencion.idParteDiario = listareportePias[0].idParteDiario;
    http.Response response = await http.post(
        Uri.parse(AppConfig.urlBackndServicioSeguro +
            '/api-pnpais/pias/app/registrarParteDiarioAtencionesMovil'),
        body: jsonEncode(atencion),
        headers: headers);
    print("jsonEncode(atencion) ${jsonEncode(atencion)}");
    print("aquii ${response.body}");
    if (response.statusCode == 200) {
      return response.statusCode;
    }
    return response.statusCode;
  }

  Future<int> guardarIncidentes(
      IncidentesNovedadesPias incidentesNovedadesPias) async {
    print("aquii ${incidentesNovedadesPias.idParteDiario}");

    var listareportePias = await DatabasePias.db
        .reportePias(incidentesNovedadesPias.idUnicoReporte);
    incidentesNovedadesPias.idUsuario = await user();
    incidentesNovedadesPias.idParteDiario = listareportePias[0].idParteDiario;
    http.Response response = await http.post(
        Uri.parse(AppConfig.urlBackndServicioSeguro +
            '/api-pnpais/pias/app/registrarParteDiarioIncNovMovil'),
        body: jsonEncode(incidentesNovedadesPias),
        headers: headers);
    print("aquii ${response.body}");
    if (response.statusCode == 200) {
      return response.statusCode;
    }
    return response.statusCode;
  }

  Future<int> guardarEvidencias(ArchivosEvidencia archivosEvidencia) async {
    var listareportePias =
        await DatabasePias.db.reportePias(archivosEvidencia.idUnicoReporte);
    print('"idParteDiario":${listareportePias[0].idParteDiario},');
    var respuesta = 0;
    var request = http.MultipartRequest(
        'POST', Uri.parse(AppConfig.backendsismonitor + '/upload/*'));

    request.fields.addAll({'storage': 'reportespias'});
    request.files.add(
        await http.MultipartFile.fromPath('file', archivosEvidencia.file!));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsonResponse;

      await response.stream.bytesToString().then((value) {
        jsonResponse = json.decode(value.toString());
      });

      print("=============>>>>>>");
      print('{"path":"${jsonResponse["path"]}",'
          '"url":"${jsonResponse["url"]}",'
          '"name":"${jsonResponse["name"]}",'
          '"extension":"${jsonResponse["extension"]}",'
          '"idParteDiario":${listareportePias[0].idParteDiario},'
          '"txtIpmaq": "movil",'
          '"idUsuario":${await user()}}');
      print("=============>>>>>>");

      http.Response responsee = await http.post(
          Uri.parse(AppConfig.urlBackndServicioSeguro +
              '/api-pnpais/pias/app/registrarParteDiarioEvidencia'),
          headers: headers,
          body: '{"path":"${jsonResponse["path"]}",'
              '"url":"${jsonResponse["url"]}",'
              '"name":"${jsonResponse["name"]}",'
              '"extension":"${jsonResponse["extension"]}",'
              '"idParteDiario":${listareportePias[0].idParteDiario},'
              '"txtIpmaq": "movil",'
              '"idUsuario":${await user()}}');
      respuesta = responsee.statusCode;
      print(respuesta);
    } else {}
    return respuesta;
  }

  Future<int?> guardarNacimientos(Nacimiento nacimiento) async {
    var rspt = await DatabasePias.db
        .ListarNacimientoPiasEn(nacimiento.idUnicoReporte, nacimiento.id);
    var listareportePias =
        await DatabasePias.db.reportePias(nacimiento.idUnicoReporte);
    for (var i = 0; i < rspt.length; i++) {
      rspt[i].idParteDiario = listareportePias[0].idParteDiario;
      rspt[i].idUsuario = await user();
      http.Response response = await http.post(
          Uri.parse(AppConfig.urlBackndServicioSeguro +
              '/api-pnpais/pias/app/registrarParteDiarioNacimientoMovil'),
          body: jsonEncode(rspt[i]),
          headers: headers);
      _log.i(AppConfig.urlBackndServicioSeguro +
          '/api-pnpais/pias/app/registrarParteDiarioNacimientoMovil');
      _log.i(jsonEncode(rspt[i]));
      _log.i(response.body);
      rspt[i].idParteDiarioNacimiento =
          int.parse(jsonDecode(response.body)["response"].toString());

      var upnac = await DatabasePias.db.updateNacimiento(rspt[i]);

      await DatabasePias.db
          .updateArchivos(rspt[i].idParteDiarioNacimiento, rspt[i].id);
      var img = await DatabasePias.db.traerArchivosParte(
          rspt[i].idUnicoReporte, rspt[i].id, rspt[i].idParteDiarioNacimiento);
      _log.i(img);

      for (var i = 0; i < img.length; i++) {
        var request = http.MultipartRequest(
            'POST', Uri.parse(AppConfig.backendsismonitor + '/upload/*'));
        request.fields.addAll({'storage': 'reportespias'});
        request.files
            .add(await http.MultipartFile.fromPath('file', img[i].file!));
        http.StreamedResponse rsesponse = await request.send();
        var jsonResponse;

        await rsesponse.stream.bytesToString().then((value) {
          jsonResponse = json.decode(value.toString());
        });

        _log.i(jsonResponse);
        _log.i(Uri.parse(AppConfig.urlBackndServicioSeguro +
            '/api-pnpais/pias/app/registrarParteDiarioNacimientoImagenMovil'));

        http.Response responses = await http.post(
            Uri.parse(AppConfig.urlBackndServicioSeguro +
                '/api-pnpais/pias/app/registrarParteDiarioNacimientoImagenMovil'),
            headers: headers,
            body: '{"path":"${jsonResponse["path"]}",'
                '"name":"${jsonResponse["name"]}",'
                '"idParteDiarioNacimiento": ${img[i].idParteDiarioNacimiento},'
                '"idUsuario": ${await user()},'
                '"txtIpmaq":""}');

        _log.i('{"path":"${jsonResponse["path"]}",'
            '"name":"${jsonResponse["name"]}",'
            '"idParteDiarioNacimiento": ${img[i].idParteDiarioNacimiento},'
            '"idUsuario": ${await user()},'
            '"txtIpmaq":""}');

        await DatabasePias.db.DeleteArchivosParte(img[i].idUnicoReporte,
            img[i].idNacimiento, img[i].idParteDiarioNacimiento);
        _log.i(responses.body);

        await DatabasePias.db.eliminarNacidos(img[i].idUnicoReporte);
        await DatabasePias.db
            .ListarNacimientoPiasEn(nacimiento.idUnicoReporte, nacimiento.id);
      }
      return response.statusCode;
    }
  }
}
