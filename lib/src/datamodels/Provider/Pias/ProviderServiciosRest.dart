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

class ProviderServiciosRest {
  Dio dio = new Dio();

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
    http.Response response = await http.get(
      Uri.parse(AppConfig.urlBackndServicioSeguro +
          '/api-pnpais/app/listarPuntoAtencionPiasMovil/$idCampania/$idPlataforma/0'),
    );

    if (response.statusCode == 200) {

      final jsonResponse = json.decode(response.body);
      print(jsonResponse["codResultado"]);
      if(jsonResponse["codResultado"]!=2){
        final listadostraba =
        new ListaPuntoAtencionPias.fromJsonList(jsonResponse["response"]);
        for (var i = 0; i < listadostraba.items.length; i++) {
          final rspt = PuntoAtencionPias(
            longitud: listadostraba.items[i].longitud,
            puntoAtencion: listadostraba.items[i].puntoAtencion,
            codigoUbigeo: listadostraba.items[i].codigoUbigeo,
            anio: listadostraba.items[i].anio,
            idCampania: listadostraba.items[i].idCampania,
            idPias: listadostraba.items[i].idPias,
            latitud: listadostraba.items[i].latitud,
            pias: listadostraba.items[i].pias,
          );

          await DatabasePias.db.insertPuntoAtencionPias(rspt);
        }
        return listadostraba.items;
      } else{
        return List.empty();
      }

    } else if (response.statusCode == 400) {}
    return List.empty();
  }

  Future<int> guardar(ReportesPias reportePias) async {
    reportePias.idUsuario = await user();
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
    request.files.add(await http.MultipartFile.fromPath(
        'file', archivosEvidencia.file!));

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
          body:  '{"path":"${jsonResponse["path"]}",'
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

  Future guardarNacimientos(Nacimiento nacimiento) async {

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

      rspt[i].idParteDiarioNacimiento =
          int.parse(jsonDecode(response.body)["response"].toString());

      await DatabasePias.db.updateNacimiento(rspt[i]);
      await DatabasePias.db
          .updateArchivos(rspt[i].idParteDiarioNacimiento, rspt[i].id);
      var img = await DatabasePias.db.traerArchivosParte(
          rspt[i].idUnicoReporte, rspt[i].id, rspt[i].idParteDiarioNacimiento);


      for (var i = 0; i < img.length; i++) {
        var request = http.MultipartRequest('POST',
            Uri.parse(AppConfig.backendsismonitor +'/upload/*'));
        request.fields.addAll({'storage': 'reportespias'});
        request.files
            .add(await http.MultipartFile.fromPath('file', img[i].file!));

        http.StreamedResponse rsesponse = await request.send();

        var jsonResponse;

        await rsesponse.stream.bytesToString().then((value) {
          jsonResponse = json.decode(value.toString());
        });

        http.Response responses = await http.post(
            Uri.parse(AppConfig.urlBackndServicioSeguro +
                '/api-pnpais/pias/app/registrarParteDiarioNacimientoImagenMovil'),
            headers: headers,
            body: '{"path":"${jsonResponse["path"]}",'
                '"name":"${jsonResponse["name"]}",'
                '"idParteDiarioNacimiento": ${img[i].idParteDiarioNacimiento},'
                '"idUsuario": ${await user()},'
                '"txtIpmaq":""}');
        await DatabasePias.db.DeleteArchivosParte(img[i].idUnicoReporte,
            img[i].idNacimiento, img[i].idParteDiarioNacimiento);
        print("errr ${responses.body}");
        await DatabasePias.db.eliminarNacidos(img[i].idUnicoReporte);
        await DatabasePias.db
            .ListarNacimientoPiasEn(nacimiento.idUnicoReporte, nacimiento.id);
      }
    }
  }
}
