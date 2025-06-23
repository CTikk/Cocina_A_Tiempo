import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';

class RecipePage extends StatelessWidget {
  const RecipePage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text("Recetas")),
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
                'assets/images/${recipe["image"]}',
                width: 60,
                height: 60,
              ),
              title: Text(
                recipe["name"],
                style: textTheme.titleMedium,
              ),
              subtitle: Text(
                "Tiempo estimado: ${recipe["time"]}",
                style: textTheme.bodyMedium,
              ),
              trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
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
        backgroundColor: const Color.fromARGB(255, 142, 65, 98),
        child: const Icon(Icons.add),
      ),
    );
  }
}

final List<Map<String, dynamic>> recipes = [
  {
    "name": "Shoyu Ramen",
    "time": "20 min",
    "image": "food_ramen.png",
    "ingredients": ["Fideos", "Huevos", "Soya", "Pimienta", "Panceta"],
  },
  {
    "name": "Ensalada César",
    "time": "15 min",
    "image": "food_salad.png",
    "ingredients": ["Lechuga", "Pollo", "Queso", "Crutones", "Aderezo César"],
  },
  {
    "name": "Arroz Primavera",
    "time": "25 min",
    "image": "food_rice.png",
    "ingredients": ["Arroz", "Choclo", "Cebolla", "Zanahoria", "Pimentón"],
  },
  {
    "name": "Pizza Margherita",
    "time": "50 min",
    "image": "food_pizza.png",
    "ingredients": ["Masa", "Tomate", "Mozzarella", "Albahaca"],
  },
  {
    "name": "Hamburguesa Clásica",
    "time": "20 min",
    "image": "food_burguer.png",
    "ingredients": ["Pan", "Carne", "Lechuga", "Tomate", "Queso", "Cebolla"],
  },
];