# DESIGN SYSTEM & UI GUIDELINES

## Aplikasi To-Do List

---

> **Tujuan Dokumen:** Mendokumentasikan seluruh aturan visual dan interaksi yang WAJIB dipatuhi oleh AI Coding Assistant (di VS Code) saat membangun antarmuka Aplikasi To-Do List. Seluruh keputusan desain di bawah ini bersifat final dan tidak boleh diubah tanpa revisi dokumen ini.

---

## 1. Palet Warna Tailwind CSS

### 1.1 Warna Dasar Halaman

| Elemen                | Kelas Tailwind CSS                          | Keterangan                              |
| --------------------- | ------------------------------------------- | --------------------------------------- |
| Background Halaman    | `bg-slate-50`                               | Latar belakang utama seluruh halaman.   |
| Kartu / Panel         | `bg-white shadow-sm border border-slate-200 rounded-xl` | Semua kartu, form, dan panel tabel.     |
| Header Bar            | `bg-white border-b border-slate-200 shadow-sm` | Bar navigasi atas.                      |

### 1.2 Warna Aksen & Semantik

| Fungsi                 | Kelas Tailwind CSS (Utama)   | Kelas Tailwind CSS (Light/Badge)         | Penggunaan                                       |
| ---------------------- | ---------------------------- | ---------------------------------------- | ------------------------------------------------ |
| **Primer / Aksi Utama** | `bg-indigo-600`, `text-indigo-600` | `bg-indigo-50`, `text-indigo-700`       | Tombol Simpan, ikon Edit, focus ring input.      |
| **Sukses / Completed** | `bg-emerald-600`, `text-emerald-600` | `bg-emerald-100`, `text-emerald-700`   | Badge status "Completed", kartu Tugas Selesai, badge koneksi Supabase. |
| **Warning / Pending**  | `bg-amber-600`, `text-amber-600` | `bg-amber-100`, `text-amber-700`       | Badge status "Pending", kartu Tugas Pending.     |
| **Bahaya / Error**     | `bg-rose-600`, `text-rose-600`   | `bg-rose-50`, `text-rose-700`           | Tombol Hapus, alert error validasi, pesan gagal. |

### 1.3 Warna Teks

| Elemen                 | Kelas Tailwind CSS      | Keterangan                              |
| ---------------------- | ----------------------- | --------------------------------------- |
| Judul Utama (H1/H2)   | `text-slate-800`        | Teks heading utama.                     |
| Label Form             | `text-slate-700`        | Label di atas input field.              |
| Teks Sekunder          | `text-slate-500`        | Subtitle, keterangan, placeholder.      |
| Teks Tabel Header      | `text-slate-500`        | Header kolom tabel (uppercase, xs).     |
| Teks Footer            | `text-slate-400`        | Teks copyright footer.                 |

---

## 2. Tipografi & Hierarki

### 2.1 Font Family

```css
font-family: 'Inter', 'Plus Jakarta Sans', ui-sans-serif, system-ui, sans-serif;
```

- **Prioritas 1:** `Inter` — font sans-serif modern, sangat readable di layar.
- **Prioritas 2:** `Plus Jakarta Sans` — fallback dengan karakter serupa.
- **Fallback:** `ui-sans-serif, system-ui, sans-serif`.

### 2.2 Skala Tipografi

| Elemen                 | Kelas Tailwind CSS                          | Contoh                                  |
| ---------------------- | ------------------------------------------- | --------------------------------------- |
| Nama Aplikasi (Header) | `text-xl font-bold text-slate-800`          | "Aplikasi To-Do List"                   |
| Subtitle Header        | `text-sm text-slate-500`                    | "Sistem Manajemen Tugas Harian"         |
| Angka KPI Card         | `text-3xl font-bold`                        | "12", "5", "7"                          |
| Label KPI Card         | `text-sm text-slate-500`                    | "Total Tugas", "Tugas Pending"          |
| Judul Section          | `text-lg font-semibold text-slate-800`      | "Tambah Tugas Baru", "Daftar Tugas"    |
| Label Form             | `text-sm font-medium text-slate-700`        | "Judul Tugas", "Deadline"               |
| Teks Tabel Body        | `text-sm text-slate-700`                    | Isi baris data tabel.                   |
| Teks Tabel Header      | `text-xs font-medium text-slate-500 uppercase tracking-wider` | "NO", "JUDUL", "STATUS"     |

### 2.3 Format Angka, Mata Uang & Tanggal

| Tipe Data    | Locale   | Format & Contoh                                              |
| ------------ | -------- | ------------------------------------------------------------ |
| **Tanggal**  | `id-ID`  | `new Intl.DateTimeFormat('id-ID', { day: 'numeric', month: 'long', year: 'numeric' }).format(date)` → **"25 November 2026"** |
| **Angka**    | `id-ID`  | Angka bulat biasa tanpa format khusus (hanya counting). Contoh: **12**, **5**, **7**. |

---

## 3. Aturan Komponen Interaktif

### 3.1 Tombol (Buttons)

#### Tombol Primer — "Simpan"

```
Default:  bg-indigo-600 text-white font-medium py-2.5 px-5 rounded-lg shadow-sm
Hover:    hover:bg-indigo-700
Focus:    focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2
Disabled: disabled:opacity-50 disabled:cursor-not-allowed
```

#### Tombol Sekunder — "Batal"

```
Default:  bg-white border border-slate-300 text-slate-700 font-medium py-2.5 px-5 rounded-lg
Hover:    hover:bg-slate-50
```

#### Tombol Aksi Tabel — "Edit" & "Hapus"

```
Edit:     text-indigo-600 hover:text-indigo-800 hover:bg-indigo-50 rounded-lg p-1.5
Hapus:    text-rose-600 hover:text-rose-800 hover:bg-rose-50 rounded-lg p-1.5
```

### 3.2 Loading State (Tombol Simpan)

Saat proses simpan/update sedang berlangsung:

- Teks tombol berubah menjadi **"Menyimpan..."**.
- Tambahkan ikon spinner (animated SVG `animate-spin`) di sebelah kiri teks.
- Tombol dalam kondisi `disabled` (`disabled:opacity-50 disabled:cursor-not-allowed`).
- Spinner berhenti dan teks kembali ke **"Simpan"** setelah proses selesai.

### 3.3 Empty State (Tabel Kosong)

Saat tabel `tasks` tidak memiliki data (atau hasil filter kosong):

- Sembunyikan elemen `<table>`.
- Tampilkan sebuah `<div>` di area tabel dengan konten:
  - Ikon ilustrasi (clipboard atau inbox kosong) berwarna `text-slate-300` berukuran besar (w-16 h-16).
  - Teks utama: **"Belum ada tugas"** — `text-lg font-medium text-slate-500`.
  - Teks sub: **"Tambahkan tugas pertama Anda!"** — `text-sm text-slate-400`.
- Seluruh elemen di-center secara vertikal dan horizontal dengan `flex flex-col items-center justify-center py-12`.

### 3.4 Alert Error Banner (Validasi TC-01 / TC-02 Gagal)

Saat validasi input gagal (judul kosong, deadline kosong, dll):

```html
<!-- Struktur Alert Error -->
<div class="bg-rose-50 border border-rose-200 text-rose-700 rounded-lg p-3 text-sm flex items-start gap-2">
  <!-- Ikon Exclamation Circle -->
  <svg class="w-5 h-5 text-rose-500 flex-shrink-0 mt-0.5">...</svg>
  <!-- Pesan Error (gunakan .textContent, BUKAN .innerHTML) -->
  <span id="error-message">Judul tugas tidak boleh kosong.</span>
</div>
```

- Alert disembunyikan secara default (`hidden` class).
- Saat validasi gagal, hapus class `hidden` dan isi pesan error via `.textContent`.
- Saat pengguna mulai mengetik di form, sembunyikan kembali alert.

### 3.5 Badge Status Tugas

| Status      | Kelas Tailwind CSS                                                  |
| ----------- | ------------------------------------------------------------------- |
| `Pending`   | `bg-amber-100 text-amber-700 text-xs font-medium px-2.5 py-0.5 rounded-full`   |
| `Completed` | `bg-emerald-100 text-emerald-700 text-xs font-medium px-2.5 py-0.5 rounded-full` |

### 3.6 Dialog Konfirmasi Hapus

Saat pengguna menekan tombol **"Hapus"**:

- Tampilkan modal overlay (`fixed inset-0 bg-black/50 flex items-center justify-center z-50`).
- Modal card: `bg-white rounded-xl shadow-xl p-6 max-w-sm w-full mx-4`.
- Ikon peringatan: lingkaran `bg-rose-100` dengan ikon `text-rose-600` di tengah.
- Judul: **"Hapus Tugas?"** — `text-lg font-semibold text-slate-800`.
- Pesan: **"Apakah Anda yakin ingin menghapus tugas ini?"** — `text-sm text-slate-500`.
- Tombol: **"Ya, Hapus"** (bg-rose-600 text-white) dan **"Batal"** (bg-white border).

### 3.7 Transisi & Animasi

| Elemen              | Aturan                                                |
| ------------------- | ----------------------------------------------------- |
| Semua tombol        | `transition-colors duration-150`                      |
| Hover kartu         | `transition-shadow duration-200` (opsional)           |
| Badge koneksi       | Dot `animate-pulse` pada indikator hijau Supabase.    |
| Spinner loading     | `animate-spin` pada ikon loading tombol Simpan.       |

---

*Dokumen ini merupakan acuan visual wajib bagi AI Coding Assistant saat membangun UI Aplikasi To-Do List.*
