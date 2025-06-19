import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; // Para Text

class ProfileSettingsTab extends StatelessWidget {
  const ProfileSettingsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Mi Perfil'),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Icon(
                CupertinoIcons.person_alt_circle_fill,
                size: 100,
                color: CupertinoColors.systemGrey,
              ),
              const SizedBox(height: 30),
              const Text(
                'Usuario: user@example.com',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: CupertinoColors.label,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                'Versión de la App: 1.0.0',
                style: TextStyle(
                  fontSize: 16,
                  color: CupertinoColors.systemGrey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: CupertinoButton(
                  onPressed: () {
                    // Lógica para cerrar sesión
                    Navigator.pushReplacementNamed(
                        context, '/'); // Volver al login
                  },
                  color: CupertinoColors.systemRed
                      .withOpacity(0.8), // Botón rojo para cerrar sesión
                  child: const Text('Cerrar Sesión',
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
