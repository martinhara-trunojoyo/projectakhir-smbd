<div class="card card-info">
	<div class="card-header">
		<h3 class="card-title">
			<i class="fa fa-table"></i> Laporan KK</h3>
	</div>
	<!-- /.card-header -->
	<div class="card-body">
		<div class="table-responsive">
		<div>
    <a href="" class="btn btn-primary" onclick="cetakDiv()">
        <i class="fa fa-print"></i>  Cetak 
    </a>
</div>

			<br>
			<table id="example1" class="table table-bordered table-striped">
				<thead>
					<tr>
						<th>No</th>
						<th>Hubungan Keluarga</th>
						<th>Nama Penduduk</th>
						<th>NO KK</th>
                        <th>Kepala Keluarga</th>
                        <th>Desa</th>
                        <th>RT</th>
                        <th>RW</th>
					</tr>
				</thead>
				<tbody>

					<?php
              $no = 1;
              $sql = $koneksi->query("SELECT * FROM v_anggota_keluarga; ");
              while ($data= $sql->fetch_assoc()) {
            ?>

					<tr>
						<td>
							<?php echo $no++; ?>
						</td>
                        <td>
							<?php echo $data['hubungan']; ?>
						</td>
						<td>
							<?php echo $data['nama_penduduk']; ?>
						</td>
						<td>
							<?php echo $data['no_kk']; ?>
						</td>
						<td>
							<?php echo $data['kepala']; ?>
						</td>
                        <td>
							<?php echo $data['desa']; ?>
						</td>
                        <td>
							<?php echo $data['rt']; ?>
						</td>
                        <td>
							<?php echo $data['rw']; ?>
						</td>
						<!-- <td>
							<a href="?page=edit-pengguna&kode=<?php echo $data['id_pengguna']; ?>" title="Ubah"
							 class="btn btn-success btn-sm">
								<i class="fa fa-edit"></i>
							</a>
							<a href="?page=del-pengguna&kode=<?php echo $data['id_pengguna']; ?>" onclick="return confirm('Apakah anda yakin hapus data ini ?')"
							 title="Hapus" class="btn btn-danger btn-sm">
								<i class="fa fa-trash"></i>
								</>
						</td> -->
					</tr>

					<?php
              }
            ?>
				</tbody>
				</tfoot>
			</table>
		</div>
	</div>
	<script>
function cetakDiv() {
    window.print();
}
</script>

	<!-- /.card-body -->