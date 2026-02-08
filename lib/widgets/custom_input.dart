import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool isNumber;

  const CustomInput({
    super.key,
    required this.controller,
    required this.label,
    this.isNumber = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(labelText: label),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Campo obligatorio';
          }
          if (isNumber && double.tryParse(value) == null) {
            return 'Debe ser un número';
          }
          return null;
        },
      ),
    );
  }
}
