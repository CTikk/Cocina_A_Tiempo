import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';

class TimersPage extends StatelessWidget {
  const TimersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Timers")),
      drawer: const AppDrawer(),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: timers.length,
        itemBuilder: (context, index) {
          final timer = timers[index];
          return Card(
            elevation: 4,
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              leading: Image.asset(
                'assets/images/${timer["image"]}',
                width: 60,
                height: 60,
              ),
              title: Text(timer["name"]),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Tiempo restante: ${timer["time"]}"),
                  const SizedBox(height: 4),
                  LinearProgressIndicator(
                    value: timer["progress"],
                    color: Color.fromARGB(255, 142, 65, 98),
                    backgroundColor: Colors.grey.shade300,
                  ),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.pause_circle, color: Colors.grey, size: 30),
                onPressed: () {
                  // Aquí se podría pausar el temporizador en el futuro
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Aquí se podría abrir la pantalla para agregar un nuevo temporizador
        },
        backgroundColor: Color.fromARGB(255, 142, 65, 98),
        child: const Icon(Icons.add),
      ),
    );
  }
}

final List<Map<String, dynamic>> timers = [
  {
    "name": "Pollo - Horneado",
    "time": "25:30",
    "progress": 0.3,
    "image": "supplies_oven.png",
  },
  {
    "name": "Pasta - Hervida",
    "time": "8:20",
    "progress": 0.8,
    "image": "supplies_pot.png",
  },
];