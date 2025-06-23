import 'dart:async';
import 'package:flutter/material.dart';
import '../database/db_helper.dart';
import '../database/timer_model.dart';
import '../widgets/app_drawer.dart';

class TimersPage extends StatefulWidget {
  const TimersPage({super.key});

  @override
  State<TimersPage> createState() => _TimersPageState();
}

class _TimersPageState extends State<TimersPage> {
  final DBHelper _dbHelper = DBHelper();
  List<TimerEntry> _timers = [];
  final Map<int, Timer> _activeTimers = {};

  @override
  void initState() {
    super.initState();
    _loadTimers();
  }

  Future<void> _loadTimers() async {
    final data = await _dbHelper.getTimers();
    setState(() {
      _timers = data;
    });

    for (var t in _timers.where((t) => t.isRunning)) {
      if (!_activeTimers.containsKey(t.id)) {
        _activeTimers[t.id!] = Timer.periodic(const Duration(seconds: 1), (timer) async {
          if (t.remainingSeconds > 0) {
            setState(() => t.remainingSeconds--);
          } else {
            timer.cancel();
            _activeTimers.remove(t.id);
            t.isRunning = false;
          }
          await _dbHelper.updateTimer(t);
        });
      }
    }
  }

  void _toggleTimer(TimerEntry entry) async {
    if (_activeTimers.containsKey(entry.id)) {
      _activeTimers[entry.id]?.cancel();
      _activeTimers.remove(entry.id);
      entry.isRunning = false;
    } else {
      entry.isRunning = true;
      _activeTimers[entry.id!] = Timer.periodic(const Duration(seconds: 1), (timer) async {
        if (entry.remainingSeconds > 0) {
          setState(() => entry.remainingSeconds--);
        } else {
          timer.cancel();
          _activeTimers.remove(entry.id);
          entry.isRunning = false;
        }
        await _dbHelper.updateTimer(entry);
      });
    }
    await _dbHelper.updateTimer(entry);
    _loadTimers();
  }

  void _resetTimer(TimerEntry entry) async {
    _activeTimers[entry.id]?.cancel();
    _activeTimers.remove(entry.id);
    entry.remainingSeconds = entry.totalSeconds;
    entry.isRunning = false;
    await _dbHelper.updateTimer(entry);
    _loadTimers();
  }

  void _deleteTimer(int id) async {
    _activeTimers[id]?.cancel();
    _activeTimers.remove(id);
    await _dbHelper.deleteTimer(id);
    _loadTimers();
  }

  void _editTimer(TimerEntry entry) async {
    final TextEditingController nameController = TextEditingController(text: entry.name);
    final TextEditingController durationController = TextEditingController(text: (entry.totalSeconds ~/ 60).toString());

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Editar Temporizador"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Nombre"),
            ),
            TextField(
              controller: durationController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Duración (min)"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancelar"),
          ),
          ElevatedButton(
            onPressed: () async {
              final int minutes = int.tryParse(durationController.text.trim()) ?? 0;
              final int newTotal = minutes * 60;
              entry.name = nameController.text.trim();
              entry.totalSeconds = newTotal;
              entry.remainingSeconds = newTotal;
              await _dbHelper.updateTimer(entry);
              if (!mounted) return;
              Navigator.pop(context);
              _loadTimers();
            },
            child: const Text("Guardar"),
          ),
        ],
      ),
    );
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    for (var timer in _activeTimers.values) {
      timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final activeTimers = _timers.where((t) => t.isRunning).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Temporizadores"),
      ),
      drawer: const AppDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/add_timer');
          _loadTimers();
        },
        child: const Icon(Icons.add),
      ),
      body: _timers.isEmpty
          ? const Center(child: Text("No hay temporizadores aún."))
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                if (activeTimers.isNotEmpty) ...[
                  Text("Temporizadores activos", style: textTheme.titleMedium),
                  const SizedBox(height: 10),
                  for (var timer in activeTimers)
                    Card(
                      color: Colors.green.shade50,
                      child: ListTile(
                        title: Text(timer.name),
                        subtitle: Text("Restante: ${_formatTime(timer.remainingSeconds)}"),
                        trailing: const Icon(Icons.timelapse, color: Colors.green),
                      ),
                    ),
                  const SizedBox(height: 20),
                ],
                Text("Todos los temporizadores", style: textTheme.titleMedium),
                const SizedBox(height: 10),
                for (var timer in _timers)
                  Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Text(timer.name, style: textTheme.titleLarge),
                          const SizedBox(height: 10),
                          Text(
                            _formatTime(timer.remainingSeconds),
                            style: textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Icon(timer.isRunning ? Icons.pause : Icons.play_arrow),
                                onPressed: () => _toggleTimer(timer),
                                tooltip: timer.isRunning ? "Pausar" : "Iniciar",
                              ),
                              IconButton(
                                icon: const Icon(Icons.restart_alt),
                                onPressed: () => _resetTimer(timer),
                                tooltip: "Reiniciar",
                              ),
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () => _editTimer(timer),
                                tooltip: "Editar",
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () => _deleteTimer(timer.id!),
                                tooltip: "Eliminar",
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
    );
  }
}
