// Fungsi tukar untuk menukar isi record (int, int)
(int, int) tukar((int, int) record) {
  var (a, b) = record;   // Destructuring
  return (b, a);         // Balik urutan
}

void main() {
  // Record campuran (contoh biasa)
  var record = ('first', a: 2, b: true, 'last');
  print(record);

  // Record khusus int, int agar bisa ditukar
  var angka = (10, 20);
  print('Sebelum tukar: $angka');

  var hasil = tukar(angka);
  print('Sesudah tukar: $hasil');

 // Record mahasiswa dengan nama dan NIM
  (String, int) mahasiswa = ('Damar Galih', 2341720200);
  print('Mahasiswa: $mahasiswa');

  // Destructuring supaya lebih jelas
  var (nama, nim) = mahasiswa;
  print('Nama: $nama, NIM: $nim');

   var mahasiswa2 = ('Damar Galih', a: 2341720200, b: true, 'last');

  print(mahasiswa2.$1);
  print(mahasiswa2.a);
  print(mahasiswa2.b); 
  print(mahasiswa2.$2);
}
