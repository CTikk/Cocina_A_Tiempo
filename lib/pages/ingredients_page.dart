import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import '../database/db_helper.dart';
import '../database/ingredient_model.dart';
import 'add_timer_page.dart';

class IngredientsPage extends StatefulWidget {
  const IngredientsPage({super.key});

  @override
  State<IngredientsPage> createState() => _IngredientsPageState();
}

class _IngredientsPageState extends State<IngredientsPage> {
  final DBHelper _dbHelper = DBHelper();
  List<Ingredient> _ingredients = [];

  @override
  void initState() {
    super.initState();
    _loadIngredients();
  }

  Future<void> _loadIngredients() async {
  try {
    await _dbHelper.insertDefaultIngredients();
    final data = await _dbHelper.getIngredients();
    setState(() {
      _ingredients = data;
    });
  } catch (e) {
    debugPrint("Error al cargar ingredientes: $e");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error al cargar ingredientes: $e")),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text("Ingredientes")),
      drawer: const AppDrawer(),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _ingredients.length,
              itemBuilder: (context, index) {
                final ingredient = _ingredients[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: ListTile(
                    /*leading: Image.asset(
                      'assets/images/${ingredient.image}',
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),*/
                    title: Text(ingredient.name, style: textTheme.titleMedium),
                    subtitle: Text("Tiempo: ${ingredient.time}", style: textTheme.bodyMedium),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () async {
                        await _dbHelper.deleteIngredient(ingredient.id!);
                        _loadIngredients();
                      },
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(ingredient.name, style: textTheme.titleLarge),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Tiempo de cocción: ${ingredient.time}", style: textTheme.bodyMedium),
                              const SizedBox(height: 10),
                              Text("Tipos de cocción:", style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
                              for (var type in ingredient.types)
                                Text("- $type", style: textTheme.bodyMedium),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("Cerrar"),
                            ),
                            ElevatedButton.icon(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddTimerPage(
                                      ingredientName: ingredient.name,
                                      cookingTime: ingredient.time,
                                    ),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.timer),
                              label: const Text("Agregar temporizador"),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/add-ingredient');
              },
              icon: const Icon(Icons.add),
              label: const Text("Agregar nuevo ingrediente"),
            ),
          )
        ],
      ),
    );
  }
}