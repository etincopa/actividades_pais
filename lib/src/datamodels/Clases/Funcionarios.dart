class ListaFuncionarios {
  List<Funcionarios> items = [];

  ListaFuncionarios();

  ListaFuncionarios.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final listarTrabajador = Funcionarios.fromJson(item);
      items.add(listarTrabajador);
    }
  }
}

class Funcionarios {
  int idProgramacion;
  String cargo;
  String telefono;
  String nombres;
  String apellidoPaterno;
  String apellidoMaterno;
  String dni;
  String ubigeoCcpp;
  int idActividad;
  int idEntidad;
  String numDocExtranjero;
  int idPais;
  int idTipoDocumento;
  String tipoDocumento;
  String nombreCargo;
  int idUsuario;
  String txtIpmaq;

  int id;
  String flgReniec;
  String tipo; //funcionario EX o peruano
  // String documento; //doc funcionario ex
  //String dni;
  String pais;

  // String nombre;
  // String apePaterno;
  // String apellidoMaterno;
  String datos;
  String entidad;

  //String cargo;
  int estado;
  String estado_registro = "";

  String? idProgramacionFuncionario="";
  String? idFuncionario="";
  String? apellidopaterno="";
  String? apellidomaterno="";

  Funcionarios({
    this.id = 0,
    this.flgReniec = '',
    this.tipo = '',
    this.dni = '',
    this.pais = '',
    this.datos = '',
    this.entidad = '',
    this.nombreCargo = '',
    this.telefono = '',
    this.apellidoMaterno = '',
    this.nombres = '',
    this.apellidoPaterno = '',
    this.idProgramacion = 0,
    this.cargo = '',
    this.estado = 0,
    this.idActividad = 0,
    this.idEntidad = 0,
    this.idPais = 0,
    this.idTipoDocumento = 0,
    this.idUsuario = 0,
    this.numDocExtranjero = '',
    this.txtIpmaq = '',
    this.ubigeoCcpp = '',
    this.tipoDocumento = '',
    this.estado_registro = "",
    this.idProgramacionFuncionario = "",
    this.idFuncionario = "",
    this.apellidopaterno = "",
    this.apellidomaterno = "",
  });

  factory Funcionarios.fromJson(Map<String, dynamic> json) {
    return Funcionarios(
        estado: json['estado'] ?? 0,
        id: json['id'] ?? 0,
        flgReniec: json['flgReniec'] ?? '',
        tipo: json['tipo'] ?? '',
        dni: json['dni'] ?? '',
        pais: json['pais'] ?? '',
        datos: json['datos'] ?? '',
        entidad: json['entidad'] ?? '',
        nombreCargo: json['nombreCargo'] ?? '',
        telefono: json['telefono'] ?? '',
        apellidoPaterno: json['apellidoPaterno'] ?? '',
        nombres: json['nombres'] ?? '',
        apellidoMaterno: json['apellidoMaterno'] ?? '',
        idProgramacion: json['idProgramacion'] ?? 0,
        cargo: json['cargo'] ?? '',
        idActividad: json['idActividad'] ?? 0,
        idEntidad: json['idEntidad'] ?? 0,
        idPais: json['idPais'] ?? 0,
        idTipoDocumento: json['idTipoDocumento'] ?? 0,
        tipoDocumento: json['tipoDocumento'] ?? '',
        idUsuario: json['idUsuario'] ?? 0,
        numDocExtranjero: json['numDocExtranjero'] ?? '',
        txtIpmaq: json['txtIpmaq'] ?? '',
        ubigeoCcpp: json['ubigeoCcpp'] ?? '');
  }

  factory Funcionarios.fromJsonReniec(Map<String, dynamic> json) {
    return Funcionarios(
      apellidoPaterno: json['apellido_paterno'],
      apellidoMaterno: json['apellido_materno'],
      nombres: json['nombres'],
      dni: json['dni'],
    );
  }

  factory Funcionarios.fromJsonTabla(Map<String, dynamic> json) {
    return Funcionarios(
      idProgramacionFuncionario : json['id_programacion_funcionario'],
      idProgramacion : int.parse(json['id_programacion']),
      idFuncionario : json['id_funcionario'],
      entidad : json['entidad'],
      telefono : json['telefono'],
      nombres : json['nombres'],
      dni : json['dni'],
      apellidopaterno : json['apellidopaterno'],
      apellidomaterno : json['apellidomaterno'],
      numDocExtranjero : json['num_doc_extranjero'],
      pais : json['pais'],
      tipoDocumento : json['tipo_documento'],
      cargo : json['cargo'],
    );
  }



  factory Funcionarios.fromMap(Map<String, dynamic> json) {
    return Funcionarios(
      id: json['id'],
      estado: json['estado'],
      flgReniec: json['flgReniec'],
      tipo: json['tipo'],
      dni: json['dni'],
      pais: json['pais'],
      datos: json['datos'],
      entidad: json['entidad'],
      nombreCargo: json['nombreCargo'],
      telefono: json['telefono'],
      apellidoPaterno: json['apellidoPaterno'],
      nombres: json['nombres'],
      apellidoMaterno: json['apellidoMaterno'],
      idProgramacion: json['idProgramacion'],
      cargo: json['cargo'],
      idActividad: json['idActividad'],
      idEntidad: json['idEntidad'],
      idPais: json['idPais'],
      idTipoDocumento: json['idTipoDocumento'],
      tipoDocumento: json['tipoDocumento'],
      idUsuario: json['idUsuario'],
      numDocExtranjero: json['numDocExtranjero'],
      txtIpmaq: json['txtIpmaq'],
      ubigeoCcpp: json['ubigeoCcpp'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['flgReniec'] = flgReniec;
    data['tipo'] = tipo;
    data['dni'] = dni;
    data['pais'] = pais;
    data['datos'] = datos;
    data['entidad'] = entidad;
    data['nombreCargo'] = nombreCargo;
    data['telefono'] = telefono;
    data['apellidoPaterno'] = apellidoPaterno;
    data['apellidoMaterno'] = apellidoMaterno;
    data['nombres'] = nombres;
    data['idProgramacion'] = idProgramacion;
    data['idProgramacion'] = idProgramacion;
    data['cargo'] = cargo;
    data['idActividad'] = idActividad;
    data['idEntidad'] = idEntidad;
    data['idPais'] = idPais;
    data['idTipoDocumento'] = idTipoDocumento;
    data['tipoDocumento'] = tipoDocumento;
    data['idUsuario'] = idUsuario;
    data['numDocExtranjero'] = numDocExtranjero;
    data['txtIpmaq'] = txtIpmaq;
    data['ubigeoCcpp'] = ubigeoCcpp;

    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      ///  "id": id,
      "estado": estado,
      "flgReniec": flgReniec,
      "tipo": tipo,
      "dni": dni,
      "pais": pais,
      "datos": datos,
      "entidad": entidad,
      "nombreCargo": nombreCargo,
      "telefono": telefono,
      "apellidoPaterno": apellidoPaterno,
      "nombres": nombres,
      "apellidoMaterno": apellidoMaterno,
      "idProgramacion": idProgramacion,
      "cargo": cargo,
      "idActividad": idActividad,
      "idEntidad": idEntidad,
      "idPais": idPais,
      "idTipoDocumento": idTipoDocumento,
      "tipoDocumento": tipoDocumento,
      "idUsuario": idUsuario,
      "numDocExtranjero": numDocExtranjero,
      "txtIpmaq": txtIpmaq,
      "ubigeoCcpp": ubigeoCcpp,
    };
  }
}
