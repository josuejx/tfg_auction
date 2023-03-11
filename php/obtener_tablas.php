<?php 
    include 'db.php';

    try {
        /// Obtener nombres de las tablas de la base de datos y guardarlas en un array
        $sql = "SHOW TABLES";

        /// Execute the query PDO
        $result = $db->query($sql);

        /// Fetch the results as a string array
        $tables = array();

        if ($result->rowCount() > 0) {
            while ($row = $result->fetch(PDO::FETCH_NUM)) {
                $tables[] = $row[0];
            }
        }

        /// Delete all the elements of the array that do not contain the string 'akVentas_'
        $tables = array_filter($tables, function($var) {
            return preg_match("/akVentas_/", $var);
        });

        /// Prepare json
        $json = array();

        foreach ($tables as $table) {
            $json[] = array(
                'table' => $table
            );
        }

        /// Print json
        echo json_encode($json);

    } catch (Exception $e) {
        echo 'Excepción capturada: ',  $e->getMessage(), "\n";
    }