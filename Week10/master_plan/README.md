# Codelabs  #10 | Dasar State Management

> **Nama Praktikan:** DAMAR GALIH FITRIANTO  
> **Kelas / NIM:**  3G & 2341720200  
> **Mata Kuliah:** Pemrograman Mobile
---
> **Dosen Pengampu:** Habibie Ed Dien

---

## Praktikum 1
Langkah 1:  
Buat Project Baru
Buatlah sebuah project flutter baru dengan nama master_plan di folder src week-10 repository GitHub Anda atau sesuai style laporan praktikum yang telah disepakati. Lalu buatlah susunan folder dalam project seperti gambar berikut ini.

Langkah 2:  
Membuat model task.dart
Praktik terbaik untuk memulai adalah pada lapisan data (data layer). Ini akan memberi Anda gambaran yang jelas tentang aplikasi Anda, tanpa masuk ke detail antarmuka pengguna Anda. Di folder model, buat file bernama task.dart dan buat class Task. Class ini memiliki atribut description dengan tipe data String dan complete dengan tipe data Boolean, serta ada konstruktor. Kelas ini akan menyimpan data tugas untuk aplikasi kita. Tambahkan kode berikut:

![alt text](/Week10/master_plan/assets/image.png)

Langkah 3:  
Buat file plan.dart
Kita juga perlu sebuah List untuk menyimpan daftar rencana dalam aplikasi to-do ini. Buat file plan.dart di dalam folder models dan isi kode seperti berikut.
![alt text](/Week10/master_plan/assets/image-2.png)

Langkah 4:  
Buat file data_layer.dart
Kita dapat membungkus beberapa data layer ke dalam sebuah file yang nanti akan mengekspor kedua model tersebut. Dengan begitu, proses impor akan lebih ringkas seiring berkembangnya aplikasi. Buat file bernama data_layer.dart di folder models. Kodenya hanya berisi export seperti berikut.

![alt text](/Week10/master_plan/assets/image-3.png)

Langkah 5:  
Pindah ke file main.dart
Ubah isi kode main.dart sebagai berikut.

![alt text](/Week10/master_plan/assets/image-4.png)

Langkah 6:  
buat plan_screen.dart
Pada folder views, buatlah sebuah file plan_screen.dart dan gunakan templat StatefulWidget untuk membuat class PlanScreen. Isi kodenya adalah sebagai berikut. Gantilah teks ‘Namaku' dengan nama panggilan Anda pada title AppBar.

![alt text](/Week10/master_plan/assets/image-5.png)

Langkah 7:  
buat method _buildAddTaskButton()
Anda akan melihat beberapa error di langkah 6, karena method yang belum dibuat. Ayo kita buat mulai dari yang paling mudah yaitu tombol Tambah Rencana. Tambah kode berikut di bawah method build di dalam class _PlanScreenState.

![alt text](/Week10/master_plan/assets/image-6.png)

Langkah 8:  
buat widget _buildList()
Kita akan buat widget berupa List yang dapat dilakukan scroll, yaitu ListView.builder. Buat widget ListView seperti kode berikut ini.

![alt text](/Week10/master_plan/assets/image-7.png)

Langkah 9:  
buat widget _buildTaskTile
Dari langkah 8, kita butuh ListTile untuk menampilkan setiap nilai dari plan.tasks. Kita buat dinamis untuk setiap index data, sehingga membuat view menjadi lebih mudah. Tambahkan kode berikut ini.

![alt text](/Week10/master_plan/assets/image-8.png)

Langkah 10:  
Tambah Scroll Controller
Anda dapat menambah tugas sebanyak-banyaknya, menandainya jika sudah beres, dan melakukan scroll jika sudah semakin banyak isinya. Namun, ada salah satu fitur tertentu di iOS perlu kita tambahkan. Ketika keyboard tampil, Anda akan kesulitan untuk mengisi yang paling bawah. Untuk mengatasi itu, Anda dapat menggunakan ScrollController untuk menghapus focus dari semua TextField selama event scroll dilakukan. Pada file plan_screen.dart, tambahkan variabel scroll controller di class State tepat setelah variabel plan.

- late ScrollController scrollController;

Langkah 11:  
Tambah Scroll Listener
Tambahkan method initState() setelah deklarasi variabel scrollController seperti kode berikut.

![alt text](/Week10/master_plan/assets/image-9.png)

Langkah 12:  
Tambah controller dan keyboard behavior
Tambahkan controller dan keyboard behavior pada ListView di method _buildList seperti kode berikut ini.

![alt text](/Week10/master_plan/assets/image-10.png)

Langkah 13:  
Terakhir, tambah method dispose()
Terakhir, tambahkan method dispose() berguna ketika widget sudah tidak digunakan lagi.

![alt text](/Week10/master_plan/assets/image-11.png)

Langkah 14: Hasil

Lakukan Hot restart (bukan hot reload) pada aplikasi Flutter Anda. Anda akan melihat tampilan akhir seperti gambar berikut. Jika masih terdapat error, silakan diperbaiki hingga bisa running.

![alt text](/Week10/master_plan/assets/image-12.png)


Tugas Praktikum 1:  Dasar State dengan Model-View 

1. Selesaikan langkah-langkah praktikum tersebut, lalu dokumentasikan berupa GIF hasil akhir praktikum beserta penjelasannya di file README.md! Jika Anda menemukan ada yang error atau tidak berjalan dengan baik, silakan diperbaiki.

2. Jelaskan maksud dari langkah 4 pada praktikum tersebut! Mengapa dilakukan demikian?
- Merupakan penerapan konsep "Barrel File" dalam pengorganisasian kode yang bertujuan untuk menyederhanakan proses import, meningkatkan maintainability, mengurangi jumlah baris import di file lain, dan memudahkan pengelolaan dependensi saat pengembangan aplikasi.
 
3. Mengapa perlu variabel plan di langkah 6 pada praktikum tersebut? Mengapa dibuat konstanta ?
- Untuk menyimpan state dari daftar tugas (tasks) yang akan ditampilkan di layar
- Dibuat konstanta untuk mengoptimalkan performa dan jika ada perubahan, objek Plan baru dibuat dengan data yang diperbarui (seperti yang terlihat di method _buildAddTaskButton dan _buildTaskTile)
4. Lakukan capture hasil dari Langkah 9 berupa GIF, kemudian jelaskan apa yang telah Anda buat!

![alt text](/Week10/master_plan/assets/image-12.png)

5. Apa kegunaan method pada Langkah 11 dan 13 dalam lifecyle state ?
- Pada langkah 9 merupakan tahap untuk membuat list serta textbox nya agar kita bisa membuat dan mengisi plan yang kita inginkan.


## Praktikum 2 Mengelola Data Layer dengan InheritedWidget dan InheritedNotifier

Langkah 1:  Buat file plan_provider.dart  
Buat folder baru provider di dalam folder lib, lalu buat file baru dengan nama plan_provider.dart berisi kode seperti berikut.

![alt text](/Week10/master_plan/assets/image-13.png)

Langkah 2: Edit main.dart  
Gantilah pada bagian atribut home dengan PlanProvider seperti berikut. Jangan lupa sesuaikan bagian impor jika dibutuhkan.

![alt text](/Week10/master_plan/assets/image-14.png)

Langkah 3: Tambah method pada model plan.dart  
Tambahkan dua method di dalam model class Plan seperti kode berikut.
![alt text](/Week10/master_plan/assets/image-15.png)

Langkah 4: Pindah ke PlanScreen  
Edit PlanScreen agar menggunakan data dari PlanProvider. Hapus deklarasi variabel plan (ini akan membuat error). Kita akan perbaiki pada langkah 5 berikut ini.

Langkah 5: Edit method _buildAddTaskButton  
Tambahkan BuildContext sebagai parameter dan gunakan PlanProvider sebagai sumber datanya. Edit bagian kode seperti berikut.

![alt text](/Week10/master_plan/assets/image-16.png)

Langkah 6: Edit method _buildTaskTile  
Tambahkan parameter BuildContext, gunakan PlanProvider sebagai sumber data. Ganti TextField menjadi TextFormField untuk membuat inisial data provider menjadi lebih mudah.

![alt text](/Week10/master_plan/assets/image-17.png)

Langkah 7: Edit _buildList  
Sesuaikan parameter pada bagian _buildTaskTile seperti kode berikut.
![alt text](/Week10/master_plan/assets/image-18.png)

Langkah 8: Tetap di class PlanScreen  
Edit method build sehingga bisa tampil progress pada bagian bawah (footer). Caranya, bungkus (wrap) _buildList dengan widget Expanded dan masukkan ke dalam widget Column seperti kode pada Langkah 9.

Langkah 9: Tambah widget SafeArea  
Terakhir, tambahkan widget SafeArea dengan berisi completenessMessage pada akhir widget Column. Perhatikan kode berikut ini.
![alt text](/Week10/master_plan/assets/image-20.png)

![alt text](/Week10/master_plan/assets/image-19.png)


Tugas Praktikum 2: InheritedWidget
1. Selesaikan langkah-langkah praktikum tersebut, lalu dokumentasikan berupa GIF hasil akhir praktikum beserta penjelasannya di file README.md! Jika Anda menemukan ada yang error atau tidak berjalan dengan baik, silakan diperbaiki sesuai dengan tujuan aplikasi tersebut dibuat.

2. Jelaskan mana yang dimaksud InheritedWidget pada langkah 1 tersebut! Mengapa yang digunakan InheritedNotifier?
![alt text](/Week10/master_plan/assets/image-21.png)
- Menggunakan InheritedWidget karena menyediakan cara untuk menyebarkan data ke widget-widget turunannya dan memungkinkan widget turunannya bereaksi ketika nilai berubah (melalui dependOnInheritedWidgetOfExactType).
3. Jelaskan maksud dari method di langkah 3 pada praktikum tersebut! Mengapa dilakukan demikian?
- completedCount: menghitung berapa banyak task pada tasks yang memiliki complete == true. lalu completenessMessage: menyusun pesan ringkas yang menampilkan progress dalam format yang mudah dibaca, mis. "2 out of 5 tasks".

- Dilakukan demikian untuk memisahkan logika hitungan dan formatting ke dalam properti model dan menggunakan getter memastikan nilai selalu konsisten dengan state saat ini (setiap baca getter dihitung ulang).

4. Lakukan capture hasil dari Langkah 9 berupa GIF, kemudian jelaskan apa yang telah Anda buat!

![alt text](/Week10/master_plan/assets/image-19.png)

5. Kumpulkan laporan praktikum Anda berupa link commit atau repository GitHub ke dosen yang telah disepakati !

## Praktikum 3: Membuat State di Multiple Screens

Langkah 1: Edit PlanProvider  
Perhatikan kode berikut, edit class PlanProvider sehingga dapat menangani List Plan.

![alt text](/Week10/master_plan/assets/image-22.png)

Langkah 2: Edit main.dart  
Langkah sebelumnya dapat menyebabkan error pada main.dart dan plan_screen.dart. Pada method build, gantilah menjadi kode seperti ini.

![alt text](/Week10/master_plan/assets/image-23.png)

Langkah 3: Edit plan_screen.dart  
Tambahkan variabel plan dan atribut pada constructor-nya seperti berikut.

![alt text](/Week10/master_plan/assets/image-24.png)

Langkah 4: Error  
Itu akan terjadi error setiap kali memanggil PlanProvider.of(context). Itu terjadi karena screen saat ini hanya menerima tugas-tugas untuk satu kelompok Plan, tapi sekarang PlanProvider menjadi list dari objek plan tersebut.

Langkah 5: Tambah getter Plan  
Tambahkan getter pada _PlanScreenState seperti kode berikut.

![alt text](/Week10/master_plan/assets/image-25.png)

Langkah 6: Method initState()  
Pada bagian ini kode tetap seperti berikut.

![alt text](/Week10/master_plan/assets/image-26.png)

Langkah 7: Widget build  
Pastikan Anda telah merubah ke List dan mengubah nilai pada currentPlan seperti kode berikut ini.

![alt text](/Week10/master_plan/assets/image-27.png)

Langkah 8: Edit _buildTaskTile  
Pastikan ubah ke List dan variabel planNotifier seperti kode berikut ini.

![alt text](/Week10/master_plan/assets/image-28.png)

Langkah 9: Buat screen baru  
Pada folder view, buatlah file baru dengan nama plan_creator_screen.dart dan deklarasikan dengan StatefulWidget bernama PlanCreatorScreen. Gantilah di main.dart pada atribut home menjadi seperti berikut.

- home: const PlanCreatorScreen(),

Langkah 10: Pindah ke class _PlanCreatorScreenState  
Kita perlu tambahkan variabel TextEditingController sehingga bisa membuat TextField sederhana untuk menambah Plan baru. Jangan lupa tambahkan dispose ketika widget unmounted seperti kode berikut.

![alt text](/Week10/master_plan/assets/image-29.png)

Langkah 11: Pindah ke method build  
Letakkan method Widget build berikut di atas void dispose. Gantilah ‘Namaku' dengan nama panggilan Anda.

![alt text](/Week10/master_plan/assets/image-30.png)

Langkah 12: Buat widget _buildListCreator  
Buatlah widget berikut setelah widget build.

![alt text](/Week10/master_plan/assets/image-31.png)

Langkah 13: Buat void addPlan()  
Tambahkan method berikut untuk menerima inputan dari user berupa text plan.

![alt text](/Week10/master_plan/assets/image-32.png)

Langkah 14: Buat widget _buildMasterPlans()  
Tambahkan widget seperti kode berikut.

![alt text](/Week10/master_plan/assets/image-33.png)

Hasil

![alt text](/Week10/master_plan/assets/image-34.png)

![alt text](/Week10/master_plan/assets/image-35.png)


Tugas Praktikum 3: State di Multiple Screens
1. Selesaikan langkah-langkah praktikum tersebut, lalu dokumentasikan berupa GIF hasil akhir praktikum beserta penjelasannya di file README.md! Jika Anda menemukan ada yang error atau tidak berjalan dengan baik, silakan diperbaiki sesuai dengan tujuan aplikasi tersebut dibuat.

2. Berdasarkan Praktikum 3 yang telah Anda lakukan, jelaskan maksud dari gambar diagram berikut ini!

![alt text](/Week10/master_plan/assets/image-36.png)

- Penggunaan PlanProvider di level atas memastikan state management konsisten

- Navigasi antar screen menggunakan Navigator.push

- Hierarchical state management dimana perubahan di child screen (PlanScreen) mempengaruhi parent screen (PlanCreatorScreen)

- Widget tree menunjukkan penggunaan material design patterns (Scaffold, SafeArea) dan layout widgets (Column, Expanded)