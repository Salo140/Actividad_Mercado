import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:navegacion_mercado/modelos/productor.dart';
import 'package:navegacion_mercado/main.dart' as app;
import 'package:navegacion_mercado/pantallas/detalle_productor.dart';
import 'package:navegacion_mercado/pantallas/inicio.dart';

void main() {
  testWidgets('El diseño conserva ancho móvil en pantalla grande y pequeña', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1200, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const app.MercadoApp());

    expect(
      tester.getSize(find.byKey(const Key('marco-aplicacion-movil'))).width,
      420,
    );

    tester.view.physicalSize = const Size(390, 844);
    await tester.pump();

    expect(
      tester.getSize(find.byKey(const Key('marco-aplicacion-movil'))).width,
      390,
    );
  });

  testWidgets('La app abre Inicio y permite abrir y cerrar el detalle', (
    tester,
  ) async {
    await tester.pumpWidget(const app.MercadoApp());

    expect(find.text('Productores cercanos'), findsOneWidget);

    await tester.tap(find.text('Finca La Esperanza'));
    await tester.pumpAndSettle();

    expect(find.text('Disponible esta semana'), findsOneWidget);
    expect(find.text('Tomate chonto'), findsOneWidget);

    await tester.tap(find.byTooltip('Volver'));
    await tester.pumpAndSettle();

    expect(find.text('Productores cercanos'), findsOneWidget);
  });

  testWidgets('Inicio muestra cinco productores y filtra la lista', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(home: const PantallaInicio(correo: 'camila@ejemplo.com')),
    );

    expect(find.text('Hola, Camila'), findsOneWidget);
    expect(find.text('5 resultados'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'Doña Rosa');
    await tester.pumpAndSettle();

    expect(find.text('1 resultados'), findsOneWidget);
    expect(find.text('Huerta Doña Rosa'), findsOneWidget);
    expect(find.text('Finca La Esperanza'), findsNothing);

    await tester.tap(find.text('Huerta Doña Rosa'));
    await tester.pumpAndSettle();
    expect(find.text('Vereda La Ceja · 5.1 km'), findsOneWidget);
  });

  testWidgets('Detalle muestra productor y cuatro productos agregables', (
    tester,
  ) async {
    const productor = Productor(
      nombre: 'Finca La Esperanza',
      vereda: 'El Retiro',
      distancia: '3.2 km',
      categoria: 'Verduras',
      productosDisponibles: 7,
    );

    await tester.pumpWidget(
      const MaterialApp(home: PantallaDetalleProductor(productor: productor)),
    );

    expect(find.text('Finca La Esperanza'), findsOneWidget);
    expect(find.text('Vereda El Retiro · 3.2 km'), findsOneWidget);
    expect(find.text('4 productos'), findsOneWidget);

    await tester.tap(find.byTooltip('Agregar a favoritos'));
    await tester.pumpAndSettle();
    expect(find.byTooltip('Quitar de favoritos'), findsOneWidget);

    await tester.tap(find.byTooltip('Quitar de favoritos'));
    await tester.pumpAndSettle();
    expect(find.byTooltip('Agregar a favoritos'), findsOneWidget);

    final botonAgregar = find.byTooltip('Agregar Tomate chonto');
    await tester.ensureVisible(botonAgregar);
    await tester.tap(botonAgregar);
    await tester.pumpAndSettle();

    expect(find.text('Agregaste 1 producto · \$3.200'), findsOneWidget);
    expect(find.byKey(const Key('cantidad-Tomate chonto')), findsOneWidget);

    await tester.tap(botonAgregar);
    await tester.pumpAndSettle();
    expect(find.text('Agregaste 2 productos · \$6.400'), findsOneWidget);

    final botonQuitar = find.byTooltip('Quitar Tomate chonto');
    await tester.tap(botonQuitar);
    await tester.pumpAndSettle();
    expect(find.text('Agregaste 1 producto · \$3.200'), findsOneWidget);

    await tester.tap(botonQuitar);
    await tester.pumpAndSettle();
    expect(find.text('Agregaste 1 producto · \$3.200'), findsNothing);
    expect(find.byKey(const Key('cantidad-Tomate chonto')), findsNothing);
    expect(botonQuitar, findsNothing);
  });

  testWidgets('Ver carrito despliega el resumen sin abrir otra pantalla', (
    tester,
  ) async {
    const productor = Productor(
      nombre: 'Finca La Esperanza',
      vereda: 'El Retiro',
      distancia: '3.2 km',
      categoria: 'Verduras',
      productosDisponibles: 7,
    );

    await tester.pumpWidget(
      const MaterialApp(home: PantallaDetalleProductor(productor: productor)),
    );

    final botonCarrito = find.byKey(const Key('boton-ver-carrito'));
    expect(find.text('\$0'), findsOneWidget);
    await tester.tap(botonCarrito);
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('resumen-carrito')), findsOneWidget);
    expect(find.text('Todavía no agregas productos.'), findsOneWidget);

    await tester.tap(find.text('Ocultar carrito'));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('resumen-carrito')), findsNothing);

    await tester.tap(find.byTooltip('Agregar Tomate chonto'));
    await tester.pumpAndSettle();
    await tester.tap(botonCarrito);
    await tester.pumpAndSettle();

    expect(find.text('1 × Tomate chonto'), findsOneWidget);
    expect(find.text('Resumen del carrito'), findsOneWidget);
    expect(
      find.descendant(
        of: find.byKey(const Key('resumen-carrito')),
        matching: find.text('1 × Tomate chonto'),
      ),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: find.byKey(const Key('resumen-carrito')),
        matching: find.text('\$3.200'),
      ),
      findsNWidgets(2),
    );
  });
}
