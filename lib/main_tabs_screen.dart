import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; // Para IconData y otros

import 'home_tab.dart';
import 'product_list_tab.dart';
import 'product_register_tab.dart';
import 'profile_settings_tab.dart';

class MainTabsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> products;
  final Function(Map<String, dynamic>) addProductCallback;

  const MainTabsScreen({
    Key? key,
    required this.products,
    required this.addProductCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
                CupertinoIcons.cube_box), // Icono para la lista de productos
            label: 'Productos',
          ),
          BottomNavigationBarItem(
            icon:
                Icon(CupertinoIcons.add_circled), // Icono para añadir producto
            label: 'Registrar',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.profile_circled), // Icono para perfil
            label: 'Perfil',
          ),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        switch (index) {
          case 0:
            return CupertinoTabView(builder: (context) {
              return HomeTab(); // Pestaña Home
            });
          case 1:
            return CupertinoTabView(builder: (context) {
              return ProductListTab(
                products: products,
                addProductCallback:
                    addProductCallback, // Se mantiene para compatibilidad, aunque el botón de añadir irá en otra pestaña
              );
            });
          case 2:
            return CupertinoTabView(builder: (context) {
              return ProductRegisterTab(
                addProductCallback: addProductCallback,
              );
            });
          case 3:
            return CupertinoTabView(builder: (context) {
              return ProfileSettingsTab();
            });
          default:
            return CupertinoTabView(builder: (context) {
              return HomeTab();
            });
        }
      },
    );
  }
}
