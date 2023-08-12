import 'dart:convert';

class RespBase64FileFld {
  static String nombreDocumento = 'nombreDocumento';
  static String base64 = 'base64';
  static String tipo = 'tipo';
  static String extension = 'extension';
}

class RespBase64FileDto {
  String? nombreDocumento = '';
  String? base64 = '';
  String? tipo = '';
  String? extension = '';

  RespBase64FileDto.empty();

  RespBase64FileDto({
    this.nombreDocumento,
    this.tipo,
    this.base64,
    this.extension,
  });

  RespBase64FileDto copy({
    String? nombreDocumento,
    String? base64,
    String? tipo,
    String? extension,
  }) =>
      RespBase64FileDto(
        nombreDocumento: nombreDocumento ?? this.nombreDocumento,
        tipo: tipo ?? this.tipo,
        base64: base64 ?? this.base64,
        extension: extension ?? this.extension,
      );

  static RespBase64FileDto fromJson(Map<String, Object?> json) => RespBase64FileDto(
        nombreDocumento: _getString(json[RespBase64FileFld.nombreDocumento]),
        tipo: _getString(json[RespBase64FileFld.tipo]),
        base64: _getString(json[RespBase64FileFld.base64]),
        extension: _getString(json[RespBase64FileFld.extension]),
      );

  Map<String, dynamic> toJson() => {
        RespBase64FileFld.nombreDocumento: nombreDocumento,
        RespBase64FileFld.tipo: tipo,
        RespBase64FileFld.base64: base64,
        RespBase64FileFld.extension: extension,
      };

  static Map<String, dynamic> toJsonObject(RespBase64FileDto o) {
    return {
      RespBase64FileFld.nombreDocumento: o.nombreDocumento,
      RespBase64FileFld.tipo: o.tipo,
      RespBase64FileFld.base64: o.base64,
      RespBase64FileFld.extension: o.extension,
    };
  }

  static List<Map<String, dynamic>> toJsonArray(List<RespBase64FileDto> o) {
    List<Map<String, dynamic>> aList = [];
    for (var item in o) {
      aList.add(RespBase64FileDto.toJsonObject(item));
    }
    return aList;
  }

  List<RespBase64FileDto> userFromJson(String sOject) {
    final jsonData = json.decode(sOject);
    return List<RespBase64FileDto>.from(
        jsonData.map((x) => RespBase64FileDto.fromJson(x)));
  }

  String userToJson(List<RespBase64FileDto> o) {
    final dyn = List<dynamic>.from(o.map((x) => x.toJson()));
    return json.encode(dyn);
  }

  static String _getString(dynamic data, {String? type}) {
    String resp = data != null ? data.toString() : '';
    if (type != null && type == "I") {
      if (resp == '') resp = '0';
    } else if (type != null && type == "D") {
      if (resp == '') resp = '0.00';
    }
    return resp;
  }

  static int _getInt(dynamic data) {
    return data != null ? int.parse(data.toString()) : 0;
  }
}
