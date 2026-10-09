import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:navegacion_mercado/modelos/productor.dart';
import 'package:navegacion_mercado/main.dart' as app;
import 'package:navegacion_mercado/pantallas/detalle_productor.dart';
import 'package:navegacion_mercado/pantallas/inicio.dart';

void main() {
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
    Productor? productorSeleccionado;

    await tester.pumpWidget(
      MaterialApp(
        home: PantallaInicio(
          correo: 'camila@ejemplo.com',
          onSeleccionarProductor: (productor) {
            productorSeleccionado = productor;
          },
        ),
      ),
    );

    expect(find.text('Hola, Camila'), findsOneWidget);
    expect(find.text('5 resultados'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'Doña Rosa');
    await tester.pumpAndSettle();

    expect(find.text('1 resultados'), findsOneWidget);
    expect(find.text('Huerta Doña Rosa'), findsOneWidget);
    expect(find.text('Finca La Esperanza'), findsNothing);

    await tester.tap(find.text('Huerta Doña Rosa'));
    expect(productorSeleccionado?.vereda, 'La Ceja');
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

  testWidgets('Ver carrito muestra el contenido y el total actualizado', (
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

    expect(find.text('Todavía no agregas productos.'), findsOneWidget);
    await tester.tap(find.byTooltip('Cerrar carrito'));
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Agregar Tomate chonto'));
    await tester.pumpAndSettle();
    await tester.tap(botonCarrito);
    await tester.pumpAndSettle();

    expect(find.text('Carrito de Finca La Esperanza'), findsOneWidget);
    expect(find.text('1 × Tomate chonto'), findsOneWidget);
    expect(find.text('\$3.200'), findsNWidgets(3));
  });
}
