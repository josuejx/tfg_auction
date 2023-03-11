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
		<td class="cabecera">Usuarios</td>
		<td class="cabecera">Password</td>
	</tr>
	<?php foreach ($usuarios as $key => $value) { ?>
	<tr>
		<td class="col1"><?php echo $key; ?></td>
		<td class="col2"><?php echo $value; ?></td>
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
		<td class="col2">/?usu={usuario}&amp;pass={contraseña}</td>
		<td>Login</td>
	</tr>
	<tr>
		<td class="col1">GET</td>
		<td class="col2">/?logout</td>
		<td>Logout</td>
	</tr>
	<tr>
		<td class="col1">GET</td>
		<td class="col2">/?user</td>
		<td>Datos del usurio conectado</td>
	</tr>
	<tr>
		<td class="col1">GET</td>
		<td class="col2">/datos</td>
		<td>Datos de la SESIÓN almacenados en el servidor</td>
	</tr>

</table>


</body>
</html>	