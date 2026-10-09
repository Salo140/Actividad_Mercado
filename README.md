# Mercado Campesino

Aplicación móvil de navegación para el mercado campesino, desarrollada con Flutter.

## Diseño del flujo

### Representación

```text
Inicio de sesión
    └─ toca "Iniciar sesión" → Inicio
           └─ toca un productor → Detalle de productor
                                      └─ toca "Volver" o Atrás → Inicio
                  └─ toca "Volver" o Atrás → Inicio de sesión
```

### Tabla de saltos

| Origen | Acción del usuario | Navegación | Dato que viaja | Destino y pila resultante |
| --- | --- | --- | --- | --- |
| Inicio de sesión | Toca "Iniciar sesión" | `Navigator.push` | Correo ingresado | Inicio. La pila queda: Inicio de sesión → Inicio. |
| Inicio | Toca una tarjeta de productor | `Navigator.push` | Productor seleccionado (nombre, vereda y productos) | Detalle de productor. La pila queda: Inicio de sesión → Inicio → Detalle de productor. |
| Detalle de productor | Toca "Volver" o el botón Atrás del sistema | `Navigator.pop` | Ninguno | Regresa a Inicio y retira Detalle de productor de la pila. |
| Inicio | Toca "Volver" o el botón Atrás del sistema | `Navigator.pop` | Ninguno | Regresa a Inicio de sesión y retira Inicio de la pila. |

## Decisiones

- Se eligió el recorrido Inicio de sesión → Inicio → Detalle de productor porque conecta las tres pantallas elegidas por el equipo y corresponde al flujo natural de compra indicado en la actividad.
- El correo se envía desde Inicio de sesión a Inicio para mostrar un saludo personalizado.
- La tarjeta seleccionada envía el productor completo a Detalle de productor, para mostrar sus datos y sus cuatro productos sin volver a buscarlo.
- Las pantallas secundarias regresan con `Navigator.pop`; así se conserva la pila y el botón Atrás del sistema tiene el mismo resultado.
- El botón opcional "Ver carrito" abre un resumen temporal con productos y total. No navega a otra pantalla ni modifica la pila porque el carrito no forma parte de las pantallas elegidas.
- Los datos serán fijos en el código. No se usarán API, base de datos ni validación de campos en esta actividad.

## Cambios respecto al diseño

- Se añadió el resumen temporal del carrito desde Detalle de productor para incluir el botón de la referencia. Como no se eligió la pantalla Carrito, el resumen se muestra sin agregar un nuevo salto de navegación.

## Ayudas usadas

- Se consultaron las instrucciones de la actividad y se usó Copilot (asistente de IA) para redactar este diseño y apoyar la implementación. El equipo revisará y explicará cada decisión y cada parte del código.

## Integrantes y pantallas

- Este integrante: Inicio y Detalle de productor.
- Compañera: Inicio de sesión.
