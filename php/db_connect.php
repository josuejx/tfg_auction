<?php
  $host_name = 'db5012211350.hosting-data.io';
  $database = 'dbs10275340';
  $user_name = 'dbu1695454';
  $password = 'JosueGarcia_0909';

  $link = new mysqli($host_name, $user_name, $password, $database);

  if ($link->connect_error) {
    die('<p>Error al conectar con servidor MySQL: '. $link->connect_error .'</p>');
  } else {
    echo '<p>Se ha establecido la conexión al servidor MySQL con éxito.</p>';
  }
?>