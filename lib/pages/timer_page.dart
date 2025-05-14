import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';

class TimersPage extends StatelessWidget {
  const TimersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Timers")),
      drawer: const AppDrawer(),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Ejemplo de Temporizador 1
          Card(
            elevation: 4,
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              leading: const Icon(Icons.timer, color: Color.fromARGB(255, 142, 65, 98), size: 40),
              title: const Text("Carne de Res - Horneado"),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Tiempo restante: 25:30"),
                  SizedBox(height: 4),
                  LinearProgressIndicator(value: 0.3, color: Color.fromARGB(255, 142, 65, 98)),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.pause_circle, color: Colors.grey, size: 30),
                onPressed: () {
                  // Aquí se podría pausar el temporizador en el futuro
                },
              ),
            ),
          ),

          // Ejemplo de Temporizador 2
          Card(
            elevation: 4,
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              leading: const Icon(Icons.timer, color: Color.fromARGB(255, 142, 65, 98), size: 40),
              title: const Text("Pasta - Hervida"),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Tiempo restante: 8:20"),
                  SizedBox(height: 4),
                  LinearProgressIndicator(value: 0.8, color: Color.fromARGB(255, 142, 65, 98)),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.pause_circle, color: Colors.grey, size: 30),
                onPressed: () {
                  // Aquí se podría pausar el temporizador en el futuro
                },
              ),
            ),
          ),

          // Botón para Agregar Temporizador
          ElevatedButton.icon(
            onPressed: () {
              // Aquí se podría abrir la pantalla para agregar un nuevo temporizador
            },
            icon: const Icon(Icons.add),
            label: const Text("Agregar Temporizador", ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 142, 65, 98),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}