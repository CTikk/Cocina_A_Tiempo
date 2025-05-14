import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';

class RecipePage extends StatelessWidget {
  const RecipePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Recipes")),
      drawer: const AppDrawer(),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          final recipe = recipes[index];
          return Card(
            elevation: 4,
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              leading: Image.asset(
                'assets/icons/splash_icon.png',
                width: 60,
                height: 60,
              ),
              title: Text(recipe["name"]),
              subtitle: Text("Tiempo estimado: ${recipe["time"]}"),
              trailing: const Icon(Icons.arrow_forward, color: Colors.grey),
              onTap: () {
                // Aquí se podría abrir la receta para ver los detalles
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Aquí se podría abrir la pantalla para crear una nueva receta
        },
        backgroundColor: Color.fromARGB(255, 142, 65, 98),
        child: const Icon(Icons.add, color: Colors.white,),
      ),
    );
  }
}

final List<Map<String, dynamic>> recipes = [
  {
    "name": "Spaghetti Carbonara",
    "time": "20 min",
    "ingredients": ["Pasta", "Huevos", "Queso", "Pimienta", "Panceta"],
  },
  {
    "name": "Ensalada César",
    "time": "15 min",
    "ingredients": ["Lechuga", "Pollo", "Queso", "Crutones", "Aderezo César"],
  },
  {
    "name": "Tacos de Carne",
    "time": "25 min",
    "ingredients": ["Carne", "Tortillas", "Cebolla", "Cilantro", "Salsa"],
  },
  {
    "name": "Pizza Margherita",
    "time": "30 min",
    "ingredients": ["Masa", "Tomate", "Mozzarella", "Albahaca"],
  },
  {
    "name": "Hamburguesa Clásica",
    "time": "20 min",
    "ingredients": ["Pan", "Carne", "Lechuga", "Tomate", "Queso", "Cebolla"],
  },
];
