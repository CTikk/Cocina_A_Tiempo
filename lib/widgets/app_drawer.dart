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
      backgroundColor: Colors.white,
      child: Column(
        children: [
          // Header del Drawer
          UserAccountsDrawerHeader(
            accountName: const Text("Chef Placeholder"),
            accountEmail: const Text("chef@example.com"),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage("assets/icons/splash_icon.png"),
              radius: 40,
            ),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 65, 57, 62),
              image: DecorationImage(
                image: AssetImage("assets/icons/splash_icon.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Enlaces del Drawer
          ListTile(
            leading: const Icon(Icons.timer, color: Color.fromARGB(255, 142, 65, 98)),
            title: const Text('Timers'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const TimersPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.person, color: Color.fromARGB(255, 142, 65, 98)),
            title: const Text('Profile'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.book, color: Color.fromARGB(255, 142, 65, 98)),
            title: const Text('Recipes'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const RecipePage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.kitchen, color: Color.fromARGB(255, 142, 65, 98)),
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