

class Perfiles{
  List<Perfil> items = [];

  Perfiles();

  Perfiles.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final _listarTrabajador = new Perfil.fromJson(item);
      items.add(_listarTrabajador);
    }
  }
}

class Perfil {
 // int? idAccion;
 // String? moduloDescripcion;
 // String? menuDescripcion;
  String? idMenuPadre;
  String? idMenuHijo;

  Perfil(
      {//this.idAccion,
       // this.moduloDescripcion,
       // this.menuDescripcion,
        this.idMenuPadre,
      //  this.idMenuHijo
      });

  Perfil.fromJson(Map<String, dynamic> json) {
  /*  idAccion = json['id_accion'];
    moduloDescripcion = json['modulo_descripcion'];
    menuDescripcion = json['menu_descripcion'];*/
    idMenuPadre = json['id_menu_padre'];
   idMenuHijo = json['id_menu_hijo']??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
   // data['id_accion'] = this.idAccion;
   // data['modulo_descripcion'] = this.moduloDescripcion;
   // data['menu_descripcion'] = this.menuDescripcion;
    data['id_menu_padre'] = this.idMenuPadre;
    data['id_menu_hijo'] = this.idMenuHijo;
    return data;
  }
}