import 'package:flutter/material.dart';
import '../services/firebase_service.dart';
import '../models/videojuego_model.dart';
import '../widgets/custom_input.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({super.key});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseService _service = FirebaseService();

  late Videojuego v;

  final tituloCtrl = TextEditingController();
  final plataformaCtrl = TextEditingController();
  final precioCtrl = TextEditingController();
  final descripcionCtrl = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    v = ModalRoute.of(context)!.settings.arguments as Videojuego;

    tituloCtrl.text = v.titulo;
    plataformaCtrl.text = v.plataforma;
    precioCtrl.text = v.precio.toString();
    descripcionCtrl.text = v.descripcion;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar videojuego')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomInput(controller: tituloCtrl, label: 'Título'),
              CustomInput(controller: plataformaCtrl, label: 'Plataforma'),
              CustomInput(controller: precioCtrl, label: 'Precio', isNumber: true),
              CustomInput(controller: descripcionCtrl, label: 'Descripción'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final updated = Videojuego(
                      id: v.id,
                      titulo: tituloCtrl.text,
                      plataforma: plataformaCtrl.text,
                      precio: double.parse(precioCtrl.text),
                      descripcion: descripcionCtrl.text,
                    );

                    await _service.updateVideojuego(v.id, updated);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Actualizar'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

