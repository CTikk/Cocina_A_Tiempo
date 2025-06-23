
import 'package:flutter/material.dart';
import '../database/db_helper.dart';
import '../database/ingredient_model.dart';
import '../database/timer_model.dart';

class AddTimerPage extends StatefulWidget {
  final String? ingredientName;
  final String? cookingTime;

  const AddTimerPage({super.key, this.ingredientName, this.cookingTime});

  @override
  State<AddTimerPage> createState() => _AddTimerPageState();
}

class _AddTimerPageState extends State<AddTimerPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _durationController = TextEditingController();
  final DBHelper _dbHelper = DBHelper();
  List<Ingredient> _ingredients = [];
  String? _selectedIngredient;

  @override
  void initState() {
    super.initState();
    _loadIngredients();
    if (widget.ingredientName != null) {
      _nameController.text = widget.ingredientName!;
    }
    if (widget.cookingTime != null) {
      _durationController.text = widget.cookingTime!;
    }
  }

  Future<void> _loadIngredients() async {
    final data = await _dbHelper.getIngredients();
    setState(() {
      _ingredients = data;
    });
  }

  void _fillFromDropdown(String name) {
    final selected = _ingredients.firstWhere((i) => i.name == name);
    _nameController.text = selected.name;
    _durationController.text = selected.time;
  }

  void _startTimer() async {
  if (_formKey.currentState!.validate()) {
    // Convertir la duración a minutos y luego a segundos
    final durationText = _durationController.text.trim().split(" ").first;
    final durationInMinutes = int.tryParse(durationText) ?? 0;
    final totalSeconds = durationInMinutes * 60;

    final newTimer = TimerEntry(
      name: _nameController.text.trim(),
      totalSeconds: totalSeconds,
      remainingSeconds: totalSeconds,
      isRunning: false,
    );

    await _dbHelper.insertTimer(newTimer);

    if (!mounted) return;
    Navigator.pop(context);
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Agregar Temporizador")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              if (_ingredients.isNotEmpty)
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: "Seleccionar ingrediente"),
                  items: _ingredients.map((ingredient) {
                    return DropdownMenuItem(
                      value: ingredient.name,
                      child: Text(ingredient.name),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedIngredient = value;
                      _fillFromDropdown(value!);
                    });
                  },
                ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: "Nombre del ingrediente"),
                validator: (value) =>
                    value == null || value.isEmpty ? "Ingresa el nombre" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _durationController,
                decoration: const InputDecoration(labelText: "Duración (ej: 30 min)"),
                validator: (value) =>
                    value == null || value.isEmpty ? "Ingresa la duración" : null,
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: _startTimer,
                icon: const Icon(Icons.timer),
                label: const Text("Crear Temporizador"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
