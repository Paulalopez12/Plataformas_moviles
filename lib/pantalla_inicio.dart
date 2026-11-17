import 'package:flutter/material.dart';

class PantallaInicio extends StatelessWidget {
  const PantallaInicio({required this.alJugar, super.key});

  final VoidCallback alJugar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1b2a3a),
      body: Center(
        child: AspectRatio(
          aspectRatio: 390 / 884,
          child: LayoutBuilder(
            builder: (context, caja) => Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  'assets/inicio_fondo.png',
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.none,
                  excludeFromSemantics: true,
                ),
                Align(
                  alignment: const Alignment(0, 0.32),
                  child: Image.asset(
                    'assets/gotitta.png',
                    width: caja.maxWidth * .92,
                    height: caja.maxHeight * .46,
                    fit: BoxFit.contain,
                    filterQuality: FilterQuality.none,
                    semanticLabel: 'Gotita saluda',
                  ),
                ),
                Positioned(
                  top: caja.maxHeight * .024,
                  left: caja.maxWidth * .06,
                  right: caja.maxWidth * .26,
                  child: const FittedBox(
                    alignment: Alignment.centerLeft,
                    fit: BoxFit.scaleDown,
                    child: _TextoPixel(
                      'GUARDIANES DE LOS\nRÍOS DE LOJA',
                      size: 25,
                    ),
                  ),
                ),
                Positioned(
                  left: 24,
                  right: 24,
                  bottom: caja.maxHeight * .038,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.zero,
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0xff1b2a3a),
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                    child: FilledButton(
                      onPressed: alJugar,
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xff5db347),
                        foregroundColor: Colors.white,
                        minimumSize: const Size.fromHeight(62),
                        side: const BorderSide(
                          color: Color(0xff1b2a3a),
                          width: 2,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.play_arrow, size: 26),
                          SizedBox(width: 8),
                          _TextoPixel('¡JUGAR!', size: 28),
                        ],
                      ),
                    ),
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

class _TextoPixel extends StatelessWidget {
  const _TextoPixel(this.texto, {required this.size});
  final String texto;
  final double size;

  @override
  Widget build(BuildContext context) {
    final estilo = TextStyle(
      fontFamily: 'PixelifySans',
      fontSize: size,
      fontWeight: FontWeight.w700,
      height: 1.1,
    );
    return Stack(
      children: [
        ExcludeSemantics(
          child: RichText(
            text: TextSpan(
              text: texto,
              style: estilo.copyWith(
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 3
                  ..color = const Color(0xff1b2a3a),
              ),
            ),
          ),
        ),
        Text(texto, style: estilo.copyWith(color: Colors.white)),
      ],
    );
  }
}
