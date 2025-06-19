import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';
import 'main_tabs_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Map<String, dynamic>> _products = [];

  void _addProduct(Map<String, dynamic> product) {
    setState(() {
      _products.add(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Mi App de Productos',
      theme: const CupertinoThemeData(
        brightness: Brightness.light,
        primaryColor: CupertinoColors.systemBlue,
      ),
      home: LoginScreen(
        onLoginSuccess: (BuildContext context) {
          // Navegamos a la pantalla de pestañas después del login exitoso.
          // Le pasamos la lista de productos y la función para añadir.
          Navigator.pushReplacement(
            context,
            CupertinoPageRoute(
              builder: (context) => MainTabsScreen(
                products: _products,
                addProductCallback: _addProduct,
              ),
            ),
          );
        },
      ),
    );
  }
}
