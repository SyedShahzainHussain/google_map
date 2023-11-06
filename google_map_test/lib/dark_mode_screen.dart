import 'package:flutter/material.dart';
import 'package:google_map_test/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class DarkModeScreen extends StatefulWidget {
  const DarkModeScreen({super.key});

  @override
  State<DarkModeScreen> createState() => _DarkModeScreenState();
}

class _DarkModeScreenState extends State<DarkModeScreen> {
  @override
  Widget build(BuildContext context) {
    final thememode = Provider.of<ThemeChange>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('hello'),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RadioListTile<ThemeMode>(
              title: Text("Light"),
              value: ThemeMode.light,
              groupValue: thememode.getThemeMode,
              onChanged: thememode.setTheme,
            ),
            RadioListTile<ThemeMode>(
              title: const Text("Dark"),
              value: ThemeMode.dark,
              groupValue: thememode.getThemeMode,
              onChanged:  thememode.setTheme,
            ),
              RadioListTile<ThemeMode>(
              title: const Text("System"),
              value: ThemeMode.system,
              groupValue: thememode.getThemeMode,
              onChanged:  thememode.setTheme,
            ),
            // Switch.adaptive(value:true, onChanged:thememode.setTheme )
          ]),
    );
  } 
}
