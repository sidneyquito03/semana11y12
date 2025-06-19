import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; // Para Text

class LoginScreen extends StatefulWidget {
  final Function(BuildContext) onLoginSuccess;

  const LoginScreen({Key? key, required this.onLoginSuccess}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false; // Nuevo: Para mostrar un indicador de carga

  void _performLogin() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      _showAlertDialog('Error de inicio de sesión',
          'Por favor, ingresa tu correo y contraseña.');
      return;
    }

    setState(() {
      _isLoading = true; // Activa el indicador de carga
    });

    // Simula una llamada a un servidor (retraso de 2 segundos)
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false; // Desactiva el indicador de carga
    });

    // Lógica de autenticación simple. Aquí podrías validar credenciales reales.
    if (_emailController.text == 'user@example.com' &&
        _passwordController.text == 'password') {
      widget.onLoginSuccess(context);
    } else {
      _showAlertDialog('Credenciales inválidas',
          'El correo o la contraseña son incorrectos.');
    }
  }

  void _showAlertDialog(String title, String message) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('LOGIN'),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(
              24.0), // Aumentamos el padding para más espacio
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Título con más estilo
              const Text(
                '¡Bienvenido!',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: CupertinoColors.activeBlue,
                ),
              ),
              const SizedBox(height: 40.0), // Más espacio
              CupertinoTextField(
                controller: _emailController,
                placeholder: 'Email',
                keyboardType: TextInputType.emailAddress,
                padding: const EdgeInsets.symmetric(
                    vertical: 14.0, horizontal: 16.0), // Padding más generoso
                decoration: BoxDecoration(
                  border: Border.all(
                      color: CupertinoColors.systemGrey4), // Borde más suave
                  borderRadius:
                      BorderRadius.circular(10.0), // Bordes más redondeados
                  color: CupertinoColors.systemGrey6, // Fondo ligero
                ),
              ),
              const SizedBox(height: 20.0), // Más espacio
              CupertinoTextField(
                controller: _passwordController,
                placeholder: 'Password',
                obscureText: true,
                padding: const EdgeInsets.symmetric(
                    vertical: 14.0, horizontal: 16.0),
                decoration: BoxDecoration(
                  border: Border.all(color: CupertinoColors.systemGrey4),
                  borderRadius: BorderRadius.circular(10.0),
                  color: CupertinoColors.systemGrey6,
                ),
              ),
              const SizedBox(height: 30.0),
              // Botón de Login con indicador de carga
              _isLoading
                  ? const CupertinoActivityIndicator(
                      radius: 15.0) // Indicador de carga
                  : SizedBox(
                      width: double.infinity,
                      child: CupertinoButton.filled(
                        onPressed: _performLogin,
                        child: const Text('LOGIN',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
