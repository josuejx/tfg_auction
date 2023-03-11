<?php

$db_name = 'db5012211350.hosting-data.io';
$db_server = 'dbs10275340';
$db_user = 'dbu1695454';
$db_pass = 'JosueGarcia_0909';

$db = new PDO("mysql:host={$db_server};dbname={$db_name};charset=utf8", $db_user, $db_pass);
$db->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);
$db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
