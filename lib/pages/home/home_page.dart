// ignore_for_file: prefer_const_constructors

import 'package:aplicacion_aditivos/pages/home/widgets/listado_aditivos.dart';
import 'package:aplicacion_aditivos/services/events_hub.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtiene la instancia de EventsHub del Provider para manejar eventos.
    EventsHub event = Provider.of<EventsHub>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text("Aditivos Alimentarios"),
      ),
      body: ListadoAditivos(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          event.onCreateAditivo(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
