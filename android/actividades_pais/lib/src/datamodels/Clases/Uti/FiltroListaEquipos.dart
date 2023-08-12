class FiltroParqueInformatico {
  String? codigoPatrimonial;
  String? denominacion;
  String? idMarca;
  String? idModelo;
  String? idUbicacion;
  String? responsableactual;
  int? pageIndex;
  int? pageSize;

  String? anio;

  String? codInventario;

  FiltroParqueInformatico(
      {this.codigoPatrimonial = '',
      this.denominacion = '',
      this.idMarca = '',
      this.idModelo = '',
      this.idUbicacion = '',
      this.responsableactual = '',
      this.pageIndex = 0,
      this.pageSize = 0,
      this.anio = '',
      this.codInventario = ''});

  FiltroParqueInformatico.fromJson(Map<String, dynamic> json) {
    codigoPatrimonial = json['codigoPatrimonial'] ?? '';
    denominacion = json['denominacion'] ?? '';
    idMarca = json['id_marca'] ?? '';
    idModelo = json['id_modelo'] ?? '';
    idUbicacion = json['id_ubicacion'] ?? '';
    responsableactual = json['responsableactual'] ?? '';
    pageIndex = json['pageIndex'] ?? 1;
    pageSize = json['pageSize'] ?? 10;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['codigoPatrimonial'] = codigoPatrimonial;
    data['denominacion'] = denominacion;
    data['id_marca'] = idMarca;
    data['id_modelo'] = idModelo;
    data['id_ubicacion'] = idUbicacion;
    data['responsableactual'] = responsableactual;
    data['pageIndex'] = pageIndex;
    data['pageSize'] = pageSize;
    data['anio'] = anio;
    data['codInventario'] = codInventario;
    return data;
  }
}
