class Usuario {
  String? nombreUsuario;
  String? nombreCompleto;
  String? email;
  String? password;

  Usuario({
    this.nombreUsuario,
    this.nombreCompleto,
    this.email,
    this.password,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        nombreUsuario: json["nombreUsuario"],
        nombreCompleto: json["nombreCompleto"],
        email: json["email"],
        password: json["passwd"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "nombreUsuario": nombreUsuario,
        "nombreCompleto": nombreCompleto,
        "email": email,
        "passwd": password,
      };

  @override
  String toString() {
    return 'Usuario{nombreUsuario: $nombreUsuario, nombreCompleto: $nombreCompleto, email: $email, password: $password}';
  }
}
