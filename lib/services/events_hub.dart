// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:aplicacion_aditivos/models/directorioaditivos.class.dart';
import 'package:aplicacion_aditivos/pages/edit/edit_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/aditivo.class.dart';

class EventsHub {
  //----------------------------------------------------------------------------
  void onShowAditivoComment(BuildContext context, Aditivo aditivo) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                "${aditivo.codigo} - ${aditivo.nombre}",
                textAlign: TextAlign.center,
              ),
              Divider(),
              SizedBox(
                height: 20,
              ),
              Text(
                aditivo.comentario,
              )
            ],
          );
        });
  }

  //----------------------------------------------------------------------------
  Future<void> onDeleteAditivo(BuildContext context, Aditivo aditivo) async {
    DirectorioAditivos coleccion =
        Provider.of<DirectorioAditivos>(context, listen: false);

    bool? result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Atención"),
          content: const Text("Vas a borrar un aditivo. ¿Estás seguro?"),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text("No"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text("Si"),
            ),
          ],
        );
      },
    );
    if (result ?? false) {
      coleccion.aditivos.remove(aditivo);
      coleccion.save();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Borrado con exito"),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  //----------------------------------------------------------------------------
  Future<void> onCreateAditivo(BuildContext context) async {
    onEditAditivo(context, Aditivo(), esNuevo: true);
  }

  //----------------------------------------------------------------------------
  Future<void> onEditAditivo(BuildContext context, Aditivo aditivo,
      {bool esNuevo = false}) async {
    DirectorioAditivos coleccion =
        Provider.of<DirectorioAditivos>(context, listen: false);

    Aditivo aditivoAEditar = aditivo.copyWith();

    String title = esNuevo ? "Creacion de Aditivo" : "Editar Aditivo";

    bool? guardado = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (context) => EditPage(aditivo: aditivoAEditar, title: title),
      ),
    );

    if (guardado ?? false) {
      if (esNuevo) {
        coleccion.aditivos.add(aditivoAEditar);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Añadido con exito"),
            duration: const Duration(seconds: 2),
          ),
        );
      } else {
        aditivo.copyValuesFrom(aditivoAEditar);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Editado con exito"),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }

    coleccion.save();
    aditivo.notificar();
  }
}
