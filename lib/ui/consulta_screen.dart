import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartphone_app/blocs/smartphone_bloc.dart';
import 'package:smartphone_app/blocs/smartphone_event.dart';
import 'package:smartphone_app/blocs/smartphone_state.dart';
import 'package:smartphone_app/repositories/smartphone_repository.dart';

class ConsultaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SmartphoneBloc(
        smartphoneRepository: SmartphoneRepository(),
      )..add(LoadSmartphones()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Listado de Smartphones'),
        ),
        body: BlocBuilder<SmartphoneBloc, SmartphoneState>(
          builder: (context, state) {
            if (state is SmartphoneLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is SmartphoneLoaded) {
              final smartphones = state.smartphones;
              if (smartphones.isEmpty) {
                return Center(
                    child: Text('No hay datos registrados en firestore.'));
              }
              return ListView.builder(
                itemCount: smartphones.length,
                itemBuilder: (context, index) {
                  final smartphone = smartphones[index];
                  return ListTile(
                    title: Text(smartphone['nombre'] ?? 'Sin nombre'),
                    subtitle: Text('Precio: \$${smartphone['precio'] ?? 0}'),
                    trailing: smartphone['disponible'] == true
                        ? Icon(Icons.check, color: Colors.green)
                        : Icon(Icons.close, color: Colors.red),
                  );
                },
              );
            } else if (state is SmartphoneError) {
              return Center(child: Text('Error: ${state.message}'));
            }
            return Container();
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, '/ingreso'),
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
