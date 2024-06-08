<?php 

include 'config.php';

class Book {
    public int $id;
    public string $title;
    public string $author;
    public string $description;
    public string $image;
    public int $year;
    public float $rating;

    public function __construct() {
    }

    public function getBooks() {
        // Implementasi logika untuk mendapatkan semua buku

        $query = "SELECT * FROM books";

        $list_books = mysqli_query($GLOBALS['conn'], $query);
        $list_books = $list_books->fetch_all(MYSQLI_ASSOC);
        
        return $list_books;
    }
    public function createBook() {
        // Implementasi logika menambahkan buku ke database

        $query = "INSERT INTO books(id, title, author, description, image, year, rating) VALUES ('', '$this->title', '$this->author', '$this->description', '$this->image', $this->year, $this->rating)";
        $result = mysqli_query($GLOBALS['conn'], $query);

        if ($result) return true;

        return false;
    }

    public function updateBook() {
        // Implementasi logika mengupdate buku
        $query = "UPDATE books SET title = $this->title, author = $this->author, description = $this->description, image = $this->image, year = $this->year, rating = $this->rating WHERE id = $this->id";
        $result = mysqli_query($GLOBALS['conn'], $query);

        if ($result) {
            return json_encode([
                'code' => 200,
                'message' => 'Success Update Book'
            ]);
        }

        return json_encode([
            'code' => 412,
            'message' => 'Failed Update Book'
        ]);
    }

    public function deleteBook() {
        // Implementasi logika menghapus buku

        $query = "DELETE FROM books WHERE id = $this->id";
        $result = mysqli_query($GLOBALS['conn'], $query);

        if ($result) {
            return json_encode([
                'code' => 200,
                'message' => 'Success Delete Book'
            ]);
        }

        return json_encode([
            'code' => 412,
            'message' => 'Failed Delete Book'
        ]);
    }
}