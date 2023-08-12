class PersonalPuestoFld {
  static String jut = 'JUT';
  static String mo = 'MO';
  static String git = 'GIT';
  static String gu = 'GU';
  static String st = 'ST';
}

class PersonalPuestoModel {
  int? jut;
  int? mo;
  int? git;
  int? gu;
  int? st;

  PersonalPuestoModel.empty();

  PersonalPuestoModel({this.jut, this.mo, this.git, this.gu, this.st});

  factory PersonalPuestoModel.fromJson(Map<String, dynamic> json) {
    return PersonalPuestoModel(
      jut: json[PersonalPuestoFld.jut],
      mo: json[PersonalPuestoFld.mo],
      git: json[PersonalPuestoFld.git],
      gu: json[PersonalPuestoFld.gu],
      st: json[PersonalPuestoFld.st],
    );
  }
}
