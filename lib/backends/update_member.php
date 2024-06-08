<?php
// Pastikan hanya metode POST yang diperbolehkan
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Include koneksi ke database
    include 'config.php';

    // Tangkap data yang dikirimkan dari aplikasi Flutter
    $id = $_POST['id'];
    $name = $_POST['name'];
    $email = $_POST['email'];

    // Query SQL untuk melakukan update data anggota
    $sql = "UPDATE members SET name='$name', email='$email' WHERE id=$id";

    // Jalankan query
    if ($conn->query($sql) === TRUE) {
        // Jika query berhasil dijalankan
        echo "Data anggota berhasil diperbarui";
    } else {
        // Jika terjadi kesalahan saat menjalankan query
        echo "Gagal memperbarui data anggota: " . $conn->error;
    }

    // Tutup koneksi ke database
    $conn->close();
} else {
    // Jika metode HTTP bukan POST, kirim respon dengan kode status 405 (Method Not Allowed)
    http_response_code(405);
    echo "Metode HTTP tidak diizinkan";
}
