class ListaTipoGobiernoResponse {
  List<TipoGobiernoResponse> items = [];

  ListaTipoGobiernoResponse();

  ListaTipoGobiernoResponse.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final _TipoGobierno = new TipoGobiernoResponse.fromJson(item);
      items.add(_TipoGobierno);
    }
  }
}

class TipoGobiernoResponse {
  int? idTipoGobierno;
  int? idSector;
  String? nombre;

  TipoGobiernoResponse.empty() {}

  TipoGobiernoResponse({
    this.idTipoGobierno,
    this.idSector,
    this.nombre,
  });

  factory TipoGobiernoResponse.fromJson(Map<String, dynamic> json) {
    return TipoGobiernoResponse(
      idTipoGobierno: json['idTipoGogierno'] ?? 0,
      idSector: json['idSector'] ?? 0,
      nombre: json['nombre'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idTipoGobierno'] = idTipoGobierno;
    data['idSector'] = idSector;
    data['nombre'] = nombre;
    return data;
  }
}
