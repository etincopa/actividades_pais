class ProgramacionMantenimientoField {
  static String ut = "ut";
  static String marzo = "marzo";
  static String abril = "abril";
  static String mayo = "mayo";
  static String junio = "junio";
  static String julio = "julio";
  static String agosto = "agosto";
  static String setiembre = "setiembre";
  static String octubre = "octubre";
}

class ProgramacionMantenimientoModel {
  String? ut;
  String? marzo;
  String? abril;
  String? mayo;
  String? junio;
  String? julio;
  String? agosto;
  String? setiembre;
  String? octubre;

  ProgramacionMantenimientoModel.empty();

  ProgramacionMantenimientoModel(
      {this.ut,
      this.marzo,
      this.abril,
      this.mayo,
      this.junio,
      this.julio,
      this.agosto,
      this.setiembre,
      this.octubre});

  factory ProgramacionMantenimientoModel.fromJson(Map<String, dynamic> json) {
    return ProgramacionMantenimientoModel(
      ut: json[ProgramacionMantenimientoField.ut],
      marzo: json[ProgramacionMantenimientoField.marzo],
      abril: json[ProgramacionMantenimientoField.abril],
      mayo: json[ProgramacionMantenimientoField.mayo],
      junio: json[ProgramacionMantenimientoField.junio],
      julio: json[ProgramacionMantenimientoField.julio],
      agosto: json[ProgramacionMantenimientoField.agosto],
      setiembre: json[ProgramacionMantenimientoField.setiembre],
      octubre: json[ProgramacionMantenimientoField.octubre],
    );
  }
}
