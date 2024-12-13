import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  Future<String?> _getUserEmail() async {
    final user = FirebaseAuth.instance.currentUser;
    return user?.email;
  }

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder<String?>(
              future: _getUserEmail(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error al cargar el correo');
                } else if (snapshot.hasData && snapshot.data != null) {
                  return Text(
                    'Usuario: ${snapshot.data}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                } else {
                  return Text(
                    'Usuario no autenticado',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }
              },
            ),
            SizedBox(height: 20),
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
