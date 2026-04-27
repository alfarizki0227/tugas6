USE perpustakaan;

-- 1) STATISTIK BUKU

-- 1. Total buku seluruhnya
SELECT COUNT(*) AS total_buku
FROM buku
WHERE is_deleted = 0;
-- Penjelasan: Menghitung jumlah seluruh buku yang masih aktif di database (tidak terhapus).

--2. Total nilai inventaris (sum harga × stok)
SELECT SUM(harga * stok) AS total_nilai_inventaris
FROM buku
WHERE is_deleted = 0;
-- Penjelasan: Menghitung total nilai inventaris perpustakaan dari semua buku (harga dikali stok).

-- 3. Rata-rata harga buku
SELECT AVG(harga) AS rata_rata_harga
FROM buku
WHERE is_deleted = 0;
-- Penjelasan: Menghitung rata-rata harga semua buku yang tersedia.

-- 4. Buku termahal (judul dan harga)
SELECT judul, harga
FROM buku
WHERE is_deleted = 0
ORDER BY harga DESC
LIMIT 1;
-- Penjelasan: Menampilkan buku dengan harga paling mahal.

-- 5. Buku dengan stok terbanyak
SELECT judul, stok
FROM buku
WHERE is_deleted = 0
ORDER BY stok DESC
LIMIT 1;
-- Penjelasan: Menampilkan buku dengan jumlah stok paling banyak.

-- 2) FILTER DAN PENCARIAN

-- 1. Semua buku kategori Programming yang harga < 100.000
SELECT *
FROM buku
WHERE is_deleted = 0
  AND kategori = 'Programming'
  AND harga < 100000;
  -- Penjelasan: Menampilkan buku kategori Programming dengan harga di bawah 100.000.

-- 2. Buku yang judulnya mengandung kata "PHP" atau "MySQL"
SELECT *
FROM buku
WHERE is_deleted = 0
  AND (judul LIKE '%PHP%' OR judul LIKE '%MySQL%');
  -- Penjelasan: Mencari buku yang judulnya mengandung kata “PHP” atau “MySQL”.

-- 3. Buku yang terbit tahun 2024
SELECT *
FROM buku
WHERE is_deleted = 0
  AND tahun_terbit = 2024;
  -- Penjelasan: Menampilkan buku yang diterbitkan pada tahun 2024.

-- 4. Buku yang stoknya antara 5-10
SELECT *
FROM buku
WHERE is_deleted = 0
  AND stok BETWEEN 5 AND 10;
  -- Penjelasan: Menampilkan buku dengan jumlah stok antara 5 sampai 10.

-- 5. Buku yang pengarangnya "Budi Raharjo"
SELECT *
FROM buku
WHERE is_deleted = 0
  AND pengarang = 'Budi Raharjo';
  -- Penjelasan: Menampilkan buku yang ditulis oleh Budi Raharjo.

-- 3) GROUPING DAN AGREGASI

-- 1. Jumlah buku per kategori (dengan total stok per kategori)
SELECT
    kategori,
    COUNT(*) AS jumlah_buku,
    SUM(stok) AS total_stok
FROM buku
WHERE is_deleted = 0
GROUP BY kategori;
-- Penjelasan: Mengelompokkan buku berdasarkan kategori, lalu menghitung jumlah buku dan total stok tiap kategori.

-- 2. Rata-rata harga per kategori
SELECT
    kategori,
    AVG(harga) AS rata_rata_harga
FROM buku
WHERE is_deleted = 0
GROUP BY kategori;
-- Penjelasan: Menghitung rata-rata harga buku untuk setiap kategori.

-- 3. Kategori dengan total nilai inventaris terbesar
SELECT
    kategori,
    SUM(harga * stok) AS total_nilai_inventaris
FROM buku
WHERE is_deleted = 0
GROUP BY kategori
ORDER BY total_nilai_inventaris DESC
LIMIT 1;
-- Penjelasan: Menampilkan kategori dengan total nilai inventaris terbesar.

-- 4) UPDATE DATA

-- 1. Naikkan harga semua buku kategori Programming sebesar 5%
UPDATE buku
SET harga = harga * 1.05
WHERE is_deleted = 0
  AND kategori = 'Programming';
  -- Penjelasan: Menaikkan harga semua buku kategori Programming sebesar 5%.

-- 2. Tambah stok 10 untuk semua buku yang stoknya < 5
UPDATE buku
SET stok = stok + 10
WHERE is_deleted = 0
  AND stok < 5;
  -- Penjelasan: Menambahkan stok sebanyak 10 untuk buku yang stoknya kurang dari 5.

-- 5) Laporan Khusus

-- 1. Daftar buku yang perlu restocking (stok < 5)
SELECT *
FROM buku
WHERE is_deleted = 0
  AND stok < 5;
  -- Penjelasan: Menampilkan daftar buku yang stoknya kurang dari 5 (perlu restock).

-- 2. Top 5 buku termahal
SELECT judul, harga, kategori, pengarang
FROM buku
WHERE is_deleted = 0
ORDER BY harga DESC
LIMIT 5;
-- Penjelasan: Menampilkan 5 buku dengan harga paling tinggi.