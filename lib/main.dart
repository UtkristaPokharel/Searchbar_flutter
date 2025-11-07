import 'package:flutter/material.dart';
import 'package:practice_project/grid.dart';
import 'package:practice_project/searchbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDark = false;

  String searchQuery = '';

  void _handleThemeToggle(bool newIsDark) {
    setState(() {
      isDark = newIsDark;
    });
  }
    void _handleSearchChanged(String newQuery) {
    setState(() {
      searchQuery = newQuery;
    });
  }
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = ThemeData(
      brightness: isDark ? Brightness.dark : Brightness.light,
      colorSchemeSeed: Colors.blue,
      useMaterial3: true,
    );
    return MaterialApp(
      theme: themeData,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Search bar example'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              MySearchBar(
                isDark: isDark,
                onThemeToggle: (bool newIsDark) {
                  _handleThemeToggle(newIsDark);
                },
                onSearchChanged: (String newQuery) {
                  _handleSearchChanged(newQuery);
                },
              ),
              const SizedBox(height: 16.0),
              Mygrid(
                searchQuery: searchQuery,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
