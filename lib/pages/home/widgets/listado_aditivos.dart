import 'package:aplicacion_aditivos/models/directorioaditivos.class.dart';
import 'package:aplicacion_aditivos/pages/home/widgets/aditivo_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListadoAditivos extends StatelessWidget {
  const ListadoAditivos({super.key});

  @override
  Widget build(BuildContext context) {
    DirectorioAditivos coleccion = Provider.of<DirectorioAditivos>(context);
    return ListView.builder(
        itemCount: coleccion.aditivos.length,
        itemBuilder: (context, index) {
          return AditivoTile(aditivo: coleccion.aditivos[index]);
        });
  }
}
