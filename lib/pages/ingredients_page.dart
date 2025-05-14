import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';

class IngredientsPage extends StatelessWidget {
  const IngredientsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ingredients")),
      drawer: const AppDrawer(),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: ingredients.length,
        itemBuilder: (context, index) {
          final ingredient = ingredients[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              title: Text(ingredient["name"]),
              subtitle: Text("Tiempo de cocción: ${ingredient["time"]}"),
              trailing: IconButton(
                icon: const Icon(Icons.info),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(ingredient["name"]),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset('assets/icons/splash_icon.png', width: 100),
                            const SizedBox(height: 10),
                            Text("Tiempo de cocción: ${ingredient["time"]}"),
                            const SizedBox(height: 10),
                            Text("Tipos de cocción:"),
                            const SizedBox(height: 5),
                            for (var type in ingredient["types"]) Text("- $type"),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                                // Aquí se agregaría a la lista de temporizadores
                              },
                              child: const Text("Agregar"),
                            )
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Cerrar"),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

final List<Map<String, dynamic>> ingredients = [
  {
    "name": "Carne de res",
    "time": "30 min",
    "types": ["A la parrilla", "Horneado", "Frito", "Estofado"]
  },
  {
    "name": "Papas",
    "time": "20 min",
    "types": ["Hervidas", "Fritas", "Asadas"]
  },
  {
    "name": "Pollo",
    "time": "25 min",
    "types": ["Horneado", "Frito", "A la parrilla", "Asado"]
  },
  {
    "name": "Pasta",
    "time": "10 min",
    "types": ["Hervida", "Salteada", "Horneada"]
  },
];