import 'package:flutter/material.dart';

import '../modelos/productor.dart';

class PantallaDetalleProductor extends StatefulWidget {
  const PantallaDetalleProductor({
    super.key,
    required this.productor,
    this.onVolver,
  });

  final Productor productor;
  final VoidCallback? onVolver;

  @override
  State<PantallaDetalleProductor> createState() =>
      _PantallaDetalleProductorState();
}

class _PantallaDetalleProductorState extends State<PantallaDetalleProductor> {
  static const _fondo = Color(0xFFF8F7F1);
  static const _verde = Color(0xFF438A52);
  static const _productos = [
    _ProductoMercado(
      nombre: 'Tomate chonto',
      precio: 3200,
      unidad: 'libra',
      ilustracion: '🍅',
      color: Color(0xFFF9E4DF),
    ),
    _ProductoMercado(
      nombre: 'Lechuga crespa',
      precio: 1800,
      unidad: 'unidad',
      ilustracion: '🥬',
      color: Color(0xFFE4F1DC),
    ),
    _ProductoMercado(
      nombre: 'Zanahoria criolla',
      precio: 2200,
      unidad: 'libra',
      ilustracion: '🥕',
      color: Color(0xFFFFE9D9),
    ),
    _ProductoMercado(
      nombre: 'Cilantro fresco',
      precio: 1200,
      unidad: 'atado',
      ilustracion: '🌿',
      color: Color(0xFFE1EFE3),
    ),
  ];

  final Map<int, int> _cantidades = {};

  int get _cantidadTotal =>
      _cantidades.values.fold(0, (total, cantidad) => total + cantidad);

  int get _precioTotal => _cantidades.entries.fold(0, (total, entrada) {
    return total + _productos[entrada.key].precio * entrada.value;
  });

  String _formatearPesos(int valor) {
    return valor.toString().replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (_) => '.',
    );
  }

  void _agregarProducto(int indice) {
    setState(() {
      _cantidades.update(indice, (cantidad) => cantidad + 1, ifAbsent: () => 1);
    });
  }

  void _quitarProducto(int indice) {
    setState(() {
      final cantidad = _cantidades[indice];
      if (cantidad == null) return;

      if (cantidad == 1) {
        _cantidades.remove(indice);
      } else {
        _cantidades[indice] = cantidad - 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _fondo,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _EncabezadoProductor(onVolver: widget.onVolver),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE5EBDD),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Icon(
                            Icons.agriculture_outlined,
                            color: _verde,
                            size: 30,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.productor.nombre,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Vereda ${widget.productor.vereda} · '
                                '${widget.productor.distancia}',
                                style: const TextStyle(
                                  color: Color(0xFF79796F),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Row(
                      children: [
                        _Insignia(
                          icono: Icons.eco_outlined,
                          titulo: 'Agroecológico',
                          detalle: 'Cultivo',
                          color: Color(0xFFE0EFDB),
                        ),
                        SizedBox(width: 8),
                        _Insignia(
                          icono: Icons.star_outline,
                          titulo: '4.9 · 128',
                          detalle: 'Reseñas',
                          color: Color(0xFFDDECF2),
                        ),
                        SizedBox(width: 8),
                        _Insignia(
                          icono: Icons.calendar_month_outlined,
                          titulo: 'Esta semana',
                          detalle: 'Cosecha',
                          color: Color(0xFFF3E0EA),
                        ),
                      ],
                    ),
                    const SizedBox(height: 22),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Expanded(
                          child: Text(
                            'Disponible esta semana',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            '${_productos.length} productos',
                            textAlign: TextAlign.end,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Color(0xFF79796F),
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    for (var i = 0; i < _productos.length; i++)
                      _TarjetaProducto(
                        producto: _productos[i],
                        cantidad: _cantidades[i] ?? 0,
                        alAgregar: () => _agregarProducto(i),
                        alQuitar: () => _quitarProducto(i),
                        precioFormateado: _formatearPesos(_productos[i].precio),
                      ),
                    if (_cantidadTotal > 0) ...[
                      const SizedBox(height: 8),
                      Text(
                        'Agregaste $_cantidadTotal '
                        '${_cantidadTotal == 1 ? 'producto' : 'productos'} · '
                        '\$${_formatearPesos(_precioTotal)}',
                        key: const Key('resumen-productos-agregados'),
                        style: const TextStyle(
                          color: _verde,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EncabezadoProductor extends StatelessWidget {
  const _EncabezadoProductor({this.onVolver});

  final VoidCallback? onVolver;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 188,
      child: Stack(
        fit: StackFit.expand,
        children: [
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFAADDD6), Color(0xFF6D9E81)],
              ),
            ),
            child: Icon(
              Icons.landscape_outlined,
              size: 112,
              color: Color(0xFF315E48),
            ),
          ),
          Positioned(
            left: 16,
            top: 14,
            child: _BotonEncabezado(
              icono: Icons.arrow_back,
              etiqueta: 'Volver',
              onPressed: onVolver,
            ),
          ),
          const Positioned(
            right: 16,
            top: 14,
            child: _BotonEncabezado(
              icono: Icons.favorite_border,
              etiqueta: 'Favorito',
            ),
          ),
        ],
      ),
    );
  }
}

class _BotonEncabezado extends StatelessWidget {
  const _BotonEncabezado({
    required this.icono,
    required this.etiqueta,
    this.onPressed,
  });

  final IconData icono;
  final String etiqueta;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFF8F7F1),
      borderRadius: BorderRadius.circular(12),
      child: IconButton(
        onPressed: onPressed ?? () => Navigator.of(context).maybePop(),
        tooltip: etiqueta,
        icon: Icon(icono, size: 20),
      ),
    );
  }
}

class _Insignia extends StatelessWidget {
  const _Insignia({
    required this.icono,
    required this.titulo,
    required this.detalle,
    required this.color,
  });

  final IconData icono;
  final String titulo;
  final String detalle;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 62,
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icono, size: 14, color: const Color(0xFF53745A)),
            const SizedBox(height: 3),
            Text(
              titulo,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w600),
            ),
            Text(
              detalle,
              style: const TextStyle(fontSize: 9, color: Color(0xFF79796F)),
            ),
          ],
        ),
      ),
    );
  }
}

class _TarjetaProducto extends StatelessWidget {
  const _TarjetaProducto({
    required this.producto,
    required this.cantidad,
    required this.alAgregar,
    required this.alQuitar,
    required this.precioFormateado,
  });

  final _ProductoMercado producto;
  final int cantidad;
  final VoidCallback alAgregar;
  final VoidCallback alQuitar;
  final String precioFormateado;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 9),
      color: Colors.white,
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: producto.color,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                producto.ilustracion,
                style: const TextStyle(fontSize: 26),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    producto.nombre,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    '\$$precioFormateado / ${producto.unidad}',
                    style: const TextStyle(
                      color: Color(0xFF79796F),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            if (cantidad > 0)
              IconButton.filledTonal(
                onPressed: alQuitar,
                tooltip: 'Quitar ${producto.nombre}',
                style: IconButton.styleFrom(
                  minimumSize: const Size(36, 40),
                  maximumSize: const Size(36, 40),
                  padding: EdgeInsets.zero,
                ),
                icon: const Icon(Icons.remove, size: 18),
              ),
            if (cantidad > 0)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  '$cantidad',
                  key: Key('cantidad-${producto.nombre}'),
                ),
              ),
            IconButton.filled(
              onPressed: alAgregar,
              tooltip: 'Agregar ${producto.nombre}',
              style: IconButton.styleFrom(
                backgroundColor: _PantallaDetalleProductorState._verde,
                minimumSize: const Size(40, 40),
              ),
              icon: const Icon(Icons.add, size: 20),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductoMercado {
  const _ProductoMercado({
    required this.nombre,
    required this.precio,
    required this.unidad,
    required this.ilustracion,
    required this.color,
  });

  final String nombre;
  final int precio;
  final String unidad;
  final String ilustracion;
  final Color color;
}
