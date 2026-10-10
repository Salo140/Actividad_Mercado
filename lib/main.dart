import 'package:flutter/material.dart';

import 'pantallas/inicio.dart';

void main() => runApp(const MercadoApp());

class MercadoApp extends StatelessWidget {
  const MercadoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mercado Campesino',
      debugShowCheckedModeBanner: false,
      builder: (context, child) => LayoutBuilder(
        builder: (context, constraints) {
          final anchoApp = constraints.maxWidth > 600
              ? 420.0
              : constraints.maxWidth;

          return ColoredBox(
            color: const Color(0xFFE8E7DF),
            child: Center(
              child: SizedBox(
                key: const Key('marco-aplicacion-movil'),
                width: anchoApp,
                height: constraints.maxHeight,
                child: child,
              ),
            ),
          );
        },
      ),
      home: const PantallaInicio(correo: 'camila@ejemplo.com'),
    );
  }
}
