class ListaParticipantes {
  List<Participantes> items = [];
  ListaParticipantes();
  ListaParticipantes.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final _listarTrabajador = new Participantes.fromJson(item);
      items.add(_listarTrabajador);
    }
  }
}

class ListaParticipantesSer{
  List<Participantes> items = [];
  ListaParticipantesSer();
  ListaParticipantesSer.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final _listarTrabajador = new Participantes.fromJsonSERICIO(item);
      items.add(_listarTrabajador);
    }
  }
}

class Participantes {
  int? id;

  int? idProgramacion;
  //PARTICIPANTE
  String? dni;
  String? primerNombre;
  String? segundoNombre = '';
  String? apellidoPaterno;
  String? apellidoMaterno;
  int? edad;
  String? sexo;
  String? ubigeoCcpp;
  String? nombreCcpp;
  String? nombreResidencia;
  String? flatResidencia;
  String? fechaNacimiento;
  String? provincia;
  String? distrito;
  String? centroPoblado;
  int? idCentroPoblado;
  String? numDocExtranjero;
  //PROGRAMACION_PARTICIPANTES
  int? idEntidad;
  String? entidad;
  int? idPais;
  String? pais;
  int? idTipoDocumento;
  String? tipoDocumento;

  int? idServicio;
  String? servicio;
  int? idUsuario;
  String? txtIpmaq;
  String? tipo;

  int? tipoParticipante;
  int? idParticipante;

  String? estado;

  String? correlativo;
  String? id_programacion_participante;
  String? nombre;
  String? nombre2;
  String? fecha_nacimiento;
  String? pais_nombre;
  String? tipo_documento_siglas;
  String? nombre_programa;
  String? estado_padron;
  String? total;

  Participantes(
      {this.id = 0,
      this.idProgramacion = 0,
      this.tipoDocumento = '',
      this.dni = '',
      this.primerNombre = '',
      this.segundoNombre = '',
      this.apellidoPaterno = '',
      this.apellidoMaterno = '',
      this.edad = 0,
      this.fechaNacimiento = '',
      this.sexo = '',
      this.ubigeoCcpp = '',
      this.nombreCcpp = '',
      this.nombreResidencia = '',
      this.entidad = '',
      this.servicio = '',
      this.provincia = '',
      this.distrito = '',
      this.idCentroPoblado = 0,
      this.centroPoblado = '',
      this.flatResidencia = '',
      this.idEntidad = 0,
      this.idPais = 0,
      this.pais = '',
      this.idServicio = 0,
      this.idTipoDocumento = 0,
      this.idUsuario = 0,
      this.numDocExtranjero = '',
      this.txtIpmaq = '',
      this.tipo = '',
      this.tipoParticipante = 0,
      this.idParticipante = 0,this.estado = "",
        this.correlativo,
        this.id_programacion_participante,
        this.nombre,
        this.nombre2,
        this.fecha_nacimiento,
        this.pais_nombre,
        this.tipo_documento_siglas,
        this.nombre_programa,
        this.estado_padron,
        this.total,});

  Participantes.fromJsonSERICIO(Map<String, dynamic> json) {
    id = json['id']??0;
    idParticipante = json['id_participante']??0;
    dni = json['DNI']??'';
    primerNombre = json['PRIMER_NOMBRE']??'';
    segundoNombre = json['SEGUNDO_NOMBRE']??'';
    apellidoPaterno = json['APELLIDO_PATERNO']??'';
    apellidoMaterno = json['APELLIDO_MATERNO']??'';
    sexo = json['SEXO']??'';
    fechaNacimiento = json['FECHA_NACIMIENTO']??'';
    // un = json['UNIDAD_TERRITORIAL'];

  }
  factory Participantes.fromJson(Map<String, dynamic> json) {
    return Participantes(
        id: json['id']??0,
        idProgramacion: json['idProgramacion']??0,
        tipoDocumento: json['tipoDocumento']??0,
        dni: json['dni']??'',
        primerNombre: json['primerNombre']??'',
        segundoNombre: json['segundoNombre']??'',
        apellidoPaterno: json['apellidoPaterno']??'',
        apellidoMaterno: json['apellidoMaterno']??'',
        edad: json['edad']??0,
        fechaNacimiento: json['fechaNacimiento']??'',
        sexo: json['sexo']??'',
        ubigeoCcpp: json['ubigeoCcpp']??'',
        nombreCcpp: json['nombreCcpp']??'',
        nombreResidencia: json['nombreResidencia']??'',
        entidad: json['entidad']??'',
        servicio: json['servicio']??'',
        provincia: json['provincia']??'',
        distrito: json['distrito']??'',
        idCentroPoblado: json['idCentroPoblado']??0,
        centroPoblado: json['centroPoblado']??'',
        flatResidencia: json['flatResidencia']??'',
        idEntidad: json['idEntidad']??0,
        idPais: json['idPais']??0,
        pais: json['pais']??'',
        idServicio: json['idServicio']??0,
        idTipoDocumento: json['idTipoDocumento']??0,
        idUsuario: json['idUsuario']??0,
        numDocExtranjero: json['numDocExtranjero'],
        txtIpmaq: json['txtIpmaq']??'',
        tipo: json['tipo']??'',
        tipoParticipante: json['tipoParticipante']??'',
        idParticipante: json['idParticipante']??0);
  }

   Participantes.fromJsondb(Map<String, dynamic> json) {
    id = json['id'];
    idParticipante = json['id_participante'];
    dni = json['DNI'];
    primerNombre = json['PRIMERNOMBRE'];
    segundoNombre = json['SEGUNDONOMBRE'];
    apellidoPaterno = json['APELLIDOPATERNO'];
    apellidoMaterno = json['APELLIDOMATERNO'];
    sexo = json['SEXO'];
    fechaNacimiento = json['FECHANACIMIENTO'];

    //

     idProgramacion= json['idProgramacion'];
    tipoDocumento= json['tipoDocumento'];
       ubigeoCcpp= json['ubigeoCcpp'];
    nombreCcpp= json['nombreCcpp'];
    nombreResidencia= json['nombreResidencia'];
    entidad= json['entidad'];
    servicio= json['servicio'];
    provincia= json['provincia'];
    distrito= json['distrito'];
    idCentroPoblado= json['idCentroPoblado'];
    centroPoblado= json['centroPoblado'];
    flatResidencia= json['flatResidencia'];
    idEntidad= json['idEntidad'];
    idPais= json['idPais'];
    pais= json['pais'];
    idServicio= json['idServicio'];
    idTipoDocumento= json['idTipoDocumento'];
    idUsuario= json['idUsuario'];
    numDocExtranjero= json['numDocExtranjero'];
    txtIpmaq= json['txtIpmaq'];
    tipo= json['tipo'];
    tipoParticipante= json['tipoParticipante'];
    idParticipante= json['idParticipante'];

  }

  factory Participantes.fromMap(Map<String, dynamic> json) => Participantes(
      id: json['id'],
      idProgramacion: json['idProgramacion'],
      tipoDocumento: json['tipoDocumento'],
      dni: json['dni'],
      primerNombre: json['primerNombre'],
      segundoNombre: json['segundoNombre'],
      apellidoPaterno: json['apellidoPaterno'],
      apellidoMaterno: json['apellidoMaterno'],
      edad: json['edad'],
      fechaNacimiento: json['fechaNacimiento'],
      sexo: json['sexo'],
      ubigeoCcpp: json['ubigeoCcpp'],
      nombreCcpp: json['nombreCcpp'],
      nombreResidencia: json['nombreResidencia'],
      entidad: json['entidad'],
      servicio: json['servicio'],
      provincia: json['provincia'],
      distrito: json['distrito'],
      idCentroPoblado: json['idCentroPoblado'],
      centroPoblado: json['centroPoblado'],
      flatResidencia: json['flatResidencia'],
      idEntidad: json['idEntidad'],
      idPais: json['idPais'],
      pais: json['pais'],
      idServicio: json['idServicio'],
      idTipoDocumento: json['idTipoDocumento'],
      idUsuario: json['idUsuario'],
      numDocExtranjero: json['numDocExtranjero'],
      txtIpmaq: json['txtIpmaq'],
      tipo: json['tipo'],
      tipoParticipante: json['tipoParticipante']);

  factory Participantes.fromJsonListaTabla(Map<String, dynamic> json) {
    return Participantes(
      correlativo: json['correlativo'] ?? '',
      id_programacion_participante: json['id_programacion_participante'] ?? '',
      idProgramacion: int.tryParse(json['id_programacion'].toString()) ?? 0,
      idParticipante: int.tryParse(json['id_participante'].toString()) ?? 0,
      nombreResidencia: json['nombre_residencia'] ?? '',
      nombre: json['nombre'] ?? '',
      nombre2: json['nombre2'] ?? '',
      apellidoPaterno: json['apellidoPaterno'] ?? '',
      apellidoMaterno: json['apellidoMaterno'] ?? '',
      dni: json['dni'] ?? '',
      edad: int.tryParse(json['edad'].toString()) ?? 0,
      fechaNacimiento: json['fecha_nacimiento'] ?? '',
      sexo: json['sexo'] ?? '',
      pais_nombre: json['pais_nombre'] ?? '',
      tipo_documento_siglas: json['tipo_documento_siglas'] ?? '',
      nombre_programa: json['nombre_programa'] ?? '',
      estado_padron: json['estado_padron'] ?? '',
      servicio: json['servicio'] ?? '',
      total: json['total'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = new Map<String, dynamic>();

    json['id'] = this.id;
    json['idProgramacion'] = this.idProgramacion;
    json['tipoDocumento'] = this.tipoDocumento;
    json['dni'] = this.dni;
    json['primerNombre'] = this.primerNombre;
    json['segundoNombre'] = this.segundoNombre;
    json['apellidoPaterno'] = this.apellidoPaterno;
    json['apellidoMaterno'] = this.apellidoMaterno;
    json['edad'] = this.edad;
    json['fechaNacimiento'] = this.fechaNacimiento;
    json['sexo'] = this.sexo;
    json['ubigeoCcpp'] = this.ubigeoCcpp;
    json['nombreCcpp'] = this.nombreCcpp;
    json['nombreResidencia'] = this.nombreResidencia;
    json['entidad'] = this.entidad;
    json['servicio'] = this.servicio;
    json['provincia'] = this.provincia;
    json['distrito'] = this.distrito;
    json['idCentroPoblado'] = this.idCentroPoblado;
    json['centroPoblado'] = this.centroPoblado;
    json['flatResidencia'] = this.flatResidencia;
    json['idEntidad'] = this.idEntidad;
    json['idPais'] = this.idPais;
    json['pais'] = this.pais;
    json['idServicio'] = this.idServicio;
    json['idTipoDocumento'] = this.idTipoDocumento;
    json['idUsuario'] = this.idUsuario;
    json['numDocExtranjero'] = this.numDocExtranjero;
    json['txtIpmaq'] = this.txtIpmaq;
    json['tipo'] = this.tipo;
    json['tipoParticipante'] = this.tipoParticipante;

    return json;
  }

  Map<String, dynamic> toMap() {
    return {
      "idProgramacion": idProgramacion,
      "tipoDocumento": tipoDocumento,
      "dni": dni,
      "primerNombre": primerNombre,
      "segundoNombre": segundoNombre,
      "apellidoPaterno": apellidoPaterno,
      "apellidoMaterno": apellidoMaterno,
      "edad": edad,
      "fechaNacimiento": fechaNacimiento,
      "sexo": sexo,
      "ubigeoCcpp": ubigeoCcpp,
      "nombreCcpp": nombreCcpp,
      "nombreResidencia": nombreResidencia,
      "entidad": entidad,
      "servicio": servicio,
      "provincia": provincia,
      "distrito": distrito,
      "idCentroPoblado": idCentroPoblado,
      "centroPoblado": centroPoblado,
      "flatResidencia": flatResidencia,
      "idEntidad": idEntidad,
      "idPais": idPais,
      "idServicio": idServicio,
      "idTipoDocumento": idTipoDocumento,
      "idUsuario": idUsuario,
      "numDocExtranjero": numDocExtranjero,
      "txtIpmaq": txtIpmaq,
      "tipo": tipo,
      "tipoParticipante": tipoParticipante,
      "pais": pais
    };
  }

  Participantes.fromJsonReniec(Map<String, dynamic> json) {
    apellidoPaterno = json['apellido_paterno'];
    apellidoMaterno = json['apellido_materno'];
    primerNombre = json['nombres'];
    segundoNombre = json['segundoNombre'] ?? "";
    dni = json['dni'];
    sexo = json['genero'];
    fechaNacimiento = json['fecha_nacimiento'];
    distrito = json['distrito'];
    provincia = json['provincia'];

  }
}
