
class Nacimiento {
  int? id;
  int? idUsuario = 0;
  int? idParteDiario = 0;
  String? detalle;
  String? idUnicoReporte;
  int? idParteDiarioNacimiento;

  Nacimiento(
      {this.id,
      this.detalle,
      this.idUnicoReporte,
      this.idUsuario = 0,
      this.idParteDiario = 0,
      this.idParteDiarioNacimiento = 0});

  Nacimiento.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idUsuario = json['idUsuario'];
    idParteDiario = json['idParteDiario'];
    detalle = json['detalle'];
    idUnicoReporte = json['idUnicoReporte'];
    idParteDiarioNacimiento = json['idParteDiarioNacimiento'];
  }

  factory Nacimiento.fromMap(Map<String, dynamic> json) => Nacimiento(
        id: json['id'],
        // idUsuario: json['idUsuario'],
        //idParteDiario: json['idParteDiario'],
        detalle: json['detalle'],

        idUnicoReporte: json['idUnicoReporte'],
        idParteDiarioNacimiento: json['idParteDiarioNacimiento'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['idUsuario'] = idUsuario;
    data['idParteDiario'] = idParteDiario;
    data['detalle'] = detalle;

    data['idUnicoReporte'] = idUnicoReporte;
    data['idParteDiarioNacimiento'] = idParteDiarioNacimiento;

    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      "detalle": detalle,
      "idUnicoReporte": idUnicoReporte,
      "idParteDiarioNacimiento": idParteDiarioNacimiento,
    };
  }
}
