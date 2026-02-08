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
                  setState(() {});
                },
                child: ListTile(
                  title: Text(v.titulo),
                  subtitle: Text('${v.plataforma} · ${v.precio} €'),
                  onTap: () async {
                    await Navigator.pushNamed(
                      context,
                      '/update',
                      arguments: v,
                    );
                    setState(() {});
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
