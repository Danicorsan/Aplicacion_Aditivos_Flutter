// ignore_for_file: prefer_const_constructors

import 'package:aplicacion_aditivos/models/aditivo.class.dart';
import 'package:aplicacion_aditivos/models/peligrosidad.enum.dart';
import 'package:aplicacion_aditivos/services/events_hub.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AditivoTile extends StatelessWidget {
  final Aditivo aditivo;

  const AditivoTile({super.key, required this.aditivo});

  @override
  Widget build(BuildContext context) {
    final event = Provider.of<EventsHub>(context, listen: false);
    return ListenableBuilder(
        listenable: aditivo,
        builder: (context, child) {
          return Card(
            child: ListTile(
              leading: switch (aditivo.peligrosidad) {
                Peligrosidad.saludable => Icon(
                    Icons.sentiment_satisfied,
                    color: Colors.green,
                  ),
                Peligrosidad.inofensivo => Icon(
                    Icons.favorite,
                    color: Colors.blue,
                  ),
                Peligrosidad.precaucion => Icon(
                    Icons.warning,
                    color: Colors.orange,
                  ),
                Peligrosidad.peligroso => Icon(
                    Icons.dangerous,
                    color: Colors.red,
                  ),
                null => Icon(
                    Icons.question_mark,
                    color: Colors.grey,
                  )
              },
              title: Text(aditivo.codigo),
              subtitle: Text(aditivo.nombre),
              trailing: SizedBox(
                width: 100,
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          event.onEditAditivo(context, aditivo);
                        },
                        icon: Icon(Icons.edit)),
                    IconButton(
                        onPressed: () {
                          event.onDeleteAditivo(context, aditivo);
                        },
                        icon: Icon(Icons.delete))
                  ],
                ),
              ),
              onTap: () => event.onShowAditivoComment(context, aditivo),
            ),
          );
        });
  }
}
