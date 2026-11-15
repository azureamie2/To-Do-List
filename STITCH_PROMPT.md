# UI/UX DESIGN PROMPT FOR GOOGLE STITCH

> **Instruksi:** Copy-paste prompt di bawah ini ke https://stitch.withgoogle.com/ untuk men-generate antarmuka web.

---

```
Design a modern, clean, and fully responsive single-page To-Do List web application interface using Tailwind CSS utility classes. The page background should be bg-slate-50 with a minimum height of 100vh. Use the Inter or Plus Jakarta Sans font family throughout.

=== HEADER BAR ===
At the top, create a full-width header bar with a bg-white border-b border-slate-200 shadow-sm. Inside the header, display:
- A bold application title "Aplikasi To-Do List" using text-xl font-bold text-slate-800.
- A subtitle underneath: "Sistem Manajemen Tugas Harian" using text-sm text-slate-500.
- On the right side of the header, place a small rounded badge showing "Supabase Connected" with a pulsing green dot indicator (bg-emerald-500 rounded-full animate-pulse) next to the text, styled with bg-emerald-50 text-emerald-700 text-xs font-medium px-3 py-1 rounded-full border border-emerald-200.

=== SUMMARY / KPI CARDS (3 Cards Row) ===
Below the header, add a section with 3 equally-spaced summary cards in a responsive grid (grid-cols-1 sm:grid-cols-3 gap-4). Each card has bg-white rounded-xl shadow-sm border border-slate-200 p-5. The 3 cards are:
1. Card 1 — "Total Tugas": Display a large bold number (e.g., "12") in text-3xl font-bold text-slate-800, with a label "Total Tugas" in text-sm text-slate-500. Add a clipboard-list icon in text-indigo-500 at the top-right corner of the card.
2. Card 2 — "Tugas Pending": Display a large bold number (e.g., "5") in text-3xl font-bold text-amber-600, with a label "Tugas Pending" in text-sm text-slate-500. Add a clock icon in text-amber-500 at the top-right corner.
3. Card 3 — "Tugas Selesai": Display a large bold number (e.g., "7") in text-3xl font-bold text-emerald-600, with a label "Tugas Selesai" in text-sm text-slate-500. Add a check-circle icon in text-emerald-500 at the top-right corner.

=== MAIN SPLIT LAYOUT (2 Responsive Columns) ===
Below the KPI cards, create a two-column responsive layout using grid-cols-1 lg:grid-cols-3 gap-6, where the left column takes lg:col-span-1 and the right column takes lg:col-span-2.

--- LEFT COLUMN: INPUT FORM & VALIDATION ---
Create a card with bg-white rounded-xl shadow-sm border border-slate-200 p-6. At the top, show a section title "Tambah Tugas Baru" in text-lg font-semibold text-slate-800 with a plus-circle icon.

Inside the card, include the following form fields stacked vertically with space-y-4:
1. "Judul Tugas" — A text input field with label text-sm font-medium text-slate-700, a rounded-lg border border-slate-300 focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 input, and placeholder "Masukkan judul tugas...". Max length 150 characters.
2. "Deskripsi" — A textarea with 3 rows, same styling as above, and placeholder "Deskripsi tugas (opsional)...".
3. "Deadline" — A date input field (type="date") with the same label and input styling.

Below the form fields, add:
- An Alert Error Box: a hidden-by-default div with bg-rose-50 border border-rose-200 text-rose-700 rounded-lg p-3 text-sm, with an exclamation-circle icon, designed to show validation error messages such as "Judul tugas tidak boleh kosong." or "Deadline harus diisi dengan tanggal yang valid." This box should be visible in the design as an example.
- A row of 2 buttons side by side:
  - Primary button "Simpan" with bg-indigo-600 hover:bg-indigo-700 text-white font-medium py-2.5 px-5 rounded-lg shadow-sm transition-colors, with a save/check icon.
  - Secondary button "Batal" with bg-white border border-slate-300 hover:bg-slate-50 text-slate-700 font-medium py-2.5 px-5 rounded-lg transition-colors, with an x icon.

--- RIGHT COLUMN: DATA TABLE, SEARCH & FILTER ---
Create a card with bg-white rounded-xl shadow-sm border border-slate-200 p-6. At the top, show a section title "Daftar Tugas" in text-lg font-semibold text-slate-800 with a list-bullet icon.

Below the title, add a toolbar row with two elements side by side:
1. A search input with a magnifying-glass icon inside, placeholder "Cari tugas...", styled with rounded-lg border border-slate-300 pl-10 focus:ring-2 focus:ring-indigo-500, taking flex-1 width.
2. A dropdown select for filtering status with options: "Semua Status", "Pending", "Completed", styled with rounded-lg border border-slate-300 bg-white text-slate-700 w-44.

Below the toolbar, create a responsive data table (overflow-x-auto) with:
- Table header: bg-slate-50 text-left text-xs font-medium text-slate-500 uppercase tracking-wider. Columns: "No", "Judul", "Deskripsi", "Deadline", "Status", "Aksi".
- Table body: Show 3-4 example rows with realistic Indonesian task data:
  - Row 1: "Mengerjakan Laporan Praktikum", truncated description, "25 November 2026", Status badge "Pending" with bg-amber-100 text-amber-700 text-xs font-medium px-2.5 py-0.5 rounded-full.
  - Row 2: "Belajar JavaScript ES6", truncated description, "20 November 2026", Status badge "Completed" with bg-emerald-100 text-emerald-700 text-xs font-medium px-2.5 py-0.5 rounded-full, with a line-through effect on the title.
  - Row 3: "Presentasi Proyek Akhir", truncated description, "01 Desember 2026", Status badge "Pending" with the amber styling.
- Each row has a checkbox on the left for toggling status.
- Each row has an "Aksi" column containing two small icon buttons:
  - Edit button: text-indigo-600 hover:text-indigo-800 hover:bg-indigo-50 rounded-lg p-1.5 with a pencil icon.
  - Hapus button: text-rose-600 hover:text-rose-800 hover:bg-rose-50 rounded-lg p-1.5 with a trash icon.
- Alternate row coloring with even:bg-slate-50 for readability.
- Table rows should have border-b border-slate-100 dividers.

=== FOOTER ===
At the very bottom, include a subtle footer with text-center text-xs text-slate-400 py-4 showing "© 2026 Aplikasi To-Do List — Workshop Pemrograman Web".

Make the entire layout visually polished, professional, and suitable for a university workshop project demo. Ensure all interactive elements look clickable with proper hover states and transitions. The design should feel modern, spacious, and easy to navigate.
```

---

*Copy-paste seluruh blok prompt di atas (di dalam codeblock) ke Google Stitch.*
