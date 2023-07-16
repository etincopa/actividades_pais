
class ListaDatosPlanMensual {
  List<DatosPlanMensual> items = [];
  ListaDatosPlanMensual();
  ListaDatosPlanMensual.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final listarTrabajador = DatosPlanMensual.fromJson(item);
      items.add(listarTrabajador);
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_programacion'] = idProgramacion;
    data['plataforma_descripcion'] = plataformaDescripcion;
    data['unidad_territorial_descripcion'] = unidadTerritorialDescripcion;
    data['fecha'] = fecha;
    data['nombre'] = nombre;
    data['nombre_sector'] = nombreSector;
    data['descripcion_intervencion'] = descripcionIntervencion;
    data['nombre_programa'] = nombrePrograma;
    data['id_evaluacion'] = idEvaluacion;
    data['observacion'] = observacion;
    data['id_plan_trabajo'] = idPlanTrabajo;
    data['tipo_plan'] = tipoPlan;
    data['codigo_plan'] = codigoPlan;
    data['total'] = total;
    return data;
  }
}