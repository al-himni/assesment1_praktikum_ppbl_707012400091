import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/theme_model.dart';

class HalamanPengaturan extends StatelessWidget {
  const HalamanPengaturan({super.key});

  @override
  Widget build(BuildContext context) {
    final themeModel = context.watch<ThemeModel>();
    final warna = Theme.of(context).colorScheme;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Pengaturan',
          style: Theme.of(context).textTheme.titleLarge
              ?.copyWith(color: warna.onSurface),
        ),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: Text('Mode Gelap', style: TextStyle(color: warna.onSurface)),
          subtitle: Text(
            'Gunakan tampilan gelap pada aplikasi.',
            style: TextStyle(color: warna.onSurfaceVariant),
          ),
          secondary: Icon(
            themeModel.modeGelap
                ? Icons.dark_mode_outlined
                : Icons.light_mode_outlined,
            color: warna.onSurface,
          ),
          value: themeModel.modeGelap,
          onChanged: themeModel.ubahModeGelap,
        ),
      ],
    );
  }
}
