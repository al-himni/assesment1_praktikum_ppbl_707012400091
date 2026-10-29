import 'package:flutter/material.dart';

import '../models/hasil_prediksi.dart';

class HalamanInputPrediksi extends StatefulWidget {
  const HalamanInputPrediksi({super.key});

  @override
  State<HalamanInputPrediksi> createState() => _HalamanInputPrediksiState();
}

class _HalamanInputPrediksiState extends State<HalamanInputPrediksi> {
  final _formKey = GlobalKey<FormState>();

  final _suhuController = TextEditingController();
  final _kelembapanUdaraController = TextEditingController();
  final _kelembapanTanahController = TextEditingController();
  final _namaPetugasController = TextEditingController();

  String _petak = 'Petak 1';
  String? _tanaman;
  bool _dataBenar = false;

  @override
  void dispose() {
    _suhuController.dispose();
    _kelembapanUdaraController.dispose();
    _kelembapanTanahController.dispose();
    _namaPetugasController.dispose();
    super.dispose();
  }

  String? _validasiAngka(
    String? nilai,
    String namaIsian, {
    bool harusPersen = false,
  }) {
    final teks = nilai?.trim() ?? '';

    if (teks.isEmpty) {
      return '$namaIsian wajib diisi.';
    }

    final angka = double.tryParse(teks);

    if (angka == null || !angka.isFinite) {
      return '$namaIsian harus berupa angka.';
    }

    if (harusPersen && (angka < 0 || angka > 100)) {
      return '$namaIsian harus di antara 0 dan 100.';
    }

    return null;
  }

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

  Future<void> _simpanData() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final hasil = HasilPrediksi(
      petak: _petak,
      tanaman: _tanaman!,
      suhuUdara: double.parse(_suhuController.text.trim()),
      kelembapanUdara: double.parse(_kelembapanUdaraController.text.trim()),
      kelembapanTanah: double.parse(_kelembapanTanahController.text.trim()),
      namaPetugas: _namaPetugasController.text.trim(),
      waktu: DateTime.now(),
    );

    final yakin = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Konfirmasi Data'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Petak: ${hasil.petak}'),
                Text('Tanaman: ${hasil.tanaman}'),
                Text('Suhu udara: ${hasil.suhuUdara} °C'),
                Text('Kelembapan udara: ${hasil.kelembapanUdara}%'),
                Text('Kelembapan tanah: ${hasil.kelembapanTanah}%'),
                Text('Nama petugas: ${hasil.namaPetugas}'),
                const Divider(),
                Row(
                  children: [
                    Icon(
                      _ikonStatus(hasil.statusMikroklimat),
                      color: _warnaStatus(
                        dialogContext,
                        hasil.statusMikroklimat,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text('Status: ${hasil.statusMikroklimat}'),
                  ],
                ),
                const SizedBox(height: 8),
                Text('Rekomendasi: ${hasil.rekomendasi}'),
                const SizedBox(height: 8),
                Text('Catatan perawatan: ${hasil.catatan}'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: const Text('Periksa Lagi'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );

    if (yakin != true || !mounted) {
      return;
    }

    Navigator.pop(context, hasil);
  }

  @override
  Widget build(BuildContext context) {
    final warna = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Input Hasil Prediksi')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              'Petak',
              style: TextStyle(
                color: warna.onSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
            RadioGroup<String>(
              groupValue: _petak,
              onChanged: (nilai) {
                if (nilai == null) return;

                setState(() {
                  _petak = nilai;
                });
              },
              child: Column(
                children: [
                  RadioListTile<String>(
                    title: const Text('Petak 1'),
                    value: 'Petak 1',
                    contentPadding: EdgeInsets.zero,
                  ),
                  RadioListTile<String>(
                    title: const Text('Petak 2'),
                    value: 'Petak 2',
                    contentPadding: EdgeInsets.zero,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              initialValue: _tanaman,
              decoration: const InputDecoration(
                labelText: 'Nama Tanaman',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: 'Padi', child: Text('Padi')),
                DropdownMenuItem(value: 'Jagung', child: Text('Jagung')),
                DropdownMenuItem(value: 'Cabai', child: Text('Cabai')),
              ],
              onChanged: (nilai) {
                setState(() {
                  _tanaman = nilai;
                });
              },
              validator: (nilai) {
                if (nilai == null || nilai.isEmpty) {
                  return 'Pilih nama tanaman.';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _suhuController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Prediksi Suhu Udara (°C)',
                border: OutlineInputBorder(),
              ),
              validator: (nilai) => _validasiAngka(nilai, 'Suhu udara'),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _kelembapanUdaraController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Prediksi Kelembapan Udara (%)',
                border: OutlineInputBorder(),
              ),
              validator: (nilai) =>
                  _validasiAngka(nilai, 'Kelembapan udara', harusPersen: true),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _kelembapanTanahController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Prediksi Kelembapan Tanah (%)',
                border: OutlineInputBorder(),
              ),
              validator: (nilai) =>
                  _validasiAngka(nilai, 'Kelembapan tanah', harusPersen: true),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _namaPetugasController,
              decoration: const InputDecoration(
                labelText: 'Nama Petugas',
                border: OutlineInputBorder(),
              ),
              validator: (nilai) {
                if (nilai == null || nilai.trim().isEmpty) {
                  return 'Nama petugas wajib diisi.';
                }
                return null;
              },
            ),
            const SizedBox(height: 8),
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Data sudah benar'),
              value: _dataBenar,
              onChanged: (nilai) {
                setState(() {
                  _dataBenar = nilai ?? false;
                });
              },
            ),
            const SizedBox(height: 8),
            FilledButton(
              onPressed: _dataBenar ? _simpanData : null,
              child: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
