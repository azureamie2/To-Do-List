# AI CODING & SECURITY GUARDRAILS (RULES)

## Aplikasi To-Do List

---

> **Tujuan Dokumen:** Menetapkan aturan hukum wajib (mandatory rules) yang HARUS dipatuhi oleh AI Coding Assistant saat menulis kode untuk Aplikasi To-Do List. Pelanggaran terhadap aturan ini akan mengakibatkan kegagalan pengujian (test failure) dan/atau kerentanan keamanan.

---

## 1. Kepatuhan Skema & Spesifikasi

### RULE-01: Nama Tabel & Kolom WAJIB Identik dengan SKPL dan PRD

- **Nama Tabel:** `tasks` (huruf kecil, tanpa prefix).
- **Nama Kolom:** Gunakan nama kolom yang 100% identik dengan yang tertulis di Modul 2 SKPL dan Bagian 3 PRD.md:

| Kolom        | Tipe                | Catatan                                    |
| ------------ | ------------------- | ------------------------------------------ |
| `id`         | `BIGINT` (PK)       | Auto-generated identity.                   |
| `judul`      | `VARCHAR(150)`       | Wajib diisi, tidak boleh kosong.           |
| `deskripsi`  | `TEXT`               | Nullable.                                  |
| `deadline`   | `DATE`               | Wajib diisi.                               |
| `status`     | `VARCHAR(10)`        | Default `'Pending'`. Hanya `'Pending'` atau `'Completed'`. |
| `created_at` | `TIMESTAMPTZ`        | Default `now()`.                           |

- **DILARANG** menambah, menghapus, atau mengganti nama kolom tanpa revisi dokumen SKPL dan PRD.

### RULE-02: Pesan Error Validasi WAJIB Identik dengan PRD

Saat validasi gagal, kalimat pesan yang ditampilkan ke pengguna HARUS persis seperti yang tertulis di PRD.md:

| Kondisi Gagal              | Pesan Error yang WAJIB Ditampilkan                        |
| -------------------------- | --------------------------------------------------------- |
| Judul kosong / hanya spasi | `"Judul tugas tidak boleh kosong."`                       |
| Deadline kosong / invalid  | `"Deadline harus diisi dengan tanggal yang valid."`       |

- **DILARANG** mengubah, memparafrase, atau menerjemahkan kalimat pesan ini.

---

## 2. Aturan Mutlak Anti-XSS (`SEC-01`)

### RULE-03: DILARANG KERAS Menggunakan `.innerHTML` untuk Data Dinamis

Kode frontend **DILARANG KERAS** merender data yang berasal dari pengguna atau database ke dalam elemen HTML menggunakan metode berikut **tanpa sanitasi**:

```javascript
// ❌ DILARANG — Rentan XSS
element.innerHTML = userInput;
element.outerHTML = '<div>' + dbData + '</div>';
document.write(userData);
```

### RULE-04: WAJIB Menggunakan `.textContent` atau `escapeHtml()`

Semua teks dinamis (dari input pengguna atau query database) WAJIB dirender menggunakan **salah satu** dari dua metode aman berikut:

#### Metode 1 — `.textContent` (DIREKOMENDASIKAN)

```javascript
// ✅ AMAN — Browser otomatis meng-escape karakter berbahaya
const cell = document.createElement('td');
cell.textContent = task.judul; // XSS payload menjadi teks biasa
tableRow.appendChild(cell);
```

#### Metode 2 — Fungsi `escapeHtml()` (Jika Harus Pakai innerHTML)

```javascript
// ✅ AMAN — Sanitasi manual sebelum render
function escapeHtml(text) {
  const map = {
    '&': '&amp;',
    '<': '&lt;',
    '>': '&gt;',
    '"': '&quot;',
    "'": '&#039;'
  };
  return String(text).replace(/[&<>"']/g, function(m) { return map[m]; });
}

// Penggunaan:
element.innerHTML = `<td>${escapeHtml(task.judul)}</td>`;
```

### RULE-05: Fungsi `escapeHtml()` Wajib Mencakup 5 Karakter

Jika mengimplementasikan fungsi `escapeHtml()`, fungsi tersebut **WAJIB** mengubah minimal 5 karakter berikut menjadi entitas HTML:

| Karakter | Entitas HTML |
| -------- | ------------ |
| `&`      | `&amp;`      |
| `<`      | `&lt;`       |
| `>`      | `&gt;`       |
| `"`      | `&quot;`     |
| `'`      | `&#039;`     |

---

## 3. Aturan Mutlak Validasi Input (`TC-01` & `TC-02`)

### RULE-06: DILARANG Hanya Mengandalkan Validasi HTML

Validasi input **TIDAK BOLEH** hanya mengandalkan atribut HTML seperti `required`, `min`, `maxlength`, atau `type="date"`. Atribut-atribut ini mudah di-bypass oleh pengguna melalui Inspect Element / DevTools.

```html
<!-- ❌ TIDAK CUKUP — Bisa di-bypass via DevTools -->
<input type="text" required maxlength="150">
```

### RULE-07: WAJIB Validasi di JavaScript Sebelum Panggil API

Sebelum memanggil fungsi Supabase (`supabase.from('tasks').insert(...)` atau `.update(...)`), kode **WAJIB** menjalankan fungsi validasi JavaScript yang memeriksa:

```javascript
// ✅ WAJIB — Validasi logika di JavaScript
function validateForm(judul, deadline) {
  // Cek 1: Judul tidak boleh kosong atau hanya spasi
  if (!judul || judul.trim().length === 0) {
    showError("Judul tugas tidak boleh kosong.");
    return false;
  }

  // Cek 2: Deadline harus terisi dan merupakan tanggal valid
  if (!deadline || isNaN(new Date(deadline).getTime())) {
    showError("Deadline harus diisi dengan tanggal yang valid.");
    return false;
  }

  return true;
}

// Penggunaan di event handler:
async function handleSimpan() {
  const judul = document.getElementById('input-judul').value;
  const deadline = document.getElementById('input-deadline').value;

  if (!validateForm(judul, deadline)) {
    return; // ⛔ HENTIKAN proses, JANGAN panggil API Supabase
  }

  // ✅ Baru panggil Supabase setelah validasi lolos
  const { data, error } = await supabase
    .from('tasks')
    .insert([{ judul: judul.trim(), deskripsi, deadline, status: 'Pending' }]);
}
```

### RULE-08: Proses Simpan WAJIB Dihentikan Jika Validasi Gagal

Jika salah satu validasi `TC-01` atau `TC-02` gagal:

1. **HENTIKAN** eksekusi fungsi (`return`). Jangan lanjutkan ke panggilan API Supabase.
2. **TAMPILKAN** pesan error di Alert Error Banner (lihat `DESIGN.md` Bagian 3.4).
3. **JANGAN** menampilkan pesan error sebagai `alert()` atau `console.log()` saja — pesan WAJIB terlihat di layar pengguna di dalam komponen UI.

---

## 4. Aturan Keamanan Kredensial (`SEC-02`)

### RULE-09: Hanya `SUPABASE_URL` dan `SUPABASE_ANON_KEY` di Frontend

File `index.html` dan file JavaScript manapun yang dimuat di browser **HANYA BOLEH** mengandung dua kredensial berikut:

```javascript
// ✅ BOLEH — Public credentials untuk akses klien
const SUPABASE_URL = 'https://xxxxx.supabase.co';
const SUPABASE_ANON_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...';
```

### RULE-10: DILARANG KERAS Menyertakan Secret Key di Frontend

Kredensial berikut **DILARANG KERAS** ditulis di kode frontend manapun:

```javascript
// ❌ DILARANG KERAS — Secret credentials, JANGAN pernah ada di frontend
const SUPABASE_SERVICE_ROLE_KEY = '...';  // DILARANG
const STITCH_API_KEY = '...';             // DILARANG
```

- **Audit:** Lakukan pencarian teks (`Ctrl+F` / `grep`) pada seluruh file `.html` dan `.js` sebelum deploy untuk memastikan string `SERVICE_ROLE_KEY` dan `STITCH_API_KEY` tidak ada.

### RULE-11: Supabase Client Initialization

Inisialisasi Supabase client di frontend WAJIB menggunakan pola berikut:

```javascript
// ✅ Pola inisialisasi yang benar
const { createClient } = supabase;
const _supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY);
```

- Gunakan CDN resmi Supabase: `https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2`
- **JANGAN** meng-import `supabase-js` dari node_modules (karena ini aplikasi single-file HTML).

---

## 5. Aturan Umum Kualitas Kode

### RULE-12: Konsistensi Bahasa

- Semua teks yang tampil di UI (label, placeholder, pesan error, tombol) menggunakan **Bahasa Indonesia**.
- Semua variabel, fungsi, dan komentar kode menggunakan **Bahasa Inggris** atau **Bahasa Indonesia** secara konsisten (pilih salah satu, jangan campur).
- Nama kolom database menggunakan **Bahasa Indonesia** sesuai SKPL (contoh: `judul`, `deskripsi`, `deadline`, `status`).

### RULE-13: Single File Architecture

- Seluruh aplikasi dibangun dalam **1 file `index.html`** (HTML + CSS + JavaScript inline).
- CSS menggunakan Tailwind CSS via CDN.
- JavaScript Supabase client via CDN.
- **TIDAK ADA** file `.js` atau `.css` terpisah kecuali secara eksplisit diminta.

### RULE-14: Error Handling untuk Operasi Database

Setiap operasi Supabase (insert, select, update, delete) **WAJIB** memeriksa objek `error`:

```javascript
const { data, error } = await _supabase.from('tasks').select('*');

if (error) {
  console.error('Database error:', error.message);
  showError('Terjadi kesalahan saat mengambil data. Silakan coba lagi.');
  return;
}
```

---

*Dokumen ini bersifat mengikat. AI Coding Assistant WAJIB membaca dan mematuhi seluruh aturan di atas sebelum menulis baris kode pertama.*
