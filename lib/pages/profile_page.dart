import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text("Perfil")),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Imagen de perfil
            const CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage("assets/images/user_profile.jpg"),
            ),
            const SizedBox(height: 20),

            // Información del usuario
            Text(
              "Chef Placeholder",
              style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              "chef@example.com",
              style: textTheme.bodyMedium?.copyWith(color: Colors.grey),
            ),
            const SizedBox(height: 20),

            // Información adicional
            const Divider(),
            ListTile(
              leading: const Icon(Icons.restaurant_menu, color: Color.fromARGB(255, 142, 65, 98)),
              title: Text("Recetas creadas", style: textTheme.bodyLarge),
              trailing: Text("5", style: textTheme.bodyMedium),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.timer, color: Color.fromARGB(255, 142, 65, 98)),
              title: Text("Temporizadores activos", style: textTheme.bodyLarge),
              trailing: Text("2", style: textTheme.bodyMedium),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.favorite, color: Colors.red),
              title: Text("Recetas favoritas", style: textTheme.bodyLarge),
              trailing: Text("3", style: textTheme.bodyMedium),
              onTap: () {},
            ),
            const Divider(),

            // Botón para editar perfil
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.edit),
              label: const Text("Editar Perfil"),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 142, 65, 98),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}