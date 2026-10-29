import 'package:flutter/material.dart';

import '../models/hasil_prediksi.dart';

class PrediksiCard extends StatelessWidget {
  const PrediksiCard({super.key, required this.hasil, required this.onHapus});

  final HasilPrediksi hasil;
  final VoidCallback onHapus;

  Color _warnaStatus(BuildContext context, String status) {
    final warna = Theme.of(context).colorScheme;

    switch (status) {
      case 'Kering':
        return warna.primary;
      case 'Optimal':
        return warna.secondary;
      default:
        return warna.tertiary;
    }
  }

  IconData _ikonStatus(String status) {
    switch (status) {
      case 'Kering':
        return Icons.water_drop_outlined;
      case 'Optimal':
        return Icons.check_circle_outline;
      default:
        return Icons.water_damage_outlined;
    }
  }

  String _formatWaktu(DateTime waktu) {
    final jam = waktu.hour.toString().padLeft(2, '0');
    final menit = waktu.minute.toString().padLeft(2, '0');

    return '${waktu.day}/${waktu.month}/${waktu.year} $jam:$menit';
  }

  @override
  Widget build(BuildContext context) {
    final warna = Theme.of(context).colorScheme;
    final warnaStatus = _warnaStatus(context, hasil.statusMikroklimat);
    final progres = (hasil.kelembapanTanah.clamp(0, 100) / 100).toDouble();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    '${hasil.petak} - ${hasil.tanaman}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: warna.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  tooltip: 'Hapus prediksi',
                  onPressed: onHapus,
                  icon: Icon(Icons.delete_outline, color: warna.onSurface),
                ),
              ],
            ),
            Row(
              children: [
                Icon(_ikonStatus(hasil.statusMikroklimat), color: warnaStatus),
                const SizedBox(width: 6),
                Text(
                  hasil.statusMikroklimat,
                  style: TextStyle(
                    color: warnaStatus,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Kelembapan tanah: ${hasil.kelembapanTanah}%',
              style: TextStyle(color: warna.onSurface),
            ),
            const SizedBox(height: 4),
            LinearProgressIndicator(
              value: progres,
              color: warnaStatus,
              backgroundColor: warna.surfaceContainerHighest,
            ),
            const SizedBox(height: 8),
            Text(
              'Suhu udara: ${hasil.suhuUdara} °C',
              style: TextStyle(color: warna.onSurface),
            ),
            Text(
              'Kelembapan udara: ${hasil.kelembapanUdara}%',
              style: TextStyle(color: warna.onSurface),
            ),
            const SizedBox(height: 8),
            Text(
              'Rekomendasi: ${hasil.rekomendasi}',
              style: TextStyle(color: warna.onSurface),
            ),
            const SizedBox(height: 4),
            Text(
              'Catatan perawatan: ${hasil.catatan}',
              style: TextStyle(color: warna.onSurface),
            ),
            const SizedBox(height: 8),
            Text(
              'Waktu prediksi: ${_formatWaktu(hasil.waktu)}',
              style: TextStyle(color: warna.onSurfaceVariant, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
