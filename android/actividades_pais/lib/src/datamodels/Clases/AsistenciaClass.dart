class AsistenciaClass {
  int numeroDni;
  String nombres;
  int snip;
  String nombreTambo;
  String modalidadTrabajo;
  int idModalidadTrabajo;
  var date;
  var dateSalida;
  String unidadorg;
  String cargo;
  String tipoasistencia;
  int idTipoasistencia;

  AsistenciaClass(
      {this.numeroDni = 0,
      this.nombres = '',
      this.snip = 0,
      this.nombreTambo = '',
      this.date = 0,
      this.dateSalida = 0,
      this.idModalidadTrabajo = 0,
      this.modalidadTrabajo = '',
      this.cargo = '',
      this.unidadorg = '',
      this.idTipoasistencia = 0,
      this.tipoasistencia = ''});

  Map<String, dynamic> toMap() {
    return {
      "numeroDni": numeroDni,
      "nombres": nombres,
      "snip": snip,
      "nombreTambo": nombreTambo,
      "modalidadTrabajo": modalidadTrabajo,
      "idModalidadTrabajo": idModalidadTrabajo,
      "cargo": cargo,
      "date": date,
      "dateSalida": dateSalida,
      "unidadorg": unidadorg,
      "idTipoasistencia": idTipoasistencia,
      "tipoasistencia": tipoasistencia
    };
  }

  factory AsistenciaClass.fromMap(Map<String, dynamic> map) => AsistenciaClass(
        numeroDni: map['numeroDni'],
        snip: map['snip'],
        nombreTambo: map['nombreTambo'],
        modalidadTrabajo: map['modalidadTrabajo'],
        idModalidadTrabajo: map['idModalidadTrabajo'],
        date: map['date'],
        dateSalida: map['dateSalida'],
        nombres: map['nombres'],
        cargo: map['cargo'],
        unidadorg: map['unidadorg'],
        tipoasistencia: map['tipoasistencia'],
        idTipoasistencia: map['idTipoasistencia'],
      );
}
