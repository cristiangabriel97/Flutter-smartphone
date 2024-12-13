import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:smartphone_app/blocs/smartphone_bloc.dart';
import 'package:smartphone_app/blocs/smartphone_event.dart';
import 'package:smartphone_app/firebase_options.dart';
import 'package:smartphone_app/repositories/smartphone_repository.dart';
import 'package:smartphone_app/ui/consulta_screen.dart';
import 'package:smartphone_app/ui/ingresardatos_screen.dart';
import 'package:smartphone_app/ui/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<SmartphoneBloc>(
          create: (context) => SmartphoneBloc(
            smartphoneRepository: SmartphoneRepository(),
          )..add(LoadSmartphones()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gestión de Smartphones',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/consulta': (context) => ConsultaScreen(),
        '/ingreso': (context) => IngresoDatoScreen(),
      },
    );
  }
}
