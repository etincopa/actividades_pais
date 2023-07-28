
class ListarParticipantesIntervenciones {
  List<ParticipantesIntervenciones> items = [];

  ListarParticipantesIntervenciones();

  ListarParticipantesIntervenciones.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final listarTrabajador = ParticipantesIntervenciones.fromJsonSERICIO(item);
      items.add(listarTrabajador);
    }
  }
}

class ParticipantesIntervenciones {
  int? id;
  int? idParticipante;
  String? dNI;
  String? pRIMERNOMBRE;
  String? sEGUNDONOMBRE;
  String? aPELLIDOPATERNO;
  String? aPELLIDOMATERNO;
  String? sEXO;
  String? fECHANACIMIENTO;
  String? uNIDADTERRITORIAL;


  ParticipantesIntervenciones(
      {
        this.id,
        this.idParticipante,
        this.dNI,
        this.pRIMERNOMBRE,
        this.sEGUNDONOMBRE,
        this.aPELLIDOPATERNO,
        this.aPELLIDOMATERNO,
        this.sEXO,
        this.fECHANACIMIENTO,
        this.uNIDADTERRITORIAL,
 });

  ParticipantesIntervenciones.fromJsonSERICIO(Map<String, dynamic> json) {
    id = json['id'];
    idParticipante = json['id_participante'];
    dNI = json['DNI'];
    pRIMERNOMBRE = json['PRIMER_NOMBRE'];
    sEGUNDONOMBRE = json['SEGUNDO_NOMBRE'];
    aPELLIDOPATERNO = json['APELLIDO_PATERNO'];
    aPELLIDOMATERNO = json['APELLIDO_MATERNO'];
    sEXO = json['SEXO'];
    fECHANACIMIENTO = json['FECHA_NACIMIENTO'];
    uNIDADTERRITORIAL = json['UNIDAD_TERRITORIAL'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['id_participante'] = idParticipante;
    data['DNI'] = dNI;
    data['PRIMER_NOMBRE'] = pRIMERNOMBRE;
    data['SEGUNDO_NOMBRE'] = sEGUNDONOMBRE;
    data['APELLIDO_PATERNO'] = aPELLIDOPATERNO;
    data['APELLIDO_MATERNO'] = aPELLIDOMATERNO;
    data['SEXO'] = sEXO;
    data['FECHA_NACIMIENTO'] = fECHANACIMIENTO;
    data['UNIDAD_TERRITORIAL'] = uNIDADTERRITORIAL;

    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      //"id": id,
      "idParticipante": idParticipante,
      "DNI": dNI,
      "PRIMERNOMBRE": pRIMERNOMBRE,
      "SEGUNDONOMBRE": sEGUNDONOMBRE,
      "APELLIDOPATERNO": aPELLIDOPATERNO,
      "APELLIDOMATERNO": aPELLIDOMATERNO,
      "SEXO": sEXO,
      "FECHANACIMIENTO": fECHANACIMIENTO,
      "UNIDADTERRITORIAL": uNIDADTERRITORIAL
     };
  }
}
