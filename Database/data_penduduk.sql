CREATE DATABASE IF NOT EXISTS data_penduduk2;
USE data_penduduk2;

-- Table structure for table tb_anggota
CREATE TABLE IF NOT EXISTS tb_anggota (
  id_anggota INT(11) NOT NULL AUTO_INCREMENT,
  id_kk INT(11) NOT NULL,
  id_pend INT(11) NOT NULL,
  hubungan VARCHAR(15) NOT NULL,
  PRIMARY KEY (id_anggota),
  KEY tb_anggota_ibfk_1 (id_pend),
  KEY id_kk (id_kk),
  CONSTRAINT tb_anggota_ibfk_1 FOREIGN KEY (id_pend) REFERENCES tb_pdd (id_pend) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT tb_anggota_ibfk_2 FOREIGN KEY (id_kk) REFERENCES tb_kk (id_kk) ON DELETE CASCADE ON UPDATE CASCADE
);
-- Table structure for table tb_datangselect * from tb_anggota

CREATE TABLE IF NOT EXISTS tb_datang (
  id_datang INT(11) NOT NULL AUTO_INCREMENT,
  nik VARCHAR(20) NOT NULL,
  nama_datang VARCHAR(20) NOT NULL,
  jekel ENUM('LK','PR') NOT NULL,
  tgl_datang DATE NOT NULL,
  pelapor INT(11) NOT NULL,
  PRIMARY KEY (id_datang),
  KEY pelapor (pelapor),
  CONSTRAINT tb_datang_ibfk_1 FOREIGN KEY (pelapor) REFERENCES tb_pdd (id_pend) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Table structure for table tb_kk
CREATE TABLE IF NOT EXISTS tb_kk (
  id_kk INT(11) NOT NULL AUTO_INCREMENT,
  no_kk VARCHAR(30) NOT NULL,
  kepala VARCHAR(20) NOT NULL,
  desa VARCHAR(20) NOT NULL,
  rt VARCHAR(5) NOT NULL,
  rw VARCHAR(5) NOT NULL,
  kec VARCHAR(20) NOT NULL,
  kab VARCHAR(20) NOT NULL,
  prov VARCHAR(20) NOT NULL,
  PRIMARY KEY (id_kk)
);

-- Table structure for table tb_lahir
CREATE TABLE IF NOT EXISTS tb_lahir (
  id_lahir INT(11) NOT NULL AUTO_INCREMENT,
  nama VARCHAR(30) NOT NULL,
  tgl_lh DATE NOT NULL,
  jekel ENUM('LK','PR') NOT NULL,
  id_kk INT(11) NOT NULL,
  PRIMARY KEY (id_lahir),
  KEY id_kk (id_kk),
  CONSTRAINT tb_lahir_ibfk_1 FOREIGN KEY (id_kk) REFERENCES tb_kk (id_kk) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Table structure for table tb_mendu
CREATE TABLE IF NOT EXISTS tb_mendu (
  id_mendu INT(11) NOT NULL AUTO_INCREMENT,
  id_pdd INT(11) NOT NULL,
  tgl_mendu DATE NOT NULL,
  sebab VARCHAR(20) NOT NULL,
  PRIMARY KEY (id_mendu),
  KEY id_pdd (id_pdd),
  CONSTRAINT tb_mendu_ibfk_1 FOREIGN KEY (id_pdd) REFERENCES tb_pdd (id_pend) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Table structure for table tb_pdd
CREATE TABLE IF NOT EXISTS tb_pdd (
  id_pend INT(11) NOT NULL AUTO_INCREMENT,
  nik VARCHAR(20) NOT NULL,
  nama VARCHAR(20) NOT NULL,
  tempat_lh VARCHAR(15) NOT NULL,
  tgl_lh DATE NOT NULL,
  jekel ENUM('LK','PR') NOT NULL,
  desa VARCHAR(15) NOT NULL,
  rt VARCHAR(4) NOT NULL,
  rw VARCHAR(4) NOT NULL,
  agama VARCHAR(15) NOT NULL,
  kawin VARCHAR(15) NOT NULL,
  pekerjaan VARCHAR(30) NOT NULL,
  STATUS ENUM('Ada','Meninggal','Pindah') NOT NULL,
  PRIMARY KEY (id_pend)
);

-- Table structure for table tb_pengguna
CREATE TABLE IF NOT EXISTS tb_pengguna (
  id_pengguna INT(11) NOT NULL AUTO_INCREMENT,
  nama_pengguna VARCHAR(20) NOT NULL,
  username VARCHAR(20) NOT NULL,
  PASSWORD VARCHAR(20) NOT NULL,
  LEVEL ENUM('Administrator','Kaur Pemerintah') NOT NULL,
  PRIMARY KEY (id_pengguna)
);

-- Table structure for table tb_pindah
CREATE TABLE IF NOT EXISTS tb_pindah (
  id_pindah INT(11) NOT NULL AUTO_INCREMENT,
  id_pdd INT(11) NOT NULL,
  tgl_pindah DATE NOT NULL,
  alasan VARCHAR(50) NOT NULL,
  PRIMARY KEY (id_pindah),
  KEY id_pdd (id_pdd),
  CONSTRAINT tb_pindah_ibfk_1 FOREIGN KEY (id_pdd) REFERENCES tb_pdd (id_pend) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS log_activity (
    id_log INT(11) NOT NULL AUTO_INCREMENT,
    TABLE_NAME VARCHAR(50) NOT NULL,
    ACTION VARCHAR(50) NOT NULL,
    action_time DATETIME NOT NULL,
    details TEXT NOT NULL,
    PRIMARY KEY (id_log)
);

SELECT * FROM log_activity;



-- Insert data into tb_pdd
INSERT INTO tb_pdd (nik, nama, tempat_lh, tgl_lh, jekel, desa, rt, rw, agama, kawin, pekerjaan, STATUS)
VALUES
('1234567890123456', 'Budi Santoso', 'Jakarta', '1975-04-23', 'LK', 'Desa Mekar', '01', '02', 'Islam', 'Kawin', 'Petani', 'Ada'),
('1234567890123457', 'Siti Aminah', 'Bandung', '1980-06-15', 'PR', 'Desa Mekar', '01', '02', 'Islam', 'Kawin', 'Ibu Rumah Tangga', 'Ada'),
('1234567890123458', 'Agus Salim', 'Surabaya', '1992-12-30', 'LK', 'Desa Sukamaju', '03', '04', 'Kristen', 'Belum Kawin', 'Guru', 'Ada'),
('1234567890123459', 'Dewi Lestari', 'Yogyakarta', '1985-11-10', 'PR', 'Desa Sukamaju', '03', '04', 'Hindu', 'Kawin', 'Dokter', 'Ada');

-- Insert data into tb_kk
INSERT INTO tb_kk (no_kk, kepala, desa, rt, rw, kec, kab, prov)
VALUES
('12345678901234567890', 'Budi Santoso', 'Desa Mekar', '01', '02', 'Kec Mekarsari', 'Kab Indah', 'Prov Jaya'),
('12345678901234567891', 'Agus Salim', 'Desa Sukamaju', '03', '04', 'Kec Sukamakmur', 'Kab Damai', 'Prov Sentosa');

-- Insert data into tb_anggota
INSERT INTO tb_anggota (id_kk, id_pend, hubungan)
VALUES
(1, 1, 'Kepala Keluarga'),
(1, 2, 'Istri'),
(2, 3, 'Kepala Keluarga'),
(2, 4, 'Istri');

-- Insert data into tb_datang
INSERT INTO tb_datang (nik, nama_datang, jekel, tgl_datang, pelapor)
VALUES
('1234567890123460', 'Rahmat Hidayat', 'LK', '2023-05-01', 1),
('1234567890123461', 'Sri Wahyuni', 'PR', '2023-06-15', 3);

-- Insert data into tb_lahir
INSERT INTO tb_lahir (nama, tgl_lh, jekel, id_kk)
VALUES
('Adi Nugroho', '2023-01-01', 'LK', 1),
('Tina Sari', '2022-12-25', 'PR', 2);

-- Insert data into tb_mendu
INSERT INTO tb_mendu (id_pdd, tgl_mendu, sebab)
VALUES
(1, '2023-07-20', 'Sakit'),
(4, '2022-11-05', 'Kecelakaan');

-- Insert data into tb_pengguna
INSERT INTO tb_pengguna (nama_pengguna, username, PASSWORD, LEVEL)
VALUES
('Admin', 'admin', 'admin123', 'Administrator'),
('Kaur Desa', 'kaurdesa', 'desa123', 'Kaur Pemerintah');

-- Insert data into tb_pindah
INSERT INTO tb_pindah (id_pdd, tgl_pindah, alasan)
VALUES
(2, '2023-08-10', 'Pindah Kerja'),
(3, '2023-09-15', 'Menikah');


-- View untuk menampilkan data lengkap anggota keluarga beserta informasi kartu keluarga
CREATE VIEW v_anggota_keluarga AS
SELECT a.id_anggota, a.id_kk, a.id_pend, a.hubungan, p.nama AS nama_penduduk, k.no_kk, k.kepala, k.desa, k.rt, k.rw
FROM tb_anggota a
JOIN tb_pdd p ON a.id_pend = p.id_pend
JOIN tb_kk k ON a.id_kk = k.id_kk;

SELECT * FROM v_anggota_keluarga;

-- View untuk menampilkan data lengkap penduduk yang datang beserta informasi pelapor:
CREATE VIEW v_penduduk_datang AS
SELECT d.id_datang, d.nik, d.nama_datang, d.jekel, d.tgl_datang, p.nama AS pelapor
FROM tb_datang d
JOIN tb_pdd p ON d.pelapor = p.id_pend;
SELECT * FROM v_penduduk_datang;

-- View untuk menampilkan data lengkap penduduk yang lahir beserta informasi kartu keluarga
CREATE VIEW v_penduduk_lahir AS
SELECT l.id_lahir, l.nama, l.tgl_lh, l.jekel, k.no_kk, k.kepala, k.desa, k.rt, k.rw
FROM tb_lahir l
JOIN tb_kk k ON l.id_kk = k.id_kk;

-- View untuk menampilkan data lengkap penduduk yang pindah beserta informasi alasan pindah
CREATE VIEW v_penduduk_pindah AS
SELECT p.id_pindah, p.id_pdd, p.tgl_pindah, p.alasan, d.nama AS nama_penduduk
FROM tb_pindah p
JOIN tb_pdd d ON p.id_pdd = d.id_pend;

-- View untuk menampilkan data lengkap penduduk yang memiliki catatan mendampingi informasi sebabnya
CREATE VIEW v_penduduk_mendampingi AS
SELECT m.id_mendu, m.id_pdd, m.tgl_mendu, m.sebab, d.nama AS nama_penduduk
FROM tb_mendu m
JOIN tb_pdd d ON m.id_pdd = d.id_pend;



-- start of SP


-- Stored Procedure untuk Menambahkan Data Penduduk Baru
DELIMITER $$

CREATE PROCEDURE AddPendudukBaru(
    IN p_nik VARCHAR(20),
    IN p_nama VARCHAR(20),
    IN p_tempat_lh VARCHAR(15),
    IN p_tgl_lh DATE,
    IN p_jekel ENUM('LK', 'PR'),
    IN p_desa VARCHAR(15),
    IN p_rt VARCHAR(4),
    IN p_rw VARCHAR(4),
    IN p_agama VARCHAR(15),
    IN p_kawin VARCHAR(15),
    IN p_pekerjaan VARCHAR(30)
)
BEGIN
    INSERT INTO tb_pdd (nik, nama, tempat_lh, tgl_lh, jekel, desa, rt, rw, agama, kawin, pekerjaan, STATUS)
    VALUES (p_nik, p_nama, p_tempat_lh, p_tgl_lh, p_jekel, p_desa, p_rt, p_rw, p_agama, p_kawin, p_pekerjaan, 'Ada');
END $$

DELIMITER ;

-- Untuk memberikan peringatan usia jika sudah lebih dari 80 tahun masih hidup apa engga (saat melihat detail penduduk)
DELIMITER $$

CREATE OR REPLACE PROCEDURE CheckUsiaPenduduk(
    IN p_id_pend INT
)
BEGIN
    DECLARE v_status VARCHAR(15);
    DECLARE v_tgl_lh DATE;
    DECLARE v_usia INT;
    
    -- Ambil tanggal lahir dan status penduduk
    SELECT tgl_lh, STATUS INTO v_tgl_lh, v_status
    FROM tb_pdd
    WHERE id_pend = p_id_pend;

    -- Hitung usia penduduk
    SET v_usia = TIMESTAMPDIFF(YEAR, v_tgl_lh, CURDATE());

    -- Perbarui status dengan peringatan jika usia lebih dari 80 tahun
    IF v_usia > 80 AND v_status = 'Ada' THEN
        SET v_status = CONCAT(v_status, ' (Diragukan)');
    END IF;

    -- Kembalikan hasil
    SELECT v_status AS STATUS;
END $$

DELIMITER ;

-- SP Menghitung Umur penduduk
DELIMITER $$

CREATE PROCEDURE hitungumur(
    IN p_id_pend INT
)
BEGIN
    DECLARE v_tgl_lh DATE;
    DECLARE v_umur INT;
    
    -- Ambil tanggal lahir
    SELECT tgl_lh INTO v_tgl_lh
    FROM tb_pdd
    WHERE id_pend = p_id_pend;

    -- Hitung umur penduduk
    SET v_umur = TIMESTAMPDIFF(YEAR, v_tgl_lh, CURDATE());

    -- Tampilkan umur penduduk
    SELECT v_umur AS umur;
END $$

DELIMITER ;

-- sp biasa
DELIMITER //

CREATE OR REPLACE PROCEDURE sp_simpan_data_kk(
    IN p_no_kk VARCHAR(30),
    IN p_kepala VARCHAR(20),
    IN p_desa VARCHAR(20),
    IN p_rt VARCHAR(5),
    IN p_rw VARCHAR(5),
    IN p_kec VARCHAR(20),
    IN p_kab VARCHAR(20),
    IN p_prov VARCHAR(20)
)
BEGIN
    INSERT INTO tb_kk (no_kk, kepala, desa, rt, rw, kec, kab, prov) 
    VALUES (p_no_kk, p_kepala, p_desa, p_rt, p_rw, p_kec, p_kab, p_prov);
END //

DELIMITER ;

-- looping and branching procedure
DELIMITER //

CREATE OR REPLACE PROCEDURE sp_update_status_umur()
BEGIN
    DECLARE done BOOLEAN DEFAULT FALSE;
    DECLARE id_pend_temp INT;
    DECLARE umur INT;
    DECLARE tgl_lahir DATE;
    DECLARE tgl_sekarang DATE;
    DECLARE tgl_kematian DATE;

    -- Cursor untuk mengambil setiap entri penduduk
    DECLARE cur CURSOR FOR 
        SELECT id_pend, tgl_lh FROM tb_pdd;

    -- Handle ketika tidak ada data di tabel
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Buka cursor
    OPEN cur;

    -- Loop untuk memproses setiap entri penduduk
    read_loop: LOOP
        -- Ambil data dari cursor
        FETCH cur INTO id_pend_temp, tgl_lahir;
        
        -- Keluar dari loop jika sudah selesai
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        -- Hitung umur
        SET tgl_sekarang = CURDATE();
        SET umur = TIMESTAMPDIFF(YEAR, tgl_lahir, tgl_sekarang);

        -- Jika umur lebih dari 100 tahun dan status masih ada, ubah status menjadi "Meninggal"
        IF umur >= 100 THEN
            UPDATE tb_pdd SET STATUS = 'Meninggal' WHERE id_pend = id_pend_temp;
        END IF;

    END LOOP;

    -- Tutup cursor
    CLOSE cur;
END //

DELIMITER ;

-- sp branching pk
DELIMITER //

CREATE PROCEDURE updatestatuskerja(
    IN p_retirement_age INT
)
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE v_id_pend INT;
    DECLARE v_tgl_lh DATE;
    DECLARE v_age INT;

    -- Cursor to select id and birth date of all penduduk
    DECLARE cur CURSOR FOR 
        SELECT id_pend, tgl_lh
        FROM tb_pdd;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO v_id_pend, v_tgl_lh;

        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Calculate age
        SET v_age = TIMESTAMPDIFF(YEAR, v_tgl_lh, CURDATE());

        -- Update job status based on age
        IF v_age >= p_retirement_age THEN
            UPDATE tb_pdd
            SET pekerjaan = 'Pensiun/Tidak Bekerja'
            WHERE id_pend = v_id_pend;
        END IF;

    END LOOP;

    CLOSE cur;
    END //
    
    DELIMITER;



-- end of SP
-- Trigger untuk Mengecek Duplikasi NIK pada Insert di tb_pdd
DELIMITER //

CREATE TRIGGER ceknikduplikat
BEFORE INSERT ON tb_pdd
FOR EACH ROW
BEGIN
    DECLARE v_count INT;
    
    -- Cek duplikasi NIK
    SELECT COUNT(*) INTO v_count FROM tb_pdd WHERE nik = NEW.nik;
    
    IF v_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'NIK sudah ada';
    END IF;
END //

DELIMITER ;

-- Trigger untuk Mengupdate Status di tb_pdd setelah Insert di tb_mendu
DELIMITER //

CREATE TRIGGER after_insert_tb_mendu_updateStats
AFTER INSERT ON tb_mendu
FOR EACH ROW
BEGIN
    UPDATE tb_pdd
    SET STATUS = 'Meninggal'
    WHERE id_pend = NEW.id_pdd;
END //

DELIMITER ;

-- Trigger untuk Mengecek dan Memperbarui Status di tb_pdd saat Penduduk Pindah
DELIMITER //

CREATE TRIGGER after_insert_tb_pindah
AFTER INSERT ON tb_pindah
FOR EACH ROW
BEGIN
    UPDATE tb_pdd
    SET STATUS = 'Pindah'
    WHERE id_pend = NEW.id_pdd;
END //

DELIMITER ;

-- trigger log activity delete 
DELIMITER //

CREATE TRIGGER after_delete_tb_pdd
AFTER DELETE ON tb_pdd
FOR EACH ROW
BEGIN
    INSERT INTO log_activity (TABLE_NAME, ACTION, action_time, details)
    VALUES ('tb_pdd', 'DELETE', NOW(), CONCAT('Data dengan ID ', OLD.id_pend, ' dihapus.'));
END //

CREATE TRIGGER after_delete_tb_anggota
AFTER DELETE ON tb_anggota
FOR EACH ROW
BEGIN
    INSERT INTO log_activity (TABLE_NAME, ACTION, action_time, details)
    VALUES ('tb_anggota', 'DELETE', NOW(), CONCAT('Data dengan ID ', OLD.id_anggota, ' dihapus.'));
END //

CREATE TRIGGER after_delete_tb_datang
AFTER DELETE ON tb_datang
FOR EACH ROW
BEGIN
    INSERT INTO log_activity (TABLE_NAME, ACTION, action_time, details)
    VALUES ('tb_datang', 'DELETE', NOW(), CONCAT('Data dengan ID ', OLD.id_datang, ' dihapus.'));
END //

CREATE TRIGGER after_delete_tb_lahir
AFTER DELETE ON tb_lahir
FOR EACH ROW
BEGIN
    INSERT INTO log_activity (TABLE_NAME, ACTION, action_time, details)
    VALUES ('tb_lahir', 'DELETE', NOW(), CONCAT('Data dengan ID ', OLD.id_lahir, ' dihapus.'));
END //

CREATE TRIGGER after_delete_tb_mendu
AFTER DELETE ON tb_mendu
FOR EACH ROW
BEGIN
    INSERT INTO log_activity (TABLE_NAME, ACTION, action_time, details)
    VALUES ('tb_mendu', 'DELETE', NOW(), CONCAT('Data dengan ID ', OLD.id_mendu, ' dihapus.'));
END //

CREATE TRIGGER after_delete_tb_pindah
AFTER DELETE ON tb_pindah
FOR EACH ROW
BEGIN
    INSERT INTO log_activity (TABLE_NAME, ACTION, action_time, details)
    VALUES ('tb_pindah', 'DELETE', NOW(), CONCAT('Data dengan ID ', OLD.id_pindah, ' dihapus.'));
END //

CREATE TRIGGER after_delete_tb_kk
AFTER DELETE ON tb_kk
FOR EACH ROW
BEGIN
    INSERT INTO log_activity (TABLE_NAME, ACTION, action_time, details)
    VALUES ('tb_kk', 'DELETE', NOW(), CONCAT('Data dengan ID ', OLD.id_kk, ' dihapus.'));
END //

DELIMITER ;

-- Update 
DELIMITER //

CREATE TRIGGER after_update_tb_pdd
AFTER UPDATE ON tb_pdd
FOR EACH ROW
BEGIN
    INSERT INTO log_activity (TABLE_NAME, ACTION, action_time, details)
    VALUES ('tb_pdd', 'UPDATE', NOW(), CONCAT('Data dengan ID ', OLD.id_pend, ' diubah.'));
END //

CREATE TRIGGER after_update_tb_anggota
AFTER UPDATE ON tb_anggota
FOR EACH ROW
BEGIN
    INSERT INTO log_activity (TABLE_NAME, ACTION, action_time, details)
    VALUES ('tb_anggota', 'UPDATE', NOW(), CONCAT('Data dengan ID ', OLD.id_anggota, ' diubah.'));
END //

CREATE TRIGGER after_update_tb_datang
AFTER UPDATE ON tb_datang
FOR EACH ROW
BEGIN
    INSERT INTO log_activity (TABLE_NAME, ACTION, action_time, details)
    VALUES ('tb_datang', 'UPDATE', NOW(), CONCAT('Data dengan ID ', OLD.id_datang, ' diubah.'));
END //

CREATE TRIGGER after_update_tb_lahir
AFTER UPDATE ON tb_lahir
FOR EACH ROW
BEGIN
    INSERT INTO log_activity (TABLE_NAME, ACTION, action_time, details)
    VALUES ('tb_lahir', 'UPDATE', NOW(), CONCAT('Data dengan ID ', OLD.id_lahir, ' diubah.'));
END //

CREATE TRIGGER after_update_tb_mendu
AFTER UPDATE ON tb_mendu
FOR EACH ROW
BEGIN
    INSERT INTO log_activity (TABLE_NAME, ACTION, action_time, details)
    VALUES ('tb_mendu', 'UPDATE', NOW(), CONCAT('Data dengan ID ', OLD.id_mendu, ' diubah.'));
END //

CREATE TRIGGER after_update_tb_pindah
AFTER UPDATE ON tb_pindah
FOR EACH ROW
BEGIN
    INSERT INTO log_activity (TABLE_NAME, ACTION, action_time, details)
    VALUES ('tb_pindah', 'UPDATE', NOW(), CONCAT('Data dengan ID ', OLD.id_pindah, ' diubah.'));
END //

CREATE TRIGGER after_update_tb_kk
AFTER UPDATE ON tb_kk
FOR EACH ROW
BEGIN
    INSERT INTO log_activity (TABLE_NAME, ACTION, action_time, details)
    VALUES ('tb_kk', 'UPDATE', NOW(), CONCAT('Data dengan ID ', OLD.id_kk, ' diubah.'));
END //

DELIMITER ;

-- insert
DELIMITER //

CREATE TRIGGER after_insert_tb_pdd
AFTER INSERT ON tb_pdd
FOR EACH ROW
BEGIN
    INSERT INTO log_activity (TABLE_NAME, ACTION, action_time, details)
    VALUES ('tb_pdd', 'INSERT', NOW(), CONCAT('Data dengan ID ', NEW.id_pend, ' berhasil ditambahkan.'));
END //

CREATE TRIGGER after_insert_tb_anggota
AFTER INSERT ON tb_anggota
FOR EACH ROW
BEGIN
    INSERT INTO log_activity (TABLE_NAME, ACTION, action_time, details)
    VALUES ('tb_anggota', 'INSERT', NOW(), CONCAT('Data dengan ID ', NEW.id_anggota, ' berhasil ditambahkan.'));
END //

CREATE TRIGGER after_insert_tb_datang
AFTER INSERT ON tb_datang
FOR EACH ROW
BEGIN
    INSERT INTO log_activity (TABLE_NAME, ACTION, action_time, details)
    VALUES ('tb_datang', 'INSERT', NOW(), CONCAT('Data dengan ID ', NEW.id_datang, ' berhasil ditambahkan.'));
END //

CREATE TRIGGER after_insert_tb_lahir
AFTER INSERT ON tb_lahir
FOR EACH ROW
BEGIN
    INSERT INTO log_activity (TABLE_NAME, ACTION, action_time, details)
    VALUES ('tb_lahir', 'INSERT', NOW(), CONCAT('Data dengan ID ', NEW.id_lahir, ' berhasil ditambahkan.'));
END //

CREATE TRIGGER after_insert_tb_mendu
AFTER INSERT ON tb_mendu
FOR EACH ROW
BEGIN
    INSERT INTO log_activity (TABLE_NAME, ACTION, action_time, details)
    VALUES ('tb_mendu', 'INSERT', NOW(), CONCAT('Data dengan ID ', NEW.id_mendu, ' berhasil ditambahkan.'));
END //

DELIMITER //
CREATE TRIGGER after_insert_tb_pindah2
AFTER INSERT ON tb_pindah
FOR EACH ROW
BEGIN
    INSERT INTO log_activity (TABLE_NAME, ACTION, action_time, details)
    VALUES ('tb_pindah', 'INSERT', NOW(), CONCAT('Data dengan ID ', NEW.id_pindah, ' berhasil ditambahkan.'));
END //

DELIMITER ;

CREATE TRIGGER after_insert_tb_kk
AFTER INSERT ON tb_kk
FOR EACH ROW
BEGIN
    INSERT INTO log_activity (TABLE_NAME, ACTION, action_time, details)
    VALUES ('tb_kk', 'INSERT', NOW(), CONCAT('Data dengan ID ', NEW.id_kk, ' berhasil ditambahkan.'));
END //

DELIMITER ;

