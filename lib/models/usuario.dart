class Usuario {
  String? nombreUsuario;
  String? nombreCompleto;
  String? email;
  String? token;
  double? fiabilidad;
  int? subastasGanadasNoPagadas;

  Usuario({
    this.nombreUsuario,
    this.nombreCompleto,
    this.email,
    this.token,
    this.fiabilidad,
    this.subastasGanadasNoPagadas,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        nombreUsuario: json["nombreUsuario"],
        nombreCompleto: json["nombreCompleto"],
        email: json["email"],
        token: json["token"],
        fiabilidad: json["fiabilidad"],
        subastasGanadasNoPagadas: json["subastasGanadas"],
      );

  Map<String, dynamic> toJson() => {
        "nombreUsuario": nombreUsuario,
        "nombreCompleto": nombreCompleto,
        "email": email,
        "token": token,
        "fiabilidad": fiabilidad,
        "subastasGanadas": subastasGanadasNoPagadas,
      };

  @override
  String toString() {
    return 'Usuario{nombreUsuario: $nombreUsuario, nombreCompleto: $nombreCompleto, email: $email}';
  }
}
