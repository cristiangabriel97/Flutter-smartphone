import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartphone_app/blocs/smartphone_bloc.dart';
import 'package:smartphone_app/blocs/smartphone_event.dart';

class IngresoDatoScreen extends StatefulWidget {
  @override
  _IngresoDatoScreenState createState() => _IngresoDatoScreenState();
}

class _IngresoDatoScreenState extends State<IngresoDatoScreen> {
  final _nombreController = TextEditingController();
  final _detallesController = TextEditingController();
  final _precioController = TextEditingController();
  bool _disponible = false;

  void _saveData(BuildContext context) {
    final smartphoneData = {
      'nombre': _nombreController.text.trim(),
      'detalles': _detallesController.text.trim(),
      'precio': double.tryParse(_precioController.text.trim()) ?? 0.0,
      'disponible': _disponible,
    };
    context.read<SmartphoneBloc>().add(AddSmartphone(smartphoneData));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ingresar Smartphone'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nombreController,
              decoration: InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: _detallesController,
              decoration: InputDecoration(labelText: 'Detalles'),
            ),
            TextField(
              controller: _precioController,
              decoration: InputDecoration(labelText: 'Precio'),
              keyboardType: TextInputType.number,
            ),
            SwitchListTile(
              title: Text('Disponible'),
              value: _disponible,
              onChanged: (val) => setState(() => _disponible = val),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _saveData(context),
              child: Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}
