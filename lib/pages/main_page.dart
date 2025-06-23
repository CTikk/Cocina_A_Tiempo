import 'dart:async';
import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import '../database/db_helper.dart';
import '../database/timer_model.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<TimerEntry> _activeTimers = [];
  final Map<int, Timer> _runningTimers = {};
  final DBHelper _dbHelper = DBHelper();

  @override
  void initState() {
    super.initState();
    _loadActiveTimers();
  }

  void _loadActiveTimers() async {
    final allTimers = await _dbHelper.getTimers();
    final active = allTimers.where((t) => t.isRunning).toList();

    for (var timerEntry in active) {
      if (!_runningTimers.containsKey(timerEntry.id)) {
        _runningTimers[timerEntry.id!] = Timer.periodic(const Duration(seconds: 1), (timer) async {
          if (timerEntry.remainingSeconds > 0) {
            setState(() => timerEntry.remainingSeconds--);
          } else {
            timer.cancel();
            _runningTimers.remove(timerEntry.id);
            timerEntry.isRunning = false;
          }
          await _dbHelper.updateTimer(timerEntry);
        });
      }
    }

    setState(() {
      _activeTimers = active;
    });
  }

  @override
  void dispose() {
    for (var timer in _runningTimers.values) {
      timer.cancel();
    }
    _runningTimers.clear();
    super.dispose();
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cocina a Tiempo'), centerTitle: true),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/icons/splash_icon.png', width: 200),
            const SizedBox(height: 20),
            const Text("Bienvenido a Cocina a Tiempo", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            const Text("Organiza tus tiempos de cocina, descubre nuevas recetas y gestiona tus ingredientes de manera sencilla.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 30),
            if (_activeTimers.isNotEmpty) ...[
              Text("Temporizadores activos", style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 10),
              for (var t in _activeTimers)
                Card(
                  color: Colors.green.shade50,
                  child: ListTile(
                    title: Text(t.name),
                    subtitle: Text("Restante: ${_formatTime(t.remainingSeconds)}"),
                    trailing: const Icon(Icons.timelapse, color: Colors.green),
                  ),
                ),
              const SizedBox(height: 20),
            ],
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildFeatureCard(context, icon: Icons.timer, title: "Temporizadores", color: Color.fromARGB(255, 142, 65, 98), route: '/timers'),
                  _buildFeatureCard(context, icon: Icons.book, title: "Recetas", color: Color.fromARGB(255, 142, 65, 98), route: '/recipes'),
                  _buildFeatureCard(context, icon: Icons.kitchen, title: "Ingredientes", color: Color.fromARGB(255, 142, 65, 98), route: '/ingredients'),
                  _buildFeatureCard(context, icon: Icons.person, title: "Perfil", color: Color.fromARGB(255, 142, 65, 98), route: '/profile'),
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
