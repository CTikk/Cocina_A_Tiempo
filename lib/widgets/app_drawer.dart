import 'package:flutter/material.dart';
import '../pages/profile_page.dart';
import '../pages/recipe_page.dart';
import '../pages/ingredients_page.dart';
import '../pages/timer_page.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // Header del Drawer
          UserAccountsDrawerHeader(
            accountName: const Text("Chef Placeholder"),
            accountEmail: const Text("chef@example.com"),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage("assets/images/splash_icon.png"),
              radius: 40,
            ),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 226, 168, 200),
              image: DecorationImage(
                image: AssetImage("assets/images/splash_icon.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Enlaces del Drawer
          ListTile(
            leading: const Icon(Icons.timer, color: Colors.green),
            title: const Text('Timers'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const TimersPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.person, color: Colors.green),
            title: const Text('Profile'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.book, color: Colors.green),
            title: const Text('Recipes'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const RecipePage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.kitchen, color: Colors.green),
            title: const Text('Ingredients'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const IngredientsPage()),
              );
            },
          ),

          // Separador
          const Divider(thickness: 1, color: Colors.grey),

          // Configuración y Salir
          ListTile(
            leading: const Icon(Icons.settings, color: Colors.grey),
            title: const Text('Settings'),
            onTap: () {
              // Aquí se podría agregar una pantalla de configuración en el futuro
            },
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app, color: Colors.red),
            title: const Text('Logout'),
            onTap: () {
              // Aquí se podría manejar el logout
            },
          ),
        ],
      ),
    );
  }
}