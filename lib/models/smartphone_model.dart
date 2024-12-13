class Smartphone {
  String id; // Identificador único (puede ser generado por Firebase)
  String nombre; // Nombre del smartphone
  String detalles; // Descripción o detalles del smartphone
  double precio; // Precio del smartphone
  bool disponible; // Indica si está disponible

  Smartphone({
    required this.id,
    required this.nombre,
    required this.detalles,
    required this.precio,
    required this.disponible,
  });

  // Método para convertir un objeto Smartphone a un Map (para Firebase)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'detalles': detalles,
      'precio': precio,
      'disponible': disponible,
    };
  }

  // Método para crear un objeto Smartphone desde un Map (para Firebase)
  factory Smartphone.fromMap(String id, Map<String, dynamic> map) {
    return Smartphone(
      id: id,
      nombre: map['nombre'] ?? '',
      detalles: map['detalles'] ?? '',
      precio: (map['precio'] as num).toDouble(), // Convertir numérico a double
      disponible: map['disponible'] ?? false,
    );
  }
}
