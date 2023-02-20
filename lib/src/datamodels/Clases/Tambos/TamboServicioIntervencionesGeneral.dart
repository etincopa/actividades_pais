class ListarTamboServicioIntervencionesGeneral {
  List<TamboServicioIntervencionesGeneral> items = [];

  ListarTamboServicioIntervencionesGeneral();

  ListarTamboServicioIntervencionesGeneral.fromJsonList(
      List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final _listarTrabajador =
          new TamboServicioIntervencionesGeneral.fromJson(item);
      items.add(_listarTrabajador);
    }
  }
}

class TamboServicioIntervencionesGeneral {
  int? idProgramacion;
  int? idTambo;
  String? tambo;
  String? tipoUsuario;
  String? sector;
  int? idPrograma;
  String? programa;
  String? descripcion;
  String? tipoEvento;
  String? fecha;
  String? imagen;
  String? pathImagen;
  String? fechaImagen;
  int? tipo;
  String? departamento;

  TamboServicioIntervencionesGeneral(
      {this.idProgramacion,
      this.idTambo,
      this.tambo,
      this.tipoUsuario,
      this.sector,
      this.idPrograma,
      this.programa,
      this.descripcion,
      this.tipoEvento,
      this.fecha,
      this.imagen,
      this.pathImagen,
      this.fechaImagen,
      this.tipo,
      this.departamento});

/*  TamboServicioIntervencionesGeneral.fromJson(Map<String, dynamic> json) {
    idProgramacion = json['idProgramacion'] ?? 0;
    idTambo = json['idTambo']?? 0;
    tambo = json['tambo']?? 0;
    tipoUsuario = json['tipoUsuario']?? 0;
    sector = json['sector']?? 0;
    idPrograma = json['idPrograma']?? 0;
    programa = json['programa']?? 0;
    descripcion = json['descripcion']?? 0;
    tipoEvento = json['tipoEvento']?? 0;
    fecha = json['fecha']?? 0;
    imagen = json['imagen']?? 0;
    pathImagen = json['pathImagen']?? 0;
    fechaImagen = json['fechaImagen']?? 0;
    tipo = json['tipo']?? 0;
    departamento = json['departamento']?? 0;
  }*/

  factory TamboServicioIntervencionesGeneral.fromJson(
      Map<String, dynamic> json) {
    //print("object ${ json['idProgramacion']}");
    return TamboServicioIntervencionesGeneral(
      idProgramacion: json['idProgramacion'] ?? 0,
      idTambo: json['idTambo'] ?? 0,
      tambo: json['tambo'] ?? 0,
      tipoUsuario: json['tipoUsuario'] ?? 0,
      sector: json['sector'] ?? 0,
      idPrograma: json['idPrograma'] ?? 0,
      programa: json['programa'] ?? 0,
      descripcion: json['descripcion'] ?? 0,
      tipoEvento: json['tipoEvento'] ?? 0,
      fecha: json['fecha'] ?? 0,
      imagen: json['imagen'] ?? 0,
      pathImagen: json['pathImagen'] ?? 0,
      fechaImagen: json['fechaImagen'] ?? 0,
      tipo: json['tipo'] ?? 0,
      departamento: json['departamento'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idProgramacion'] = this.idProgramacion;
    data['idTambo'] = this.idTambo;
    data['tambo'] = this.tambo;
    data['tipoUsuario'] = this.tipoUsuario;
    data['sector'] = this.sector;
    data['idPrograma'] = this.idPrograma;
    data['programa'] = this.programa;
    data['descripcion'] = this.descripcion;
    data['tipoEvento'] = this.tipoEvento;
    data['fecha'] = this.fecha;
    data['imagen'] = this.imagen;
    data['pathImagen'] = this.pathImagen;
    data['fechaImagen'] = this.fechaImagen;
    data['tipo'] = this.tipo;
    data['departamento'] = this.departamento;
    return data;
  }
}
