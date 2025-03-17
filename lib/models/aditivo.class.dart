import 'package:flutter/material.dart';

import 'peligrosidad.enum.dart';

//==============================================================================
class Aditivo extends ChangeNotifier {
  String codigo;
  String nombre;
  Peligrosidad? peligrosidad;
  String comentario;
  bool esFavorito;

  //----------------------------------------------------------------------------
  Aditivo({
    this.codigo = "",
    this.nombre = "",
    this.peligrosidad,
    this.comentario = "",
    this.esFavorito = false,
  });

  //----------------------------------------------------------------------------
  factory Aditivo.fromJson(Map<String, dynamic> data) {
    String nombreCompleto = data["nombre"] as String;

    List<String> componentes = nombreCompleto.split(' - ');

    return Aditivo(
        codigo: componentes[0],
        nombre: componentes[1],
        peligrosidad: data["peligrosidad"] != null
            ? Peligrosidad.tryParse(data["peligrosidad"])!
            : null,
        comentario: data["comentario"],
        esFavorito: data["esFavorito"] ?? false);
  }

  //----------------------------------------------------------------------------
  Aditivo copyWith(
      {String? codigo,
      String? nombre,
      Peligrosidad? peligrosidad,
      String? comentario,
      bool? esFavorito}) {
    return Aditivo(
      codigo: codigo ?? this.codigo,
      nombre: nombre ?? this.nombre,
      peligrosidad: peligrosidad ?? this.peligrosidad,
      comentario: comentario ?? this.comentario,
      esFavorito: esFavorito ?? this.esFavorito,
    );
  }

  notificar() {
    notifyListeners();
  }

  //----------------------------------------------------------------------------
  Map<String, dynamic> toJson() {
    return {
      "nombre": "$codigo - $nombre",
      if (peligrosidad != null) "peligrosidad": "$peligrosidad",
      "comentario": comentario,
      if (esFavorito) "esFavorito": true,
    };
  }

//----------------------------------------------------------------------------
  // Método copyValuesFrom
  void copyValuesFrom(Aditivo aditivo) {
    codigo = aditivo.codigo;
    comentario = aditivo.comentario;
    nombre = aditivo.nombre;
    esFavorito = aditivo.esFavorito;
    peligrosidad = aditivo.peligrosidad;
  }

  bool equalsData(Object other) {
    if (other is Aditivo) {
      return codigo == other.codigo &&
          comentario == other.comentario &&
          nombre == other.nombre &&
          esFavorito == other.esFavorito &&
          peligrosidad == other.peligrosidad;
    }
    return false;
  }

  //----------------------------------------------------------------------------
  @override
  String toString() {
    return toJson().toString();
  }
}
