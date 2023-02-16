
class IntentosRegistrosFallecidos {
  int? id;
  int? idPlataforma;
  int? idProgramacion;
  String? dni;
  String? idUsuarioReg;
  String? fechaReg;
  String? ipmaqReg;

  IntentosRegistrosFallecidos(
      {
        this.id,
        this.idPlataforma,
        this.idProgramacion,
        this.dni,
        this.idUsuarioReg,
        this.fechaReg,
        this.ipmaqReg,

      });

  factory IntentosRegistrosFallecidos.fromMap(Map<String, dynamic> json) =>
      IntentosRegistrosFallecidos(
        id: json['id'],
        idPlataforma: json['id_plataforma'],
        idProgramacion: json['id_programacion'],
        dni: json['dni'],
        idUsuarioReg: json['id_usuario_reg'],
        fechaReg: json['fecha_reg'],
        ipmaqReg: json['ipmaq_reg'],
      );
  Map<String, dynamic> toMap() {
    return {
      "id_plataforma": idPlataforma,
      "id_programacion": idProgramacion,
      "dni": dni,
      "id_usuario_reg": idUsuarioReg,
      "fecha_reg": fechaReg,
      "ipmaq_reg": ipmaqReg,

    };
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idPlataforma'] = this.idPlataforma;
    data['idProgramacion'] = this.idProgramacion;
    data['dni'] = this.dni;
    data['idUsuarioReg'] = this.idUsuarioReg;
    data['fechaReg'] = this.fechaReg;
    data['ipmaqReg'] = this.ipmaqReg;


    return data;
  }
}
