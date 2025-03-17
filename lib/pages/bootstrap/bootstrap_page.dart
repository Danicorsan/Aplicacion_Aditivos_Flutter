// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:aplicacion_aditivos/models/directorioaditivos.class.dart';
import 'package:aplicacion_aditivos/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BootstrapPage extends StatefulWidget {
  const BootstrapPage({super.key});

  @override
  State<BootstrapPage> createState() => _BootstrapPageState();
}

class _BootstrapPageState extends State<BootstrapPage> {
  @override
  void initState() {
    bootstrap();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Examen de flutter",
              style: TextStyle(fontSize: 25),
            ),
            Text("Por Daniel Cortes Sanchez"),
            Text("2ºDAM - Curso 2024"),
            SizedBox(
              height: 20,
            ),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }

  void bootstrap() async {
    NavigatorState navigator = Navigator.of(context);

    DirectorioAditivos coleccion =
        Provider.of<DirectorioAditivos>(context, listen: false);

    coleccion.load().then((value) {
      navigator.pushReplacement(
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    });
  }
}
