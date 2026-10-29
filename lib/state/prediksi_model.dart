import 'package:flutter/foundation.dart';

import '../models/hasil_prediksi.dart';

class PrediksiModel extends ChangeNotifier {
  final List<HasilPrediksi> _daftarPrediksi = [];
  String _filterPetak = 'Semua';

  String get filterPetak => _filterPetak;

  List<HasilPrediksi> get prediksiTerfilter {
    if (_filterPetak == 'Semua') {
      return List.unmodifiable(_daftarPrediksi);
    }

    return List.unmodifiable(
      _daftarPrediksi.where((hasil) => hasil.petak == _filterPetak),
    );
  }

  int get jumlahTotal => _daftarPrediksi.length;

  int get jumlahOptimal {
    return _daftarPrediksi
        .where((hasil) => hasil.statusMikroklimat == 'Optimal')
        .length;
  }

  int get jumlahPerluTindakan {
    return _daftarPrediksi.where((hasil) {
      return hasil.statusMikroklimat == 'Kering' ||
          hasil.statusMikroklimat == 'Terlalu Lembap';
    }).length;
  }

  void tambahPrediksi(HasilPrediksi hasil) {
    _daftarPrediksi.insert(0, hasil);
    notifyListeners();
  }

  void hapusPrediksi(HasilPrediksi hasil) {
    _daftarPrediksi.removeWhere((item) => identical(item, hasil));
    notifyListeners();
  }

  void ubahFilterPetak(String petak) {
    _filterPetak = petak;
    notifyListeners();
  }
}
