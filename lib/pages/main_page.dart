import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cocina a Tiempo'),
        centerTitle: true,
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Imagen de bienvenida
            Image.asset('assets/icons/splash_icon.png', width: 200),
            const SizedBox(height: 20),
            
            // Título de bienvenida
            const Text(
              "Bienvenido a Cocina a Tiempo",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Mensaje de introducción
            const Text(
              "Organiza tus tiempos de cocina, descubre nuevas recetas y gestiona tus ingredientes de manera sencilla.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 30),

            // Tarjetas con atajos a las principales funciones
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildFeatureCard(
                    context,
                    icon: Icons.timer,
                    title: "Temporizadores",
                    color: const Color.fromARGB(255, 142, 65, 98),
                    route: '/timers',
                  ),
                  _buildFeatureCard(
                    context,
                    icon: Icons.book,
                    title: "Recetas",
                    color: const Color.fromARGB(255, 142, 65, 98),
                    route: '/recipes',
                  ),
                  _buildFeatureCard(
                    context,
                    icon: Icons.kitchen,
                    title: "Ingredientes",
                    color: const Color.fromARGB(255, 142, 65, 98),
                    route: '/ingredients',
                  ),
                  _buildFeatureCard(
                    context,
                    icon: Icons.person,
                    title: "Perfil",
                    color: const Color.fromARGB(255, 142, 65, 98),
                    route: '/profile',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(BuildContext context, {required IconData icon, required String title, required Color color, required String route}) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: color),
            const SizedBox(height: 10),
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}