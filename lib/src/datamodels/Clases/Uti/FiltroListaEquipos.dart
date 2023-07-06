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
      this.pageSize = 0, this.anio='', this.codInventario=''});

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['codigoPatrimonial'] = this.codigoPatrimonial;
    data['denominacion'] = this.denominacion;
    data['id_marca'] = this.idMarca;
    data['id_modelo'] = this.idModelo;
    data['id_ubicacion'] = this.idUbicacion;
    data['responsableactual'] = this.responsableactual;
    data['pageIndex'] = this.pageIndex;
    data['pageSize'] = this.pageSize;
    data['anio'] = this.anio;
    data['codInventario'] = this.codInventario;
    return data;
  }
}
