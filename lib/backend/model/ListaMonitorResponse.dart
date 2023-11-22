class ListaMonitoresFld {
  static String idUnidadTerritorial = 'idUnidadTerritorial';
  static String unidadTerritorial = 'unidadTerritorial';
  static String idEmpleado = 'idEmpleado';
  static String nombres = 'nombres';
  static String documento = 'documento';
  static String celular = 'celular';
  static String correo = 'correo';
  static String genero = 'genero';
  static String estadoCivil = 'estadoCivil';
  static String apaterno = 'apaterno';
  static String amaterno = 'amaterno';
}

class ListaMonitorTamboModel {
  int? idUnidadTerritorial = 0;
  String? unidadTerritorial = '';
  int? idEmpleado = 0;
  String? nombres = '';
  String? documento = '';
  String? celular = '';
  String? correo = '';
  String? genero = '';
  String? estadoCivil = '';
  String? apaterno = '';
  String? amaterno = '';

  ListaMonitorTamboModel.empty();

  ListaMonitorTamboModel({
    this.idUnidadTerritorial,
    this.unidadTerritorial,
    this.idEmpleado,
    this.nombres,
    this.documento,
    this.celular,
    this.correo,
    this.genero,
    this.estadoCivil,
    this.apaterno,
    this.amaterno,
  });

  factory ListaMonitorTamboModel.fromJson(Map<String, dynamic> json) {
    return ListaMonitorTamboModel(
      idUnidadTerritorial: json[ListaMonitoresFld.idUnidadTerritorial],
      unidadTerritorial: json[ListaMonitoresFld.unidadTerritorial],
      idEmpleado: json[ListaMonitoresFld.idEmpleado],
      nombres: json[ListaMonitoresFld.nombres],
      documento: json[ListaMonitoresFld.documento],
      celular: json[ListaMonitoresFld.celular],
      correo: json[ListaMonitoresFld.correo],
      genero: json[ListaMonitoresFld.genero],
      estadoCivil: json[ListaMonitoresFld.estadoCivil],
      apaterno: json[ListaMonitoresFld.apaterno],
      amaterno: json[ListaMonitoresFld.amaterno],
    );
  }
}
