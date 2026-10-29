import 'catatan_perawatan.dart';

class HasilPrediksi {
  final String petak;
  final String tanaman;
  final double suhuUdara;
  final double kelembapanUdara;
  final double kelembapanTanah;
  final String namaPetugas;
  final DateTime waktu;

  const HasilPrediksi({
    required this.petak,
    required this.tanaman,
    required this.suhuUdara,
    required this.kelembapanUdara,
    required this.kelembapanTanah,
    required this.namaPetugas,
    required this.waktu,
  });

  String get statusMikroklimat {
    if (kelembapanTanah < 40) {
      return 'Kering';
    } else if (kelembapanTanah <= 70) {
      return 'Optimal';
    } else {
      return 'Terlalu Lembap';
    }
  }

  String get rekomendasi {
    if (kelembapanTanah < 40) {
      return 'Segera lakukan penyiraman atau irigasi.';
    } else if (kelembapanTanah <= 70) {
      return 'Pertahankan pola perawatan saat ini.';
    } else {
      return 'Kurangi penyiraman dan periksa drainase.';
    }
  }

  String get catatan {
    return catatanPerawatan[tanaman] ?? 'Catatan perawatan belum tersedia.';
  }
}
