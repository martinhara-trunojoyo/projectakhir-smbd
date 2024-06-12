<div class="card card-info">
	<div class="card-header">
		<h3 class="card-title">
			<i class="fa fa-table"></i> Laporan Penduduk Pindah</h3>
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
						<th>Tanggal Pindah</th>
						<th>Alasan</th>
						<th>Nama Penduduk</th>
                        
                        
					</tr>
				</thead>
				<tbody>

					<?php
              $no = 1;
              $sql = $koneksi->query("SELECT * FROM v_penduduk_pindah;

");
              while ($data= $sql->fetch_assoc()) {
            ?>

					<tr>
						<td>
							<?php echo $no++; ?>
						</td>
                        <td>
							<?php echo $data['tgl_pindah']; ?>
						</td>
						<td>
							<?php echo $data['alasan']; ?>
						</td>
						<td>
							<?php echo $data['nama_penduduk']; ?>
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
	<!-- /.card-body -->