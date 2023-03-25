class Puja {
  // Atributos
  double? cantidad;
  DateTime? fecha;

  // Relaciones
  String? idUsuario;
  int? idProducto;

  // Constructor
  Puja({
    this.cantidad,
    this.fecha,
    this.idUsuario,
    this.idProducto,
  });

  // toJson
  Map<String, dynamic> toJson() {
    return {
      'cantidad': cantidad,
      'fecha': fecha,
      'idUsuario': idUsuario,
      'idProducto': idProducto,
    };
  }

  // fromJson
  factory Puja.fromJson(Map<String, dynamic> json) {
    return Puja(
      cantidad: json['cantidad'].toDouble(),
      fecha: DateTime.parse(json['fecha']),
      idUsuario: json['idUsuario'],
      idProducto: json['idProducto'],
    );
  }
}
