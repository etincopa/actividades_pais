
class CombosFld {
  static String id = 'id';
  static String descrip = 'descrip';
  static String descrip2 = 'descrip2';

  /*
  * Propiedades servicios REST
  */
  static String idTipoGobierno = 'id_tipo_gobierno';
  static String nombre = 'nombre';
  static String abreviatura = 'abreviatura';
  static String idSector = 'id_sector';
  static String nombreSector = 'nombre_sector';
  static String idEntidad = 'id_entidad';
  static String nombrePrograma = 'nombre_programa';
  static String idDocumetoEvento = 'id_documeto_evento';
  static String descripcion = 'descripcion';
  static String idArticulacionOrientada = 'id_articulacion_orientada';
  static String idTipoActividad = 'id_tipo_actividad';
}

class CombosDto {
  static const cbCod001 = 'lista-tipo-gobierno';
  static const cbCod002 = 'lista-sector';
  static const cbCod003 = 'lista-programa';
  static const cbCod004 = 'lista-tipo-documento';
  static const cbCod005 = 'lista-articulacion-orientada';
  static const cbCod006 = 'lista-tipo-actividades';

  int? id = 0;
  String? descrip = '';
  String? descrip2 = '';

  CombosDto.empty();

  CombosDto({
    this.id,
    this.descrip2,
    this.descrip,
  });

  CombosDto copy({
    int? id,
    String? descrip,
    String? descrip2,
    int? rol,
  }) =>
      CombosDto(
        id: id ?? this.id,
        descrip2: descrip2 ?? this.descrip2,
        descrip: descrip ?? this.descrip,
      );

  static CombosDto fromJson(Map<String, Object?> o, {String? type}) {
    int f1 = 0;
    String f2 = "";
    String f3 = "";

    if (type == CombosDto.cbCod001) {
      f1 = _getInt(o[CombosFld.idTipoGobierno]);
      f2 = _getString(o[CombosFld.nombre]);
      f3 = _getString(o[CombosFld.abreviatura]);
    } else if (type == CombosDto.cbCod002) {
      f1 = _getInt(o[CombosFld.idSector]);
      f2 = _getString(o[CombosFld.nombreSector]);
      f3 = "";
    } else if (type == CombosDto.cbCod003) {
      f1 = _getInt(o[CombosFld.idEntidad]);
      f2 = _getString(o[CombosFld.nombrePrograma]);
      f3 = "";
    } else if (type == CombosDto.cbCod004) {
      f1 = _getInt(o[CombosFld.idDocumetoEvento]);
      f2 = _getString(o[CombosFld.descripcion]);
      f3 = "";
    } else if (type == CombosDto.cbCod005) {
      f1 = _getInt(o[CombosFld.idArticulacionOrientada]);
      f2 = _getString(o[CombosFld.descripcion]);
      f3 = "";
    } else if (type == CombosDto.cbCod006) {
      f1 = _getInt(o[CombosFld.idTipoActividad]);
      f2 = _getString(o[CombosFld.descripcion]);
      f3 = "";
    }

    return CombosDto(
      id: f1,
      descrip2: f2,
      descrip: f3,
    );
  }

  Map<String, dynamic> toJson() => {
        CombosFld.id: id,
        CombosFld.descrip: descrip2,
        CombosFld.descrip2: descrip,
      };

  static Map<String, dynamic> toJsonObject(CombosDto o) {
    return {
      CombosFld.id: o.id,
      CombosFld.descrip: o.descrip2,
      CombosFld.descrip2: o.descrip,
    };
  }

  static List<Map<String, dynamic>> toJsonArray(List<CombosDto> o) {
    List<Map<String, dynamic>> aList = [];
    for (var item in o) {
      aList.add(CombosDto.toJsonObject(item));
    }
    return aList;
  }

  static String _getString(dynamic data, {String? type}) {
    String resp = data != null ? data.toString() : '';
    if (type != null && type == "I") {
      if (resp == '') resp = '0';
    } else if (type != null && type == "D") {
      if (resp == '') resp = '0.00';
    }
    return resp;
  }

  static int _getInt(dynamic data) {
    return data != null ? int.parse(data.toString()) : 0;
  }
}
