<!DOCTYPE html>
<html>
<head>
	<title>API Rest</title>
	<style>
		table {
			border:1px solid black;
			border-collapse:collapse;
			margin:20px auto;
			background-color:#dddddd;				
		}
		td {
			border:2px solid black;
			padding:10px;
		}
		h1, h3 {
			text-align:center;
		}
		.cabecera {
			font-weight:bold;
			background-color:orange;
		}
		.col1 {
			font-weight:bold;
		}
		.col2 {
			min-width:130px;
		}
		

		#button{
			text-decoration: none;
			font-size: 25px;
			color: #FFFFFF;
			font-family: arial;
			background: linear-gradient(to bottom, #939393, #595959);
			border: solid #924C00 1px;
			border-radius: 5px;
			padding:15px;
			text-shadow: 0px 1px 2px #000000;
			box-shadow: 0px 1px 5px #0D2444;
			-webkit-transition: all 0.15s ease;
			-moz-transition: all 0.15s ease;
			-o-transition: all 0.15s ease;
			transition: all 0.15s ease;
		}
		#button:hover{
			opacity: 0.9;
			background: linear-gradient(to bottom, #5E5E5E, #B2B2B2);
			border: 1px solid #000000;
			box-shadow: 0px 1px 2px #000000;
		}		
	</style>
</head>
<body>

<h1>API REST en PHP</h1>

<h3>ESPECIFICACIÓN DE INTERFAZ</h3>

<table>
	<tr>
		<td class="cabecera">Tabla</td>
		<td class="cabecera">Clave</td>
		<td class="cabecera">Campos</td>
	</tr>
	<?php foreach (tablasBD() as $key => $value) { ?>
		<?php if ($key=="") { continue; } ?>
	<tr>
		<td class="col1"><?php echo $key; ?></td>
		<td class="col2"><?php echo $value['clave']; ?></td>
		<td><?php echo $value['campos']; ?></td>
	</tr>
	<?php } ?>
</table>

<table>
	<tr>
		<td class="cabecera">Método</td>
		<td class="cabecera">Query String</td>
		<td class="cabecera">Descripción</td>
	</tr>
	<tr>
		<td class="col1">GET</td>
		<td class="col2">/</td>
		<td>Muestra las especificaciones del API Rest</td>
	</tr>
	<tr>
		<td class="col1">GET<br>PUT<br>POST<br>DELETE</td>
		<td class="col2">/<b>datos</b></td>
		<td>Muestra en formato HTML todos los datos implicados en la llamada al API Rest incluidos los recibidos.</td>
	</tr>
	<tr>
		<td class="col1">GET</td>
		<td class="col2">/tabla</td>
		<td>Muestra los datos de todos los registros de <b>tabla</b></td>
	</tr>
	<tr>
		<td class="col1">GET</td>
		<td class="col2">/tabla/<b>count</b></td>
		<td>Muestra el número de registros de <b>tabla</b></td>
	</tr>
	<tr>
		<td class="col1">GET</td>
		<td class="col2">/tabla/valor</td>
		<td>Muestra los datos del registro cuya clave de la <b>tabla</b> es igual a <b>valor</b>, teniendo en cuenta el campo clave de las variables definidas</td>
	</tr>
	<tr>
		<td class="col1">GET</td>
		<td class="col2">/tabla/campo/?desde=valor</td>
		<td>Muestra los datos de los registros de la <b>tabla</b> cuyo <b>campo</b> sea mayor o igual que el <b>valor</b></td>
	</tr>
	<tr>
		<td class="col1">GET</td>
		<td class="col2">/tabla/campo/?hasta=valor</td>
		<td>Muestra los datos de los registros de la <b>tabla</b> cuyo <b>campo</b> sea menor o igual que el <b>valor</b></td>
	</tr>
	<tr>
		<td class="col1">GET</td>
		<td class="col2">/tabla/campo/?desde=valor1&amp;hasta=valor2</td>
		<td>Muestra los datos de los registros de la <b>tabla</b> cuyo <b>campo</b> sea mayor o igual que el <b>valor1</b> y menor o igual que el <b>valor2</b>
		</td>
	</tr>	
	<tr>
		<td class="col1">DELETE</td>
		<td class="col2">/tabla/valor</td>
		<td>Elimina el registro cuya clave de la <b>tabla</b> es igual a <b>valor</b>, teniendo en cuenta el campo clave de las variables definidas</td>
	</tr>
	<tr>
		<td class="col1">PUT
		<td class="col2">/tabla/valor</td>
		<td>Actualiza el registro cuya clave de la <b>tabla</b> es igual a <b>valor</b>, teniendo en cuenta el campo clave de las variables definidas</td>
	</tr>
	<tr>
		<td class="col1">POST</td>
		<td class="col2">/tabla</td>
		<td>Inserta en <b>tabla</b> un registro nuevo con los datos recibidos</td>
	</tr>
	<tr>
		<td class="col1">GET</td>
		<td class="col2">/<b>fichero</b>/{nombreFichero}</td>
		<td>Muestra el fichero PDF cuyo nombre sea el indicado en <b>nombreFichero</b> (nombre de un fichero pdf sin la extension). Busca el archivo en la carpeta correspondiente segun si es alabaran o factura.</td>
	</tr>
</table>


<div style="margin-top:40px;width:100%;text-align:center;">
	<a id="button" href="inc/apirest_doc.pdf">Descargar PDF de especificación completa</a>
</div>



</body>
</html>	