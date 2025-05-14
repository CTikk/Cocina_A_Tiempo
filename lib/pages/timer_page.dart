import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';

class TimersPage extends StatelessWidget {
  const TimersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Timers")),
      drawer: const AppDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/icons/splash_icon.png', width: 150),
            const SizedBox(height: 20),
            const Text("Timers", style: TextStyle(fontSize: 24)),
          ],
        ),
      ),
    );
  }
}