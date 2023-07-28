class ArchivosEvidencia {
  int? id;
  int? idParteDiario = 0;
  String? file = '';
  String? idUnicoReporte = '';

  ArchivosEvidencia({
    this.id,
    this.idParteDiario,
    this.file,
    this.idUnicoReporte,
  });

  ArchivosEvidencia.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idParteDiario = json['idParteDiario'];
    file = json['file'];
    idUnicoReporte = json['idUnicoReporte'];
  }

  factory ArchivosEvidencia.fromMap(Map<String, dynamic> json) =>
      ArchivosEvidencia(
        id: json['id'],
        idParteDiario: json['idParteDiario'],
        file: json['file'],
        idUnicoReporte: json['idUnicoReporte'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['idParteDiario'] = idParteDiario;
    data['file'] = file;
    data['idUnicoReporte'] = idUnicoReporte;
    return data;
  }

  Map<String, dynamic> toMap() {
    //idParteDiario,file, idUnicoReporte
    return {
      "idParteDiario": idParteDiario,
      "file": file,
      "idUnicoReporte": idUnicoReporte,
    };
  }
}
