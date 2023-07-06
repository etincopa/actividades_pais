import 'dart:convert';

String tableNamePartidaEjecutadas = 'monitoreo_partida_ejecutada';

class PartidaEjecutadaFld {
  static final List<String> values = [
    //// Add all fields
    id,
    isEdit,
    time,

    idMonitoreo,
    snip,
    sequence,
    idAvanceFisicoPartida,
    avanceFisicoPartidaDesc,
    avanceFisicoPartida,
    imgPartidaEjecutada,
    idUsuario,
    usuario,
    txtIpReg,
  ];

  static String id = '_id';
  static String isEdit = 'isEdit';
  static String time = 'time';

  static String idMonitoreo = 'idMonitoreo';
  static String snip = 'snip';
  static String sequence = 'sequence';
  static String idAvanceFisicoPartida = 'idAvanceFisicoPartida';
  static String avanceFisicoPartidaDesc = 'avanceFisicoPartidaDesc';
  static String avanceFisicoPartida = 'avanceFisicoPartida';
  static String imgPartidaEjecutada = 'imgActividad';
  static String idUsuario = 'idUsuario';
  static String usuario = 'usuario';
  static String txtIpReg = 'txtIpReg';

  /*
   * Propiedades API
   */
  static String idMonitoreo_ = 'idMonitoreo';
  static String idUsuario_ = 'idUsuario';
  static String snip_ = 'snip';
  static String avanceFisicoAcumulado_ = 'avanceFisicoAcumulado';
  static String idAvanceFisicoPartida_ = 'idAvanceFisicoPartida';
  static String avanceFisicoPartida_ = 'avanceFisicoPartida';
  static String observaciones_ = 'observaciones';
  static String imgActividad1_ = 'imgActividad1';
  static String imgActividad2_ = 'imgActividad2';
  static String imgActividad3_ = 'imgActividad3';
  static String txtIpReg_ = 'txtIpReg';
}

class PartidaEjecutadaModel {
  int? id = 0;
  int? isEdit = 0;
  DateTime? createdTime;

  int? idAvanceFisicoPartida = 0;
  String? idMonitoreo = "";
  double? avanceFisicoPartida = 0.0;
  String? imgPartidaEjecutada = "";
  String? avanceFisicoPartidaDesc = "";
  int? sequence = 0;

  String? snip = '';
  String? txtIpReg = '';
  int? idUsuario = 0;
  String? usuario = '';

  PartidaEjecutadaModel.empty();

  PartidaEjecutadaModel({
    this.id,
    this.isEdit,
    this.createdTime,
    this.idMonitoreo,
    this.idAvanceFisicoPartida,
    this.avanceFisicoPartida,
    this.imgPartidaEjecutada,
    this.avanceFisicoPartidaDesc,
    this.sequence,
    this.snip,
    this.txtIpReg,
    this.idUsuario,
    this.usuario,
  });

  PartidaEjecutadaModel copy({
    int? id,
    int? isEdit,
    DateTime? createdTime,
    String? idMonitoreo,
    int? idAvanceFisicoPartida,
    double? avanceFisicoPartida,
    String? imgPartidaEjecutada,
    String? avanceFisicoPartidaDesc,
    int? sequence,
    String? snip,
    String? txtIpReg,
    int? idUsuario,
    String? usuario,
  }) =>
      PartidaEjecutadaModel(
        id: id ?? this.id,
        isEdit: isEdit ?? this.isEdit,
        createdTime: createdTime ?? this.createdTime,
        idMonitoreo: idMonitoreo ?? this.idMonitoreo,
        idAvanceFisicoPartida:
            idAvanceFisicoPartida ?? this.idAvanceFisicoPartida,
        avanceFisicoPartida: avanceFisicoPartida ?? this.avanceFisicoPartida,
        imgPartidaEjecutada: imgPartidaEjecutada ?? this.imgPartidaEjecutada,
        avanceFisicoPartidaDesc:
            avanceFisicoPartidaDesc ?? this.avanceFisicoPartidaDesc,
        sequence: sequence ?? this.sequence,
        snip: snip ?? this.snip,
        txtIpReg: txtIpReg ?? this.txtIpReg,
        idUsuario: idUsuario ?? this.idUsuario,
        usuario: usuario ?? this.usuario,
      );

  static PartidaEjecutadaModel fromJson(Map<String, Object?> json) =>
      PartidaEjecutadaModel(
        id: json[PartidaEjecutadaFld.id] as int?,
        isEdit: json[PartidaEjecutadaFld.isEdit] == null
            ? 0
            : json[PartidaEjecutadaFld.isEdit] as int,
        createdTime: json[PartidaEjecutadaFld.time] != null
            ? DateTime.parse(json[PartidaEjecutadaFld.time] as String)
            : null,
        idMonitoreo: json[PartidaEjecutadaFld.idMonitoreo] as String,
        idAvanceFisicoPartida:
            _getInt(json[PartidaEjecutadaFld.idAvanceFisicoPartida]),
        avanceFisicoPartida:
            _getDouble(json[PartidaEjecutadaFld.avanceFisicoPartida]),
        imgPartidaEjecutada:
            json[PartidaEjecutadaFld.imgPartidaEjecutada] as String,
        avanceFisicoPartidaDesc:
            json[PartidaEjecutadaFld.avanceFisicoPartidaDesc] as String,
        sequence: _getInt(json[PartidaEjecutadaFld.sequence]),
        snip: json[PartidaEjecutadaFld.snip] as String,
        txtIpReg: json[PartidaEjecutadaFld.txtIpReg] as String,
        idUsuario: _getInt(json[PartidaEjecutadaFld.idUsuario]),
        usuario: json[PartidaEjecutadaFld.usuario] as String,
      );

  Map<String, dynamic> toJson() => {
        //PartidaEjecutadaFields.id: id,
        PartidaEjecutadaFld.isEdit: isEdit,
        //PartidaEjecutadaFields.time: createdTime.toIso8601String(),

        PartidaEjecutadaFld.idMonitoreo: idMonitoreo,
        PartidaEjecutadaFld.snip: snip,
        PartidaEjecutadaFld.sequence: sequence,
        PartidaEjecutadaFld.idAvanceFisicoPartida: idAvanceFisicoPartida,
        PartidaEjecutadaFld.avanceFisicoPartidaDesc: avanceFisicoPartidaDesc,
        PartidaEjecutadaFld.avanceFisicoPartida: avanceFisicoPartida,
        PartidaEjecutadaFld.imgPartidaEjecutada: imgPartidaEjecutada,
        PartidaEjecutadaFld.idUsuario: idUsuario,
        PartidaEjecutadaFld.usuario: usuario,
        PartidaEjecutadaFld.txtIpReg: txtIpReg,
      };

  static Map<String, dynamic> toJsonObject(PartidaEjecutadaModel o) {
    return {
      PartidaEjecutadaFld.idMonitoreo: o.idMonitoreo,
      PartidaEjecutadaFld.idAvanceFisicoPartida: o.idAvanceFisicoPartida,
      PartidaEjecutadaFld.avanceFisicoPartida: o.avanceFisicoPartida,
      PartidaEjecutadaFld.imgPartidaEjecutada: o.imgPartidaEjecutada,
      PartidaEjecutadaFld.avanceFisicoPartidaDesc: o.avanceFisicoPartidaDesc,
      PartidaEjecutadaFld.sequence: o.sequence,
      PartidaEjecutadaFld.snip: o.snip,
      PartidaEjecutadaFld.txtIpReg: o.txtIpReg,
      PartidaEjecutadaFld.idUsuario: o.idUsuario,
      PartidaEjecutadaFld.usuario: o.usuario,
    };
  }

  static List<Map<String, dynamic>> toJsonArray(
      List<PartidaEjecutadaModel> aPartidaEjecutada) {
    List<Map<String, dynamic>> aList = [];
    for (var item in aPartidaEjecutada) {
      aList.add(PartidaEjecutadaModel.toJsonObject(item));
    }
    return aList;
  }

  /*
   * POST: .../registrarAvanceAcumuladoPartidaMonitereoMovil
   */
  static Map<String, String> toJsonObjectApi4(PartidaEjecutadaModel o) {
    return {
      PartidaEjecutadaFld.idMonitoreo_: _getString(o.idMonitoreo),
      PartidaEjecutadaFld.idAvanceFisicoPartida_:
          _getString(o.idAvanceFisicoPartida),
      PartidaEjecutadaFld.avanceFisicoAcumulado_:
          _getString(o.avanceFisicoPartida, type: 'D'),
      PartidaEjecutadaFld.snip_: _getString(o.snip),
      PartidaEjecutadaFld.idUsuario_: _getString(o.idUsuario, type: 'I'),
      PartidaEjecutadaFld.txtIpReg_: _getString(o.txtIpReg),
    };
  }

  List<PartidaEjecutadaModel> userFromJson(String sOject) {
    final jsonData = json.decode(sOject);
    return List<PartidaEjecutadaModel>.from(
        jsonData.map((x) => PartidaEjecutadaModel.fromJson(x)));
  }

  String userToJson(List<PartidaEjecutadaModel> aPartidaEjecutada) {
    final dyn = List<dynamic>.from(aPartidaEjecutada.map((x) => x.toJson()));
    return json.encode(dyn);
  }

  static double _getDouble(dynamic data) {
    return data != null ? double.parse(data.toString()) : 0.000;
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

  static DateTime _getDateTime(dynamic data) {
    return data != null ? DateTime.parse(data as String) : DateTime.now();
  }

  static int _getInt(dynamic data) {
    return data != null ? int.parse(data.toString()) : 0;
  }
}
