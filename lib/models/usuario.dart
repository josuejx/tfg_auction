class Usuario {
  String? nombreUsuario;
  String? nombreCompleto;
  String? email;

  Usuario({
    this.nombreUsuario,
    this.nombreCompleto,
    this.email,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        nombreUsuario: json["nombreUsuario"],
        nombreCompleto: json["nombreCompleto"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "nombreUsuario": nombreUsuario,
        "nombreCompleto": nombreCompleto,
        "email": email,
      };

  @override
  String toString() {
    return 'Usuario{nombreUsuario: $nombreUsuario, nombreCompleto: $nombreCompleto, email: $email}';
  }
}
