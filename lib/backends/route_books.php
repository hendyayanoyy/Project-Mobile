<?php

use function PHPSTORM_META\map;

include 'books.php';
header('Content-Type: application/json');
$books = new Book();
function createBook() {
    $books = $GLOBALS['books'];
    if($_SERVER['REQUEST_METHOD'] == 'POST') {
        $books->title = $_POST['title'];
        $books->author = $_POST['author'];
        $books->description = $_POST['description'];
        $books->year = $_POST['year'];
        $books->rating = $_POST['rating'];

        if($_FILES['image']) {
            $image = $_FILES['image']['name'];
            $ext = pathinfo($image, PATHINFO_EXTENSION);
            $books->image = date('YmdHis').'-'.uniqid().'.'.$ext;
            $upload = move_uploaded_file($_FILES['image']['tmp_name'], $_SERVER['DOCUMENT_ROOT'].'/lib/assets/books/'.$books->image);

            if(!$upload) {
                echo json_encode([
                    'code' => 500,
                    'message' => 'Failed upload image',
                ]);

                header('status: 500');

                return;
            }
        }

        $create = $books->createBook();

        if($create) {
            echo json_encode([
                'data' => $create,
                'code' => 201,
                'message' => 'Success create data',
            ]);

            header('status: 201');

            return;
        }

        echo json_encode([
            'code' => 412,
            'message' => 'Failed create data',
        ]);

        header('status: 412');

        return;
    }

    return json_encode([
        'code' => 405,
        'message' => 'Method not allowed',
    ]);
}

function updateBook() {
    $books = $GLOBALS['books'];
    if($_SERVER['REQUEST_METHOD'] == 'POST') {

        $books->id = $_GET['id'];

        $detail = $books->detailBook();

        if(empty($detail)) {
            echo json_encode([
                'code' => 404,
                'message' => 'Data not found',
            ]);
            return;
        } else {
            $books->title = $detail['title'];
            $books->author = $detail['author'];
            $books->description = $detail['description'];
            $books->year = $detail['year'];
            $books->rating = $detail['rating'];
            $books->image = $detail['image'];
        }

        $books->title = $_POST['title'];
        $books->author = $_POST['author'];
        $books->description = $_POST['description'];
        $books->year = $_POST['year'];
        $books->rating = $_POST['rating'];

        if($_FILES['image']) {
            $image = $_FILES['image']['name'];
            $ext = pathinfo($image, PATHINFO_EXTENSION);
            $books->image = date('YmdHis').'-'.uniqid().'.'.$ext;
            $upload = move_uploaded_file($_FILES['image']['tmp_name'], $_SERVER['DOCUMENT_ROOT'].'/lib/assets/books/'.$books->image);

            if(!$upload) {
                echo json_encode([
                    'code' => 500,
                    'message' => 'Failed upload image',
                ]);

                header('status: 500');

                return;
            }
        }

        $update = $books->updateBook();

        if($update) {
            echo json_encode([
                'data' => $update,
                'code' => 201,
                'message' => 'Success create data',
            ]);

            header('status: 201');

            return;
        }

        echo json_encode([
            'code' => 412,
            'message' => 'Failed create data',
        ]);

        header('status: 412');

        return;
    }

    return json_encode([
        'code' => 405,
        'message' => 'Method not allowed',
    ]);
}

function deleteBook() {
    $books = $GLOBALS['books'];
    if($_SERVER['REQUEST_METHOD'] == 'DELETE') {
        $books->id = $_GET['id'];

        $detail = $books->detailBook();
        if(empty($detail)) {
            echo json_encode([
                'code' => 404,
                'message' => 'Data not found',
            ]);
            return;
        }

        $delete = $books->deleteBook();
        if($delete) {
            echo json_encode([
                'data' => $delete,
                'code' => 200,
                'message' => 'Success delete data',
            ]);

            header('status: 200');

            return;
        }

        echo json_encode([
            'code' => 412,
            'message' => 'Failed delete data',
        ]);

        header('status: 412');

        return;
    }
}

function getBooks() {
    $books = $GLOBALS['books'];
    if($_SERVER['REQUEST_METHOD'] == 'GET') {
        $list = $books->getBooks();

        if(empty($list)) {
            echo json_encode([
                'data' => [],
                'code' => 404,
                'message' => 'Not found',
            ]);

            header('status: 404');

            return;
        }

        echo json_encode([
            'data' => array_map(function($book) {
                $book['id'] = (int)$book['id'];
                $book['rating'] = (double)$book['rating'];
                $book['year'] = (int)$book['year'];

                if($book['image']) {
                    $book['image'] = 'lib/assets/books/'.$book['image'];
                }

                if($book['description']) {
                    $book['description'] = substr($book['description'], 0, 200).'...';
                }

                return $book;
            }, $list),
            'code' => 200,
            'message' => 'Success get data',
        ]);

        header('status: 200');

        return;
    }

    echo json_encode([
        'code' => 405,
        'message' => 'Method not allowed',
    ]);

    header('status: 405');

    return;
}

function topBooks() {
    $books = $GLOBALS['books'];
    if($_SERVER['REQUEST_METHOD'] == 'GET') {
        $list = $books->topBooks();

        if(empty($list)) {
            echo json_encode([
                'data' => [],
                'code' => 404,
                'message' => 'Not found',
            ]);

            header('status: 404');

            return;
        }

        echo json_encode([
            'data' => array_map(function($book) {
                $book['id'] = (int)$book['id'];
                $book['rating'] = (double)$book['rating'];
                $book['year'] = (int)$book['year'];

                if($book['image']) {
                    $book['image'] = 'lib/assets/books/'.$book['image'];
                }

                if($book['description']) {
                    $book['description'] = substr($book['description'], 0, 200).'...';
                }

                return $book;
            }, $list),
            'code' => 200,
            'message' => 'Success get data',
        ]);

        header('status: 200');

        return;
    }

    echo json_encode([
        'code' => 405,
        'message' => 'Method not allowed',
    ]);

    header('status: 405');

    return;
}

function newsBooks() {
    $books = $GLOBALS['books'];
    if($_SERVER['REQUEST_METHOD'] == 'GET') {
        $list = $books->newsBooks();

        if(empty($list)) {
            echo json_encode([
                'data' => [],
                'code' => 404,
                'message' => 'Not found',
            ]);

            header('status: 404');

            return;
        }

        echo json_encode([
            'data' => array_map(function($book) {
                $book['id'] = (int)$book['id'];
                $book['rating'] = (double)$book['rating'];
                $book['year'] = (int)$book['year'];

                if($book['image']) {
                    $book['image'] = 'lib/assets/books/'.$book['image'];
                }

                if($book['description']) {
                    $book['description'] = substr($book['description'], 0, 200).'...';
                }

                return $book;
            }, $list),
            'code' => 200,
            'message' => 'Success get data',
        ]);

        header('status: 200');

        return;
    }

    echo json_encode([
        'code' => 405,
        'message' => 'Method not allowed',
    ]);

    header('status: 405');

    return;
}

switch($_GET['action']) {
    case 'create':
        createBook();
        break;
    case 'update':
        updateBook();
        break;
    case 'delete':
        deleteBook();
        break;
    case 'read':
        getBooks();
        break;
    case 'top':
        topBooks();
        break;
    case 'new':
        newsBooks();
        break;
    default:
        echo json_encode([
            'code' => 404,
            'message' => 'Not found',
        ]);
        break;
}