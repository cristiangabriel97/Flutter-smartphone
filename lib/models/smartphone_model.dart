class Smartphone {
  String id;
  String nombre;
  String detalles;
  double precio;
  bool disponible;

  Smartphone({
    required this.id,
    required this.nombre,
    required this.detalles,
    required this.precio,
    required this.disponible,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'detalles': detalles,
      'precio': precio,
      'disponible': disponible,
    };
  }

  factory Smartphone.fromMap(String id, Map<String, dynamic> map) {
    return Smartphone(
      id: id,
      nombre: map['nombre'] ?? '',
      detalles: map['detalles'] ?? '',
      precio: (map['precio'] as num).toDouble(),
      disponible: map['disponible'] ?? false,
    );
  }
}
