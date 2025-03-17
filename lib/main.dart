// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:aplicacion_aditivos/models/directorioaditivos.class.dart';
import 'package:aplicacion_aditivos/pages/bootstrap/bootstrap_page.dart';
import 'package:aplicacion_aditivos/services/events_hub.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => DirectorioAditivos(),
        ),
        InheritedProvider(create: (context) => EventsHub())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Aditivos Alimentarios',
        theme: ThemeData.dark(),
        home: BootstrapPage(),
      ),
    );
  }
}
