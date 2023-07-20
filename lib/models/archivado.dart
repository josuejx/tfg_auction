class Archivado {
  String? idUsuario;
  int? idProducto;

  Archivado({this.idUsuario, this.idProducto});

  Archivado.fromJson(Map<String, dynamic> json) {
    idUsuario = json['idUsuario'];
    idProducto = json['idProducto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idUsuario'] = this.idUsuario;
    data['idProducto'] = this.idProducto;
    return data;
  }
}
