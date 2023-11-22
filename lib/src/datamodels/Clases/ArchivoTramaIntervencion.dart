
class ArchivoTramaIntervenciones {
  List<ArchivoTramaIntervencion> items = [];
  ArchivoTramaIntervenciones();
  ArchivoTramaIntervenciones.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final listarTrabajador = ArchivoTramaIntervencion.fromJson(item);
      items.add(listarTrabajador);
    }
  }
}

class ArchivoTramaIntervencion {
  int? id;
  String? codigoIntervencion;
  String? file;
  String? fileEncode;
  int? nmero;

  ArchivoTramaIntervencion(
      {this.codigoIntervencion, this.file, this.fileEncode, this.nmero, this.id});

  ArchivoTramaIntervencion.fromJson(Map<String, dynamic> json) {
    codigoIntervencion = json['codigoIntervencion'];
    file = json['file'];
    fileEncode = json['fileEncode'];
    nmero = json['nmero'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['codigoIntervencion'] = codigoIntervencion;
    data['file'] = file;
    data['fileEncode'] = fileEncode;
    data['nmero'] = nmero;
    data['id'] = id;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      "codigoIntervencion": codigoIntervencion,
      "file": file,
      "fileEncode": fileEncode,
      "nmero": nmero
    };
  }

  factory ArchivoTramaIntervencion.fromMap(Map<String, dynamic> json) =>
      ArchivoTramaIntervencion(
        codigoIntervencion: json['codigoIntervencion'],
        file: json['file'],
        fileEncode: json['fileEncode'],
        nmero: json['nmero'],
        id: json['id'],
      );
}
