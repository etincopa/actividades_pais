
class ListaDatosPlanMensual {
  List<DatosPlanMensual> items = [];
  ListaDatosPlanMensual();
  ListaDatosPlanMensual.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final _listarTrabajador = new DatosPlanMensual.fromJson(item);
      items.add(_listarTrabajador);
    }
  }
}

class DatosPlanMensual {
  String? idProgramacion;
  String? plataformaDescripcion;
  String? unidadTerritorialDescripcion;
  String? fecha;
  String? nombre;
  String? nombreSector;
  String? descripcionIntervencion;
  String? nombrePrograma;
  String? idEvaluacion;
  String? observacion;
  String? idPlanTrabajo;
  String? tipoPlan;
  String? codigoPlan;
  String? total;

  DatosPlanMensual({this.idProgramacion, this.plataformaDescripcion, this.unidadTerritorialDescripcion, this.fecha, this.nombre, this.nombreSector, this.descripcionIntervencion, this.nombrePrograma, this.idEvaluacion, this.observacion, this.idPlanTrabajo, this.tipoPlan, this.codigoPlan, this.total});

  DatosPlanMensual.fromJson(Map<String, dynamic> json) {
    idProgramacion = json['id_programacion']??'';
    plataformaDescripcion = json['plataforma_descripcion']??'';
    unidadTerritorialDescripcion = json['unidad_territorial_descripcion']??'';
    fecha = json['fecha']??'';
    nombre = json['nombre']??'';
    nombreSector = json['nombre_sector']??'';
    descripcionIntervencion = json['descripcion_intervencion']??'';
    nombrePrograma = json['nombre_programa']??'';
    idEvaluacion = json['id_evaluacion']??'';
    observacion = json['observacion']??'';
    idPlanTrabajo = json['id_plan_trabajo']??'';
    tipoPlan = json['tipo_plan']??'';
    codigoPlan = json['codigo_plan']??'';
    total = json['total']??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_programacion'] = this.idProgramacion;
    data['plataforma_descripcion'] = this.plataformaDescripcion;
    data['unidad_territorial_descripcion'] = this.unidadTerritorialDescripcion;
    data['fecha'] = this.fecha;
    data['nombre'] = this.nombre;
    data['nombre_sector'] = this.nombreSector;
    data['descripcion_intervencion'] = this.descripcionIntervencion;
    data['nombre_programa'] = this.nombrePrograma;
    data['id_evaluacion'] = this.idEvaluacion;
    data['observacion'] = this.observacion;
    data['id_plan_trabajo'] = this.idPlanTrabajo;
    data['tipo_plan'] = this.tipoPlan;
    data['codigo_plan'] = this.codigoPlan;
    data['total'] = this.total;
    return data;
  }
}