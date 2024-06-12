<?php

if(isset($_GET['kode'])){
    // Konfigurasi database
    $dsn = "mysql:host=localhost;dbname=data_penduduk2";
    $username = "root";
    $password = "";

    try {
        // Membuat koneksi PDO
        $conn = new PDO($dsn, $username, $password);
        $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

        // Menyiapkan query untuk mengambil data penduduk
        $sql_cek = "SELECT * FROM tb_pdd WHERE id_pend = :id_pend";
        $stmt = $conn->prepare($sql_cek);
        $stmt->bindParam(':id_pend', $_GET['kode']);
        $stmt->execute();
        $data_cek = $stmt->fetch(PDO::FETCH_ASSOC);

        if ($data_cek) {
            // Memanggil stored procedure untuk mengecek usia
            $sql_status = "CALL CheckUsiaPenduduk(:id_pend)";
            $stmt_status = $conn->prepare($sql_status);
            $stmt_status->bindParam(':id_pend', $_GET['kode']);
            $stmt_status->execute();
            $status_cek = $stmt_status->fetch(PDO::FETCH_ASSOC);

            // Tutup result set
            $stmt_status->closeCursor();

            // Memanggil stored procedure untuk menghitung umur
            $sql_umur = "CALL hitungumur(:id_pend)";
            $stmt_umur = $conn->prepare($sql_umur);
            $stmt_umur->bindParam(':id_pend', $_GET['kode']);
            $stmt_umur->execute();
            $umur_cek = $stmt_umur->fetch(PDO::FETCH_ASSOC);

            // Tutup result set
            $stmt_umur->closeCursor();

            // Memanggil stored procedure untuk memperbarui status pekerjaan berdasarkan usia
            $sql_update = "CALL updatestatuskerja(:retirement_age)";
            $stmt_update = $conn->prepare($sql_update);
            $retirement_age = 60; // Ubah sesuai kebutuhan Anda
            $stmt_update->bindParam(':retirement_age', $retirement_age, PDO::PARAM_INT);
            $stmt_update->execute();

            // Ambil data yang telah diperbarui
            $stmt->execute();
            $data_cek = $stmt->fetch(PDO::FETCH_ASSOC);

            // Memanggil stored procedure untuk menghitung umur
            $sql_umur = "SELECT TIMESTAMPDIFF(YEAR, tgl_lh, CURDATE()) AS umur FROM tb_pdd WHERE id_pend = :id_pend";
            $stmt_umur = $conn->prepare($sql_umur);
            $stmt_umur->bindParam(':id_pend', $_GET['kode']);
            $stmt_umur->execute();
            $umur_cek = $stmt_umur->fetch(PDO::FETCH_ASSOC);

            // Tutup result set
            $stmt_umur->closeCursor();
        } else {
            echo "<script>alert('Data tidak ditemukan'); window.location='index.php?page=data-pend';</script>";
            exit();
        }

    } catch (PDOException $e) {
        // Menampilkan pesan error jika terjadi kesalahan
        echo "<script>alert('Kesalahan koneksi database: ".$e->getMessage()."'); window.location='index.php?page=data-pend';</script>";
        exit();
    }

    // Menutup koneksi
    $conn = null;
}

?>

<div class="card card-success">
    <div class="card-header">
        <h3 class="card-title">
            <i class="fa fa-user"></i> Detail Penduduk
        </h3>
    </div>
    <div class="card-body p-0">
        <table class="table">
            <tbody>
                <tr>
                    <td style="width: 150px">
                        <b>NIK</b>
                    </td>
                    <td>:
                        <?php echo $data_cek['nik']; ?>
                    </td>
                </tr>
                <tr>
                    <td style="width: 150px">
                        <b>Nama</b>
                    </td>
                    <td>:
                        <?php echo $data_cek['nama']; ?>
                    </td>
                </tr>
                <tr>
                    <td style="width: 150px">
                        <b>TTL</b>
                    </td>
                    <td>:
                        <?php echo $data_cek['tempat_lh']; ?>
                        /
                        <?php echo $data_cek['tgl_lh']; ?>
                    </td>
                </tr>
                <tr>
                    <td style="width: 150px">
                        <b>Jenis Kelamin</b>
                    </td>
                    <td>:
                        <?php echo $data_cek['jekel']; ?>
                    </td>
                </tr>
                <tr>
                    <td style="width: 150px">
                        <b>Alamat</b>
                    </td>
                    <td>:
                        <?php echo $data_cek['desa']; ?>, RT
                        <?php echo $data_cek['rt']; ?>/ RW
                        <?php echo $data_cek['rw']; ?>
                    </td>
                </tr>
                <tr>
                    <td style="width: 150px">
                        <b>Agama</b>
                    </td>
                    <td>:
                        <?php echo $data_cek['agama']; ?>
                    </td>
                </tr>
                <tr>
                    <td style="width: 150px">
                        <b>Status Kawin</b>
                    </td>
                    <td>:
                        <?php echo $data_cek['kawin']; ?>
                    </td>
                </tr>
                <tr>
                    <td style="width: 150px">
                        <b>Pekerjaan</b>
                    </td>
                    <td>:
                        <?php echo $data_cek['pekerjaan']; ?>
                    </td>
                </tr>
				<tr>
                    <td style="width: 150px">
                        <b>Umur</b>
                    </td>
                    <td>:
                        <?php echo $umur_cek['umur']; ?> tahun
                    </td>
                </tr>
                <tr>
                    <td style="width: 150px">
                        <b>Status</b>
                    </td>
                    <td>:
                        <?php echo $status_cek['status']; ?>
                    </td>
                </tr>
            </tbody>
        </table>
        <div class="card-footer">
            <a href="?page=data-pend" class="btn btn-warning">Kembali</a>
        </div>
    </div>
</div>