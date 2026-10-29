import 'package:flutter/material.dart';

class StatCard extends StatelessWidget {
  const StatCard({
    super.key,
    required this.judul,
    required this.jumlah,
    required this.ikon,
  });

  final String judul;
  final int jumlah;
  final IconData ikon;

  @override
  Widget build(BuildContext context) {
    final warna = Theme.of(context).colorScheme;

    return SizedBox(
      width: 108,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(ikon, color: warna.primary),
              const SizedBox(height: 4),
              Text(
                '$jumlah',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: warna.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                judul,
                textAlign: TextAlign.center,
                style: TextStyle(color: warna.onSurface),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
