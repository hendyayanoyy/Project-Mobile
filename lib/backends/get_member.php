<?php
include 'config.php';

$sql = "SELECT * FROM members";
$result = $conn->query($sql);

if ($result) {
    if ($result->num_rows > 0) {
        $members = array();
        while ($row = $result->fetch_assoc()) {
            $row['id'] = (int)$row['id'];
            $members[] = $row;
        }
        header('Content-Type: application/json');
        echo json_encode($members);
    } else {
        header('Content-Type: application/json');
        echo json_encode(array('message' => 'No results found'));
    }
} else {
    header('Content-Type: application/json');
    echo json_encode(array('error' => 'Query failed'));
}

$conn->close();
