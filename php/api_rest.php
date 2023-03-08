<?php
    include('db_connect.php');

    header('Content-Type: application/json');
    header('Access-Control-Allow-Origin: *');

    echo "Hello World!";

    // Save the first parameter of the URL
    $table = $_GET['table'];

    echo $table;