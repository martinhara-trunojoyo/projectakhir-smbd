<?php
// Koneksi ke database
$host = 'localhost';
$username = 'root';
$password = '';
$database = 'data_penduduk2'; // Ganti dengan nama database Anda

// Membuat koneksi
$koneksi = new mysqli($host, $username, $password, $database);

// Memeriksa koneksi
if ($koneksi->connect_error) {
    die("Koneksi Gagal: " . $koneksi->connect_error);
}

// Memanggil stored procedure untuk memperbarui status umur
$sql = "CALL sp_update_status_umur()";
if ($koneksi->query($sql) === TRUE) {
    //echo "Status umur penduduk berhasil diperbarui.";
} else {
    echo "Error: " . $koneksi->error;
}

// Query untuk menampilkan data penduduk
$sql_data_penduduk = "SELECT p.id_pend, p.nik, p.nama, p.jekel, p.desa, p.rt, p.rw, a.id_kk, k.no_kk, k.kepala 
                      FROM tb_pdd p LEFT JOIN tb_anggota a ON p.id_pend=a.id_pend 
                      LEFT JOIN tb_kk k ON a.id_kk=k.id_kk";

$result = $koneksi->query($sql_data_penduduk);

?>

<div class="card card-info">
    <div class="card-header">
        <h3 class="card-title">
            <i class="fa fa-table"></i> Data Penduduk</h3>
    </div>
    <!-- /.card-header -->
    <div class="card-body">
        <div class="table-responsive">
            <div>
                <a href="?page=add-pend" class="btn btn-primary">
                    <i class="fa fa-edit"></i> Tambah Data</a>
            </div>
            <br>
            <table id="example1" class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>No</th>
                        <th>NIK</th>
                        <th>Nama</th>
                        <th>JK</th>
                        <th>Alamat</th>
                        <th>No KK</th>
                        <th>Aksi</th>
                    </tr>
                </thead>
                <tbody>

                    <?php
                    $no = 1;
                    if ($result->num_rows > 0) {
                        while ($data = $result->fetch_assoc()) {
                    ?>

                            <tr>
                                <td>
                                    <?php echo $no++; ?>
                                </td>
                                <td>
                                    <?php echo $data['nik']; ?>
                                </td>
                                <td>
                                    <?php echo $data['nama']; ?>
                                </td>
                                <td>
                                    <?php echo $data['jekel']; ?>
                                </td>
                                <td>
                                    <?php echo $data['desa']; ?>
                                    RT
                                    <?php echo $data['rt']; ?>/ RW
                                    <?php echo $data['rw']; ?>.
                                </td>
                                <td>
                                    <?php echo $data['no_kk']; ?>-
                                    <?php echo $data['kepala']; ?>
                                </td>

                                <td>
                                    <a href="?page=view-pend&kode=<?php echo $data['id_pend']; ?>" title="Detail" class="btn btn-info btn-sm">
                                        <i class="fa fa-user"></i>
                                    </a>
                                    <a href="?page=edit-pend&kode=<?php echo $data['id_pend']; ?>" title="Ubah" class="btn btn-success btn-sm">
                                        <i class="fa fa-edit"></i>
                                    </a>
                                    <a href="?page=del-pend&kode=<?php echo $data['id_pend']; ?>" onclick="return confirm('Apakah anda yakin hapus data ini ?')" title="Hapus" class="btn btn-danger btn-sm">
                                        <i class="fa fa-trash"></i>
                                    </a>
                                </td>
                            </tr>

                    <?php
                        }
                    } else {
                        echo "<tr><td colspan='7'>Tidak ada data</td></tr>";
                    }
                    ?>
                </tbody>
                <tfoot>
                </tfoot>
            </table>
        </div>
    </div>
    <!-- /.card-body -->
</div>

<?php
// Menutup koneksi
$koneksi->close();
?>
