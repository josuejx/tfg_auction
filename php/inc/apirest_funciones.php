<?php

/*
	mostrarParamsJSON()
	decodeQuery($query)
	mostrarDatos() 
	to_xml(SimpleXMLElement $object, array $data, string $etiqueta)	
	
	response($status,$status_message,$data)
*/	


    /* mostrarParams */
	function mostrarParamsJSON() {
		global $params;
		global $method;
		global $rawJSON;
		global $arrayDatos;
		
        header('Content-Type: application/json; charset=utf-8');                 
		echo '{';
		echo '"method":"'.$method.'",';
		echo "\n";
		echo '"params":{';
			$iniciado=false;
			foreach ($params as $key => $value) {
				if ($iniciado) {
					echo ',"';
					echo "\n";
				} else {
					$iniciado=true;
				}
				echo '"'.$key.'":"'.$value.'"';
			}
			echo "},";
			echo "\n";
		echo '"POST":{';
			$iniciado=false;
			foreach ($_POST as $key => $value) {
				if ($iniciado) {
					echo ',"';
					echo "\n";
				} else {
					$iniciado=true;
				}
				echo '"'.$key.'":"'.$value.'"';
			}
			echo "},";
			echo "\n";
		echo '"arrayDatos":{';
			$iniciado=false;
			foreach ($arrayDatos as $key => $value) {
				if ($iniciado) {
					echo ',"';
					echo "\n";
				} else {
					$iniciado=true;
				}
				echo '"'.$key.'":"'.$value.'"';
			}
			echo "},";
			echo "\n";			
		echo '"rawJSON":';
			if ($rawJSON=="") {
				echo "{}";
			} else {
				echo $rawJSON;
			}
		echo '}';
	}



		
		
	/* decodeQuery */
	function decodeQuery($query) {
		$arrayDecode=array();
		if ($query!="") {
			$arrayParams=explode("&",$query);
			for ($i=0;$i<count($arrayParams);$i++) {
				$par=explode("=",$arrayParams[$i]);
				$arrayDecode[$par[0]]=$par[1];
			}	
		}
		return $arrayDecode;
	}



	/* Mostrar manual de especificación */
	function mostrarManual() {

	}

	/* Mostrar fichero introducido en el segundo parámetro */
	function mostrarFichero() {
		$showError = false;

		global $params;
		$nombreFichero=$params["value"];
		$tipo="application/pdf";
		$primerCaracter = substr($nombreFichero, 0, 1);

		$ruta="../akventas/";
		if ($primerCaracter=="A") {
			$ruta=$ruta."albaranes/";
		} else if ($primerCaracter=="F") {
			$ruta=$ruta."facturas/";
		} else {
			$showError = true;
		}

		if (!$showError) {
			$nombreFichero=$ruta.$nombreFichero.".pdf";
			if (file_exists($nombreFichero)) {
				header('Content-Type: '.$tipo);
				header('Content-Disposition: inline; filename="'.$nombreFichero.'"');
				header('Content-Length: ' . filesize($nombreFichero));
				readfile($nombreFichero);
			} else {
				echo "Error: No se ha encontrado el fichero";
			}
		} else {
			echo "Error: No se ha encontrado el fichero";
		}
	}

	/* Mostrar datos de recepción */
	function mostrarDatos() {
		$intro="\n";
echo "<!DOCTYPE html>
<html>
	<head>
		<title>API Rest</title>
		<style>
			table {
				border:1px solid black;
				border-collapse:collapse;
				margin:0 auto;
				background-color:#dddddd;				
			}
			td {
				border:2px solid black;
				padding:10px;
			}
			h1 {
				text-align:center;
			}
			.col1 {
				font-weight:bold;
				background-color:orange;
			}
		</style>
	</head>".$intro;
	
		echo "	<body>".$intro;
		echo "		<h1>DATOS RECIBIDOS POR EL SERVICIO API REST</h1>";
		echo "		<table>".$intro;
		
		echo "			<tr>".$intro;
		echo "				<td class='col1'>METHOD</td>".$intro;
		echo "				<td>".$GLOBALS['method']."</td>".$intro;
		echo "			</tr>";
		
		echo "			<tr>".$intro;
		echo "				<td class='col1'>Content-Type</td>".$intro;
		echo "				<td>".$GLOBALS['contentType']."</td>".$intro;
		echo "			</tr>".$intro;
		
		echo "			<tr>".$intro;
		echo "				<td class='col1'>Accept</td>".$intro;
		echo "				<td>".$GLOBALS['accept']."</td>".$intro;
		echo "			</tr>".$intro;
		
	/*
		echo "<tr>";
		echo "<td>Params</td>".$intro;
		echo "<td>";
			echo "<pre>";
			print_r($GLOBALS['params']);
			echo "</pre>";
		echo "</td>";
		echo "</tr>";
	*/
		echo "			<tr>".$intro;
		echo "				<td class='col1'>_SESSION</td>".$intro;
		echo "				<td>".$intro;
		echo "SESSION ID: <b>".session_id()."</b>";
		echo "					<pre>".$intro;
		print_r($_SESSION).$intro;
		echo "					</pre>".$intro;
		echo "				</td>".$intro;
		echo "			</tr>".$intro;	
	
		echo "			<tr>".$intro;
		echo "				<td class='col1'>_GET</td>".$intro;
		echo "				<td>".$intro;
		echo "					<pre>".$intro;
		print_r($_GET).$intro;
		echo "					</pre>".$intro;
		echo "				</td>".$intro;
		echo "			</tr>".$intro;

		echo "			<tr>".$intro;
		echo "				<td class='col1'>_POST</td>".$intro;
		echo "				<td>".$intro;
		echo "					<pre>".$intro;
		print_r($_POST).$intro;
		echo "					</pre>".$intro;
		echo "				</td>".$intro;
		echo "			</tr>".$intro;
		
		echo "			<tr>".$intro;
		echo "				<td class='col1'>DATOS</td>".$intro;
		echo "				<td>".$intro;
		echo "					<pre>".$intro;
		print_r($GLOBALS['arrayDatos']).$intro;
		echo "					</pre>".$intro;
		echo "				</td>".$intro;
		echo "			</tr>".$intro;

		echo "		</table>".$intro;

		echo "	</body>".$intro;
		echo "</html>".$intro;

/*
		echo $linea.$intro;
		echo "_SERVER: ".$intro;
		echo "<pre>";
		print_r($_SERVER);
		echo "</pre>";
*/
	}
	
	
	
	
	function to_xml(SimpleXMLElement $object, array $data, string $etiqueta)	{   
		
		foreach ($data as $key => $value) {
			$new_object = $object->addChild($etiqueta);
			to_xml_registro($new_object, $value);
		}   
	}   	
	
	function to_xml_registro(SimpleXMLElement $object, $data)	{   
		
		foreach ($data as $key => $value) {
			if (is_array($value)) {
				$new_object = $object->addChild($key);
				to_xml($new_object, $value);
			} else {
				// if the key is an integer, it needs text with it to actually work.
				if (ctype_digit($key)) {
					$key = "key_$key";
				}

				$object->addChild($key, $value);
			}   
		}   
	}   
	
	
	/* ******************************* */
	function response($status,$status_message,$data)
	{
		/*
			$response['status']=$status;
			$response['status_message']=$status_message;
			$response['data']=$data;
		*/
		
		switch ($GLOBALS['accept']) {
			case "application/xml":
				http_response_code($status);

				header('Content-Type: application/xml; charset=utf-8');  
				header('Access-Control-Allow-Origin: *');
				//print_r($data);
				$xml = new SimpleXMLElement('<?xml version="1.0" encoding="UTF-8" standalone="yes"?><data/>');
				to_xml_registro($xml, $data);
				print $xml->asXML();
				break;
				
			case "application/json":
				http_response_code($status);

				header('Content-Type: application/json; charset=utf-8'); 
				header('Access-Control-Allow-Origin: *');
				//header("HTTP/1.1 ".$status." ".$status_message); // No siempre funciona, depende de la configuración de Apache
				$json_response = json_encode($data, JSON_PRETTY_PRINT); 
				echo $json_response;
				break;
			default:
				http_response_code($status);
				
				header('Content-Type:text/html; charset=utf-8');
				header('Access-Control-Allow-Origin: *');
				// header("HTTP/1.1 ".$status." ".$status_message); // No siempre funciona, depende de la configuración de Apache
				$intro="\n";
				
echo "<!DOCTYPE html>
<html>
	<head>
		<title>API Rest</title>
		<style>
			table {
				border:1px solid black;
				border-collapse:collapse;
				margin:0 auto;
				background-color:#dddddd;				
			}
			td {
				border:2px solid black;
				padding:10px;
			}
			h1 {
				text-align:center;
			}
			.col1 {
				font-weight:bold;
				background-color:orange;
			}
		</style>
	</head>".$intro;

					echo "	<body>".$intro;
					echo "		<h1>RESPUESTA DEL SERVICIO API REST</h1>";
					echo "		<table>".$intro;
					
					foreach ($data as $key => $value) {
						echo "			<tr>".$intro;
						echo "				<td class='col1'>".$key."</td>".$intro;
						echo "				<td>".$value."</td>".$intro;
						echo "			</tr>";
					}
					echo "		</table>".$intro;
					echo "	</body>".$intro;
					echo "</html>";
				
				break;
			
		}
	}
