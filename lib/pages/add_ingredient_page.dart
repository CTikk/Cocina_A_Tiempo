import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import '../database/db_helper.dart';
import '../database/ingredient_model.dart';

class AddIngredientPage extends StatefulWidget {
  const AddIngredientPage({super.key});

  @override
  State<AddIngredientPage> createState() => _AddIngredientPageState();
}

class _AddIngredientPageState extends State<AddIngredientPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _timeController = TextEditingController();

  final Map<String, bool> _cookingTypes = {
    'Frito': false,
    'Hervido': false,
    'Asado': false,
    'Horneado': false,
    'A la parrilla': false,
    'Salteado': false,
  };

  void _saveIngredient() async {
    if (_formKey.currentState!.validate()) {
      final selectedTypes = _cookingTypes.entries
          .where((entry) => entry.value)
          .map((entry) => entry.key)
          .toList();

      if (selectedTypes.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Selecciona al menos un tipo de cocción.",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        );
        return;
      }

      final ingredient = Ingredient(
        name: _nameController.text.trim(),
        time: _timeController.text.trim(),
        image: 'placeholder.png',
        types: selectedTypes,
      );

      await DBHelper().insertIngredient(ingredient);

      if (!mounted) return;
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Ingrediente agregado"),
          content: const Text("¿Deseas añadir un temporizador para este ingrediente?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text("No"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                Navigator.pushNamed(context, '/timers');
              },
              child: const Text("Sí"),
            ),
          ],
        ),
      );

      _nameController.clear();
      _timeController.clear();
      setState(() {
        for (var key in _cookingTypes.keys) {
          _cookingTypes[key] = false;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text("Agregar Ingrediente")),
      drawer: const AppDrawer(), // Drawer integrado
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: "Nombre del ingrediente"),
                validator: (value) =>
                    value == null || value.isEmpty ? "Ingresa un nombre" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _timeController,
                decoration: const InputDecoration(labelText: "Tiempo de cocción"),
                validator: (value) =>
                    value == null || value.isEmpty ? "Ingresa el tiempo" : null,
              ),
              const SizedBox(height: 16),
              Text("Tipos de cocción:", style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
              ..._cookingTypes.keys.map((type) {
                return CheckboxListTile(
                  title: Text(type, style: textTheme.bodyMedium),
                  value: _cookingTypes[type],
                  onChanged: (val) {
                    setState(() {
                      _cookingTypes[type] = val ?? false;
                    });
                  },
                );
              }),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _saveIngredient,
                icon: const Icon(Icons.save),
                label: const Text("Guardar Ingrediente"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}