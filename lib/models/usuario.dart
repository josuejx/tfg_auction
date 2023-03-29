class Usuario {
  String? nombreUsuario;
  String? nombreCompleto;
  String? email;
  String? token;

  Usuario({
    this.nombreUsuario,
    this.nombreCompleto,
    this.email,
    this.token,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        nombreUsuario: json["nombreUsuario"],
        nombreCompleto: json["nombreCompleto"],
        email: json["email"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "nombreUsuario": nombreUsuario,
        "nombreCompleto": nombreCompleto,
        "email": email,
        "token": token,
      };

  @override
  String toString() {
    return 'Usuario{nombreUsuario: $nombreUsuario, nombreCompleto: $nombreCompleto, email: $email}';
  }
}
