import 'package:flutter/material.dart';

import 'detalle_productor.dart';
import '../modelos/productor.dart';

class PantallaInicio extends StatefulWidget {
  const PantallaInicio({
    super.key,
    this.correo = 'camila@ejemplo.com',
    this.onSeleccionarProductor,
  });

  final String correo;
  final ValueChanged<Productor>? onSeleccionarProductor;

  @override
  State<PantallaInicio> createState() => _PantallaInicioState();
}

class _PantallaInicioState extends State<PantallaInicio> {
  static const _productores = [
    Productor(
      nombre: 'Finca La Esperanza',
      vereda: 'El Retiro',
      distancia: '3.2 km',
      categoria: 'Verduras',
      productosDisponibles: 7,
    ),
    Productor(
      nombre: 'Huerta Doña Rosa',
      vereda: 'La Ceja',
      distancia: '5.1 km',
      categoria: 'Verduras',
      productosDisponibles: 7,
    ),
    Productor(
      nombre: 'Finca El Manantial',
      vereda: 'Rionegro',
      distancia: '4.4 km',
      categoria: 'Frutas',
      productosDisponibles: 15,
    ),
    Productor(
      nombre: 'Granja Los Alpes',
      vereda: 'Guarne',
      distancia: '6.0 km',
      categoria: 'Lácteos',
      productosDisponibles: 5,
    ),
    Productor(
      nombre: 'Cultivos San Isidro',
      vereda: 'El Retiro',
      distancia: '2.8 km',
      categoria: 'Frutas',
      productosDisponibles: 9,
    ),
  ];

  static const _categorias = ['Todos', 'Verduras', 'Frutas', 'Lácteos'];
  static const _verde = Color(0xFF438A52);
  static const _fondo = Color(0xFFF8F7F1);

  String _busqueda = '';
  String _categoriaSeleccionada = 'Todos';

  List<Productor> get _productoresFiltrados {
    return _productores.where((productor) {
      final coincideCategoria =
          _categoriaSeleccionada == 'Todos' ||
          productor.categoria == _categoriaSeleccionada;
      final texto = '${productor.nombre} ${productor.vereda}'.toLowerCase();
      final coincideBusqueda = texto.contains(_busqueda.toLowerCase());
      return coincideCategoria && coincideBusqueda;
    }).toList();
  }

  String get _nombreComprador {
    final nombre = widget.correo.split('@').first;
    if (nombre.isEmpty) return 'Hola';
    return nombre[0].toUpperCase() + nombre.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    final productores = _productoresFiltrados;

    return Scaffold(
      backgroundColor: _fondo,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hola, $_nombreComprador',
                    style: const TextStyle(color: Color(0xFF79796F)),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Mercado campesino\ncerca de ti',
                    style: TextStyle(
                      fontSize: 25,
                      height: 1.15,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF292B27),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    onChanged: (value) => setState(() => _busqueda = value),
                    decoration: InputDecoration(
                      hintText: 'Buscar productor o vereda',
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: const Color(0xFFF0EDE3),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 40,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _categorias.length,
                      itemBuilder: (context, index) {
                        final categoria = _categorias[index];
                        final seleccionada =
                            categoria == _categoriaSeleccionada;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ElevatedButton(
                            onPressed: () {
                              setState(
                                () => _categoriaSeleccionada = categoria,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: seleccionada
                                  ? _verde
                                  : const Color(0xFFE7E6DC),
                              foregroundColor: seleccionada
                                  ? Colors.white
                                  : _verde,
                              elevation: seleccionada ? 2 : 0,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                              ),
                              shape: const StadiumBorder(),
                            ),
                            child: Text(categoria),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
                        child: Text(
                          'Productores cercanos',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          '${productores.length} resultados',
                          textAlign: TextAlign.end,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: Color(0xFF79796F)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: productores.isEmpty
                  ? const Center(child: Text('No hay productores disponibles'))
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                      itemCount: productores.length,
                      itemBuilder: (context, index) {
                        final productor = productores[index];
                        return _TarjetaProductor(
                          productor: productor,
                          onTap: () {
                            if (widget.onSeleccionarProductor != null) {
                              widget.onSeleccionarProductor!(productor);
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (context) =>
                                      PantallaDetalleProductor(
                                        productor: productor,
                                      ),
                                ),
                              );
                            }
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TarjetaProductor extends StatelessWidget {
  const _TarjetaProductor({required this.productor, this.onTap});

  final Productor productor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      color: Colors.white,
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  color: const Color(0xFFE5EBDD),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.agriculture_outlined,
                  color: Color(0xFF438A52),
                  size: 30,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productor.nombre,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${productor.vereda} · ${productor.distancia}',
                      style: const TextStyle(
                        color: Color(0xFF79796F),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      '${productor.productosDisponibles} disponibles esta semana',
                      style: const TextStyle(
                        color: Color(0xFF9A5B36),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Color(0xFF79796F)),
            ],
          ),
        ),
      ),
    );
  }
}
