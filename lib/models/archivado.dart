class Archivado {
  int? id;
  String? idUsuario;
  int? idProducto;

  Archivado({this.idUsuario, this.idProducto});

  Archivado.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idUsuario = json['idUsuario'];
    idProducto = json['idProducto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['idUsuario'] = this.idUsuario;
    data['idProducto'] = this.idProducto;
    return data;
  }
}
