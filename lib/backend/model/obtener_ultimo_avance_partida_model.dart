import 'dart:convert';

String tableNameUltimoAvancePartida = 'obtenerUltimoAvancePartida';

class UltimoAvancePartidaFld {
  static final List<String> values = [
    ////Add all fields
    id,
    isEdit,
    time,

    numSnip,
    idTambo,
    idMonitoreo,
    idAvanceFisicoPartida,
    avanceFisicoPartida,
  ];
  /*
   * Propiedades DB
   */
  static String id = '_id';
  static String isEdit = 'isEdit';
  static String time = 'time';

  static String numSnip = 'numSnip';
  static String idTambo = 'idTambo';
  static String idMonitoreo = 'idMonitoreo';
  static String idAvanceFisicoPartida = 'idAvanceFisicoPartida';
  static String avanceFisicoPartida = 'avanceFisicoPartida';
}

class UltimoAvancePartidaModel {
  int? id = 0;
  int? isEdit = 0;
  DateTime? createdTime = null;

  String? numSnip;
  int? idTambo;
  int? idMonitoreo;
  int? idAvanceFisicoPartida;
  double? avanceFisicoPartida;

  UltimoAvancePartidaModel.empty() {}

  UltimoAvancePartidaModel({
    this.id,
    this.isEdit,
    this.createdTime,
    this.numSnip,
    this.idTambo,
    this.idMonitoreo,
    this.idAvanceFisicoPartida,
    this.avanceFisicoPartida,
  });

  UltimoAvancePartidaModel copy({
    int? id,
    int? isEdit,
    DateTime? createdTime,
    String? numSnip,
    int? idTambo,
    int? idMonitoreo,
    int? idAvanceFisicoPartida,
    double? avanceFisicoPartida,
  }) =>
      UltimoAvancePartidaModel(
        id: id ?? this.id,
        isEdit: isEdit ?? this.isEdit,
        createdTime: createdTime ?? this.createdTime,
        numSnip: numSnip ?? this.numSnip,
        idTambo: idTambo ?? this.idTambo,
        idMonitoreo: idMonitoreo ?? this.idMonitoreo,
        idAvanceFisicoPartida:
            idAvanceFisicoPartida ?? this.idAvanceFisicoPartida,
        avanceFisicoPartida: avanceFisicoPartida ?? this.avanceFisicoPartida,
      );

  Map<String, dynamic> toJson() => {
        UltimoAvancePartidaFld.isEdit: isEdit,
        UltimoAvancePartidaFld.numSnip: numSnip,
        UltimoAvancePartidaFld.idTambo: idTambo,
        UltimoAvancePartidaFld.idMonitoreo: idMonitoreo,
        UltimoAvancePartidaFld.idAvanceFisicoPartida: idAvanceFisicoPartida,
        UltimoAvancePartidaFld.avanceFisicoPartida: avanceFisicoPartida,
      };

  factory UltimoAvancePartidaModel.fromJson(Map<String, dynamic> json) {
    return UltimoAvancePartidaModel(
      id: json[UltimoAvancePartidaFld.id] == null
          ? 0
          : json[UltimoAvancePartidaFld.id] as int?,
      isEdit: json[UltimoAvancePartidaFld.isEdit] == null
          ? 0
          : json[UltimoAvancePartidaFld.isEdit] as int,
      createdTime: json[UltimoAvancePartidaFld.time] != null
          ? DateTime.parse(json[UltimoAvancePartidaFld.time] as String)
          : null,
      numSnip: json[UltimoAvancePartidaFld.numSnip],
      idTambo: json[UltimoAvancePartidaFld.idTambo],
      idMonitoreo: json[UltimoAvancePartidaFld.idMonitoreo],
      idAvanceFisicoPartida: json[UltimoAvancePartidaFld.idAvanceFisicoPartida],
      avanceFisicoPartida: json[UltimoAvancePartidaFld.avanceFisicoPartida],
    );
  }
}
