import 'package:aplicacion_aditivos/models/aditivo.class.dart';
import 'package:aplicacion_aditivos/models/peligrosidad.enum.dart';
import 'package:flutter/material.dart';

class EditPage extends StatefulWidget {
  final Aditivo aditivo;
  final String title;

  const EditPage({
    super.key,
    required this.aditivo,
    required this.title,
  });

  @override
  State<EditPage> createState() => _ContactFormPageState();
}

class _ContactFormPageState extends State<EditPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _codigo, _nombre, _comentario, _peligrosidad;
  bool isChange = false;
  late Aditivo initialAditivo;
  late Aditivo aditivo;

  // Agrega un controlador para manejar el valor del radio seleccionado.
  Peligrosidad? _selectedPeligrosidad;

  @override
  void initState() {
    initialAditivo = widget.aditivo;
    aditivo = initialAditivo.copyWith();

    _codigo = TextEditingController(text: initialAditivo.codigo);
    _comentario = TextEditingController(text: initialAditivo.comentario);
    _nombre = TextEditingController(text: initialAditivo.nombre);
    _peligrosidad =
        TextEditingController(text: initialAditivo.peligrosidad.toString());

    // Inicializa el valor del radio con la peligrosidad actual del aditivo.
    _selectedPeligrosidad = initialAditivo.peligrosidad;

    super.initState();
  }

  @override
  void dispose() {
    _codigo.dispose();
    _comentario.dispose();
    _peligrosidad.dispose();
    _nombre.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: _handleWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            IconButton(
              onPressed: isChange ? onSubmitForm : null,
              icon: const Icon(Icons.check),
            ),
          ],
        ),
        body: Container(
          margin: const EdgeInsets.all(20),
          child: Form(
              key: _formKey,
              child: ListView(children: [
                TextFormField(
                  controller: _codigo,
                  decoration: const InputDecoration(
                    labelText: "Código",
                    hintText: "Introduce un código",
                  ),
                  validator: validarTexto,
                  onChanged: (value) {
                    onDateChange();
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _nombre,
                  decoration: const InputDecoration(
                    labelText: "Nombre",
                    hintText: "Introduce un nombre",
                  ),
                  validator: validarNombre,
                  onChanged: (value) {
                    onDateChange();
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _comentario,
                  decoration: const InputDecoration(
                    labelText: "Comentario",
                    hintText: "Introduce un comentario",
                  ),
                  onChanged: (value) {
                    onDateChange();
                  },
                  minLines: 1,
                  maxLines: 10,
                ),
                const SizedBox(height: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _elemsRadio(),
                ),
              ])),
        ),
      ),
    );
  }

  Future<bool> _handleWillPop() async {
    if (initialAditivo == aditivo) {
      return true;
    }
    bool? result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Atención"),
          content: const Text(
              "¿Seguro que deseas salir? Los cambios no se guardarán."),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text("No"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text("Sí"),
            ),
          ],
        );
      },
    );
    return result ?? false;
  }

  List<Widget> _elemsRadio() {
    return Peligrosidad.values.map((peligrosidad) {
      return RadioListTile<Peligrosidad>(
        title: Text(peligrosidad.toString()),
        value: peligrosidad,
        groupValue: _selectedPeligrosidad,
        onChanged: (Peligrosidad? value) {
          setState(() {
            _selectedPeligrosidad = value;
            aditivo.peligrosidad = value;
            onDateChange();
          });
        },
      );
    }).toList();
  }

  String? validarTexto(String? value) {
    if (value == null || value.isEmpty) {
      return "Introduce un valor";
    }
    String pattern = r'\bE-\d{3}[a-z]*\b';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return "Formato de texto incorrecto";
    }
    return null;
  }

  String? validarNombre(String? value) {
    if (value == null || value.isEmpty) {
      return "Introduce un nombre";
    }
    return null;
  }

  void onDateChange() {
    aditivo.codigo = (_codigo.text.isEmpty ? null : _codigo.text)!;
    aditivo.comentario = (_comentario.text.isEmpty ? null : _comentario.text)!;
    aditivo.nombre = (_nombre.text.isEmpty ? null : _nombre.text)!;

    setState(() {
      isChange = !initialAditivo.equalsData(aditivo);
    });
  }

  void onSubmitForm() {
    if (_formKey.currentState!.validate()) {
      initialAditivo.copyValuesFrom(aditivo);
      Navigator.of(context).pop(true);
    }
  }
}
