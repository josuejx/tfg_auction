class Categoria {
  int? id;
  String? nombre;
  String? imagen;

  Categoria({
    this.id,
    this.nombre,
    this.imagen,
  });

  factory Categoria.fromJson(Map<String, dynamic> json) => Categoria(
        id: json["id"],
        nombre: json["nombre"],
        imagen: json["imagen"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "imagen": imagen,
      };
}
