import 'package:flutter/material.dart';

import '../navigation/app_routes.dart';

class HalamanBeranda extends StatelessWidget {
  const HalamanBeranda({super.key});

  @override
  Widget build(BuildContext context) {
    final warna = Theme.of(context).colorScheme;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Selamat Datang di AgriClima LSTM',
          style: Theme.of(context).textTheme.headlineSmall
              ?.copyWith(color: warna.onSurface, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          'Aplikasi untuk mencatat hasil prediksi mikroklimat tanaman '
          'di lahan kelompok tani Sri Mulya, agar kebutuhan penyiraman '
          'tiap petak mudah dipantau.',
          style: TextStyle(color: warna.onSurface),
        ),
        const SizedBox(height: 20),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Informasi Model',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: warna.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text('Model: LSTM', style: TextStyle(color: warna.onSurface)),
                const SizedBox(height: 8),
                Text(
                  'Prediksi: 24 jam ke depan',
                  style: TextStyle(color: warna.onSurface),
                ),
                const SizedBox(height: 8),
                Text(
                  'Parameter: 3 mikroklimat',
                  style: TextStyle(color: warna.onSurface),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        OutlinedButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.tentang);
          },
          child: const Text('Tentang Aplikasi'),
        ),
      ],
    );
  }
}
