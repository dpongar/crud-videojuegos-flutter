import 'package:flutter/material.dart';
import '../services/firebase_service.dart';
import '../models/videojuego_model.dart';
import '../widgets/custom_input.dart';

class InsertScreen extends StatefulWidget {
  const InsertScreen({super.key});

  @override
  State<InsertScreen> createState() => _InsertScreenState();
}

class _InsertScreenState extends State<InsertScreen> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseService _service = FirebaseService();

  final tituloCtrl = TextEditingController();
  final plataformaCtrl = TextEditingController();
  final precioCtrl = TextEditingController();
  final descripcionCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Añadir videojuego')),
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
                    final v = Videojuego(
                      id: '',
                      titulo: tituloCtrl.text,
                      plataforma: plataformaCtrl.text,
                      precio: double.parse(precioCtrl.text),
                      descripcion: descripcionCtrl.text,
                    );

                    await _service.insertVideojuego(v);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Guardar'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
