import 'dart:convert';

class RespTokenFields {
  static String id = 'id';
  static String name = 'name';
  static String token = 'token';
  static String rol = 'rol';
}

class RespTokenDto {
  int? id = 0;
  String? name = '';
  String? token = '';
  String? rol = '';

  RespTokenDto.empty();

  RespTokenDto({
    this.id,
    this.token,
    this.name,
    this.rol,
  });

  RespTokenDto copy({
    int? id,
    String? name,
    String? token,
    String? rol,
  }) =>
      RespTokenDto(
        id: id ?? this.id,
        token: token ?? this.token,
        name: name ?? this.name,
        rol: rol ?? this.rol,
      );

  static RespTokenDto fromJson(Map<String, Object?> json) => RespTokenDto(
        id: _getInt(json[RespTokenFields.id]),
        token: _getString(json[RespTokenFields.token]),
        name: _getString(json[RespTokenFields.name]),
        rol: _getString(json[RespTokenFields.rol]),
      );

  Map<String, dynamic> toJson() => {
        RespTokenFields.id: id,
        RespTokenFields.token: token,
        RespTokenFields.name: name,
        RespTokenFields.rol: rol,
      };

  static Map<String, dynamic> toJsonObject(RespTokenDto o) {
    return {
      RespTokenFields.id: o.id,
      RespTokenFields.token: o.token,
      RespTokenFields.name: o.name,
      RespTokenFields.rol: o.rol,
    };
  }

  static List<Map<String, dynamic>> toJsonArray(List<RespTokenDto> o) {
    List<Map<String, dynamic>> aList = [];
    for (var item in o) {
      aList.add(RespTokenDto.toJsonObject(item));
    }
    return aList;
  }

  List<RespTokenDto> userFromJson(String sOject) {
    final jsonData = json.decode(sOject);
    return List<RespTokenDto>.from(
        jsonData.map((x) => RespTokenDto.fromJson(x)));
  }

  String userToJson(List<RespTokenDto> o) {
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
