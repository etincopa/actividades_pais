class Archivos{
  int? id;
  int? idNacimiento=0;
  int? idParteDiario=0;
  String? file='';
  String? idUnicoReporte='';
  int? idParteDiarioNacimiento=0;

  Archivos(
      {this.id,
        this.idNacimiento,
        this.idParteDiario,
        this.file,
        this.idUnicoReporte,
        this.idParteDiarioNacimiento,
        });

  Archivos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idNacimiento = json['idNacimiento'];
    idParteDiario = json['idParteDiario'];
    file = json['file'];
    idUnicoReporte = json['idUnicoReporte'];
    idParteDiarioNacimiento = json['idParteDiarioNacimiento'];
  }

  factory Archivos.fromMap(Map<String, dynamic> json) => Archivos(
      id : json['id'],
      idNacimiento : json['idNacimiento'],
      idParteDiario : json['idParteDiario'],
      file : json['file'],
      idUnicoReporte : json['idUnicoReporte'],
    idParteDiarioNacimiento : json['idParteDiarioNacimiento'],
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['idNacimiento'] = idNacimiento;
    data['idParteDiario'] = idParteDiario;
    data['file'] = file;
    data['idUnicoReporte'] = idUnicoReporte;
    data['idParteDiarioNacimiento'] = idParteDiarioNacimiento;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      "idNacimiento": idNacimiento,
      "idParteDiario": idParteDiario,
      "file": file,
      "idUnicoReporte": idUnicoReporte,
      "idParteDiarioNacimiento": idParteDiarioNacimiento
    };
  }
}