<?php

header('access-control-allow-origin: *');
header("access-control-allow-headers: *");
header("access-control-allow-methods: *");

$method = $_SERVER['REQUEST_METHOD'];
if ($method === 'OPTIONS') {
    die();
}

$servername = "localhost";
$username = "root";
$password = "";
$dbname = "library";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
