  class Videojuego {
    final String id;
    final String titulo;
    final String plataforma;
    final double precio;
    final String descripcion;

    Videojuego({
      required this.id,
      required this.titulo,
      required this.plataforma,
      required this.precio,
      required this.descripcion,
    });

    factory Videojuego.fromMap(String id, Map<String, dynamic> data) {
      return Videojuego(
        id: id,
        titulo: data['titulo'],
        plataforma: data['plataforma'],
        precio: (data['precio'] as num).toDouble(),
        descripcion: data['descripcion'],
      );
    }

    Map<String, dynamic> toMap() {
      return {
        'titulo': titulo,
        'plataforma': plataforma,
        'precio': precio,
        'descripcion': descripcion,
      };
    }
  }
