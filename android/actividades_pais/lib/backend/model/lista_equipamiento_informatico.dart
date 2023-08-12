class EquiposInformaticosFld {
  static String codigoPatrimonial = 'codigoPatrimonial';
  static String descripcion = 'descripcionBien';
  static String marca = 'marca';
  static String modelo = 'modelo';
  static String serie = 'serie';

  static String medida = 'medida';
  static String estado = 'estado';
  static String condicion = 'condicion';
  static String fechaRegistro = 'fechaRegistro';
  static String fechaContabilidad = 'fechaContabilidad';

  static String documAdquisicion = 'documAdquisi';
  static String fechaPriorizacion = 'fechasPriorizacion';
  static String valorAdquisicion = 'valorAdquisicion';
  static String valorDeprec = 'valorDeprec2021';
  static String valorNeto = 'valorNeto';

  static String priorizacionRenovacion = 'priorizadoRenovacion';
  static String tambo = 'tambo';
  static String centroPoblado = 'centroPoblado';
  static String distrito = 'distrito';
  static String departamento = 'departamento';

  static String provincia = 'provincia';
  static String snip = 'snip';
  static String categoria = 'categoria';
}

class EquipamientoInformaticoModel {
  String? codigoPatrimonial;
  String? descripcion;
  String? marca;
  String? modelo;
  String? serie;

  String? medida;
  String? estado;
  String? condicion;
  String? fechaRegistro;
  String? fechaContabilidad;

  String? documAdquisicion;
  String? fechaPriorizacion;
  double? valorAdquisicion;
  double? valorDeprec;
  double? valorNeto;

  String? priorizacionRenovacion;
  String? tambo;
  String? centroPoblado;
  String? distrito;
  String? departamento;

  String? provincia;
  String? snip;
  String? categoria;

  EquipamientoInformaticoModel.empty();

  EquipamientoInformaticoModel({
    this.codigoPatrimonial,
    this.descripcion,
    this.marca,
    this.modelo,
    this.serie,
    this.medida,
    this.estado,
    this.condicion,
    this.fechaRegistro,
    this.fechaContabilidad,
    this.documAdquisicion,
    this.fechaPriorizacion,
    this.valorAdquisicion,
    this.valorDeprec,
    this.valorNeto,
    this.priorizacionRenovacion,
    this.tambo,
    this.centroPoblado,
    this.distrito,
    this.departamento,
    this.provincia,
    this.snip,
    this.categoria,
  });

  factory EquipamientoInformaticoModel.fromJson(Map<String, dynamic> json) {
    return EquipamientoInformaticoModel(
      codigoPatrimonial: json[EquiposInformaticosFld.codigoPatrimonial],
      descripcion: json[EquiposInformaticosFld.descripcion],
      marca: json[EquiposInformaticosFld.marca],
      modelo: json[EquiposInformaticosFld.modelo],
      serie: json[EquiposInformaticosFld.serie],
      medida: json[EquiposInformaticosFld.medida],
      estado: json[EquiposInformaticosFld.estado],
      condicion: json[EquiposInformaticosFld.condicion],
      fechaRegistro: json[EquiposInformaticosFld.fechaRegistro],
      fechaContabilidad: json[EquiposInformaticosFld.fechaContabilidad],
      documAdquisicion: json[EquiposInformaticosFld.documAdquisicion],
      fechaPriorizacion: json[EquiposInformaticosFld.fechaPriorizacion],
      valorAdquisicion: json[EquiposInformaticosFld.valorAdquisicion],
      valorDeprec: json[EquiposInformaticosFld.valorDeprec],
      valorNeto: json[EquiposInformaticosFld.valorNeto],
      priorizacionRenovacion:
          json[EquiposInformaticosFld.priorizacionRenovacion],
      tambo: json[EquiposInformaticosFld.tambo],
      centroPoblado: json[EquiposInformaticosFld.centroPoblado],
      distrito: json[EquiposInformaticosFld.distrito],
      departamento: json[EquiposInformaticosFld.departamento],
      provincia: json[EquiposInformaticosFld.provincia],
      snip: json[EquiposInformaticosFld.snip],
      categoria: json[EquiposInformaticosFld.categoria],
    );
  }
}
