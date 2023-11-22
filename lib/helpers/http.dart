import 'dart:convert';

import 'package:actividades_pais/helpers/http_responce.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;

class Http {
  late Dio _dio;
  late Logger _log;
  late bool _logsEnabled;

  Http({
    required Dio dio,
    required Logger logger,
    required bool logsEnabled,
  }) {
    _dio = dio;
    _log = logger;
    _logsEnabled = logsEnabled;
  }

  /*
  USO:
  - OBJECTO
  //var oResp = await _http.get<Map<String, dynamic>, dynamic>( '${basePathApp}listarTramaMonitoreo', method: "GET",);
  - LISTA
  //var oResp = await _http.get<dynamic, List<Map<String, dynamic>>>('${basePathApp}listarTramaMonitoreo', method: "GET", );
  */
  Future<T> get<T, K>(
    String path, {
    String method = "GET",
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    Map<String, dynamic>? formData,
    Map<String, String>? headers,
  }) async {
    final Response response = await _dio.request(
      path,
      options: Options(
        method: method,
        headers: headers,
      ),
      queryParameters: queryParameters,
      data: formData != null ? FormData.fromMap(formData) : data,
    );

    if (response.statusCode == 200) {
      final dynamic oResp = json.decode(response.data["response"]);
      if (oResp is List) {
        return List<K>.from(oResp) as T;
      } else {
        return oResp as T;
      }
    } else {
      throw Exception(response);
    }
  }

  Future<HttpResponse<T>> request<T>(
    String path, {
    String method = "GET",
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    Map<String, dynamic>? formData,
    Map<String, String>? headers,
    T Function(dynamic data)? parser,
  }) async {
    try {
      final response = await _dio.request(
        path,
        options: Options(
          method: method,
          headers: headers,
        ),
        queryParameters: queryParameters,
        data: formData != null ? FormData.fromMap(formData) : json.encode(data),
      );

      var oData;

      try {
        oData = response.data["response"] ?? response.data;
      } catch (oError) {
        if (response.data is String) {
          oData = jsonDecode(response.data);
        } else {
          oData = response.data;
        }
      }

      if (parser != null) {
        return HttpResponse.success<T>(parser(oData));
      }
      return HttpResponse.success<T>(oData);
    } catch (oError) {
      _log.e(
        oError.toString(),
      );

      int statusCode = 0;
      String message = "Unknown error";
      dynamic data;
      if (oError is DioError) {
        statusCode = -1;
        message = oError.message!;
        if (oError.response != null) {
          statusCode = oError.response!.statusCode!;
          if (oError.response!.statusMessage! != "") {
            message = oError.response!.statusMessage!;
          }
          data = oError.response!.data;
        }
      }

      return HttpResponse.fail<T>(
        statusCode: statusCode,
        message: message,
        data: data,
      );
    }
  }

  Future<HttpResponse<T>> postMultipartFile2<T>(
    String path, {
    Map<String, String>? headers,
    Map<String, String>? data,
    Map<String, dynamic>? formData,
    List<Map<String, String>>? aFile,
    T Function(dynamic data)? parser,
  }) async {
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse('${_dio.options.baseUrl}$path'));
      if (headers != null) {
        request.headers.addAll(headers);
      }

      request.fields.addAll(data!);

      for (var oFile in aFile!) {
        for (final entry in oFile.entries) {
          request.files
              .add(await http.MultipartFile.fromPath(entry.key, entry.value));
        }
      }

      http.StreamedResponse response = await request.send();
      var oData;
      if (response.statusCode == 200) {
        final oResp2 = await http.Response.fromStream(response);
        oData = json.decode(oResp2.body == "" ? "{}" : oResp2.body);

        if (parser != null) {
          return HttpResponse.success<T>(parser(oData));
        }
        return HttpResponse.success<T>(oData);
      } else {
        throw Exception(
          'Servidor responde con statusCode: ${response.statusCode}',
        );
      }
    } catch (e) {
      int statusCode = 0;
      String message = e.toString() == "" ? "Unknown error" : e.toString();
      dynamic data;
      if (e is DioError) {
        statusCode = -1;
        message = e.message!;
        if (e.response != null) {
          statusCode = e.response!.statusCode!;
          if (e.response!.statusMessage! != "") {
            message = e.response!.statusMessage!;
          }
          data = e.response!.data;
        }
      }

      return HttpResponse.fail<T>(
        statusCode: statusCode,
        message: message,
        data: data,
      );
    }
  }

  Future<HttpResponse<T>> postMultipartFile<T>(
    String path, {
    Map<String, String>? headers,
    Map<String, String>? data,
    Map<String, dynamic>? formData,
    List<Map<String, String>>? aFile,
    T Function(dynamic data)? parser,
  }) async {
    try {
      /*var data = {
        'name': 'wendux',
        'age': 25,
        'file':
            await MultipartFile.fromFile('./text.txt', filename: 'upload.txt'),
        'files': [
          await MultipartFile.fromFile('./text1.txt', filename: 'text1.txt'),
          await MultipartFile.fromFile('./text2.txt', filename: 'text2.txt'),
        ]
      };*/

      final response = await _dio.post(
        path,
        options: Options(
          //method: method,
          headers: headers,
        ),
        data: FormData.fromMap(data!),
      );

      /*
      RESPONSE:
      {
        "codResultado": 1,
        "msgResultado": "OK",
        "total": null,
        "response": null,
        "idPerfil": null
      }*/
      final oData = response.data;

      if (parser != null) {
        return HttpResponse.success<T>(parser(oData));
      }
      return HttpResponse.success<T>(oData);
    } catch (e) {
      //_logger.e(e);

      int statusCode = 0;
      String message = "Unknown error";
      dynamic data;
      if (e is DioError) {
        statusCode = -1;
        message = e.message!;
        if (e.response != null) {
          statusCode = e.response!.statusCode!;
          if (e.response!.statusMessage! != "") {
            message = e.response!.statusMessage!;
          }
          data = e.response!.data;
        }
      }

      return HttpResponse.fail<T>(
        statusCode: statusCode,
        message: message,
        data: data,
      );
    }
  }
}
