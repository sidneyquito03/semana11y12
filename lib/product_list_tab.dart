import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; // Para IconData

// El mismo CupertinoListTile auxiliar, asegúrate de que esté definido o copiado aquí si no lo tienes globalmente.
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

class ProductListTab extends StatefulWidget {
  final List<Map<String, dynamic>> products;
  final Function(Map<String, dynamic>)
      addProductCallback; // Se mantiene por si se necesita, aunque ahora se añade desde otra pestaña.

  const ProductListTab({
    Key? key,
    required this.products,
    required this.addProductCallback,
  }) : super(key: key);

  @override
  State<ProductListTab> createState() => _ProductListTabState();
}

class _ProductListTabState extends State<ProductListTab> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Mis Productos'), // Nuevo título
      ),
      child: SafeArea(
        child: widget.products.isEmpty
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(CupertinoIcons.cube_box_fill,
                        size: 60, color: CupertinoColors.systemGrey),
                    SizedBox(height: 20),
                    Text(
                      'Aún no tienes productos.',
                      style: TextStyle(
                          fontSize: 18, color: CupertinoColors.systemGrey),
                    ),
                    Text(
                      '¡Ve a la pestaña "Registrar" para añadir uno!',
                      style: TextStyle(
                          fontSize: 16, color: CupertinoColors.systemGrey),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: widget.products.length,
                itemBuilder: (context, index) {
                  final product = widget.products[index];
                  return CupertinoListTile(
                    title: Text(
                      product['name'] ?? 'Producto sin nombre',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      'Precio: \$${product['price']?.toStringAsFixed(2) ?? 'N/A'}',
                      style: const TextStyle(color: CupertinoColors.systemGrey),
                    ),
                    trailing: const Icon(CupertinoIcons.right_chevron,
                        color: CupertinoColors.systemGrey),
                    onPressed: () {
                      // Aquí podrías navegar a una pantalla de detalles del producto
                      showCupertinoModalPopup(
                        context: context,
                        builder: (BuildContext context) => CupertinoActionSheet(
                          title:
                              Text(product['name'] ?? 'Detalles del Producto'),
                          message: Text(
                              'Precio: \$${product['price']?.toStringAsFixed(2) ?? 'N/A'}'),
                          actions: <CupertinoActionSheetAction>[
                            CupertinoActionSheetAction(
                              child: const Text('Editar',
                                  style: TextStyle(
                                      color: CupertinoColors.systemBlue)),
                              onPressed: () {
                                Navigator.pop(context);
                                // Lógica para editar
                              },
                            ),
                            CupertinoActionSheetAction(
                              child: const Text('Eliminar',
                                  style: TextStyle(
                                      color: CupertinoColors.systemRed)),
                              onPressed: () {
                                Navigator.pop(context);
                                setState(() {
                                  widget.products.removeAt(
                                      index); // Eliminar el producto de la lista
                                });
                              },
                            ),
                          ],
                          cancelButton: CupertinoActionSheetAction(
                            child: const Text('Cancelar'),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
      ),
    );
  }
}
