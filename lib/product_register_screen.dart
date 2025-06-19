import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; // Para Text si no usas temas específicos.

class ProductRegisterScreen extends StatefulWidget {
  const ProductRegisterScreen({Key? key}) : super(key: key);

  @override
  _ProductRegisterScreenState createState() => _ProductRegisterScreenState();
}

class _ProductRegisterScreenState extends State<ProductRegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  void _saveProduct() {
    final String name = _nameController.text.trim();
    final double? price = double.tryParse(_priceController.text.trim());

    if (name.isNotEmpty && price != null) {
      // Creamos un mapa con los datos del producto
      final Map<String, dynamic> newProduct = {
        'name': name,
        'price': price,
      };
      // Regresamos el producto a la pantalla anterior (ProductListScreen)
      Navigator.pop(context, newProduct);
    } else {
      // Muestra una alerta si falta información.
      showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: const Text('Datos incompletos'),
            content:
                const Text('Por favor, ingresa un nombre y un precio válido.'),
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
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('REGISTRO DE PRODUCTOS'),
        // Botón para retroceder, ya que CupertinoNavigationBar lo maneja automáticamente.
        // Si quieres un botón personalizado, puedes usar leading.
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Campo Nombre del producto
              CupertinoTextField(
                controller: _nameController,
                placeholder: 'Nombre del producto',
                padding: const EdgeInsets.symmetric(
                    vertical: 12.0, horizontal: 16.0),
                decoration: BoxDecoration(
                  border: Border.all(color: CupertinoColors.systemGrey),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              const SizedBox(height: 16.0),
              // Campo Precio
              CupertinoTextField(
                controller: _priceController,
                placeholder: 'Precio',
                keyboardType: TextInputType
                    .number, // Para que aparezca el teclado numérico
                padding: const EdgeInsets.symmetric(
                    vertical: 12.0, horizontal: 16.0),
                decoration: BoxDecoration(
                  border: Border.all(color: CupertinoColors.systemGrey),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              const SizedBox(height: 24.0),
              // Botón Guardar
              SizedBox(
                width: double.infinity,
                child: CupertinoButton.filled(
                  onPressed: _saveProduct,
                  child: const Text('GUARDAR'),
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
    _nameController.dispose();
    _priceController.dispose();
    super.dispose();
  }
}
