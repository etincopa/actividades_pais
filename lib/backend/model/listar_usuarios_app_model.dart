import 'dart:convert';

String tableNameUsers = 'listar_usuarios_app';

class UserFields {
  static final List<String> values = [
    /// Add all fields
    id,
    isEdit,
    time,
    codigo,
    clave,
    nombres,
    rol,
  ];

  static String id = '_id';
  static String isEdit = 'isEdit';
  static String time = 'time';
  static String codigo = 'codigo';
  static String clave = 'clave';
  static String nombres = 'nombres';
  static String rol = 'rol';
}

class UserModel {
  static final sRolRES = "RESIDENTE"; // Residente,
  static final sRolSUP = "SUPERVISOR"; // Supervisor,
  static final sRolCRP = "CRP"; // (coordinador regional del proyecto)

  int? id = 0;
  int? isEdit = 0;
  DateTime? createdTime = null;

  String? codigo = "";
  String? clave = "";
  String? nombres = "";
  String? rol = "";

  UserModel.empty() {}

  UserModel({
    this.id,
    this.isEdit,
    this.createdTime,
    this.codigo,
    this.clave,
    this.nombres,
    this.rol,
  });

  UserModel copy({
    int? id,
    int? isEdit,
    DateTime? createdTime,
    String? codigo,
    String? clave,
    String? nombres,
    String? rol,
  }) =>
      UserModel(
        id: id ?? this.id,
        isEdit: isEdit ?? this.isEdit,
        createdTime: createdTime ?? this.createdTime,
        codigo: codigo ?? this.codigo,
        clave: clave ?? this.clave,
        nombres: nombres ?? this.nombres,
        rol: rol ?? this.rol,
      );

  static UserModel fromJson(Map<String, Object?> json) => UserModel(
        id: json[UserFields.id] as int?,
        isEdit: json[UserFields.isEdit] == null
            ? 0
            : json[UserFields.isEdit] as int,
        createdTime: json[UserFields.time] != null
            ? DateTime.parse(json[UserFields.time] as String)
            : null,
        codigo: json[UserFields.codigo] as String,
        clave: json[UserFields.clave] == null
            ? ""
            : json[UserFields.clave] as String,
        nombres: json[UserFields.nombres] as String,
        rol: json[UserFields.rol] as String,
      );

  Map<String, dynamic> toJson() => {
        //UserFields.id: id,
        UserFields.isEdit: isEdit,
        //UserFields.time: createdTime.toIso8601String(),
        UserFields.codigo: codigo,
        UserFields.clave: clave,
        UserFields.rol: rol,
        UserFields.nombres: nombres,
      };

  static Map<String, dynamic> toJsonObject(UserModel o) {
    return {
      UserFields.codigo: o.codigo,
      UserFields.clave: o.clave,
      UserFields.rol: o.rol,
      UserFields.nombres: o.nombres,
    };
  }

  static List<Map<String, dynamic>> toJsonArray(List<UserModel> aUser) {
    List<Map<String, dynamic>> aList = [];
    for (var item in aUser) {
      aList.add(UserModel.toJsonObject(item));
    }
    return aList;
  }

  List<UserModel> userFromJson(String sOject) {
    final jsonData = json.decode(sOject);
    return List<UserModel>.from(jsonData.map((x) => UserModel.fromJson(x)));
  }

  String userToJson(List<UserModel> aUser) {
    final dyn = List<dynamic>.from(aUser.map((x) => x.toJson()));
    return json.encode(dyn);
  }
}
