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
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text("Chef Placeholder"),
            accountEmail: Text("chef@example.com"),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage("assets/icons/splash_icon.png"),
            ),
            decoration: BoxDecoration(
              color: Colors.green,
            ),
          ),
          ListTile(
            title: const Text('Timers'),
            leading: const Icon(Icons.timer),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TimersPage()),
              );
            },
          ),
          ListTile(
            title: const Text('Profile'),
            leading: const Icon(Icons.person),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage()),
              );
            },
          ),
          ListTile(
            title: const Text('Recipes'),
            leading: const Icon(Icons.book),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RecipePage()),
              );
            },
          ),
          ListTile(
            title: const Text('Ingredients'),
            leading: const Icon(Icons.kitchen),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const IngredientsPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}