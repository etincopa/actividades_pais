class MantenimientoInfraestructuraFld {
  static String snip = 'snipNumero';
  static String departamento = 'departamento';
  static String provincia = 'provincia';
  static String tambo = 'tambo';
  static String inicioFuncionamiento = 'anioInicioFuncionamiento';
  static String ultimaIntervencion = 'ultimaIntervencion';

  static String situacion = 'situacion';
  static String montoMantenimiento = 'mantenimientoInfraestructura';
  static String montoPozo = 'pozoTierra';
  static String montoCambioBateria = 'cambioBaterias';
}

class PlanMantenimientoInfraestructuraModel {
  String? snip;
  String? departamento;
  String? provincia;
  String? tambo;
  String? inicioFuncionamiento;
  String? ultimaIntervencion;
  String? situacion;
  String? montoMantenimientoInfraestructura;
  String? pozoTierra;
  String? cambioBaterias;

  PlanMantenimientoInfraestructuraModel.empty();

  PlanMantenimientoInfraestructuraModel(
      {this.snip,
      this.departamento,
      this.provincia,
      this.tambo,
      this.inicioFuncionamiento,
      this.ultimaIntervencion,
      this.situacion,
      this.montoMantenimientoInfraestructura,
      this.pozoTierra,
      this.cambioBaterias});

  factory PlanMantenimientoInfraestructuraModel.fromJson(
      Map<String, dynamic> json) {
    return PlanMantenimientoInfraestructuraModel(
      snip: json[MantenimientoInfraestructuraFld.snip],
      departamento: json[MantenimientoInfraestructuraFld.departamento],
      provincia: json[MantenimientoInfraestructuraFld.provincia],
      tambo: json[MantenimientoInfraestructuraFld.tambo],
      inicioFuncionamiento:
          json[MantenimientoInfraestructuraFld.inicioFuncionamiento],
      ultimaIntervencion:
          json[MantenimientoInfraestructuraFld.ultimaIntervencion],
      situacion: json[MantenimientoInfraestructuraFld.situacion],
      montoMantenimientoInfraestructura:
          json[MantenimientoInfraestructuraFld.montoMantenimiento],
      pozoTierra: json[MantenimientoInfraestructuraFld.montoPozo],
      cambioBaterias: json[MantenimientoInfraestructuraFld.montoCambioBateria],
    );
  }
}
