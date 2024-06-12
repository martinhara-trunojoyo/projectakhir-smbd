<?php
// Buat koneksi ke database
$host = 'localhost';
$username = 'root';
$password = '';
$database = 'data_penduduk2';

$koneksi = new mysqli($host, $username, $password, $database);

// Periksa koneksi
if ($koneksi->connect_error) {
    die("Koneksi database gagal: " . $koneksi->connect_error);
}

// Panggil stored procedure
$koneksi->query("CALL sp5()");

// Ambil data log_activity setelah dipanggil stored procedure
$query = "SELECT * FROM log_activity";
$result = $koneksi->query($query);

// Tampilkan data dalam tabel HTML
echo '<div class="card card-info">';
echo '<div class="card-header">';
echo '<h3 class="card-title"><i class="fa fa-table"></i> Aktivitas</h3>';
echo '</div>';
echo '<div class="card-body">';
echo '<div class="table-responsive">';
echo '<table id="example1" class="table table-bordered table-striped">';
echo '<thead>';
echo '<tr>';
echo '<th>No</th>';
echo '<th>Table Name</th>';
echo '<th>Action</th>';
echo '<th>Action Time</th>';
echo '<th>Details</th>';
echo '</tr>';
echo '</thead>';
echo '<tbody>';

$no = 1;
while ($data = $result->fetch_assoc()) {
    echo '<tr>';
    echo '<td>' . $no++ . '</td>';
    echo '<td>' . $data['TABLE_NAME'] . '</td>';
    echo '<td>' . $data['ACTION'] . '</td>';
    echo '<td>' . $data['action_time'] . '</td>';
    echo '<td>' . $data['details'] . '</td>';
    echo '</tr>';
}

echo '</tbody>';
echo '</table>';
echo '</div>';
echo '</div>';
echo '</div>';

// Tutup koneksi
$koneksi->close();
?>
