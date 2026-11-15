# SPESIFIKASI KEBUTUHAN PERANGKAT LUNAK (SKPL)

## APLIKASI TO-DO LIST

---

## 1. Deskripsi Pekerjaan

Pengembangan aplikasi To-Do List berbasis web untuk mencatat dan mengelola daftar tugas harian. Pengguna dapat menambahkan tugas, mengubah status pengerjaan, mengatur tanggal deadline, serta menghapus tugas.

## 2. Capaian Utama (Main Achievement)

Terbangunnya aplikasi manajemen tugas berbasis web yang fungsional, mencakup pengelolaan tugas (CRUD), perubahan status dinamis (Pending / Completed), serta validasi format deadline.

## 3. Tujuan Aplikasi

1. Menerapkan konsep CRUD pada pengelolaan tugas.
2. Memahami manajemen perubahan status data.
3. Melatih validasi input tanggal dan pengujian fungsional.

## 4. Teknologi yang Digunakan (Tech Stack)

- **Frontend:** HTML5, CSS3, JavaScript.
- **Backend:** PHP / Node.js.
- **Database:** MySQL / MariaDB.
- **Testing:** Black Box Testing.

## 5. Alur Utama Sistem

Buka Aplikasi → Daftar Tugas → Tambah Tugas → Simpan → Detail Tugas → Edit → Update Status → Hapus.

## 6. Format Narasumber (NARSUM)

> **PENTING:** Apabila terdapat format penyampaian laporan, struktur pengumpulan dokumen, atau spesifikasi khusus yang diberikan secara langsung oleh Narasumber (Narsum) / Dosen / Pembimbing, maka format dari narsum tersebut bersifat mutlak dan harus menjadi acuan utama, mengesampingkan template dasar yang ada pada dokumen ini.

## 7. Batasan Scope

- Tidak mencakup kolaborasi tugas antar pengguna.
- Tidak mencakup sinkronisasi kalender eksternal (Google Calendar).
- Tidak mencakup notifikasi push atau email.

*Halaman 1 dari 2*

---

## 8. MODUL, SCOPE OF WORK, DAN TEMPLATE PENGERJAAN

### Modul 1 — Analisis Kebutuhan

- **Cakupan:** Identifikasi jenis data tugas (judul, deskripsi, deadline, status) dan pembatasan scope.
- **Output:** Dokumen spesifikasi kebutuhan aplikasi To-Do List.

| ID Kebutuhan | Nama Fitur | Deskripsi Fungsionalitas |
|---|---|---|
| REQ-01 | Kelola Tugas | Sistem memungkinkan penambahan, pengubahan, dan penghapusan tugas. |
| REQ-02 | Status Tugas | Sistem memfasilitasi perubahan status tugas (Pending / Completed). |

### Modul 2 — Database & Setup

- **Cakupan:** Perancangan tabel `tasks`, penentuan field, dan konfigurasi koneksi database.
- **Output:** Database dan tabel tugas siap pakai.

| Nama Tabel | Field Utama | Tipe Data | Keterangan / Relasi |
|---|---|---|---|
| `tasks` | `id` | INT (PK) | Menyimpan seluruh daftar tugas pengguna. |
| | `judul` | VARCHAR(150) | Judul tugas. |
| | `deskripsi` | TEXT | Deskripsi rinci tugas. |
| | `deadline` | DATE | Tanggal batas penyelesaian tugas. |
| | `status` | ENUM('Pending', 'Completed') | Status pengerjaan tugas. |

### Modul 3 & 4 — UI/UX & CRUD Tugas

- **Cakupan:** Dashboard tugas, filter status, form tugas, serta aksi pembaruan status cepat (checkbox).
- **Output:** Antarmuka (Interface) dan fitur CRUD tugas yang berfungsi penuh.

### Modul 5 — Testing & Basic Security

- **Cakupan:** Pengujian fungsionalitas CRUD, validasi form kosong, dan identifikasi kerentanan input dasar.

| ID Test | Skenario Pengujian | Input Data | Hasil yang Diharapkan | Status |
|---|---|---|---|---|
| TC-01 | Toggle Status Tugas | Klik Checkbox Tugas | Status berubah menjadi 'Completed' secara instan. | PASS |
| TC-02 | Form Judul Kosong | Judul: "" | Sistem menolak simpan & menampilkan peringatan. | PASS |

*Halaman 2 dari 2*
