import 'dart:convert';

class TramaRespApiFields {
  static final List<String> values = [
    codResultado,
    msgResultado,
    total,
    response,
    idPerfil,
  ];

  static String codResultado = 'codResultado';
  static String msgResultado = 'msgResultado';
  static String total = 'total';
  static String response = 'response';
  static String idPerfil = 'idPerfil';
}

class TramaRespApiDto {
  int? codResultado = 0;
  int? total = 0;
  String? msgResultado = '';
  Map<String, dynamic>? response = {};
  int? idPerfil = 0;

  TramaRespApiDto.empty();

  TramaRespApiDto({
    this.codResultado,
    this.msgResultado,
    this.total,
    this.response,
    this.idPerfil,
  });

  TramaRespApiDto copy({
    int? codResultado,
    int? total,
    String? msgResultado,
    Map<String, dynamic>? response,
    int? idPerfil,
  }) =>
      TramaRespApiDto(
        codResultado: codResultado ?? this.codResultado,
        msgResultado: msgResultado ?? this.msgResultado,
        total: total ?? this.total,
        response: response ?? this.response,
        idPerfil: idPerfil ?? this.idPerfil,
      );

  static TramaRespApiDto fromJson(Map<String, Object?> json) => TramaRespApiDto(
        codResultado: json[TramaRespApiFields.codResultado] == null
            ? 0
            : json[TramaRespApiFields.codResultado] as int,
        msgResultado: json[TramaRespApiFields.msgResultado] == null
            ? ""
            : json[TramaRespApiFields.msgResultado] as String,
        total: json[TramaRespApiFields.total] == null
            ? 0
            : json[TramaRespApiFields.total] as int,
        response: json[TramaRespApiFields.response] as dynamic,
        idPerfil: json[TramaRespApiFields.idPerfil] == null
            ? 0
            : json[TramaRespApiFields.idPerfil] as int,
      );

  Map<String, dynamic> toJson() => {
        TramaRespApiFields.codResultado: codResultado,
        TramaRespApiFields.msgResultado: msgResultado,
        TramaRespApiFields.total: total,
        TramaRespApiFields.response: response,
        TramaRespApiFields.idPerfil: idPerfil,
      };

  static Map<String, dynamic> toJsonObject(TramaRespApiDto o) {
    return {
      TramaRespApiFields.codResultado: o.codResultado,
      TramaRespApiFields.msgResultado: o.msgResultado,
      TramaRespApiFields.total: o.total,
      TramaRespApiFields.response: o.response,
      TramaRespApiFields.idPerfil: o.idPerfil,
    };
  }

  static List<Map<String, dynamic>> toJsonArray(
      List<TramaRespApiDto> aTramaMonitoreo) {
    List<Map<String, dynamic>> aList = [];
    for (var item in aTramaMonitoreo) {
      aList.add(TramaRespApiDto.toJsonObject(item));
    }
    return aList;
  }

  List<TramaRespApiDto> userFromJson(String sOject) {
    final jsonData = json.decode(sOject);
    return List<TramaRespApiDto>.from(
        jsonData.map((x) => TramaRespApiDto.fromJson(x)));
  }

  String userToJson(List<TramaRespApiDto> aTramaMonitoreo) {
    final dyn = List<dynamic>.from(aTramaMonitoreo.map((x) => x.toJson()));
    return json.encode(dyn);
  }
}
