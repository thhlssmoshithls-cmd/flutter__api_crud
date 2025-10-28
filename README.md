## Tujuan Praktikum
	Tujuan praktikum ini adalah:
    1.	Memahami konsep dasar API (Application Programming Interface) dan REST API.
    2.	Menggunakan package http di Flutter untuk melakukan permintaan (request) ke API eksternal.
    3.	Melakukan operasi CRUD (Create, Read, Update, Delete) terhadap data melalui API.
    4.	Mengurai data JSON (parsing) dan mengubahnya menjadi objek Dart (Model).
    5.	Menampilkan data dari API ke dalam UI Flutter menggunakan widget seperti ListView.
    6.	Mengimplementasikan styling dasar pada komponen UI untuk menyajikan data dengan rapi.
    7.	Mengelola state secara sederhana untuk menangani data yang bersifat asinkron (asynchronous).

## Dasar Teori (penjelasan singkat tentang API, REST, JSON, http package).
    1.API(Application Programming Interface) adalah seperangkat definisi, protokol, dan tools untuk membangun perangkat lunak aplikasi. Dalam praktikum ini, API bertindak sebagai jembatan yang memungkinkan aplikasi Flutter (klien) Anda berkomunikasi dengan server (backend) untuk mengambil atau mengirim data
    2.REST(Representational State Transfer) adalah adalah gaya arsitektur yang paling umum digunakan untuk membuat API berbasis web. REST API menggunakan metode HTTP standar untuk melakukan operasi pada resources.
    3.JSON(JavaScript Object Notation) adalah format pertukaran data yang ringan dan mudah dibaca manusia serta diparsing oleh mesin. Hampir semua REST API menggunakan JSON sebagai format data utama.
    4.Package http adalah library yang direkomendasikan untuk melakukan permintaan HTTP di Dart dan Flutter. Package ini menyediakan fungsi-fungsi mudah digunakan seperti http.get(), http.post(), http.put(), dan http.delete().

## Langkah-langkah implementasi (disertai screenshot hasil setiap bagian penting).
    1.Membuat Proyek flutter  Baru
    flutter create praktikum_api_crud
    2.	Menambahkan Depedency
<img width="174" height="80" alt="image" src="https://github.com/user-attachments/assets/67d0a447-cf9d-4258-a434-c94375c0d192" />
    3.	Membuat user model
<img width="624" height="508" alt="image" src="https://github.com/user-attachments/assets/39ed5787-7795-4945-8179-ee2a0928a1f7" />
    4.	Membuat api service
<img width="624" height="370" alt="image" src="https://github.com/user-attachments/assets/7b1c37cf-55c8-4416-8d0a-c7b4aab82995" />
<img width="624" height="354" alt="image" src="https://github.com/user-attachments/assets/27ce3339-d17a-4e43-a2eb-0ea6eed41d0e" />
    5.	Menampilkan hasil
<img width="389" height="864" alt="image" src="https://github.com/user-attachments/assets/8dceeab3-a3d6-45be-aeb6-1731a798904b" />
<img width="389" height="864" alt="image" src="https://github.com/user-attachments/assets/1b7300d5-ea41-44cf-9de4-9f7554f7d150" />

## Analisis Kode (jelaskan bagian-bagian penting dari kode Anda).
    1.	fetchUsers() digunakan untuk mengambil data dari API menggunakan metode GET.
    2.	createUser() digunakan untuk mengirim data baru dengan metode Post
    3.	updateUser() digunakan untuk memperbarui data dengan menggunakan Put
    4.	deleteUser() digunakn untuk menghapus user dars erver mengginakan Delete.

## Kesimpulan dan Saran.
    •Kesimpulan 
    Dari praktikum diatas bisa disumpulkan bahwa flutter dapat berinteraksi dengan API eksternal menggunakan package http untuk melakukan Crud. Proyek parktikum_api_crud berjalan dengan baik dan membantu memahami cara mengelola data secara real-time.
    •Saran 
    Kedepannya apikasi bisa ditambahkan fitur data biar lebih praktis, terus juga pegecekan input supaya ngak ada data kosong atau salah masuk. Selain itu, tampilan aplikasinya bisa dibuat lebih menarik dan rapi bair nyaman dipakai


 
 



