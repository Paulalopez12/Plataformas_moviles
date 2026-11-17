import 'package:flutter/material.dart';

import 'elegir_avatar.dart';
import 'pantalla_carga.dart';
import 'pantalla_inicio.dart';
import 'pantallas_capuli.dart';

void main() => runApp(const GuardianesApp());

class GuardianesApp extends StatelessWidget {
  const GuardianesApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Guardianes de los Ríos de Loja',
    theme: ThemeData(
      colorSchemeSeed: const Color(0xff19785c),
      fontFamily: 'Nunito',
    ),
    home: const CapuliPage(),
  );
}

enum Paso { inicio, mundo, historia, menu, juego, resultado }

class CapuliPage extends StatefulWidget {
  const CapuliPage({super.key});

  @override
  State<CapuliPage> createState() => _CapuliPageState();
}

class _CapuliPageState extends State<CapuliPage> {
  Paso paso = Paso.inicio;
  Explorador? explorador;
  int? respuesta;
  double antes = 0.5;
  String aviso = '';
  bool primerJuegoListo = false;

  void jugar() => setState(() {
    paso = Paso.juego;
    respuesta = null;
    antes = 0.5;
    aviso = '';
  });

  void comprobar() => setState(() {
    if (respuesta == 1) {
      paso = Paso.resultado;
      primerJuegoListo = true;
    } else {
      aviso = respuesta == null
          ? 'Elige una respuesta primero.'
          : 'Intenta otra vez. Mira lo que flota en el río.';
    }
  });

  @override
  Widget build(BuildContext context) {
    if (paso == Paso.inicio) {
      return PantallaInicio(
        alJugar: () async {
          final perfil = await Navigator.of(context).push<Explorador>(
            MaterialPageRoute<Explorador>(builder: (_) => const ElegirAvatar()),
          );
          if (!mounted || perfil == null) return;
          setState(() {
            explorador = perfil;
            paso = Paso.mundo;
          });
        },
      );
    }
    void irA(Paso destino) => setState(() => paso = destino);
    if (paso == Paso.mundo) {
      return MundoCapuli(
        explorador: explorador!,
        gotas: primerJuegoListo ? 1 : 0,
        alJugar: () async {
          final completa = await Navigator.of(context).push<bool>(
            MaterialPageRoute<bool>(builder: (_) => const PantallaCarga()),
          );
          if (!mounted || completa != true) return;
          irA(Paso.historia);
        },
        alMenu: () => irA(Paso.menu),
      );
    }
    if (paso == Paso.historia) {
      return HistoriaCapuli(
        alVolver: () => irA(Paso.mundo),
        alContinuar: () => irA(Paso.menu),
      );
    }
    if (paso == Paso.menu) {
      return MenuCapuli(
        completado: primerJuegoListo,
        alVolver: () => irA(Paso.historia),
        alMundo: () => irA(Paso.mundo),
        alJugar: jugar,
      );
    }
    final titulo = switch (paso) {
      Paso.inicio => 'Guardianes de los Ríos',
      Paso.mundo => 'Mundo Vóxel',
      Paso.historia => 'El río y los huertos',
      Paso.menu => 'Juegos',
      Paso.juego => 'Antes y después',
      Paso.resultado => '¡Reto completado!',
    };
    return Scaffold(
      appBar: AppBar(title: const Text('Guardianes de los Ríos')),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: ListView(
              key: ValueKey(paso),
              padding: const EdgeInsets.all(24),
              children: [
                Text(titulo, style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 16),
                ...switch (paso) {
                  Paso.inicio => const <Widget>[],
                  Paso.mundo || Paso.historia || Paso.menu => const <Widget>[],
                  Paso.juego => [
                    const Text(
                      'Mueve el control para comparar el río de antes con el de ahora.',
                    ),
                    const SizedBox(height: 12),
                    Semantics(
                      image: true,
                      label: 'Comparación del río junto a huertos y del río con basura',
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: SizedBox(
                          height: 130,
                          width: double.infinity,
                          child: ComparadorCapuli(antes: antes),
                        ),
                      ),
                    ),
                    Slider(
                      value: antes,
                      onChanged: (v) => setState(() => antes = v),
                      semanticFormatterCallback: (v) =>
                          '${(v * 100).round()} por ciento del antes',
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(child: Text('Antes: huertos')),
                        Flexible(
                          child: Text(
                            'Después: basura',
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text('¿Qué problema afecta al río del Capulí hoy?'),
                    for (final (i, opcion) in const [
                      'Dejó de pasar por Loja',
                      'Llegan basura y desechos',
                      'Se convirtió en un lago',
                    ].indexed)
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: ChoiceChip(
                          label: Text(opcion),
                          selected: respuesta == i,
                          onSelected: (_) => setState(() {
                            respuesta = i;
                            aviso = '';
                          }),
                        ),
                      ),
                    const SizedBox(height: 12),
                    if (aviso.isNotEmpty)
                      Semantics(liveRegion: true, child: Text(aviso)),
                    FilledButton(
                      onPressed: comprobar,
                      child: const Text('Comprobar respuesta'),
                    ),
                  ],
                  Paso.resultado => [
                    const Text('Ganaste una gota 💧'),
                    const SizedBox(height: 12),
                    const Text(
                      'Los vecinos cuentan que la basura y los desechos del río también llegan a sus cultivos.',
                    ),
                    FilledButton(
                      onPressed: jugar,
                      child: const Text('Volver a jugar'),
                    ),
                    TextButton(
                      onPressed: () => irA(Paso.menu),
                      child: const Text('Volver a Juegos'),
                    ),
                  ],
                },
              ],
            ),
          ),
        ),
      ),
    );
  }
}
