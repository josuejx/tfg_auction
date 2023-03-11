<?php

/*
	execSelect($tabla, $claveValue=null, $claveKey="id")
	execDelete() 
	execInsert($datos)
*/	
	

	/* execSelect */
	function execSelect($tabla, $claveValue=null, $claveKey=null) {
		
		$fieldKey=$claveKey;
		if ($fieldKey==null) {
			$fieldKey=$GLOBALS['tablas'][$GLOBALS['params']['action']];
		}
		
		$results=array();

		// CREAR CONEXIÓN
		$conn = new mysqli($GLOBALS['servername'], $GLOBALS['username'], $GLOBALS['password'], $GLOBALS['dbname']);
		$conn->set_charset("utf8");
		
		// COMPROBAR CONEXIÓN
		if ($conn->connect_error) {
			die("ERROR en la conexión: " . $conn->connect_error);
		}

		$sql="";
		if ($claveValue!=null) {
			if ($fieldKey==$GLOBALS['tablas'][$GLOBALS['params']['action']]) {
				$sql = "SELECT * FROM ".$tabla." WHERE ".$fieldKey."='".$claveValue."'";
			} else {
				$sql = "SELECT * FROM ".$tabla." WHERE CONVERT(".$fieldKey.",CHAR) LIKE '%".$claveValue."%'";
			}
		} else {
			if ($claveKey!=null) { // Se debe indicar rango (desde-hasta)
				if ( (isset($_GET['desde'])) || (isset($_GET['hasta'])) ) {
					$condi="";
					if (isset($_GET['desde'])) {
						if ($condi!="") $condi.=" AND ";
						$condi.=" ".$fieldKey.">='".addslashes(trim($_GET['desde']))."' ";
					}
					if (isset($_GET['hasta'])) {
						if ($condi!="") $condi.=" AND ";
						$condi.=" ".$fieldKey."<='".addslashes(trim($_GET['hasta']))."' ";
					}
					$sql = "SELECT * FROM ".$tabla." WHERE ".$condi;
				} else {
					$_SESSION['sqlError']="Faltan los parémetros desde o hasta";
				}
			} else {
				$sql = "SELECT * FROM ".$tabla;
			}
		}
		//echo $sql;
		$_SESSION['sqlQuery']=$sql;
		if ($sql!="") {
			$result = $conn->query($sql);
			if (!$result) {
				$_SESSION['sqlError']=$conn->errno." - ".$conn->error;
			}
			if ($result!=null) {
				if ($result->num_rows > 0) {
					while($registro = $result->fetch_array()) {
						$campos=array();
						foreach ($registro as $campo => $valor) {
							if (!is_int($campo)) {
								$campos[$campo]=$valor;
							}
						}
						$results[]=$campos;
					}
				}
			}
		} else {
			$results=array();
		}
		
		$conn->close();
		return $results;
	}

	/* execExiste */
	function execExiste($tabla, $claveValue, $claveKey) {
		$results=array();

		// CREAR CONEXIÓN
		$conn = new mysqli($GLOBALS['servername'], $GLOBALS['username'], $GLOBALS['password'], $GLOBALS['dbname']);
		$conn->set_charset("utf8");
		
		// COMPROBAR CONEXIÓN
		if ($conn->connect_error) {
			die("ERROR en la conexión: " . $conn->connect_error);
		}

		$resultado=false;
		$sql = "SELECT * FROM ".$tabla." WHERE ".$claveKey."='".$claveValue."'";
		//echo $sql;
		$result = $conn->query($sql);
		if ($result!=null) {
			if ($result->num_rows > 0) {
				$resultado=true;
			}
		}
		$conn->close();
		return $resultado;
	}


	/* execCount */
	function execCount($tabla) {
		$results=array();

		// CREAR CONEXIÓN
		$conn = new mysqli($GLOBALS['servername'], $GLOBALS['username'], $GLOBALS['password'], $GLOBALS['dbname']);
		$conn->set_charset("utf8");
		
		// COMPROBAR CONEXIÓN
		if ($conn->connect_error) {
			die("ERROR en la conexión: " . $conn->connect_error);
		}

		$resultado=0;
		$sql = "SELECT COUNT(*) as total FROM ".$tabla;
		//echo $sql;
		$_SESSION['sqlQuery']=$sql;
		$result = $conn->query($sql);
		if (!$result) {
			$_SESSION['sqlError']=$conn->errno." - ".$conn->error;
		}
		if ($result!=null) {
			if ($result->num_rows > 0) {
				if ($registros=$result->fetch_array()) {
					$resultado=$registros['total'];
				}
			}
		}
		$conn->close();
		return $resultado;
	}

	/* execDelete */
	function execDelete($tabla, $claveValue=null) {
		global $params;
		
		$claveKey=$GLOBALS['tablas'][$GLOBALS['params']['action']];
		
		// CREAR CONEXIÓN
		$conn = new mysqli($GLOBALS['servername'], $GLOBALS['username'], $GLOBALS['password'], $GLOBALS['dbname']);
		$conn->set_charset("utf8");
		
		// COMPROBAR CONEXIÓN
		if ($conn->connect_error) {
			die("ERROR en la conexión: " . $conn->connect_error);
		}

		if ($claveValue!=null) {
			if (execExiste($tabla,$claveValue,$claveKey)) {
				$sql = "DELETE FROM ".$tabla." WHERE ".$claveKey."='".$claveValue."'";
				//echo $sql;
				$_SESSION['sqlQuery']=$sql;
				$result = $conn->query($sql);
				if (!$result) {
					$_SESSION['sqlError']=$conn->errno." - ".$conn->error;
				}
			} else {
				$result=false;
			}
		} else {
			$result=false;
		}

		$conn->close();
		
		return $result;
	}

	
	/* execInsert */
	function execInsert($tabla, $datos) {
		global $params;
		
		// CREAR CONEXIÓN
		$conn = new mysqli($GLOBALS['servername'], $GLOBALS['username'], $GLOBALS['password'], $GLOBALS['dbname']);
		$conn->set_charset("utf8");

		// COMPROBAR CONEXIÓN
		if ($conn->connect_error) {
			die("ERROR en la conexión: " . $conn->connect_error);
		}

		$sql = "INSERT INTO ".$tabla." (";
		$primero=true;
		foreach ($datos AS $key => $value) {
			if (!$primero) {
				$sql .= ",";
			} else {
				$primero=false;
			}
			$sql .= $key;
		}
		$sql .= ") VALUES (";
		$primero=true;
		foreach ($datos AS $key => $value) {
			if (!$primero) {
				$sql .= ",";
			} else {
				$primero=false;
			}
			$sql .= "'".$value."'";
		}
		$sql .= ")";

		//echo $sql;
		$_SESSION['sqlQuery']=$sql;
		
		
		// Control de la clave
		//if ( ($datos[$GLOBALS['tablas'][$tabla]]=="") || ($datos[$GLOBALS['tablas'][$tabla]]==0) ) {
		//	$_SESSION['sqlError']="ERROR: La clave es vacía o los datos no cumplen el formato";
		//	$result=false;
		//} else {
			$result = $conn->query($sql);
			if (!$result) {
				$_SESSION['sqlError']=$conn->errno." - ".$conn->error;
			}
		//}
		$conn->close();
		
		return $result;
	}


	/* execUpdate */
	function execUpdate($datos, $tabla, $claveValue=null) {
		global $params;
		
		$claveKey=$GLOBALS['tablas'][$GLOBALS['params']['action']];
		
		// CREAR CONEXIÓN
		$conn = new mysqli($GLOBALS['servername'], $GLOBALS['username'], $GLOBALS['password'], $GLOBALS['dbname']);
		$conn->set_charset("utf8");
		
		// COMPROBAR CONEXIÓN
		if ($conn->connect_error) {
			die("ERROR en la conexión: " . $conn->connect_error);
		}

		if ($claveValue!=null) {
			if (isset($datos[$claveKey])) {
				if ($claveValue==$datos[$claveKey]) {
					if (execExiste($tabla,$claveValue,$claveKey)) {
						$sql = "UPDATE ".$params['action']." SET ";
						$primero=true;
						foreach ($datos AS $key => $value) {
							if (!$primero) {
								$sql .= ",";
							} else {
								$primero=false;
							}
							$sql .= $key."='".$value."'";
						}
						$sql .= " WHERE ";
						$sql .= " ".$claveKey." = '".$claveValue."'";
						//echo $sql;
						$_SESSION['sqlQuery']=$sql;
						$result = $conn->query($sql);
						if (!$result) {
							$_SESSION['sqlError']=$conn->errno." - ".$conn->error;
						}
						if ($result) {
							$result=1; // Actualizado
						} else {
							$result=-2; // Error general
						}
					} else {
						$result=-3; // El registro no existe
					}
				} else {
					$result=-1; // Identificador de Registro no coincide con datos recibidos
				}
			} else {
				$result=-5; // Los datos no incluyen el identificador
			}
		} else {
			$result=-4; // Falta identificador en la URL
		}

		$conn->close();
		
		return $result;
	}
	
	
	function tablasBD() {
		// CREAR CONEXIÓN
		$conn = new mysqli($GLOBALS['servername'], $GLOBALS['username'], $GLOBALS['password'], $GLOBALS['dbname']);
		$conn->set_charset("utf8");
		
		// COMPROBAR CONEXIÓN
		if ($conn->connect_error) {
			die("ERROR en la conexión: " . $conn->connect_error);
		}

		
		$tablas=array();
		foreach ($GLOBALS['tablas'] as $key => $value) {
			$sql="DESCRIBE ".$key;
			$result = $conn->query($sql);
			if ($result!=null) {
				if ($result->num_rows > 0) {
					$tablas[$key]['clave']="";
					$tablas[$key]['campos']="";
					while($registro = $result->fetch_array()) {
						if ($registro['Key']=="PRI") {
							$tablas[$key]['clave'].=$registro['Field'];
						} else {
							$tablas[$key]['campos'].=$registro['Field']."<br>";
						}
					}
				}
			}
		}
		
		$conn->close();
		return $tablas;
	}
	
