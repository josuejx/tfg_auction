<?php
	session_start();
	
	require_once "apirest_variables.php";
	require_once "inc/apirest_lecturaparam.php";
	
	require_once "inc/apirest_metodos.php";
	require_once "inc/apirest_funciones.php";
	require_once "inc/apirest_mysql.php";

	
	$tablasValidas=array();
	foreach ($tablas as $key => $value) {
		$tablasValidas[]=$key;
	}
	
	
	// ********************************************** 	
	// GESTIONAR CADA MÉTODO
	
	$mostrarData=false;
	$mostrarManual=false;
	$mostrarLogin=false;
	$mostrarImagen=false;
	if (isset($params['action'])) {
		if ($params['action']=='datos') {
			$mostrarData=true;
		}
		if ($params['action']=='login') {
			$mostrarLogin=true;
		}
		if ($params['action']=='image') {
			$mostrarImagen=true;
		}
		if ($params['action']=='') {
			$mostrarManual=true;
		}
	} else {
		$mostrarManual=true;
	}
	
	$txtIdent="";
	if (count($usuarios)>0) {

		// user
		if (isset($_GET['user'])) {
			header('Content-Type: application/json; charset=utf-8');

			if (isset($_SESSION['usuario'])) {
				echo '{';
				echo '  "mensaje":"Usuario actualmente identificado", '. "\n";
				echo '  "usuario":"'.$_SESSION['usuario'].'" '. "\n";
				echo '}';
			} else {
				echo '{';
				echo '  "mensaje":"", '. "\n";
				echo '  "usuario":"" '. "\n";
				echo '}';
			}
			$txtIdent="user";			
		}

		
		// logout
		if (isset($_GET['logout'])) {
			unset($_SESSION['usuario']);

			header('Content-Type: application/json; charset=utf-8');
			echo '{';
			echo '  "mensaje":"Logout correcto", '. "\n";
			echo '  "usuario":"" '. "\n";
			echo '}';
			$txtIdent="logout";			
		}
		
		// login
		$conectado=false;
		if ( (isset($_GET['usu'])) && (isset($_GET['pass'])) ) {
			$usu=addslashes(trim($_GET['usu']));
			$pass=addslashes(trim($_GET['pass']));
			
			if (isset($usuarios[$usu])) {
				if ($usuarios[$usu]==$pass) {
					$_SESSION['usuario']=$usu;
					$conectado=true;			
				} else {
					if (isset($_SESSION['usuario'])) {
						unset($_SESSION['usuario']);
					}
					$conectado=false;			
				}
			}
			
			header('Content-Type: application/json; charset=utf-8');
			if (!$conectado) {
				echo '{';
				echo '  "mensaje":"Error en identificación", '. "\n";
				echo '  "usuario":"" '. "\n";
				echo '}';
				$txtIdent="login";
				
			} else {
				echo '{';
				echo '  "mensaje":"Usuario identificado", '. "\n";
				echo '  "usuario":"'.$_SESSION['usuario'].'" '. "\n";
				echo '}';
				$txtIdent="login-error";
			}
		}
		
		if (isset($_SESSION['usuario'])) {
			$conectado=true;
		}
		
	} else {
		$conectado=true;
	}
		
	if ($txtIdent=="") {
		if ($conectado) {

			if ($mostrarData) {
				mostrarDatos();
			} 

			if ($mostrarLogin) {
				mostrarLogin();
			}

			if ($mostrarImagen) {
				mostrarImagen();
				return;
			}
			
			if ($mostrarManual) {
				require_once "inc/manual.php";
			} 


			if ( (!$mostrarData) && (!$mostrarManual) ) {
				switch ($method) {
					case 'GET': //consulta
						metodoGET();
						break;     
					case 'POST': //inserta
						if (count($_POST)>0) {
							metodoPOST($_POST);			
						} else {
							metodoPOST($arrayDatos);			
						}
						break;                
					case 'PUT': //actualiza
						metodoPUT($arrayDatos);
						break;      
					case 'DELETE': //elimina
						metodoDELETE();
						break;
					default: // Método NO soportado
						metodoNoSoportado();
						break;
				}		
			}
		} else {
			if ($mostrarData) {
				mostrarDatos();
			} else {
				require_once "inc/login.php";
			} 
		}
	}
	
	unset($_SESSION['sqlQuery']);
	unset($_SESSION['sqlError']);
