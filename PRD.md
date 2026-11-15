# PRODUCT REQUIREMENTS DOCUMENT (PRD)

## Aplikasi To-Do List

---

## 1. Identitas & Tujuan Aplikasi

| Atribut               | Nilai                                                                                                 |
| --------------------- | ----------------------------------------------------------------------------------------------------- |
| **Nama Aplikasi**     | Aplikasi To-Do List                                                                                   |
| **Ringkasan Sistem**  | Aplikasi web untuk mencatat dan mengelola daftar tugas harian. Pengguna dapat menambahkan tugas, mengubah status pengerjaan, mengatur tanggal deadline, serta menghapus tugas. |
| **Capaian Utama**     | Terbangunnya aplikasi manajemen tugas berbasis web yang fungsional, mencakup pengelolaan tugas (CRUD), perubahan status dinamis (Pending / Completed), serta validasi format deadline. |
| **Tech Stack**        | Frontend: HTML5, CSS3, JavaScript, Tailwind CSS · Database: Supabase (PostgreSQL) · Testing: Black Box Testing |

### Tujuan Aplikasi

1. Menerapkan konsep CRUD pada pengelolaan tugas.
2. Memahami manajemen perubahan status data.
3. Melatih validasi input tanggal dan pengujian fungsional.

### Batasan Scope

- Tidak mencakup kolaborasi tugas antar pengguna.
- Tidak mencakup sinkronisasi kalender eksternal (Google Calendar).
- Tidak mencakup notifikasi push atau email.

### Alur Utama Sistem

```
Buka Aplikasi → Daftar Tugas → Tambah Tugas → Simpan → Detail Tugas → Edit → Update Status → Hapus
```

---

## 2. Spesifikasi Fungsional Lengkap (CRUD + Filter)

### 2.1 Daftar Kebutuhan dari SKPL

| ID Kebutuhan | Nama Fitur     | Deskripsi Fungsionalitas                                                          |
| ------------ | -------------- | --------------------------------------------------------------------------------- |
| REQ-01       | Kelola Tugas   | Sistem memungkinkan penambahan, pengubahan, dan penghapusan tugas.                |
| REQ-02       | Status Tugas   | Sistem memfasilitasi perubahan status tugas (Pending / Completed).                |

### 2.2 Penjabaran Siklus CRUD Lengkap

#### A. CREATE — Form Tambah Tugas

| Aspek              | Detail                                                                                                |
| ------------------- | ----------------------------------------------------------------------------------------------------- |
| **Trigger**         | Pengguna mengisi form input tugas dan menekan tombol **"Simpan"**.                                    |
| **Field Input**     | `judul` (wajib, maks 150 karakter), `deskripsi` (opsional, teks panjang), `deadline` (wajib, format DATE `YYYY-MM-DD`). |
| **Status Default**  | Saat tugas baru ditambahkan, kolom `status` otomatis diisi `'Pending'`.                               |
| **Validasi TC-01**  | Jika field `judul` dikosongkan, sistem menolak simpan dan menampilkan pesan: **"Judul tugas tidak boleh kosong."** |
| **Validasi Deadline** | Jika field `deadline` dikosongkan atau formatnya tidak valid, sistem menolak simpan dan menampilkan pesan: **"Deadline harus diisi dengan tanggal yang valid."** |
| **Sukses**          | Data tersimpan ke tabel `tasks` di Supabase, tabel riwayat diperbarui secara real-time, kartu ringkasan (KPI) dihitung ulang. |

#### B. READ — Tabel Riwayat & Kartu Ringkasan

| Aspek                   | Detail                                                                                            |
| ----------------------- | ------------------------------------------------------------------------------------------------- |
| **Tabel Riwayat Tugas** | Menampilkan seluruh data dari tabel `tasks` dalam format tabel responsif, diurutkan berdasarkan `deadline` ascending (tugas terdekat di atas). |
| **Kolom Tabel**         | No, Judul, Deskripsi (dipotong maks 50 karakter di tabel, lengkap saat hover/detail), Deadline (format `dd MMMM yyyy` Indonesia), Status (badge berwarna), Aksi (tombol Edit & Hapus). |
| **Kartu KPI (3 buah)**  | **Kartu 1:** Total Tugas (jumlah seluruh baris). **Kartu 2:** Tugas Pending (jumlah baris dengan `status = 'Pending'`). **Kartu 3:** Tugas Selesai (jumlah baris dengan `status = 'Completed'`). |
| **Empty State**         | Jika tabel kosong, tampilkan ilustrasi dan pesan: **"Belum ada tugas. Tambahkan tugas pertama Anda!"** |

#### C. UPDATE — Edit Data Tugas & Toggle Status

| Aspek                      | Detail                                                                                         |
| -------------------------- | ---------------------------------------------------------------------------------------------- |
| **Edit Data Tugas**        | Pengguna menekan tombol **"Edit"** pada baris tabel → form input diisi otomatis dengan data tugas yang dipilih → pengguna mengubah data → menekan tombol **"Simpan"** → data di-update di tabel `tasks`. |
| **Toggle Status (REQ-02)** | Pengguna mengklik checkbox pada baris tugas → status berubah menjadi `'Completed'` secara instan (tanpa reload). Jika diklik ulang, status kembali menjadi `'Pending'`. |
| **Validasi**               | Validasi yang sama dengan CREATE berlaku saat UPDATE (judul tidak boleh kosong, deadline wajib valid). |
| **Tombol Batal Edit**      | Tersedia tombol **"Batal"** untuk membatalkan mode edit dan mengosongkan form kembali ke mode tambah. |

#### D. DELETE — Hapus Tugas

| Aspek              | Detail                                                                                                |
| ------------------- | ----------------------------------------------------------------------------------------------------- |
| **Trigger**         | Pengguna menekan tombol **"Hapus"** pada baris tabel.                                                 |
| **Konfirmasi**      | Sistem menampilkan dialog konfirmasi: **"Apakah Anda yakin ingin menghapus tugas ini?"** dengan pilihan **"Ya, Hapus"** dan **"Batal"**. |
| **Sukses**          | Baris dihapus dari tabel `tasks`, tabel riwayat dan kartu KPI diperbarui otomatis.                    |

#### E. SEARCH & FILTER

| Aspek                | Detail                                                                                               |
| -------------------- | ---------------------------------------------------------------------------------------------------- |
| **Pencarian**        | Kotak pencarian (search box) memfilter data berdasarkan kata kunci pada kolom `judul` atau `deskripsi` secara real-time (client-side filter). |
| **Filter Status**    | Dropdown filter dengan opsi: **Semua**, **Pending**, **Completed**. Memfilter tabel berdasarkan kolom `status`. |

---

## 3. Spesifikasi Skema Data (Supabase PostgreSQL)

### Tabel: `tasks`

> Nama tabel dan nama kolom (field) 100% sesuai dengan Modul 2 SKPL.

| Nama Kolom   | Tipe Data PostgreSQL      | Constraint & Validasi                                                                               | Keterangan                          |
| ------------ | ------------------------- | ---------------------------------------------------------------------------------------------------- | ----------------------------------- |
| `id`         | `BIGINT` (PK)             | `PRIMARY KEY`, `GENERATED ALWAYS AS IDENTITY` — auto-increment, unik, tidak boleh null.              | Menyimpan seluruh daftar tugas pengguna. |
| `judul`      | `VARCHAR(150)`            | `NOT NULL`, `CHECK (char_length(trim(judul)) > 0)` — judul tidak boleh kosong atau hanya spasi.      | Judul tugas.                        |
| `deskripsi`  | `TEXT`                    | Nullable (boleh kosong). Default: `NULL`.                                                            | Deskripsi rinci tugas.              |
| `deadline`   | `DATE`                    | `NOT NULL` — tanggal batas penyelesaian wajib diisi.                                                 | Tanggal batas penyelesaian tugas.   |
| `status`     | `VARCHAR(10)`             | `NOT NULL`, `DEFAULT 'Pending'`, `CHECK (status IN ('Pending', 'Completed'))` — hanya 2 nilai valid. | Status pengerjaan tugas.            |
| `created_at` | `TIMESTAMPTZ`             | `NOT NULL`, `DEFAULT now()` — otomatis terisi saat data dibuat.                                      | Waktu pencatatan tugas (audit).     |

---

## 4. Kontrak Pengujian Black Box & Keamanan (Acuan Mutlak QA)

### 4.1 Skenario Pengujian Fungsional (dari Modul 5 SKPL)

| ID Test | Skenario Pengujian    | Input Data              | Hasil yang Diharapkan                                          | Status |
| ------- | --------------------- | ----------------------- | -------------------------------------------------------------- | ------ |
| TC-01   | Toggle Status Tugas   | Klik Checkbox Tugas     | Status berubah menjadi 'Completed' secara instan.              | PASS   |
| TC-02   | Form Judul Kosong     | Judul: ""               | Sistem menolak simpan & menampilkan peringatan.                | PASS   |

### 4.2 Skenario Pengujian Validasi Tambahan

| ID Test | Skenario Pengujian        | Input Data                  | Hasil yang Diharapkan                                                         | Status |
| ------- | ------------------------- | --------------------------- | ----------------------------------------------------------------------------- | ------ |
| TC-03   | Deadline Kosong           | Deadline: ""                | Sistem menolak simpan & menampilkan: **"Deadline harus diisi dengan tanggal yang valid."** | PASS   |
| TC-04   | Simpan Data Valid         | Judul: "Belajar JavaScript", Deadline: "2026-12-01" | Data berhasil tersimpan, muncul di tabel, KPI diperbarui.                     | PASS   |
| TC-05   | Hapus Tugas + Konfirmasi  | Klik "Hapus" → "Ya, Hapus" | Baris terhapus dari tabel dan database, KPI diperbarui.                       | PASS   |
| TC-06   | Toggle Status Balik       | Klik Checkbox Tugas (Completed) | Status berubah kembali menjadi 'Pending' secara instan.                      | PASS   |

### 4.3 Skenario Pengujian Keamanan

| ID Test | Skenario Pengujian                            | Input Data / Aksi                                    | Hasil yang Diharapkan                                                                     | Status |
| ------- | --------------------------------------------- | ---------------------------------------------------- | ----------------------------------------------------------------------------------------- | ------ |
| SEC-01  | Uji Anti-XSS pada input teks                 | Judul: `<img src=x onerror=alert(1)>`                | Payload TIDAK dieksekusi sebagai HTML/JS. Teks ditampilkan apa adanya sebagai teks biasa (escaped). Alert box TIDAK muncul. | PASS   |
| SEC-02  | Audit ketiadaan Secret Key di kode frontend   | Inspeksi seluruh file `.html` dan `.js` di frontend   | Tidak ditemukan string `SUPABASE_SERVICE_ROLE_KEY` atau `STITCH_API_KEY` dalam kode sumber. Hanya `SUPABASE_URL` dan `SUPABASE_ANON_KEY` yang digunakan. | PASS   |

---

*Dokumen ini merupakan acuan mutlak untuk pengembangan, desain UI, dan pengujian Aplikasi To-Do List.*
