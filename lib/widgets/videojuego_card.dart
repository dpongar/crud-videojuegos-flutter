import 'package:flutter/material.dart';
import '../models/videojuego_model.dart';

class VideojuegoCard extends StatelessWidget {
  final Videojuego videojuego;

  const VideojuegoCard({super.key, required this.videojuego});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TÍTULO
            Text(
              videojuego.titulo,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 6),

            // PLATAFORMA
            Row(
              children: [
                const Icon(Icons.videogame_asset, size: 18),
                const SizedBox(width: 6),
                Text(videojuego.plataforma),
              ],
            ),

            const SizedBox(height: 6),

            // PRECIO
            Row(
              children: [
                const Icon(Icons.euro, size: 18),
                const SizedBox(width: 6),
                Text(
                  '${videojuego.precio} €',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // DESCRIPCIÓN
            Text(
              videojuego.descripcion,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }
}
