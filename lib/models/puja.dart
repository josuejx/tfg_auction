class Puja {
  // Atributos
  double? cantidad;
  DateTime? fecha;
  bool? pujaAutomatica;

  // Relaciones
  String? idUsuario;
  int? idProducto;

  // Constructor
  Puja({
    this.cantidad,
    this.fecha,
    this.idUsuario,
    this.idProducto,
    this.pujaAutomatica,
  });

  // toJson
  Map<String, dynamic> toJson() {
    return {
      'cantidad': cantidad,
      'fecha': fecha,
      'idUsuario': idUsuario,
      'idProducto': idProducto,
      'pujaAutomatica': pujaAutomatica,
    };
  }

  // fromJson
  factory Puja.fromJson(Map<String, dynamic> json) {
    return Puja(
      cantidad: json['cantidad'].toDouble(),
      fecha: DateTime.fromMillisecondsSinceEpoch(json['fecha'].seconds * 1000),
      idUsuario: json['idUsuario'],
      idProducto: json['idProducto'],
      pujaAutomatica: json['pujaAutomatica'],
    );
  }
}
