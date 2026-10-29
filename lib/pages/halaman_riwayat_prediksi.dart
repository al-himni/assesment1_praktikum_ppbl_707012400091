import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/prediksi_model.dart';
import '../widgets/prediksi_card.dart';
import '../widgets/stat_card.dart';

class HalamanRiwayatPrediksi extends StatelessWidget {
  const HalamanRiwayatPrediksi({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<PrediksiModel>();
    final warna = Theme.of(context).colorScheme;
    final daftar = model.prediksiTerfilter;

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Riwayat Prediksi',
            style: Theme.of(context).textTheme.titleLarge
                ?.copyWith(color: warna.onSurface, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buatFilter(context, model, 'Semua'),
                const SizedBox(width: 8),
                _buatFilter(context, model, 'Petak 1'),
                const SizedBox(width: 8),
                _buatFilter(context, model, 'Petak 2'),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              StatCard(
                judul: 'Total',
                jumlah: model.jumlahTotal,
                ikon: Icons.list_alt,
              ),
              StatCard(
                judul: 'Optimal',
                jumlah: model.jumlahOptimal,
                ikon: Icons.check_circle_outline,
              ),
              StatCard(
                judul: 'Perlu Tindakan',
                jumlah: model.jumlahPerluTindakan,
                ikon: Icons.warning_amber_outlined,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: daftar.isEmpty
                ? Center(
                    child: Text(
                      'Belum ada data',
                      style: TextStyle(color: warna.onSurface),
                    ),
                  )
                : ListView.builder(
                    itemCount: daftar.length,
                    itemBuilder: (context, index) {
                      final hasil = daftar[index];

                      return PrediksiCard(
                        hasil: hasil,
                        onHapus: () {
                          context.read<PrediksiModel>().hapusPrediksi(hasil);
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buatFilter(
    BuildContext context,
    PrediksiModel model,
    String namaPetak,
  ) {
    final warna = Theme.of(context).colorScheme;

    return ChoiceChip(
      label: Text(namaPetak, style: TextStyle(color: warna.onSurface)),
      selected: model.filterPetak == namaPetak,
      selectedColor: warna.surfaceContainerHighest,
      onSelected: (dipilih) {
        if (dipilih) {
          context.read<PrediksiModel>().ubahFilterPetak(namaPetak);
        }
      },
    );
  }
}
