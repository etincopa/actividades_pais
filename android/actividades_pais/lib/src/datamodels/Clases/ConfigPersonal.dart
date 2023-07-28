class ListasUsuarios {
  List<ConfigPersonal> items = [];

  ListasUsuarios();

  ListasUsuarios.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final listarTrabajador = ConfigPersonal.fromJsonSERICIO(item);
      items.add(listarTrabajador);
    }
  }
}

class ConfigPersonal {
  int numeroDni = 0;
  int id = 0;
  String nombres = '';
  String apellidoPaterno = '';
  String apellidoMaterno = '';
  String contrasenia = '';
  String unidad = '';
  String codigo = '';
  String rol = '';
  String fechaNacimento = '';
  String tipoUsuario = '';

  ConfigPersonal({
    this.numeroDni = 0,
    this.id = 0,
    this.nombres = '',
    this.apellidoPaterno = '',
    this.apellidoMaterno = '',
    this.unidad = '',
    this.contrasenia = '',
    this.rol = '',
    this.codigo = '',
    this.fechaNacimento = '',
  });

  Map<String, dynamic> toMap() {
    return {
      "codigo": codigo,
      "nombres": nombres,
      "rol": rol,
      "fechaNacimento": fechaNacimento,
      "numeroDni": numeroDni,
      "contrasenia": contrasenia,
      "apellidoPaterno": apellidoPaterno,
      "apellidoMaterno": apellidoMaterno,
      "unidad": unidad,
      "tipoUsuario": tipoUsuario ?? '',
    };
  }

  ConfigPersonal.fromJsonSERICIO(Map<String, dynamic> json) {
    nombres = json['nombres'];
    codigo = json['codigo'];
    rol = json['rol'];
  }

  ConfigPersonal.fromMap(Map<String, dynamic> map) {
    id = map['id'] ??0;
    numeroDni = map['numeroDni']??0;
    nombres = map['nombres']??0;
    apellidoPaterno = map['apellidoPaterno']??0;
    apellidoMaterno = map['apellidoMaterno']??0;
    contrasenia = map['contrasenia']??0;
    unidad = map['unidad']??0;
    codigo = map['codigo']??0;
    rol = map['rol']??0;
    tipoUsuario = map['tipoUsuario'] ?? '';
  }
}
