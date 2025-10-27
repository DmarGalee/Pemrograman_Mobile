# 📸 Flutter Camera & Photo Filter Projects

> **Nama Praktikan:** DAMAR GALIH FITRIANTO  
> **Kelas / NIM:**  3G & 2341720200  
> **Mata Kuliah:** Pemrograman Mobile 
> **Dosen Pengampu:** Habibie Ed Dien

---

1. [Deskripsi Umum](#deskripsi-umum)
Banyak aplikasi yang mengharuskan penggunaan kamera perangkat untuk mengambil foto dan video. Flutter menyediakan plugin kamera untuk tujuan ini. Plugin kamera menyediakan alat untuk mendapatkan daftar kamera yang tersedia, menampilkan pratinjau yang berasal dari kamera tertentu, dan mengambil foto atau video.

2. [Praktikum 1 - kamera_flutter](#praktikum1kamera_flutter)

    Ambil Sensor Kamera dari device
    ![Kamera](kamera_flutter/img/no3.png)

    Buat dan inisialisasi CameraController
    ![Camera Controller](kamera_flutter/img/no4.png)

    [displaypicture_screen.dart.png](#displaypicture_screen.dart.png)
    ![Hasil Kode dan Main](kamera_flutter/img/displaypicture_screen.dart.png)
    
    DisplayPictureScreen digunakan untuk menampilkan hasil foto yang diambil dari kamera. Kelas ini merupakan turunan dari StatelessWidget, artinya tampilannya tidak berubah setelah dibuat.

    Widget ini menerima satu parameter bernama imagePath, yaitu path (lokasi) file gambar yang dihasilkan dari proses pemotretan. Di dalam method build(), digunakan widget Scaffold untuk membangun struktur layar dengan AppBar sebagai judul dan body berisi widget Center agar gambar berada di tengah layar.

    Bagian utama tampilan gambar dibuat menggunakan Image.file(File(imagePath)), yang artinya Flutter akan membaca file gambar dari penyimpanan lokal menggunakan kelas File dari library dart:io, lalu menampilkannya di layar. Dengan begitu, setiap kali pengguna mengambil foto, hasilnya akan ditampilkan pada halaman ini secara penuh dan rapi di tengah layar.

    [takepicture_screen.dart.png](#takepicture_screen.dart.png)
    ![Hasil Kode dan Main](kamera_flutter/img/takepicture_screen.dart.png)

    Di dalam TakePictureScreen, dibuat objek CameraController untuk mengatur kamera dan memulai proses inisialisasi agar kamera siap digunakan. 
    
    Setelah inisialisasi selesai, widget FutureBuilder akan menampilkan preview kamera secara langsung dengan CameraPreview(_controller). Jika kamera belum siap, aplikasi menampilkan loading indicator, dan jika gagal, menampilkan pesan error. Tersedia tombol FloatingActionButton bergambar ikon kamera untuk mengambil foto; tombol ini hanya aktif jika kamera sudah siap. Saat ditekan, kamera akan mengambil gambar menggunakan takePicture() dan hasilnya berupa path file gambar dikirim ke halaman DisplayPictureScreen melalui navigasi.

    [hasil.png](#hasil.png)
    ![Hasil Kode dan Main](kamera_flutter/img/hasil.png)
    

3. [Praktikum 2 - photo_filter_carousel](#praktikum-2---photo_filter_carousel)

     Buat widget Selector ring dan dark gradient
    ![Photo](photo_filter_carousel/img/no2.png)

    Kelas FilterSelector adalah StatefulWidget yang menampilkan deretan filter dalam bentuk carousel. Widget ini menerima tiga parameter utama:

    filters → daftar warna (atau efek filter) yang akan ditampilkan,

    onFilterChanged → callback yang dijalankan saat filter berubah,

    padding → jarak antar elemen carousel.

    Di dalam kelas _FilterSelectorState, digunakan PageController untuk mengatur posisi halaman dan animasi perpindahan filter.
    Metode _onPageChanged() memantau pergeseran halaman, lalu memanggil onFilterChanged untuk memberi tahu filter mana yang sedang aktif.
    Widget FilterItem (yang diimpor dari filter_item.dart) digunakan untuk menampilkan tiap item filter.

    Pada bagian build(), carousel dibuat menggunakan Scrollable dan Flow dengan CarouselFlowDelegate untuk menata elemen filter agar bisa digeser halus secara horizontal. Efek tambahan seperti bayangan gradien (_buildShadowGradient) dan cincin seleksi (_buildSelectionRing) ditambahkan agar tampilan filter lebih menarik dan menunjukkan filter yang sedang dipilih.


    Buat widget photo filter carousel
    ![Photo](photo_filter_carousel/img/no3.png)

    Buat widget photo filter carousel
    ![Photo](photo_filter_carousel/img/no4.png)

   - [Hasil & Screenshot](#hasil--screenshot-2)


4. [Kesimpulan](#kesimpulan)
5. [Referensi](#referensi)