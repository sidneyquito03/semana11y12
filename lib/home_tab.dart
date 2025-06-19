import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; // Para Text

import 'profile_settings_tab.dart'; // Para navegar a la pantalla de perfil

class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Bienvenido'),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Icon(
                CupertinoIcons.hand_thumbsup_fill,
                size: 80,
                color: CupertinoColors.activeBlue,
              ),
              const SizedBox(height: 30),
              const Text(
                '¡Hola de nuevo!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: CupertinoColors.label,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                'Explora tus productos o registra nuevos.',
                style: TextStyle(
                  fontSize: 16,
                  color: CupertinoColors.systemGrey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: CupertinoButton.filled(
                  onPressed: () {
                    // Navegar a la pestaña de Perfil (usando un truco para cambiar de pestaña)
                    // Esto es un poco avanzado, pero para un ejemplo simple está bien.
                    // En una app real, podrías usar un Provider o BLoC para cambiar de pestaña.
                    DefaultTabController.of(context)?.animateTo(
                        3); // Asume que Perfil es la 4ta pestaña (índice 3)
                  },
                  child: const Text('Ir a mi perfil',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
