import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; // Para Text

class ProductRegisterTab extends StatefulWidget {
  final Function(Map<String, dynamic>) addProductCallback;

  const ProductRegisterTab({Key? key, required this.addProductCallback})
      : super(key: key);

  @override
  _ProductRegisterTabState createState() => _ProductRegisterTabState();
}

class _ProductRegisterTabState extends State<ProductRegisterTab> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  void _saveProduct() {
    final String name = _nameController.text.trim();
    final double? price = double.tryParse(_priceController.text.trim());

    if (name.isNotEmpty && price != null) {
      final Map<String, dynamic> newProduct = {
        'name': name,
        'price': price,
      };
      widget.addProductCallback(
          newProduct); // Añade el producto a la lista global

      // Muestra un mensaje de éxito
      showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: const Text('¡Producto Guardado!'),
            content: Text('${name} ha sido añadido a tu lista.'),
            actions: <CupertinoDialogAction>[
              CupertinoDialogAction(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                  _nameController.clear(); // Limpia los campos
                  _priceController.clear();
                },
              ),
            ],
          );
        },
      );
    } else {
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
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Nuevo Producto'),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Registra un nuevo artículo',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: CupertinoColors.label,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30.0),
              CupertinoTextField(
                controller: _nameController,
                placeholder: 'Nombre del producto',
                padding: const EdgeInsets.symmetric(
                    vertical: 14.0, horizontal: 16.0),
                decoration: BoxDecoration(
                  border: Border.all(color: CupertinoColors.systemGrey4),
                  borderRadius: BorderRadius.circular(10.0),
                  color: CupertinoColors.systemGrey6,
                ),
              ),
              const SizedBox(height: 20.0),
              CupertinoTextField(
                controller: _priceController,
                placeholder: 'Precio',
                keyboardType: TextInputType.number,
                padding: const EdgeInsets.symmetric(
                    vertical: 14.0, horizontal: 16.0),
                decoration: BoxDecoration(
                  border: Border.all(color: CupertinoColors.systemGrey4),
                  borderRadius: BorderRadius.circular(10.0),
                  color: CupertinoColors.systemGrey6,
                ),
              ),
              const SizedBox(height: 30.0),
              SizedBox(
                width: double.infinity,
                child: CupertinoButton.filled(
                  onPressed: _saveProduct,
                  child: const Text('GUARDAR',
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
    _nameController.dispose();
    _priceController.dispose();
    super.dispose();
  }
}
