import 'dart:async';

import 'package:flutter/material.dart';

class PantallaCarga extends StatefulWidget {
  const PantallaCarga({super.key});

  @override
  State<PantallaCarga> createState() => _PantallaCargaState();
}

class _PantallaCargaState extends State<PantallaCarga> {
  static const cuadros = [
    'assets/carga_01.png',
    'assets/carga_02.png',
    'assets/carga_03.png',
    'assets/carga_04.png',
  ];
  int cuadro = 0;
  Timer? _reloj;

  @override
  void initState() {
    super.initState();
    _reloj = Timer.periodic(const Duration(milliseconds: 750), (reloj) {
      if (cuadro == cuadros.length - 1) {
        reloj.cancel();
        Navigator.of(context).pop(true);
        return;
      }
      setState(() => cuadro++);
    });
  }

  @override
  void dispose() {
    _reloj?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final porcentaje = (cuadro + 1) * 25;
    return Scaffold(
      backgroundColor: const Color(0xff80c4ec),
      body: SafeArea(
        child: Center(
          child: AspectRatio(
            aspectRatio: 390 / 884,
            child: Stack(
              fit: StackFit.expand,
              children: [
                IndexedStack(
                  index: cuadro,
                  sizing: StackFit.expand,
                  children: [
                    for (final imagen in cuadros)
                      Image.asset(
                        imagen,
                        fit: BoxFit.fill,
                        excludeFromSemantics: true,
                      ),
                  ],
                ),
                Align(
                  alignment: const Alignment(0, .82),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Cargando aventura... $porcentaje%',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color(0xff1b2a3a),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        ColoredBox(
                          color: const Color(0xff1b2a3a),
                          child: Padding(
                            padding: const EdgeInsets.all(3),
                            child: Row(
                              children: [
                                for (var i = 0; i < 12; i++)
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(1),
                                      child: ColoredBox(
                                        color: i < (cuadro + 1) * 3
                                            ? const Color(0xff5db347)
                                            : const Color(0xff8a9099),
                                        child: const SizedBox(height: 12),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
