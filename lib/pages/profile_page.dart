import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Imagen de perfil
            CircleAvatar(
              radius: 80,
              backgroundImage: const AssetImage("assets/images/splash_icon.png"),
              backgroundColor: Colors.grey.shade200,
            ),
            const SizedBox(height: 20),

            // Información del usuario
            const Text(
              "Chef Placeholder",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "chef@example.com",
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 20),

            // Información adicional
            const Divider(),
            ListTile(
              leading: const Icon(Icons.restaurant_menu, color: Colors.green),
              title: const Text("Recetas creadas"),
              trailing: const Text("5"),
              onTap: () {
                // Aquí se podría navegar a una lista de recetas creadas
              },
            ),
            ListTile(
              leading: const Icon(Icons.timer, color: Colors.green),
              title: const Text("Temporizadores activos"),
              trailing: const Text("2"),
              onTap: () {
                // Aquí se podría navegar a los temporizadores activos
              },
            ),
            ListTile(
              leading: const Icon(Icons.favorite, color: Colors.red),
              title: const Text("Recetas favoritas"),
              trailing: const Text("3"),
              onTap: () {
                // Aquí se podría navegar a las recetas favoritas
              },
            ),
            const Divider(),

            // Botón para editar perfil
            ElevatedButton.icon(
              onPressed: () {
                // Aquí se podría abrir la pantalla para editar perfil
              },
              icon: const Icon(Icons.edit),
              label: const Text("Editar Perfil"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
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
