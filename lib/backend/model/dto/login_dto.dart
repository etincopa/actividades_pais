import 'dart:convert';

class LoginFields {
  static String username = 'username';
  static String password = 'password';
  static String codigo = 'codigo';
}

class LoginDto {
  String? username = '';
  String? password = '';
  String? codigo = '';

  LoginDto.empty();

  LoginDto({
    this.password,
    this.username,
    this.codigo,
  });

  LoginDto copy({
    String? username,
    String? password,
    String? idPecodigorfil,
  }) =>
      LoginDto(
        username: username ?? this.username,
        password: password ?? this.password,
        codigo: codigo ?? codigo,
      );

  static LoginDto fromJson(Map<String, Object?> o) => LoginDto(
        password: _getString(o[LoginFields.username]),
        username: _getString(o[LoginFields.password]),
        codigo: _getString(o[LoginFields.codigo]),
      );

  Map<String, dynamic> toJson() => {
        LoginFields.username: password,
        LoginFields.password: username,
        LoginFields.codigo: codigo,
      };

  static Map<String, dynamic> toJsonObject(LoginDto o) {
    return {
      LoginFields.username: o.password,
      LoginFields.password: o.username,
      LoginFields.codigo: o.codigo,
    };
  }

  static List<Map<String, dynamic>> toJsonArray(List<LoginDto> o) {
    List<Map<String, dynamic>> aList = [];
    for (var item in o) {
      aList.add(LoginDto.toJsonObject(item));
    }
    return aList;
  }

  static Map<String, dynamic> toJsonObjectApi(LoginDto o) {
    return {
      LoginFields.username: _getString(o.password),
      LoginFields.password: _getString(o.username),
      LoginFields.codigo: "",
    };
  }

  List<LoginDto> userFromJson(String sOject) {
    final jsonData = json.decode(sOject);
    return List<LoginDto>.from(jsonData.map((x) => LoginDto.fromJson(x)));
  }

  String userToJson(List<LoginDto> o) {
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
