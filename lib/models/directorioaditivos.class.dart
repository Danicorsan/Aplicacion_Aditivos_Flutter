// ignore_for_file: unused_field, avoid_print

import 'dart:convert';

import 'package:aplicacion_aditivos/models/enumeraciones.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'aditivo.class.dart';

//==============================================================================
class DirectorioAditivos extends ChangeNotifier {
  DirectorioAditivosState _state = DirectorioAditivosState.initial;

  //----------------------------------------------------------------------------
  // Carga la información sobre los aditivos del almacenamiento de datos
  // local usando shared_preferences. Si no hay datos, los obtiene de la
  // variable global aditivosJson
  Future<void> load([bool forceReset = false]) async {
    //espera 2 segundos
    await Future.delayed(const Duration(seconds: 2));

    //cargar
    String? jsonString;
    final prefs = await SharedPreferences.getInstance();
    jsonString = prefs.getString("aditivos");

    _state = DirectorioAditivosState.loaded;
    List<Map<String, dynamic>> data =
        (jsonDecode(jsonString!) as List).cast<Map<String, dynamic>>();
    DirectorioAditivos coleccion = DirectorioAditivos.fromJson(data);
    aditivos = List.from(coleccion.aditivos);
    notifyListeners();
    _state = DirectorioAditivosState.ready;
  }

  //----------------------------------------------------------------------------
  // Almacena la información actual sobre los aditivos en el almacenamiento
  // local
  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonString = jsonEncode(toJson());
    await prefs.setString("aditivos", jsonString);
    notifyListeners();
  }

  //----------------------------------------------------------------------------
  List<Aditivo> aditivos;

  //----------------------------------------------------------------------------
  DirectorioAditivos({List<Aditivo>? aditivos}) : aditivos = aditivos ?? [];

  //----------------------------------------------------------------------------
  factory DirectorioAditivos.fromJson(List<Map<String, dynamic>> jsonData) {
    try {
      return DirectorioAditivos(
          aditivos: jsonData.map((e) => Aditivo.fromJson(e)).toList());
    } on Exception catch (e) {
      print(e);
      return DirectorioAditivos();
    }
  }

  //----------------------------------------------------------------------------
  List<Map<String, dynamic>> toJson() {
    return aditivos.map((aditivo) => aditivo.toJson()).toList();
  }

  //----------------------------------------------------------------------------
  void copyFrom(DirectorioAditivos otroDirectorio) {
    aditivos = otroDirectorio.aditivos.map((m) => m.copyWith()).toList();
  }

  notificar() {
    notifyListeners();
  }

  //----------------------------------------------------------------------------
  @override
  String toString() {
    return toJson().toString();
  }
}
