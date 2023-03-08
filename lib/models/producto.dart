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
}
