class MonitoresFld {
  static String idPlatarfoma = 'idPlatarfoma';
  static String snip = 'snip';
  static String tambo = 'tambo';
  static String idEmpleado = 'idEmpleado';
  static String apePaterno = 'apePaterno';
  static String apeMaterno = 'apeMaterno';
  static String nombre = 'nombre';
  static String documento = 'documento';
  static String celular = 'celular';
  static String correo = 'correo';
  static String path = 'path';
  static String tipoContrato = 'tipoContrato';
  static String estadoCivil = 'estadoCivil';
  static String genero = 'genero';
  static String brevete = 'brevete';
  static String unidadTerritorial = 'unidadTerritorial';
  static String utDireccion = 'utDireccion';
}

class MonitorTamboModel {
  String? idPlatarfoma = '';
  String? snip = '';
  String? tambo = '';
  String? idEmpleado = '';
  String? apePaterno = '';
  String? apeMaterno = '';
  String? nombre = '';
  String? documento = '';
  String? celular = '';
  String? correo = '';
  String? path = '';
  String? estadoCivil = '';
  String? tipoContrato = '';
  String? genero = '';
  String? brevete = '';
  String? unidadTerritorial = '';
  String? utDireccion = '';

  MonitorTamboModel.empty();

  MonitorTamboModel({
    this.idPlatarfoma,
    this.snip,
    this.tambo,
    this.idEmpleado,
    this.apePaterno,
    this.apeMaterno,
    this.nombre,
    this.documento,
    this.celular,
    this.correo,
    this.path,
    this.estadoCivil,
    this.tipoContrato,
    this.genero,
    this.brevete,
    this.unidadTerritorial,
    this.utDireccion,
  });

  factory MonitorTamboModel.fromJson(Map<String, dynamic> json) {
    return MonitorTamboModel(
      idPlatarfoma: json[MonitoresFld.idPlatarfoma],
      snip: json[MonitoresFld.snip],
      tambo: json[MonitoresFld.tambo],
      idEmpleado: json[MonitoresFld.idEmpleado],
      apePaterno: json[MonitoresFld.apePaterno],
      apeMaterno: json[MonitoresFld.apeMaterno],
      nombre: json[MonitoresFld.nombre],
      documento: json[MonitoresFld.documento],
      celular: json[MonitoresFld.celular],
      correo: json[MonitoresFld.correo],
      path: json[MonitoresFld.path],
      estadoCivil: json[MonitoresFld.estadoCivil],
      tipoContrato: json[MonitoresFld.tipoContrato],
      genero: json[MonitoresFld.genero],
      brevete: json[MonitoresFld.brevete],
      unidadTerritorial: json[MonitoresFld.unidadTerritorial],
      utDireccion: json[MonitoresFld.utDireccion],
    );
  }
}
