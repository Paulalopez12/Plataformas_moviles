import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guardianes_de_los_rios/main.dart';

void main() {
  testWidgets('Permite reintentar, acertar y volver a jugar', (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 884));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(const GuardianesApp());

    Future<void> pulsar(String texto) async {
      final boton = find.text(texto);
      if (boton.evaluate().isEmpty) {
        await tester.scrollUntilVisible(boton, 180);
      }
      await tester.ensureVisible(boton);
      await tester.tap(boton);
      await tester.pumpAndSettle();
    }

    expect(find.text('GUARDIANES DE LOS\nRÍOS DE LOJA'), findsOneWidget);
    await pulsar('¡JUGAR!');
    expect(find.text('SAMI'), findsOneWidget);
    await pulsar('Quinde');
    expect(find.text('QUINDE'), findsOneWidget);
    expect(find.bySemanticsLabel('Quinde'), findsWidgets);
    await pulsar('Súper Gota');
    await pulsar('¡LISTO! ▶');
    expect(find.text('Súper Gota'), findsOneWidget);
    expect(find.bySemanticsLabel('Quinde'), findsOneWidget);
    await pulsar('¡JUGAR!');
    expect(find.text('Cargando aventura... 25%'), findsOneWidget);
    for (final porcentaje in [50, 75, 100]) {
      await tester.pump(const Duration(milliseconds: 750));
      expect(find.text('Cargando aventura... $porcentaje%'), findsOneWidget);
    }
    expect(find.text('El río y los huertos'), findsNothing);
    await tester.pump(const Duration(milliseconds: 750));
    await tester.pumpAndSettle();
    expect(find.text('El río y los huertos'), findsOneWidget);
    await pulsar('¡JUGAR ESTE NIVEL!');
    expect(find.text('0/4'), findsOneWidget);
    await pulsar('Antes y después');
    await pulsar('Dejó de pasar por Loja');
    await pulsar('Comprobar respuesta');
    expect(find.textContaining('Intenta otra vez'), findsOneWidget);
    await pulsar('Llegan basura y desechos');
    await pulsar('Comprobar respuesta');
    expect(find.text('¡Reto completado!'), findsOneWidget);
    await pulsar('Volver a Juegos');
    expect(find.text('1/4'), findsOneWidget);
    await pulsar('Antes y después');
    await pulsar('Comprobar respuesta');
    expect(find.text('Elige una respuesta primero.'), findsOneWidget);
  });
}
