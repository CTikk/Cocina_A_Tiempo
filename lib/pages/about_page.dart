import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/app_drawer.dart'; // ← Asegúrate de importar esto

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  int _rating = 0;

  Future<void> _sendEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'chef@example.com',
      query: 'subject=Feedback Cocina a Tiempo&body=Escribe tu opinión aquí...',
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No se pudo abrir el cliente de correo")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text("Acerca de")),
      drawer: const AppDrawer(), // ← Aquí agregamos el drawer
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Cocina a Tiempo",
              style: textTheme.titleLarge?.copyWith(fontSize: 26),
            ),
            const SizedBox(height: 10),
            Text(
              "Desarrollado por Valentine Sierra",
              style: textTheme.bodyMedium,
            ),
            const SizedBox(height: 20),
            Text(
              "Aplicación diseñada para ayudarte a organizar tus ingredientes y tiempos de cocción fácilmente.",
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium,
            ),
            const SizedBox(height: 30),
            Text(
              "¿Qué te ha parecido la app?",
              style: textTheme.titleLarge?.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (i) {
                return IconButton(
                  icon: Icon(
                    i < _rating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                    size: 32,
                  ),
                  onPressed: () {
                    setState(() {
                      _rating = i + 1;
                    });
                  },
                );
              }),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: _sendEmail,
              icon: const Icon(Icons.email),
              label: const Text("Enviar sugerencia"),
            ),
          ],
        ),
      ),
    );
  }
}