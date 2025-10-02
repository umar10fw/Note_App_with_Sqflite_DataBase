import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_database_project/Data/provider/themeprovider.dart';

class SettingPage extends StatelessWidget {
  SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Setting"),
      ),
      body: Consumer<ThemeProvider>(builder: (context, provider, child) {
        return SwitchListTile.adaptive(
          title: Text("Dark Mode"),
          subtitle: Text("Change them mode here"),
          value: provider.getThemeValue(),
          onChanged: (value) {
            provider.updateThemeMode(value: value);
          },
        );
      },)
    );
  }
}
