class Usuario {
  String? nombreUsuario;
  String? nombreCompleto;
  String? email;
  String? token;
  double? fiabilidad;

  Usuario({
    this.nombreUsuario,
    this.nombreCompleto,
    this.email,
    this.token,
    this.fiabilidad,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        nombreUsuario: json["nombreUsuario"],
        nombreCompleto: json["nombreCompleto"],
        email: json["email"],
        token: json["token"],
        fiabilidad: json["fiabilidad"],
      );

  Map<String, dynamic> toJson() => {
        "nombreUsuario": nombreUsuario,
        "nombreCompleto": nombreCompleto,
        "email": email,
        "token": token,
        "fiabilidad": fiabilidad,
      };

  @override
  String toString() {
    return 'Usuario{nombreUsuario: $nombreUsuario, nombreCompleto: $nombreCompleto, email: $email}';
  }
}
