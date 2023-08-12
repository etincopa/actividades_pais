class ProgIntervemcionTamboFld {
  static String idProgramacion = 'idProgramacion';
  static String idPlataforma = 'idPlataforma';
  static String tipoProgramacion = 'tipoProgramacion';
  static String estadoProgramacion = 'estadoProgramacion';
  static String puntos = 'puntos';
  static String nombrePlataforma = 'nombrePlataforma';
  static String fecha = 'fecha';
  static String descripcion = 'descripcion';
}

class ProgIntervencionTamboModel {
  int? idProgramacion = 0;
  int? idPlataforma = 0;
  int? tipoProgramacion = 0;
  int? estadoProgramacion = 0;
  int? puntos = 0;
  String? nombrePlataforma = '';
  String? fecha = '';
  String? descripcion = '';

  ProgIntervencionTamboModel.empty();

  ProgIntervencionTamboModel({
    this.idProgramacion,
    this.idPlataforma,
    this.tipoProgramacion,
    this.estadoProgramacion,
    this.puntos,
    this.nombrePlataforma,
    this.fecha,
    this.descripcion,
  });

  ProgIntervencionTamboModel copy({
    int? idProgramacion,
    int? idPlataforma,
    int? tipoProgramacion,
    int? estadoProgramacion,
    int? puntos,
    String? nombrePlataforma,
    String? fecha,
    String? descripcion,
  }) =>
      ProgIntervencionTamboModel(
        idProgramacion: idProgramacion ?? this.idProgramacion,
        idPlataforma: idPlataforma ?? this.idPlataforma,
        tipoProgramacion: tipoProgramacion ?? this.tipoProgramacion,
        estadoProgramacion: estadoProgramacion ?? this.estadoProgramacion,
        puntos: puntos ?? this.puntos,
        nombrePlataforma: nombrePlataforma ?? this.nombrePlataforma,
        fecha: fecha ?? this.fecha,
        descripcion: descripcion ?? this.descripcion,
      );

  factory ProgIntervencionTamboModel.fromJson(Map<String, dynamic> json) {
    return ProgIntervencionTamboModel(
      idProgramacion: json[ProgIntervemcionTamboFld.idProgramacion],
      idPlataforma: json[ProgIntervemcionTamboFld.idPlataforma],
      tipoProgramacion: json[ProgIntervemcionTamboFld.tipoProgramacion],
      estadoProgramacion: json[ProgIntervemcionTamboFld.estadoProgramacion],
      puntos: json[ProgIntervemcionTamboFld.puntos],
      nombrePlataforma: json[ProgIntervemcionTamboFld.nombrePlataforma],
      fecha: json[ProgIntervemcionTamboFld.fecha],
      descripcion: json[ProgIntervemcionTamboFld.descripcion],
    );
  }
}
