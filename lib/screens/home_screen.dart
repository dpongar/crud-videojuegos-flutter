import 'package:flutter/material.dart';
import '../services/firebase_service.dart';
import '../models/videojuego_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseService _service = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Videojuegos')),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/insert');
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<List<Videojuego>>(
        future: _service.getVideojuegos(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final videojuegos = snapshot.data!;

          if (videojuegos.isEmpty) {
            return const Center(child: Text('No hay videojuegos'));
          }

          return ListView.builder(
            itemCount: videojuegos.length,
            itemBuilder: (context, index) {
              final v = videojuegos[index];

              return Dismissible(
                key: Key(v.id),
                direction: DismissDirection.startToEnd,
                background: Container(
                  color: Colors.red,
                  padding: const EdgeInsets.only(left: 20),
                  alignment: Alignment.centerLeft,
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                confirmDismiss: (_) async {
                  return await showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text('¿Eliminar ${v.titulo}?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text('Cancelar'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: const Text('Borrar'),
                        ),
                      ],
                    ),
                  );
                },
                onDismissed: (_) async {
                  await _service.deleteVideojuego(v.id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("${v.titulo} eliminado")),
                  );
                  setState(() {});
                },
                child: InkWell(
                  onTap: () async {
                    await Navigator.pushNamed(context, '/update', arguments: v);
                    setState(() {});
                  },
                  child: Card(
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 200,
                              color: Colors.black,
                              child: Image.network(
                                v.imagenUrl,
                                fit: BoxFit.contain,
                              ),
                            ),

                            Positioned(
                              top: 10,
                              left: 10,
                              child: Container(
                                color: Colors.black54,
                                padding: const EdgeInsets.all(6),
                                child: Text(
                                  v.plataforma,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                v.titulo,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 6),

                              Text(
                                "${v.precio} €",
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.cyan,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),

                              Text(
                                v.descripcion,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(color: Colors.white70),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
