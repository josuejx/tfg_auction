<?php


/* ********************************************************************************** */
/* ********************************************************************************** */

/* MÉTODOS */


/* ***************************** */
	function metodoGET() {
		global $params;
		
		if (isset($params['action'])) {
			if ( ($params['action']=="datos") || (in_array($params['action'], $GLOBALS['tablasValidas']))) {
				switch ($params['action']) {
					case 'manual':
						mostrarManual();
						break;
					case 'datos':
						mostrarDatos();
						break;
					default:
						if (isset($params['value'])) {
							if ($params['value']=="count") {
								$datos=array();
								$datos['tabla']=$params['action'];
								$datos['total_registros']=execCount($params['action']);
							} else {
								if (isset($params['field'])) {
								  $datos=execSelect($params['action'],$params['value'],$params['field']);
								} else {
								  $datos=execSelect($params['action'],$params['value']);
								}
							}
						} else {
							if (isset($params['field'])) {
								$datos=execSelect($params['action'],null,$params['field']);
							} else {
								$datos=execSelect($params['action']);
							}
						}
						
						if (!isset($_SESSION['sqlError'])) {
							if (count($datos)>0) {
								if ($GLOBALS['accept']=="application/xml") {
									header('Content-Type: application/xml; charset=utf-8');  
									header('Access-Control-Allow-Origin: *');
									http_response_code(200);
									$xml = new SimpleXMLElement('<?xml version="1.0" encoding="UTF-8" standalone="yes"?><data/>');
									to_xml($xml, $datos, $params['action']);
									print $xml->asXML();						
								} else {
									header('Content-Type: application/json; charset=utf-8');     
									header('Access-Control-Allow-Origin: *');
									http_response_code(200);
									echo json_encode($datos, JSON_NUMERIC_CHECK + JSON_PRETTY_PRINT);
								}
							} else {
								$data=array();
								$data['respuesta']=404;
								$data['metodo']=$GLOBALS['method'];
								$data['tabla']=$params['action'];
								$data['mensaje']="Consulta SQL sin resultados";
								if (isset($_SESSION['sqlQuery'])) $data['sqlQuery']=$_SESSION['sqlQuery'];
								response($data['respuesta'], "Consulta SQL sin resultados", $data);							
							}
						} else {
							$data=array();
							$data['respuesta']=400;
							$data['metodo']=$GLOBALS['method'];
							$data['tabla']=$params['action'];
							$data['mensaje']="Error en el SQL";
							if (isset($_SESSION['sqlQuery'])) $data['sqlQuery']=$_SESSION['sqlQuery'];
							if (isset($_SESSION['sqlError'])) $data['sqlError']=$_SESSION['sqlError'];
							response($data['respuesta'], "Error en el SQL", $data);							
						}
						break;
				}
			} else {
				$data=array();
				$data['respuesta']=400;
				$data['metodo']=$GLOBALS['method'];
				$data['tabla']=$params['action'];
				$data['mensaje']="Tabla ".$params['action']." no aceptada o no existe";
				response($data['respuesta'], "Acción/Tabla no aceptada o no existe", $data);
			}
		} else {
			$data['respuesta']=501; // No hay acción -> Algo no está bien instalado
			$data['metodo']=$GLOBALS['method'];
			$data['mensaje']="Acción no definida";			
			response($data['respuesta'], $data['mensaje'], $data);
		}
	}
	
	
	
/* ***************************** */
	function metodoPOST($datos) {
		global $params;	
		
		if (isset($params['action'])) {
			if (in_array($params['action'], $GLOBALS['tablasValidas'])) {
				if (execInsert($params['action'], $datos)) {
					$data=array();
					$data['respuesta']=201;
					$data['metodo']=$GLOBALS['method'];
					$data['tabla']=$params['action'];
					$data['mensaje']="Registro insertado";
					if (isset($_SESSION['sqlQuery'])) $data['sqlQuery']=$_SESSION['sqlQuery'];
					response($data['respuesta'], $data['mensaje'], $data);			
				} else {
					$data=array();
					$data['respuesta']=400;
					$data['metodo']=$GLOBALS['method'];
					$data['tabla']=$params['action'];
					$data['mensaje']="Error al insertar";
					if (isset($_SESSION['sqlQuery'])) $data['sqlQuery']=$_SESSION['sqlQuery'];
					if (isset($_SESSION['sqlError'])) $data['sqlError']=$_SESSION['sqlError'];
					response($data['respuesta'], $data['mensaje'], $data);			
				}
			} else {
				$data=array();
				$data['respuesta']=400;
				$data['metodo']=$GLOBALS['method'];
				$data['tabla']=$params['action'];
				$data['mensaje']="Tabla ".$params['action']." no aceptada o no existe";
				response($data['respuesta'], "Acción no aceptada o no existe", $data);
			}
		} else {
			$data['respuesta']=501;
			$data['metodo']=$GLOBALS['method'];
			$data['mensaje']="Acción no definida";			
			response($data['respuesta'], $data['mensaje'], $data);
		}
	}


/* ***************************** */
	function metodoPUT($datos) {
		global $params;	
		
		if (isset($params['action'])) {
			if (in_array($params['action'], $GLOBALS['tablasValidas'])) {
				if (isset($params['value'])) {
					$resp=execUpdate($datos, $params['action'], $params['value']);
					switch ($resp) {
						case 1: // actualizado
							$data=array();
							$data['respuesta']=200;
							$data['metodo']=$GLOBALS['method'];
							$data['tabla']=$params['action'];
							$data['mensaje']="Registro ".$params['value']." actualizado";
							if (isset($_SESSION['sqlQuery'])) $data['sqlQuery']=$_SESSION['sqlQuery'];
							response($data['respuesta'], $data['mensaje'], $data);			
							break;
						case -1: // Identificador de Registro no coincide con datos recibidos
							$data=array();
							$data['respuesta']=400;
							$data['metodo']=$GLOBALS['method'];
							$data['tabla']=$params['action'];
							$data['mensaje']="Identificador de Registro (".$params['value'].") no coincide con datos recibidos";
							response($data['respuesta'], $data['mensaje'], $data);
							break;
						case -2: // Error general
							$data=array();
							$data['respuesta']=400;
							$data['metodo']=$GLOBALS['method'];
							$data['tabla']=$params['action'];
							$data['mensaje']="Error al actualizar";
							if (isset($_SESSION['sqlQuery'])) $data['sqlQuery']=$_SESSION['sqlQuery'];
							if (isset($_SESSION['sqlError'])) $data['sqlError']=$_SESSION['sqlError'];
							response($data['respuesta'], $data['mensaje'], $data);			
							break;
						case -3: // Registro no existe
							$data=array();
							$data['respuesta']=400;
							$data['metodo']=$GLOBALS['method'];
							$data['tabla']=$params['action'];
							$data['mensaje']="Registro (".$params['value'].") no existe";
							response($data['respuesta'], $data['mensaje'], $data);			
							break;						
						case -4: // Falta identificador
							$data=array();
							$data['respuesta']=400;
							$data['metodo']=$GLOBALS['method'];
							$data['tabla']=$params['action'];
							$data['mensaje']="Falta identificador";
							response($data['respuesta'], $data['mensaje'], $data);			
							break;
						case -5: // Los datos no incluyen el identificador
							$data=array();
							$data['respuesta']=400;
							$data['metodo']=$GLOBALS['method'];
							$data['tabla']=$params['action'];
							$data['mensaje']="Los datos no incluyen el identificador";
							response($data['respuesta'], $data['mensaje'], $data);			
							break;
					}
				} else {
					$data=array();
					$data['respuesta']=400;
					$data['metodo']=$GLOBALS['method'];
					$data['tabla']=$params['action'];
					$data['mensaje']="Registro no identificado";
					response($data['respuesta'], "Acción no aceptada", $data);
				}						
			} else {
				$data=array();
				$data['respuesta']=400;
				$data['metodo']=$GLOBALS['method'];
				$data['tabla']=$params['action'];
				$data['mensaje']="Tabla ".$params['action']." no aceptada o no existe";
				response($data['respuesta'], "Acción no aceptada o no existe", $data);
			}
		} else {
			$data['respuesta']=501;
			$data['metodo']=$GLOBALS['method'];
			$data['mensaje']="Acción no definida";			
			response($data['respuesta'], $data['mensaje'], $data);
		}
	}
		
/* ***************************** */
	function metodoDELETE() {
		global $params;	
		if (isset($params['action'])) {
			if (in_array($params['action'], $GLOBALS['tablasValidas'])) {
				if (isset($params['value'])) {
					if (execDelete($params['action'],$params['value'])) {
						$data=array();
						$data['respuesta']=200;
						$data['metodo']=$GLOBALS['method'];
						$data['tabla']=$params['action'];
						$data['mensaje']="Registro ".$params['value']." eliminado";
						if (isset($_SESSION['sqlQuery'])) $data['sqlQuery']=$_SESSION['sqlQuery'];
						response($data['respuesta'], $data['mensaje'], $data);								
					} else {
						$data=array();
						$data['respuesta']=400;
						$data['metodo']=$GLOBALS['method'];
						$data['tabla']=$params['action'];
						$data['mensaje']="Error al eliminar registro";
						if (isset($_SESSION['sqlQuery'])) $data['sqlQuery']=$_SESSION['sqlQuery'];
						if (isset($_SESSION['sqlError'])) $data['sqlError']=$_SESSION['sqlError'];
						response($data['respuesta'], $data['mensaje'], $data);									
					}
				} else {
					$data=array();
					$data['respuesta']=400;
					$data['metodo']=$GLOBALS['method'];
					$data['tabla']=$params['action'];
					$data['mensaje']="Registro no identificado";
					response($data['respuesta'], "Acción no aceptada", $data);
				}				
			} else {
				$data=array();
				$data['respuesta']=501;
				$data['metodo']=$GLOBALS['method'];
				$data['tabla']=$params['action'];
				$data['mensaje']="Tabla ".$params['action']." no aceptada o no existe";
				response($data['respuesta'], "Acción no aceptada o no existe", $data);
			}
		}
	}	


/* ***************************** */
	function metodoNoSoportado() {
		global $params;	
			
		$data=array();
		$data['respuesta']=405;
		$data['metodo']=$GLOBALS['method'];
		$data['mensaje']="Método no permitido";
		response($data['respuesta'], $data['mensaje'], $data);			
	}
	