-- ============================================================
-- SUPABASE SCHEMA SQL — Aplikasi To-Do List
-- ============================================================
-- Jalankan script ini di menu SQL Editor pada dashboard Supabase.
-- Script ini akan:
--   1. Membuat tabel `tasks` dengan constraint validasi.
--   2. Mengaktifkan Row Level Security (RLS).
--   3. Membuat policy CRUD untuk role `anon` (demo workshop).
--   4. Menyisipkan 3 data contoh (dummy data).
-- ============================================================

-- ============================================================
-- LANGKAH 1: Buat Tabel `tasks`
-- ============================================================
-- Nama tabel dan nama kolom 100% sesuai Modul 2 SKPL.
-- Constraint CHECK mengunci aturan validasi TC-01 di level database.

CREATE TABLE IF NOT EXISTS public.tasks (
    id          BIGINT          GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    judul       VARCHAR(150)    NOT NULL
                                CONSTRAINT chk_judul_not_empty
                                CHECK (char_length(trim(judul)) > 0),
    deskripsi   TEXT            DEFAULT NULL,
    deadline    DATE            NOT NULL,
    status      VARCHAR(10)     NOT NULL
                                DEFAULT 'Pending'
                                CONSTRAINT chk_status_valid
                                CHECK (status IN ('Pending', 'Completed')),
    created_at  TIMESTAMPTZ     NOT NULL
                                DEFAULT now()
);

-- Komentar tabel untuk dokumentasi
COMMENT ON TABLE  public.tasks              IS 'Menyimpan seluruh daftar tugas pengguna (SKPL Modul 2).';
COMMENT ON COLUMN public.tasks.id           IS 'Primary key auto-increment.';
COMMENT ON COLUMN public.tasks.judul        IS 'Judul tugas (wajib, maks 150 karakter, tidak boleh kosong).';
COMMENT ON COLUMN public.tasks.deskripsi    IS 'Deskripsi rinci tugas (opsional).';
COMMENT ON COLUMN public.tasks.deadline     IS 'Tanggal batas penyelesaian tugas (wajib).';
COMMENT ON COLUMN public.tasks.status       IS 'Status pengerjaan: Pending atau Completed.';
COMMENT ON COLUMN public.tasks.created_at   IS 'Timestamp pembuatan record.';


-- ============================================================
-- LANGKAH 2: Aktifkan Row Level Security (RLS)
-- ============================================================

ALTER TABLE public.tasks ENABLE ROW LEVEL SECURITY;


-- ============================================================
-- LANGKAH 3: Buat Policy Akses CRUD untuk Role `anon`
-- ============================================================
-- Policy ini mengizinkan akses penuh untuk role `anon`
-- (keperluan demo workshop). Constraint CHECK di tabel tetap
-- menjaga validasi data meskipun policy bersifat permisif.

-- Policy SELECT: Anon boleh membaca semua data.
CREATE POLICY "anon_select_tasks"
    ON public.tasks
    FOR SELECT
    TO anon
    USING (true);

-- Policy INSERT: Anon boleh menambah data.
-- WITH CHECK memastikan data yang masuk memenuhi aturan bisnis.
CREATE POLICY "anon_insert_tasks"
    ON public.tasks
    FOR INSERT
    TO anon
    WITH CHECK (
        char_length(trim(judul)) > 0
        AND deadline IS NOT NULL
        AND status IN ('Pending', 'Completed')
    );

-- Policy UPDATE: Anon boleh mengubah data.
-- WITH CHECK memastikan data hasil update tetap valid.
CREATE POLICY "anon_update_tasks"
    ON public.tasks
    FOR UPDATE
    TO anon
    USING (true)
    WITH CHECK (
        char_length(trim(judul)) > 0
        AND deadline IS NOT NULL
        AND status IN ('Pending', 'Completed')
    );

-- Policy DELETE: Anon boleh menghapus data.
CREATE POLICY "anon_delete_tasks"
    ON public.tasks
    FOR DELETE
    TO anon
    USING (true);


-- ============================================================
-- LANGKAH 4: Insert 3 Data Contoh (Dummy Data)
-- ============================================================
-- Data realistis agar aplikasi langsung memiliki tampilan data
-- saat pertama kali dijalankan.

INSERT INTO public.tasks (judul, deskripsi, deadline, status)
VALUES
    (
        'Mengerjakan Laporan Praktikum',
        'Menyelesaikan laporan praktikum Basis Data BAB 1-3, termasuk ERD dan normalisasi tabel.',
        '2026-11-25',
        'Pending'
    ),
    (
        'Belajar JavaScript ES6',
        'Mempelajari konsep arrow function, destructuring, async/await, dan fetch API.',
        '2026-11-20',
        'Completed'
    ),
    (
        'Presentasi Proyek Akhir',
        'Menyiapkan slide presentasi dan demo aplikasi untuk sidang proyek akhir semester.',
        '2026-12-01',
        'Pending'
    );


-- ============================================================
-- SELESAI!
-- ============================================================
-- Verifikasi dengan menjalankan:
--   SELECT * FROM public.tasks ORDER BY deadline ASC;
-- ============================================================
