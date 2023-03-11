class Usuario {
  int? id;
  String? nombreUsuario;
  String? nombreCompleto;
  String? email;
  String? password;

  Usuario({
    this.id,
    this.nombreUsuario,
    this.nombreCompleto,
    this.email,
    this.password,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        id: json["id"],
        nombreUsuario: json["nombreUsuario"],
        nombreCompleto: json["nombreCompleto"],
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombreUsuario": nombreUsuario,
        "nombreCompleto": nombreCompleto,
        "email": email,
        "password": password,
      };
}
