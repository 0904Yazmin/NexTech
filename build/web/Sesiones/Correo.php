<?php 
	$nombre = $_POST['Yaz'];
	$email = $_POST['naimad1018@gmail.com'];
	$asunto = 'Formulario Rellenado';
	$mensaje = "Nombre: ".$nombre."<br> Email: $email<br> Mensaje:".$_POST['mensaje'];


	if(mail('reyes.barquera.yazmin@gmail.com', $asunto, $mensaje)){
		echo "Correo enviado";
	}
 ?>