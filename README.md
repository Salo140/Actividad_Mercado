# Mercado Campesino

Aplicación móvil de navegación para el mercado campesino, desarrollada con Flutter.

## Diseño del flujo

### Representación

```text
Inicio de sesión
    └─ "Iniciar sesión" --push(correo)--> Inicio
                                           ├─ buscar / filtrar
                                           │  (misma pantalla; pila sin cambios)
                                           ├─ seleccionar productor
                                           │  --push(productor)--> Detalle
                                           │                        ├─ + / − cantidad
                                           │                        │  (misma pantalla)
                                           │                        ├─ corazón: favorito
                                           │                        │  (misma pantalla)
                                           │                        ├─ "Ver carrito"
                                           │                        │  (muestra/oculta resumen)
                                           │                        └─ "Volver" / Atrás
                                           │                           --pop--> Inicio
                                           └─ Atrás --pop--> Inicio de sesión
```

### Tabla de saltos

| Origen | Acción del usuario | Navegación | Dato que viaja | Destino y pila resultante |
| --- | --- | --- | --- | --- |
| Inicio de sesión | Toca "Iniciar sesión" | `Navigator.push` | Correo ingresado | Inicio. La pila queda: Inicio de sesión → Inicio. |
| Inicio | Toca una tarjeta de productor | `Navigator.push` | Productor seleccionado (nombre, vereda y productos) | Detalle de productor. La pila queda: Inicio de sesión → Inicio → Detalle de productor. |
| Detalle de productor | Toca "Volver" o el botón Atrás del sistema | `Navigator.pop` | Ninguno | Regresa a Inicio y retira Detalle de productor de la pila. |
| Inicio | Toca "Volver" o el botón Atrás del sistema | `Navigator.pop` | Ninguno | Regresa a Inicio de sesión y retira Inicio de la pila. |

Las búsquedas, filtros, favoritos, cantidades y el resumen del carrito son acciones dentro de cada pantalla: no ejecutan `Navigator.push` ni `Navigator.pop`, y no cambian la pila.

## Decisiones

- Se eligió el recorrido Inicio de sesión → Inicio → Detalle de productor porque conecta las tres pantallas elegidas por el equipo y corresponde al flujo natural de compra indicado en la actividad.
- Inicio permite buscar por nombre o vereda y filtrar por categoría. Estos controles solo cambian la lista visible.
- `StatefulWidget` y `setState` mantienen actualizados el texto buscado, el filtro, el favorito, las cantidades y la visibilidad del resumen dentro de la misma pantalla.
- El correo se envía desde Inicio de sesión a Inicio para mostrar un saludo personalizado.
- La tarjeta seleccionada envía el productor completo a Detalle de productor, para mostrar sus datos y sus cuatro productos sin volver a buscarlo.
- Detalle permite marcar el productor como favorito y agregar o quitar unidades de cada producto.
- Las pantallas secundarias regresan con `Navigator.pop`; así se conserva la pila y el botón Atrás del sistema tiene el mismo resultado.
- El botón "Ver carrito" muestra u oculta un resumen dentro del detalle con cantidades, subtotales y total. No se crea una pantalla Carrito adicional ni se modifica la pila.
- Los datos serán fijos en el código. No se usarán API, base de datos ni validación de campos en esta actividad.
- La navegación usa `Navigator.push`, `MaterialPageRoute`, datos por constructor y `Navigator.pop`, que son los patrones de navegación explicados en la guía. No se agregaron rutas con nombre, argumentos de ruta ni navegación anidada.

## Cambios respecto al diseño

- Se añadieron búsqueda y filtros en Inicio, favorito y control de cantidades en Detalle, y un resumen expandible del carrito dentro de Detalle.
- El resumen no agrega una pantalla ni un salto al flujo: se muestra en la misma pantalla, por lo que la tabla de navegación y la pila no cambian.

## Ayudas usadas

- Se consultaron las instrucciones de la actividad y se usó Copilot (asistente de IA) para redactar este diseño y apoyar la implementación. El equipo revisará y explicará cada decisión y cada parte del código.

## Integrantes y pantallas

- Este integrante: Inicio y Detalle de productor.
- Compañera: Inicio de sesión.
