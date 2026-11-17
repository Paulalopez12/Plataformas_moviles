# Guardianes de los Ríos de Loja

Esta es la carpeta principal de la aplicación. Ábrela completa en Visual Studio Code: aquí están pubspec.yaml, lib, android y web.

## Cómo empezar

1. En Visual Studio Code, usa Archivo → Abrir carpeta y selecciona guardianes_de_los_rios.
2. Si todavía no tienes la extensión Flutter, instálala desde Extensiones. También instala la de Dart si VS Code la solicita.
3. En Terminal → Nueva terminal, ejecuta `flutter pub get`.
4. Para probar en el navegador, ejecuta `flutter run -d chrome` (o `flutter run -d edge` si usas Edge).
5. Para Android, abre un emulador o conecta un teléfono con depuración USB, comprueba que aparezca con `flutter devices` y selecciónalo en la parte inferior de VS Code. Pulsa F5. Si no aparece, usa `flutter doctor` para identificar qué falta.

## Dónde trabajar

- `lib/main.dart`: pantalla de inicio, historia, minijuego y resultado. Prueba primero cambiar el texto de bienvenida; guarda el archivo para ver el cambio con la app en ejecución.
- `test/widget_test.dart`: prueba del recorrido con respuesta incorrecta, respuesta correcta y reinicio. Se ejecuta con `flutter test`.
- `pubspec.yaml`: configuración de Flutter. Más adelante aquí añadiremos recursos como imágenes y sonidos.

La primera versión incluye el capítulo Capulí y un minijuego. El siguiente paso es agregar la elección de avatar y apodo antes de la historia. Los demás juegos y el guardado del avance quedan para más adelante.
