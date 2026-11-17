import 'package:flutter/material.dart';

import 'elegir_avatar.dart';

const _tinta = Color(0xff1b2a3a);
const _azul = Color(0xffd5e5f8);
const _verde = Color(0xff9cf47a);
const _oro = Color(0xffffdc80);

const _fichas = [
  (Icons.public, 'Mundo'),
  (Icons.sports_esports_outlined, 'Juegos'),
  (Icons.menu_book_outlined, 'Álbum'),
  (Icons.emoji_events_outlined, 'Premios'),
  (Icons.account_circle_outlined, 'Perfil'),
];

Widget _marco(Widget cuerpo) => Scaffold(
  backgroundColor: _tinta,
  body: SafeArea(
    child: Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 430),
        child: ColoredBox(color: _azul, child: cuerpo),
      ),
    ),
  ),
);

Widget _fondo(String archivo) => Image.asset(
  'assets/$archivo.png',
  fit: BoxFit.cover,
  excludeFromSemantics: true,
);

Widget _bloque(Widget child, {Color color = _azul, VoidCallback? tocar}) {
  return Material(
    color: color,
    shape: RoundedRectangleBorder(
      side: const BorderSide(color: _tinta, width: 2),
      borderRadius: BorderRadius.circular(6),
    ),
    clipBehavior: Clip.antiAlias,
    child: InkWell(
      onTap: tocar,
      child: Padding(padding: const EdgeInsets.all(8), child: child),
    ),
  );
}

Widget _accion(String texto, VoidCallback tocar) => FilledButton.icon(
  onPressed: tocar,
  icon: const Icon(Icons.play_arrow),
  label: Text(texto, textAlign: TextAlign.center),
  style: FilledButton.styleFrom(
    backgroundColor: _verde,
    foregroundColor: _tinta,
    minimumSize: const Size(0, 50),
    textStyle: const TextStyle(
      fontFamily: 'Fredoka',
      fontSize: 19,
      fontWeight: FontWeight.bold,
    ),
    shape: RoundedRectangleBorder(
      side: const BorderSide(color: _tinta, width: 2),
      borderRadius: BorderRadius.circular(8),
    ),
  ),
);

class _Barra extends StatelessWidget {
  const _Barra({required this.activa, this.alMundo});
  final int activa;
  final VoidCallback? alMundo;

  @override
  Widget build(BuildContext context) => ColoredBox(
    color: const Color(0xffb9d1ec),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        for (var i = 0; i < _fichas.length; i++)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ColoredBox(
              color: i == activa ? _oro : _azul,
              child: IconButton(
                tooltip: _fichas[i].$2,
                onPressed: i == 0 ? alMundo : null,
                icon: Icon(_fichas[i].$1),
              ),
            ),
          ),
      ],
    ),
  );
}

class MundoCapuli extends StatelessWidget {
  const MundoCapuli({
    required this.explorador,
    required this.gotas,
    required this.alJugar,
    required this.alMenu,
    super.key,
  });

  final Explorador explorador;
  final int gotas;
  final VoidCallback alJugar, alMenu;

  @override
  Widget build(BuildContext context) {
    final avatar = explorador.avatar.toLowerCase();
    return Scaffold(
      backgroundColor: _tinta,
      body: SafeArea(
        child: Center(
          child: FittedBox(
            fit: BoxFit.contain,
            child: SizedBox(
              width: 390,
              height: 884,
              child: ColoredBox(
                color: const Color(0xfff4f6ff),
                child: Column(
                  children: [
                    SizedBox(
                      height: 56,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 7,
                        ),
                        child: Row(
                          children: [
                            Flexible(
                              child: _BaldosaMundo(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ColoredBox(
                                      color: const Color(0xff2e9be6),
                                      child: Padding(
                                        padding: const EdgeInsets.all(3),
                                        child: Image.asset(
                                          'assets/icono_$avatar.png',
                                          width: 30,
                                          height: 30,
                                          excludeFromSemantics: true,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 7),
                                    Flexible(
                                      child: Text(
                                        explorador.apodo,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontFamily: 'Fredoka',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Spacer(),
                            _BaldosaMundo(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.water_drop,
                                      color: Color(0xffc78700),
                                      size: 19,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      '$gotas',
                                      style: const TextStyle(
                                        fontFamily: 'Fredoka',
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            const _MarcadorCabecera(
                              icono: Icons.map_outlined,
                              nombre: 'Mapa, pendiente',
                            ),
                            const SizedBox(width: 8),
                            const _MarcadorCabecera(
                              icono: Icons.volume_up_outlined,
                              nombre: 'Sonido, pendiente',
                              color: _oro,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 700,
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            _fondo('mundo_fondo'),
                            const Positioned(
                              top: 12,
                              left: 16,
                              child: _MarcadorCabecera(
                                icono: Icons.inventory_2_outlined,
                                nombre: 'Misión del día, pendiente',
                                color: _oro,
                              ),
                            ),
                            for (final (nombre, x, y) in const [
                              ('5. Jipiro', 196.0, 34.0),
                              ('4. Simón Bolívar', 96.0, 179.0),
                              ('3. El León', 296.0, 325.0),
                              ('2. La Tebaida', 113.0, 409.0),
                            ])
                              Positioned(
                                top: y,
                                left: x - 61,
                                width: 122,
                                child: _NivelBloqueado(nombre),
                              ),
                            Positioned(
                              left: 124,
                              top: 365,
                              width: 150,
                              height: 178,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  const Positioned(
                                    top: 0,
                                    child: Icon(
                                      Icons.keyboard_double_arrow_down,
                                      color: _oro,
                                      size: 32,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    child: Image.asset(
                                      'assets/$avatar.png',
                                      width: 125,
                                      height: 150,
                                      fit: BoxFit.contain,
                                      filterQuality: FilterQuality.none,
                                      semanticLabel: explorador.avatar,
                                    ),
                                  ),
                                  Positioned(
                                    right: 0,
                                    bottom: 25,
                                    child: Image.asset(
                                      'assets/gotitta.png',
                                      width: 43,
                                      height: 50,
                                      fit: BoxFit.contain,
                                      excludeFromSemantics: true,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              left: 140,
                              right: 140,
                              top: 545,
                              height: 57,
                              child: _BaldosaMundo(
                                tocar: alJugar,
                                color: _verde,
                                sombra: const Color(0xff2d730d),
                                child: const Text(
                                  '1. Capulí',
                                  style: TextStyle(
                                    fontFamily: 'Fredoka',
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 98,
                              right: 98,
                              bottom: 29,
                              height: 58,
                              child: _BaldosaMundo(
                                tocar: alJugar,
                                color: _verde,
                                sombra: const Color(0xff2d730d),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      '¡JUGAR!',
                                      style: TextStyle(
                                        fontFamily: 'Fredoka',
                                        fontSize: 21,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Icon(Icons.play_arrow, size: 24),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      height: 79,
                      child: ColoredBox(
                        color: const Color(0xffd5e5f8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (var i = 0; i < _fichas.length; i++)
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                ),
                                child: SizedBox(
                                  width: 56,
                                  height: 54,
                                  child: Tooltip(
                                    message: i < 2
                                        ? _fichas[i].$2
                                        : '${_fichas[i].$2}, pendiente',
                                    child: _BaldosaMundo(
                                      color: i == 0
                                          ? const Color(0xff2e9be6)
                                          : const Color(0xffe7f0fd),
                                      tocar: i == 1 ? alMenu : null,
                                      child: Icon(_fichas[i].$1),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BaldosaMundo extends StatelessWidget {
  const _BaldosaMundo({
    required this.child,
    this.color = _azul,
    this.sombra = const Color(0xff374b60),
    this.tocar,
  });

  final Widget child;
  final Color color, sombra;
  final VoidCallback? tocar;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      boxShadow: [BoxShadow(color: sombra, offset: const Offset(0, 4))],
    ),
    child: Material(
      color: color,
      borderRadius: BorderRadius.circular(5),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: tocar,
        child: Center(widthFactor: 1, child: child),
      ),
    ),
  );
}

class _MarcadorCabecera extends StatelessWidget {
  const _MarcadorCabecera({
    required this.icono,
    required this.nombre,
    this.color = _azul,
  });
  final IconData icono;
  final String nombre;
  final Color color;

  @override
  Widget build(BuildContext context) => Tooltip(
    message: nombre,
    child: SizedBox(
      width: 44,
      height: 42,
      child: _BaldosaMundo(color: color, child: Icon(icono, size: 21)),
    ),
  );
}

class _NivelBloqueado extends StatelessWidget {
  const _NivelBloqueado(this.nombre);
  final String nombre;

  @override
  Widget build(BuildContext context) => Semantics(
    label: '$nombre, bloqueado',
    excludeSemantics: true,
    child: Column(
      children: [
        _BaldosaMundo(
          color: const Color(0xffdbedcd),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
            child: Text(
              nombre,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontFamily: 'Fredoka',
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        const SizedBox(
          width: 61,
          height: 56,
          child: _BaldosaMundo(
            color: Color(0xffbed5df),
            child: Icon(Icons.lock_outline, size: 21),
          ),
        ),
      ],
    ),
  );
}

class HistoriaCapuli extends StatelessWidget {
  const HistoriaCapuli({
    required this.alVolver,
    required this.alContinuar,
    super.key,
  });
  final VoidCallback alVolver, alContinuar;

  @override
  Widget build(BuildContext context) => _marco(
    Stack(
      fit: StackFit.expand,
      children: [
        _fondo('rio_capuli_limpio'),
        ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: alVolver,
                  tooltip: 'Volver a Mundo',
                  icon: const Icon(Icons.arrow_back),
                  style: IconButton.styleFrom(backgroundColor: _oro),
                ),
                const SizedBox(width: 18),
                Flexible(
                  child: _bloque(
                    const Text(
                      'CAPÍTULO 1\nCAPULÍ',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: 'Fredoka', fontSize: 19),
                    ),
                    color: _oro,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Center(
              child: Text(
                'Mira el río desde lejos',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 110),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/gotitta.png',
                  width: 68,
                  excludeFromSemantics: true,
                ),
                Expanded(
                  child: _bloque(
                    const Padding(
                      padding: EdgeInsets.all(6),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'El río y los huertos',
                            style: TextStyle(
                              fontFamily: 'Fredoka',
                              fontSize: 19,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Hasta los años 90, el Capulí era campo verde con huertos. El río regaba los cultivos y las familias lo usaban en casa.',
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Un vecino recuerda que antes bañaba a sus hijos en él.',
                          ),
                          SizedBox(height: 8),
                          Text(
                            '¿Qué habrá cambiado? ¡Descúbrelo jugando!',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 48),
            _accion('¡JUGAR ESTE NIVEL!', alContinuar),
          ],
        ),
      ],
    ),
  );
}

class MenuCapuli extends StatelessWidget {
  const MenuCapuli({
    required this.completado,
    required this.alVolver,
    required this.alMundo,
    required this.alJugar,
    super.key,
  });
  final bool completado;
  final VoidCallback alVolver, alMundo, alJugar;

  @override
  Widget build(BuildContext context) => _marco(
    Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              IconButton(
                onPressed: alVolver,
                tooltip: 'Volver a la historia',
                icon: const Icon(Icons.arrow_back),
              ),
              Expanded(
                child: Center(
                  child: _bloque(
                    const Text(
                      'JUEGOS',
                      style: TextStyle(fontFamily: 'Fredoka', fontSize: 23),
                    ),
                    color: _oro,
                  ),
                ),
              ),
              const SizedBox(width: 48),
            ],
          ),
        ),
        Text(
          'Capítulo 1 · Capulí',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        _bloque(Text(completado ? '1/4' : '0/4')),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(12),
            children: [
              for (final (titulo, imagen) in const [
                ('Antes y después', 'juego_antes_y_despues'),
                ('Sopa de letras', ''),
                ('Construye el río', 'juego_construye_el_rio'),
                ('Salvemos el río', ''),
                ('Preguntas rápidas', 'juego_preguntas_rapidas'),
              ])
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: _bloque(
                    Row(
                      children: [
                        SizedBox(
                          width: 54,
                          height: 54,
                          child: imagen.isEmpty
                              ? const Icon(Icons.extension_outlined)
                              : _fondo(imagen),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                titulo,
                                style: const TextStyle(
                                  fontFamily: 'Fredoka',
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                titulo == 'Antes y después'
                                    ? (completado
                                          ? '★ Completado'
                                          : 'Disponible')
                                    : 'Próximamente',
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          titulo == 'Antes y después'
                              ? Icons.play_arrow
                              : Icons.lock_outline,
                        ),
                      ],
                    ),
                    color: Colors.white,
                    tocar: titulo == 'Antes y después' ? alJugar : null,
                  ),
                ),
            ],
          ),
        ),
        _Barra(activa: 1, alMundo: alMundo),
      ],
    ),
  );
}

class ComparadorCapuli extends StatelessWidget {
  const ComparadorCapuli({required this.antes, super.key});
  final double antes;

  @override
  Widget build(BuildContext context) => Stack(
    fit: StackFit.expand,
    children: [
      _fondo('rio_capuli_sucio'),
      ClipRect(clipper: _Recorte(antes), child: _fondo('rio_capuli_limpio')),
    ],
  );
}

class _Recorte extends CustomClipper<Rect> {
  const _Recorte(this.fraccion);
  final double fraccion;

  @override
  Rect getClip(Size size) =>
      Rect.fromLTWH(0, 0, size.width * fraccion, size.height);

  @override
  bool shouldReclip(_Recorte anterior) => anterior.fraccion != fraccion;
}
