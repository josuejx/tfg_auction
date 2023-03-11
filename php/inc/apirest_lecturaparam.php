<?php

    // ****************************************************************
	// Método: GET, POST, PUT, DELETE
	$method = $_SERVER['REQUEST_METHOD'];

    // ****************************************************************
    // QUERY: el resto de la URL que utilizamos como parámetros
	$query = "";
	if (isset($_SERVER['QUERY_STRING'])) {
		$query = $_SERVER['QUERY_STRING'];
	}
	
	//$params=decodeQuery($query);
	$params=$_GET;
	if (isset($params['action'])) {
		$accion=$params['action'];
	}

    // ****************************************************************
	// ACCEPT: El tipo de datos que acepta el cliente
	$accept = isset($_SERVER["HTTP_ACCEPT"]) ? trim($_SERVER["HTTP_ACCEPT"]) : '';


    // ****************************************************************
	// CONTENT_TYPE: El tipo de datos que envía el cliente
	$contentType = isset($_SERVER["CONTENT_TYPE"]) ? trim($_SERVER["CONTENT_TYPE"]) : '';


    // ****************************************************************
	// DATOS o CONTENIDO: Son los datos que envía el cliente utilizando "raw"
	$content = file_get_contents("php://input");

		$rawJSON="";
		$arrayDatos=array();
		// Obtener array de un JSON de entrada
		if (strcasecmp($contentType, 'application/json') == 0) {
			$rawJSON = json_encode(json_decode($content)); // para eliminar caracteres innecesarios
			$arrayDatos=json_decode($rawJSON, true); // el true es para Pretty
		}

		// Obtener array de un XML de entrada
		if (strcasecmp($contentType, 'application/xml') == 0) {
			$rawXML = $content; 
			$xml = simplexml_load_string($rawXML);
			$json = json_encode($xml);
			$arrayDatos = json_decode($json, true);
		}

	//mostrarParamsJSON();
