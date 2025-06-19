import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; // Necesario para IconData y algunos otros si no usas CupertinoIcons.

import 'product_register_screen.dart'; // Importamos la pantalla de registro de productos.

class ProductListScreen extends StatefulWidget {
  final List<Map<String, dynamic>>
      products; // La lista de productos que nos llega desde MyApp
  final Function(Map<String, dynamic>)
      addProductCallback; // La función para añadir productos

  const ProductListScreen({
    Key? key,
    required this.products,
    required this.addProductCallback,
  }) : super(key: key);

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Items'), // Título de la vista de lista
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () async {
            // Navegamos a la pantalla de registro
            final newProduct = await Navigator.push(
              context,
              CupertinoPageRoute<Map<String, dynamic>>(
                builder: (context) => ProductRegisterScreen(),
              ),
            );

            // Si se devolvió un producto, lo añadimos a la lista
            if (newProduct != null) {
              widget.addProductCallback(newProduct);
            }
          },
          child: const Icon(CupertinoIcons.add), // Icono de añadir
        ),
      ),
      child: SafeArea(
        child: widget.products.isEmpty
            ? const Center(
                child: Text('No hay productos registrados aún. ¡Añade uno!'),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: widget.products.length,
                itemBuilder: (context, index) {
                  final product = widget.products[index];
                  return CupertinoListTile(
                    // Un ListTile al estilo Cupertino
                    title: Text(product['name'] ?? 'Producto sin nombre'),
                    subtitle: Text(
                        'Precio: \$${product['price']?.toStringAsFixed(2) ?? 'N/A'}'),
                    // Puedes añadir más acciones aquí si quieres, como editar o eliminar.
                  );
                },
              ),
      ),
    );
  }
}

// Pequeño widget auxiliar para CupertinoListTile, ya que no existe nativamente en Flutter SDK.
// Lo creamos para dar un look similar al material `ListTile`.
class CupertinoListTile extends StatelessWidget {
  final Widget title;
  final Widget? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onPressed;

  const CupertinoListTile({
    Key? key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: CupertinoColors.systemGrey.withOpacity(0.3),
              width: 0.5,
            ),
          ),
        ),
        child: Row(
          children: <Widget>[
            if (leading != null) ...[
              leading!,
              const SizedBox(width: 16.0),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  title,
                  if (subtitle != null) ...[
                    const SizedBox(height: 4.0),
                    subtitle!,
                  ],
                ],
              ),
            ),
            if (trailing != null) ...[
              const SizedBox(width: 16.0),
              trailing!,
            ],
          ],
        ),
      ),
    );
  }
}
