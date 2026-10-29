import 'package:flutter/material.dart';

class HalamanTentang extends StatelessWidget {
  const HalamanTentang({super.key});

  @override
  Widget build(BuildContext context) {
    final warna = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Tentang AgriClima')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Tujuan Aplikasi',
            style: Theme.of(context).textTheme.titleMedium
                ?.copyWith(color: warna.onSurface, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Aplikasi untuk mencatat hasil prediksi mikroklimat tanaman '
            'di lahan kelompok tani Sri Mulya, agar kebutuhan penyiraman '
            'tiap petak mudah dipantau.',
            style: TextStyle(color: warna.onSurface),
          ),
          const Divider(height: 32),
          Text(
            'Lokasi Pemantauan',
            style: Theme.of(context).textTheme.titleMedium
                ?.copyWith(color: warna.onSurface, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text('Petak 1', style: TextStyle(color: warna.onSurface)),
          Text('Petak 2', style: TextStyle(color: warna.onSurface)),
          const Divider(height: 32),
          Text(
            'Parameter Mikroklimat',
            style: Theme.of(context).textTheme.titleMedium
                ?.copyWith(color: warna.onSurface, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text('Suhu udara', style: TextStyle(color: warna.onSurface)),
          Text('Kelembapan udara', style: TextStyle(color: warna.onSurface)),
          Text('Kelembapan tanah', style: TextStyle(color: warna.onSurface)),
        ],
      ),
    );
  }
}
