class LoginClass {
  int? id;
  String? name;
  String? token;
  String? rol;
  String? username;
  String? password;

  LoginClass({ this.id, this.name, this.token, this.rol, this.password,this.username});

  factory LoginClass.fromJson(Map<String, dynamic> data) {
    // note the explicit cast to String
    // this is required if robust lint rules are enabled

    final id = data['id'];
    final name = data['name'];
    final  token = data['token'];
    final rol = data['rol'];
    final username = data['username'];
    final password = data['password'];

    return LoginClass(name: name, id: id, password: password, rol: rol, token: token,username: username);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['token'] = token;
    data['rol'] = rol;
    data['username'] = username;
    data['password'] = password;
    return data;
  }

  factory LoginClass.fromMap(Map<String, dynamic> json) =>
      LoginClass(
        id: json['id'],
        name: json['name'],
        token: json['token'],
        rol: json['rol'],
        username: json['username'],
        password: json['password'],
      );

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "token": token,
      "rol": rol,
      "username": username,
      "password": password,
    };
  }}

