class Producto {
  // Atributos
  int? id;
  String? nombre;
  String? descripcion;
  double? precio;
  DateTime? finalizacion;
  String? imagen;

  // Relaciones
  int? idCategoria;
  String? idUsuario;

  Producto({
    this.id,
    this.nombre,
    this.descripcion,
    this.precio,
    this.finalizacion,
    this.imagen,
    this.idCategoria,
    this.idUsuario,
  });

  Producto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nombre = json['nombre'];
    descripcion = json['descripcion'];
    precio = json['precio'].toDouble();
    finalizacion = DateTime.fromMillisecondsSinceEpoch(
        json['finalizacion'].seconds * 1000);
    idCategoria = json['idCategoria'];
    idUsuario = json['idUsuario'];
    imagen = json['imagen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nombre'] = this.nombre;
    data['descripcion'] = this.descripcion;
    data['precio'] = this.precio;
    data['finalizacion'] = this.finalizacion.toString();
    data['idCategoria'] = this.idCategoria;
    data['idUsuario'] = this.idUsuario;
    data['imagen'] = this.imagen;
    return data;
  }
}
