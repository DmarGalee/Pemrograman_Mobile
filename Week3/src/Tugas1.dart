void main() {

  String nama = "Damar Galih";
  String nim = "2341720200";

  for (int i = 0; i <= 201; i++) {
    if (BilPrima(i)) {
      print("$i -> $nama - $nim");
    }
  }
}


bool BilPrima(int n) {
  if (n < 2) return false;
  for (int i = 2; i <= n / 2; i++) {
    if (n % i == 0) return false;
  }
  return true;
}
