extension CurrencyFormat on num {
  String toRupiah() {
    return "Rp ${toStringAsFixed(0).replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => ".")}";
  }
}
