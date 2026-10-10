# Investigación de widgets de Flutter

**Nombre del estudiante:** Salomé Caicedo Santamaría  
**Grupo:** 601 
**Fecha:** 10 de octubre de 2026  

**Mis widgets:** `Checkbox`, `Tooltip`, `ClipRRect`



## 1. `Checkbox`

### Qué es y para qué sirve

`Checkbox` muestra una casilla que el usuario puede marcar o desmarcar. Sirve para elegir una opción que puede estar activada o desactivada, por ejemplo, indicar que un producto está disponible.

El widget muestra el estado, pero en una aplicación normalmente debemos guardar ese estado en una variable y actualizarlo cuando el usuario lo cambie.

### Cuándo usarlo y cuándo no

Lo usaría cuando el usuario pueda activar o desactivar una opción, como “Producto disponible”. Si necesito que la persona escoja una sola opción entre varias, podría ser mejor `Radio`. Si quiero mostrar una opción con su texto en una misma fila, también existe `CheckboxListTile`.

### Ejemplo mínimo

Este ejemplo es una aplicación completa que puedes ejecutar en DartPad:

```dart
import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: Ejemplo()));

class Ejemplo extends StatefulWidget {
  const Ejemplo({super.key});

  @override
  State<Ejemplo> createState() => _EjemploState();
}

class _EjemploState extends State<Ejemplo> {
  bool disponible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Disponibilidad del producto')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
              value: disponible,
              activeColor: Colors.green,
              checkColor: Colors.white,
              onChanged: (valor) {
                setState(() {
                  disponible = valor ?? false;
                });
              },
            ),
            Text(disponible ? 'Producto disponible' : 'Producto agotado'),
          ],
        ),
      ),
    );
  }
}


```

### Explicación del ejemplo

- `marcado` guarda si la casilla está seleccionada.
- `value: marcado` muestra el estado actual.
- `onChanged` se ejecuta cuando el usuario toca la casilla.
- `setState` actualiza la pantalla para mostrar el nuevo estado.

### Propiedades importantes

| Propiedad | Qué hace | Ejemplo |
|---|---|---|
| `value` | Define si está marcado (`true`) o desmarcado (`false`). | `value: marcado` |
| `onChanged` | Recibe el nuevo valor cuando se cambia la casilla. | `onChanged: (valor) { ... }` |
| `activeColor` | Define el color de la casilla cuando está seleccionada. | `activeColor: Colors.green` |
| `checkColor` | Define el color de la marca de verificación. | `checkColor: Colors.white` |
| `tristate` | Permite un tercer estado: `null`, además de `true` y `false`. | `tristate: true` |

### Ejemplo personalizado

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: Tienda()));

class Tienda extends StatefulWidget {
  const Tienda({super.key});

  @override
  State<Tienda> createState() => _TiendaState();
}

class _TiendaState extends State<Tienda> {
  bool disponible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mercado Campesino'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(20),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.shopping_basket,
                  size: 65,
                  color: Colors.green,
                ),
                const Text(
                  'Fresas frescas',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text('Precio: \$8.000 por libra'),
                const Divider(),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        disponible
                            ? 'Producto disponible'
                            : 'Producto agotado',
                      ),
                    ),
                    Checkbox(
                      value: disponible,
                      activeColor: Colors.green,
                      onChanged: (valor) {
                        setState(() {
                          disponible = valor ?? false;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

```

En este ejemplo, la casilla empieza marcada y es verde. Al tocarla, cambia el texto entre “Producto disponible” y “Producto agotado”.

### Dónde lo usaría en Mercado Campesino

Lo usaría en el formulario donde el productor registra o edita un producto, para marcar si todavía está disponible para la venta. Así puede actualizar esa información fácilmente.

### Fuentes y ayudas usadas

- Documentación oficial: https://api.flutter.dev/flutter/material/Checkbox-class.html
- Guía de widgets de Flutter: https://docs.flutter.dev/ui/widgets
- Ayuda utilizada: ChatGPT para organizar la investigación y preparar ejemplos; los ejemplos deben ejecutarse y revisarse antes de la sustentación.

---

## 2. `Tooltip`

### Qué es y para qué sirve

`Tooltip` muestra un pequeño mensaje que explica para qué sirve un elemento de la interfaz. Por ejemplo, puede explicar el significado de un ícono de ayuda. Normalmente, el mensaje aparece al mantener el cursor sobre el elemento o al interactuar con él, según el dispositivo.

Ayuda a que los íconos sean más fáciles de entender sin tener que agregar explicaciones largas en toda la pantalla.

### Cuándo usarlo y cuándo no

Lo usaría para explicar íconos que podrían generar dudas, como un botón de información o una opción poco conocida. No lo usaría para mostrar instrucciones largas o información indispensable; en ese caso es mejor poner el texto visible directamente en la pantalla.

### Ejemplo mínimo

dart
 
import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: Ejemplo()));

class Ejemplo extends StatelessWidget {
  const Ejemplo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ejemplo Tooltip')),
      body: const Center(
        child: Tooltip(
          message: 'Este es un mensaje de ayuda',
          child: Icon(Icons.info, size: 40),
        ),
      ),
    );
  }
}


### Explicación del ejemplo

- `Tooltip` envuelve al ícono.
- `message` contiene el mensaje que se quiere mostrar.
- `child` es el elemento al que se le agrega la ayuda; en este caso, un ícono de información.

### Propiedades importantes

| Propiedad | Qué hace | Ejemplo |
|---|---|---|
| `message` | Define el texto que aparece como ayuda. | `message: 'Más información'` |
| `child` | Define el elemento al que acompaña el mensaje. | `child: Icon(Icons.help)` |
| `waitDuration` | Define cuánto espera antes de mostrar el mensaje al pasar el cursor. | `waitDuration: Duration(seconds: 1)` |
| `showDuration` | Define cuánto tiempo permanece visible el mensaje. | `showDuration: Duration(seconds: 3)` |
| `preferBelow` | Indica si se prefiere mostrar el mensaje debajo del elemento. | `preferBelow: false` |

###Ejemplo personalizado

```dart

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: Informacion()));

class Informacion extends StatelessWidget {
  const Informacion({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle del producto'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(20),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.eco,
                  color: Colors.green,
                  size: 55,
                ),
                const Text(
                  'Tomates frescos',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Precio por kilo: \$6.000',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(width: 6),
                    const Tooltip(
                      message:
                          'Este es el precio correspondiente a un kilo de tomates.',
                      child: Icon(
                        Icons.help_outline,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Text(
                  'Producto cultivado por agricultores locales.',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

```

Aquí aparece el texto “Precio por unidad” y un ícono de ayuda. Al interactuar con el ícono, se explica qué significa ese dato. En pantallas táctiles, el comportamiento puede variar según la forma de interacción y la plataforma.

### Dónde lo usaría en Mercado Campesino

Lo usaría junto a campos del formulario de productos, por ejemplo, junto a “Precio por unidad” o “Cantidad disponible”, para aclarar qué debe ingresar el productor sin llenar la pantalla de instrucciones.

### Fuentes y ayudas usadas

- Documentación oficial: https://api.flutter.dev/flutter/material/Tooltip-class.html
- Guía de widgets de Flutter: https://docs.flutter.dev/ui/widgets
- Ayuda utilizada: ChatGPT para organizar la investigación y preparar ejemplos; los ejemplos deben ejecutarse y revisarse antes de la sustentación.

---

## 3. `ClipRRect`

### Qué es y para qué sirve

`ClipRRect` recorta su contenido para que tenga esquinas redondeadas. Es útil, por ejemplo, para mostrar una foto de un producto dentro de una tarjeta con bordes redondeados.

No cambia la imagen original: recorta la parte que se muestra en pantalla para ajustarla a la forma indicada.

### Cuándo usarlo y cuándo no

Lo usaría para que las fotos de productos o las imágenes de una tarjeta tengan esquinas redondeadas. Si quiero una imagen circular, elegiría `ClipOval`. Si no necesito recortar el contenido, puedo mostrar la imagen directamente sin `ClipRRect`.

### Ejemplo mínimo

```dart
import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: Ejemplo()));

class Ejemplo extends StatelessWidget {
  const Ejemplo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ejemplo ClipRRect')),
      body: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: 180,
            height: 120,
            color: Colors.green,
            child: const Center(
              child: Text('Producto', style: TextStyle(color: Colors.white)),
            ),
          ),
        ),
      ),
    );
  }
}
```

### Explicación del ejemplo

- `ClipRRect` recorta el elemento que está dentro.
- `borderRadius: BorderRadius.circular(20)` redondea las esquinas con un radio de 20.
- `child` contiene el elemento que se va a recortar; aquí es un `Container` verde con texto.

### Propiedades importantes

| Propiedad | Qué hace | Ejemplo |
|---|---|---|
| `borderRadius` | Define cuánto se redondean las esquinas. | `BorderRadius.circular(16)` |
| `child` | Es el contenido que se recorta. | `child: Image.network(url)` |
| `clipBehavior` | Define cómo se realiza el recorte. | `clipBehavior: Clip.antiAlias` |
| `clipper` | Permite definir una forma de recorte personalizada mediante un `CustomClipper`. | `clipper: MiRecortador()` |

### Ejemplo personalizado

```dart

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: Catalogo()));

class Catalogo extends StatelessWidget {
  const Catalogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuestros productos'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(20),
          clipBehavior: Clip.antiAlias,
          child: SizedBox(
            width: 280,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
                    height: 170,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Producto destacado',
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Precio: \$12.000',
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.green,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text('Disponible para comprar'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

```

En este ejemplo, la imagen ocupa un espacio de 260 por 180, se ajusta con `BoxFit.cover` y tiene las esquinas redondeadas. `Clip.antiAlias` ayuda a que los bordes del recorte se vean suaves.

### Dónde lo usaría en Mercado Campesino

Lo usaría en la lista o en la pantalla de detalle de un producto para que las fotos de frutas, verduras u otros productos tengan esquinas redondeadas y la aplicación mantenga un diseño uniforme.

### Fuentes y ayudas usadas

- Documentación oficial: https://api.flutter.dev/flutter/widgets/ClipRRect-class.html
- Guía de widgets de Flutter: https://docs.flutter.dev/ui/widgets
- Ayuda utilizada: ChatGPT para organizar la investigación y preparar ejemplos; los ejemplos deben ejecutarse y revisarse antes de la sustentación.

---

## Preparación para la sustentación

Una forma sencilla de explicar cada widget con tus palabras:

- **Checkbox:** “Es una casilla que puedo marcar o desmarcar. Uso `value` para mostrar el estado y `onChanged` para detectar el cambio. Si cambia una variable de estado, uso `setState` para actualizar la pantalla”.
- **Tooltip:** “Muestra una pequeña explicación para un elemento, como un ícono. La propiedad principal es `message`, donde escribo el texto de ayuda”.
- **ClipRRect:** “Recorta el contenido para que las esquinas queden redondeadas. La propiedad `borderRadius` controla cuánto se redondean”.

Antes de entregar:

- [ ] Confirmar en Teams que los tres widgets no estén registrados por otra persona.
- [ ] Completar el nombre y el grupo.
- [ ] Ejecutar los seis ejemplos, uno por uno, en DartPad o en el proyecto.
- [ ] Verificar que las imágenes y los mensajes se vean correctamente.
- [ ] Guardar el archivo como `widgets_apellido_nombre.md`.
- [ ] Subirlo a `actividades/widgets/` en el repositorio del equipo y hacer tu propio commit.
- [ ] Practicar la explicación sin leer literalmente el documento.
