import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/hasil_prediksi.dart';
import '../pages/halaman_beranda.dart';
import '../pages/halaman_pengaturan.dart';
import '../pages/halaman_riwayat_prediksi.dart';
import '../state/prediksi_model.dart';
import 'app_routes.dart';

class KerangkaNavigasi extends StatefulWidget {
  const KerangkaNavigasi({super.key});

  @override
  State<KerangkaNavigasi> createState() => _KerangkaNavigasiState();
}

class _KerangkaNavigasiState extends State<KerangkaNavigasi> {
  int _tabAktif = 0;

  final List<String> _namaTab = [
    'Beranda',
    'Prediksi',
    'Statistik',
    'Pengaturan',
  ];

  late final List<Widget> _halaman = [
    const HalamanBeranda(),
    const HalamanRiwayatPrediksi(),
    const Center(child: Text('Statistik')),
    const HalamanPengaturan(),
  ];

  Future<void> _bukaFormPrediksi() async {
    final hasil = await Navigator.pushNamed<dynamic>(
      context,
      AppRoutes.inputPrediksi,
    );

    if (!mounted || hasil is! HasilPrediksi) {
      return;
    }

    context.read<PrediksiModel>().tambahPrediksi(hasil);

    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Data Tersimpan')));
  }

  Widget _ikonPrediksi(IconData ikon) {
    return Consumer<PrediksiModel>(
      builder: (context, model, child) {
        return Badge(
          isLabelVisible: model.jumlahPerluTindakan > 0,
          label: Text('${model.jumlahPerluTindakan}'),
          child: Icon(ikon),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final warna = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('AgriClima - ${_namaTab[_tabAktif]}'),
        backgroundColor: warna.surface,
        foregroundColor: warna.onSurface,
      ),
      body: IndexedStack(index: _tabAktif, children: _halaman),
      floatingActionButton: _tabAktif == 1
          ? FloatingActionButton.extended(
              onPressed: _bukaFormPrediksi,
              icon: const Icon(Icons.add),
              label: const Text('Prediksi Baru'),
            )
          : null,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tabAktif,
        onDestinationSelected: (indeks) {
          setState(() {
            _tabAktif = indeks;
          });
        },
        destinations: [
          const NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Beranda',
          ),
          NavigationDestination(
            icon: _ikonPrediksi(Icons.eco_outlined),
            selectedIcon: _ikonPrediksi(Icons.eco),
            label: 'Prediksi',
          ),
          const NavigationDestination(
            icon: Icon(Icons.bar_chart_outlined),
            selectedIcon: Icon(Icons.bar_chart),
            label: 'Statistik',
          ),
          const NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Pengaturan',
          ),
        ],
      ),
    );
  }
}
