class ListaTipoGobiernoResponse {
  List<TipoGobiernoResponse> items = [];

  ListaTipoGobiernoResponse();

  ListaTipoGobiernoResponse.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final TipoGobierno = TipoGobiernoResponse.fromJson(item);
      items.add(TipoGobierno);
    }
  }
}

class TipoGobiernoResponse {
  int? idTipoGobierno;
  int? idSector;
  String? nombre;

  TipoGobiernoResponse.empty();

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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idTipoGobierno'] = idTipoGobierno;
    data['idSector'] = idSector;
    data['nombre'] = nombre;
    return data;
  }
}
