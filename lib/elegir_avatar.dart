import 'package:flutter/material.dart';

const _tinta = Color(0xff1b2a3a);
const _oro = Color(0xffffc83d);
const _pasto = Color(0xff5db347);

typedef Explorador = ({String avatar, String apodo});

class ElegirAvatar extends StatefulWidget {
  const ElegirAvatar({super.key});

  @override
  State<ElegirAvatar> createState() => _ElegirAvatarState();
}

class _ElegirAvatarState extends State<ElegirAvatar> {
  static const avatares = {
    'Nutria': 'nutria',
    'Quinde': 'quinde',
    'Sapito': 'sapito',
    'Inti': 'inti',
    'Sami': 'sami',
    'Chispita': 'chispita',
  };
  final _apodo = TextEditingController();
  String avatarElegido = 'Sami';

  @override
  void dispose() {
    _apodo.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final icono = avatares[avatarElegido]!;
    return Scaffold(
      backgroundColor: const Color(0xfff2faff),
      appBar: AppBar(
        backgroundColor: const Color(0xfff2faff),
        foregroundColor: _tinta,
        title: const Text('FASE 1'),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 390),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              children: [
                const Text(
                  '¿QUIÉN ERES, EXPLORADOR?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _tinta,
                    fontSize: 24,
                    fontFamily: 'Fredoka',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 225,
                  child: Center(
                    child: Image.asset(
                      'assets/$icono.png',
                      height: 225,
                      fit: BoxFit.contain,
                      filterQuality: FilterQuality.none,
                      semanticLabel: avatarElegido,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: _tinta,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 6,
                      ),
                      child: Text(
                        avatarElegido.toUpperCase(),
                        style: const TextStyle(
                          color: Color(0xffffe8a8),
                          fontFamily: 'Fredoka',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                GridView.count(
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 1.3,
                  children: [
                    for (final entrada in avatares.entries)
                      _TarjetaAvatar(
                        nombre: entrada.key,
                        icono: entrada.value,
                        seleccionada: avatarElegido == entrada.key,
                        elegir: () =>
                            setState(() => avatarElegido = entrada.key),
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _apodo,
                  onChanged: (_) => setState(() {}),
                  maxLength: 20,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    labelText: 'Escribe tu apodo',
                    prefixIcon: Icon(Icons.edit_outlined),
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                    counterText: '',
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  children: [
                    for (final apodo in [
                      'Capitán Nutria',
                      'Guardián Río',
                      'Súper Gota',
                    ])
                      ActionChip(
                        label: Text(apodo),
                        onPressed: () => setState(() => _apodo.text = apodo),
                      ),
                  ],
                ),
                const SizedBox(height: 10),
                FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: _pasto,
                    foregroundColor: _tinta,
                    minimumSize: const Size.fromHeight(56),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: _apodo.text.trim().isEmpty
                      ? null
                      : () {
                          final perfil = (
                            avatar: avatarElegido,
                            apodo: _apodo.text.trim(),
                          );
                          Navigator.of(context).pop(perfil);
                        },
                  child: const Text(
                    '¡LISTO! ▶',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'No necesitas dar datos personales.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: _tinta),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TarjetaAvatar extends StatelessWidget {
  const _TarjetaAvatar({
    required this.nombre,
    required this.icono,
    required this.seleccionada,
    required this.elegir,
  });
  final String nombre;
  final String icono;
  final bool seleccionada;
  final VoidCallback elegir;

  @override
  Widget build(BuildContext context) => Semantics(
    selected: seleccionada,
    child: DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(color: Color(0xff526780), offset: Offset(0, 3)),
        ],
      ),
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: seleccionada ? _oro : const Color(0xffd5e3f4),
          foregroundColor: _tinta,
          padding: const EdgeInsets.all(4),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: elegir,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icono_$icono.png',
              width: 30,
              height: 30,
              fit: BoxFit.contain,
              excludeFromSemantics: true,
            ),
            const SizedBox(height: 4),
            Text(nombre, maxLines: 1, overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    ),
  );
}
