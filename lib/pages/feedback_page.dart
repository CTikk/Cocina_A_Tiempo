import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  Map<String, List<Map<String, dynamic>>> questions = {};
  final Map<String, List<int>> answers = {};

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    final String jsonData = await rootBundle.loadString('assets/json/feedback_questions.json');
    final Map<String, dynamic> parsed = jsonDecode(jsonData);

    setState(() {
      questions = parsed.map((section, qList) => MapEntry(
            section,
            (qList as List).map((q) => Map<String, dynamic>.from(q)).toList(),
          ));

      for (var section in questions.keys) {
        answers[section] = List.filled(questions[section]!.length, 0);
      }
    });
  }

Future<void> _sendFeedback() async {
  final buffer = StringBuffer();

  for (var section in questions.keys) {
    buffer.writeln("🔹 $section:");
    for (int i = 0; i < questions[section]!.length; i++) {
      final titulo = questions[section]![i]["titulo"];
      final stars = answers[section]![i];
      buffer.writeln("- $titulo: $stars estrellas");
    }
    buffer.writeln("");
  }

  final String content = buffer.toString();

  try {
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/feedback.txt');
    await file.writeAsString(content);

    await Share.shareXFiles(
      [XFile(file.path)],
      text: 'Opinión sobre la app Cocina a Tiempo',
    );
  } catch (e) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("No se pudo compartir el archivo: $e")),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text("Tu Opinión")),
      body: questions.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                for (var section in questions.keys) ...[
                  Text(
                    section.toUpperCase(),
                    style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  for (int i = 0; i < questions[section]!.length; i++) ...[
                    Text(
                      questions[section]![i]["titulo"],
                      style: textTheme.bodyLarge,
                    ),
                    Row(
                      children: List.generate(5, (index) {
                        return IconButton(
                          icon: Icon(
                            index < answers[section]![i] ? Icons.star : Icons.star_border,
                            color: Colors.amber,
                          ),
                          onPressed: () {
                            setState(() {
                              answers[section]![i] = index + 1;
                            });
                          },
                        );
                      }),
                    ),
                    Text(
                      "→ ${answers[section]![i] == 0 ? questions[section]![i]["min"] : questions[section]![i]["max"]}",
                      style: textTheme.bodySmall?.copyWith(color: Colors.grey),
                    ),
                    const SizedBox(height: 20),
                  ]
                ],
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {
                    final buffer = StringBuffer();
                    for (var section in questions.keys) {
                      buffer.writeln("🔹 $section:");
                      for (int i = 0; i < questions[section]!.length; i++) {
                        buffer.writeln(
                            "- ${questions[section]![i]["titulo"]}: ${answers[section]![i]} estrellas");
                      }
                      buffer.writeln("");
                    }

                    _sendFeedback();
                  },
                  icon: const Icon(Icons.send),
                  label: const Text("Enviar respuestas"),
                )
              ],
            ),
    );
  }
}