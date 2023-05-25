<%-- 
    Document   : menu_alumno
    Created on : 16 mar. 2023, 00:56:46
    Author     : kim53
--%>
<%@page import="java.sql.ResultSet"%>
<%@page import="Conexion.BD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    HttpSession miSessiondelUsuario = (HttpSession) request.getSession();

    int idPersona = (int) (miSessiondelUsuario.getAttribute("id_usu") == null ? 0 : miSessiondelUsuario.getAttribute("id_usu"));
    if (idPersona < 1) {
        response.sendRedirect("../jsp/Menu.jsp");
    }
    String nombre = "";
    String correo = "";
    BD basesita = new BD();
    basesita.conectar();
    String datitos = "Select * from Usuario where id_usu = '" + idPersona + "'";
    ResultSet rsDatosPer = basesita.consulta(datitos);
    if (rsDatosPer.next()) {
        nombre = rsDatosPer.getString(2);
        correo = rsDatosPer.getString(3);
    }
%>
<html>
    <title>Copernicus System</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="../CSS/barra_menu.css" rel="stylesheet" type="text/css"/>
    <link href="../CSS/menu_bienvendo.css" rel="stylesheet" type="text/css"/>
    <link href="../CSS/Navegacion_menu.css" rel="stylesheet" type="text/css"/>
    
	<link rel="stylesheet" href="../CSS/reset.css"> <!-- CSS reset -->
	<link rel="stylesheet" href="../CSS/style.css"> <!-- Resource style -->
	<script src="../js/modernizr.js"></script> <!-- Modernizr -->
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Quicksand:wght@500&display=swap');
        body{
            overflow: hidden;
            margin: 0;
        }
        .section{
            overflow: hidden;
            overflow-x:  hidden;
            overflow-y: hidden;
        }

    </style>
    <link rel="shorcut icon" href="../Img/logos/LogoCopernicus.png">
</head>
<body>
    <header>
		<div class="cd-logo"><a href="menu_alumno.jsp"><img src="../Img/logos/LogoCopernicus.png" width="30px" height="30px" alt="Logo"></a></div>

		<nav class="cd-main-nav-wrapper">
			<ul class="cd-main-nav">
				<li><a href="menu_alumno.jsp" target="seccion">Menú</a></li>
				
				<li><a href="../Jsp/Foros/foro_usuarioA.jsp" target="seccion">Foro de la clase</a></li>
				<li><a href="../Jsp/Calificaciones/Lista_cal.jsp" target="seccion">Calificaciones</a></li>
                <li><a href="../Jsp/Modelos/Modelos3D.html" target="seccion">Modelos3D</a></li>
 
                <li><a href="../Jsp/Modelos/Galeria_modelos.html" target="seccion">Actividades/Material educativo</a></li>
                <li><a href="#0" target="seccion">Lecciones</a></li>
				<li>
					<a href="#0" class="cd-subnav-trigger"><span>Opciones </span></a>
					<ul style="color: white;">
						<li><a href="../Sesiones/perfil_usu.jsp" target="seccion">Perfil</a></li>
						<li><a href="../Jsp/Otros/planes/precios_docente.html" target="seccion">Actualizar plan</a></li>
                        <li><a href="../Jsp/Help/Intro.html" target="seccion">Ayuda y soporte</a></li>
						<li><a href="#0" target="seccion">Acerca de</a></li>
						<li><a href="../Sesiones/cerrarSesion.jsp">Cerrar sesión</a></li>
						<li><a href="#0" class="placeholder">Placeholder</a></li>
					</ul>
				</li>
			</ul> <!-- .cd-main-nav -->
		</nav> <!-- .cd-main-nav-wrapper -->
		<a href="#0" class="cd-nav-trigger">Menu<span></span></a>
	</header>
	
    <div >
        <iframe name="seccion" src="bienvenido.jsp" width="100%" height="860vh"></iframe>
    </div>

    <script src="menu.js"></script>
    <script src="../js/jquery-2.1.1.js"></script>
    <script src="../js/main.js"></script> <!-- Resource jQuery -->



</body>
</html>
