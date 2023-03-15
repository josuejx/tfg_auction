class Producto {
  // Atributos
  int? id;
  String? nombre;
  String? descripcion;
  double? precio;
  String? imagen;
  DateTime? finalizacion;

  // Relaciones
  int? idCategoria;
  int? idUsuario;

  Producto({
    this.id,
    this.nombre,
    this.descripcion,
    this.precio,
    this.imagen,
    this.finalizacion,
  });

  Producto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nombre = json['nombre'];
    descripcion = json['descripcion'];
    precio = json['precio'];
    imagen = json['imagen'].toString();
    finalizacion = DateTime.parse(json['finalizacion']);
    idCategoria = json['idCategoria'];
    idUsuario = json['idUsuario'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nombre'] = this.nombre;
    data['descripcion'] = this.descripcion;
    data['precio'] = this.precio;
    data['imagen'] = this.imagen;
    data['finalizacion'] = this.finalizacion.toString();
    data['idCategoria'] = this.idCategoria;
    data['idUsuario'] = this.idUsuario;
    return data;
  }
}