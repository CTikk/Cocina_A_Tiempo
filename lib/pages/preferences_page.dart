import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/app_drawer.dart'; // Asegúrate de importar el Drawer

class PreferencesPage extends StatefulWidget {
  const PreferencesPage({super.key});

  @override
  State<PreferencesPage> createState() => _PreferencesPageState();
}

class _PreferencesPageState extends State<PreferencesPage> {
  bool _alarmSound = true;
  String _measurementUnit = 'Litros';
  String _themeColorKey = 'Verde';
  bool _showTips = true;

  final List<String> _units = ['Litros', 'Onzas', 'Gramos'];
  final Map<String, Color> _colors = {
    'Verde': Colors.green,
    'Rosa': Colors.pink,
    'Marrón': Colors.brown,
    'Morado': Colors.deepPurple,
  };

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _alarmSound = prefs.getBool('alarmSound') ?? true;
      _measurementUnit = prefs.getString('measurementUnit') ?? 'Litros';
      _themeColorKey = prefs.getString('themeColorKey') ?? 'Verde';
      _showTips = prefs.getBool('showTips') ?? true;
    });
  }

  Future<void> _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('alarmSound', _alarmSound);
    await prefs.setString('measurementUnit', _measurementUnit);
    await prefs.setString('themeColorKey', _themeColorKey);
    await prefs.setBool('showTips', _showTips);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Preferencias guardadas", style: Theme.of(context).textTheme.bodyMedium),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text("Preferencias")),
      drawer: const AppDrawer(), // <- Drawer añadido aquí
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SwitchListTile(
            title: Text("Sonido de alarma", style: textTheme.bodyLarge),
            value: _alarmSound,
            onChanged: (value) => setState(() => _alarmSound = value),
          ),
          ListTile(
            title: Text("Unidad de medida", style: textTheme.bodyLarge),
            trailing: DropdownButton<String>(
              value: _measurementUnit,
              onChanged: (value) {
                if (value != null) setState(() => _measurementUnit = value);
              },
              items: _units.map(
                (unit) => DropdownMenuItem(
                  value: unit,
                  child: Text(unit, style: textTheme.bodyMedium),
                ),
              ).toList(),
            ),
          ),
          ListTile(
            title: Text("Color de la aplicación", style: textTheme.bodyLarge),
            trailing: DropdownButton<String>(
              value: _themeColorKey,
              onChanged: (key) {
                if (key != null) setState(() => _themeColorKey = key);
              },
              items: _colors.keys.map(
                (key) => DropdownMenuItem(
                  value: key,
                  child: Text(key, style: textTheme.bodyMedium),
                ),
              ).toList(),
            ),
          ),
          SwitchListTile(
            title: Text("Mostrar consejos de cocina", style: textTheme.bodyLarge),
            value: _showTips,
            onChanged: (value) => setState(() => _showTips = value),
          ),
          const SizedBox(height: 30),
          ElevatedButton.icon(
            onPressed: _savePreferences,
            icon: const Icon(Icons.save),
            label: const Text("Guardar"),
          ),
        ],
      ),
    );
  }
}