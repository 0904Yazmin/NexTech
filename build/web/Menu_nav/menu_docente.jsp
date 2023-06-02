<%-- 
    Document   : menu_docente
    Created on : 16 mar. 2023, 00:56:34
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

    <!--
        <header>
            <a href="menu_docente.jsp" ><img src="../Img/logos/LogoCopernicus.png" alt="logo" class="logo"></a>
            <nav class="nav_A">
                <center>
                    <ul>
                        <li> <a href="../Jsp/Clases/clasesitas.jsp" class="link" target="seccion"><img src="../Img/Iconos_menu/clases.png" class="imgmenu"> Clases
                             <img src="../Img/Iconos_menu/desplegar.png" class="imgmenu usu"></a>
                                <ul>
                                    <li><a href="../Jsp/Clases/CrearClaseForm.html" class="link" target="seccion"><img src="../Img/Iconos_menu/plus.png" class="imgmenu">Crear clase</a></li>
                                </ul>
                        </li>
                        <li>
                            <a href="../Jsp/Actividades/Actividades.jsp" class="link" target="seccion">
                                <img src="../Img/Iconos_menu/lecciones.png" class="imgmenu"> Actividades 
                                <img src="../Img/Iconos_menu/desplegar.png" class="imgmenu usu">
                            </a>
                            <ul>
                                <li>
                                    <a href="../Actividades/Basico.jsp" class="link" target="seccion"><img src="../Img/Iconos_menu/apuntes.png" class="imgmenu"> Lecciones</a>
                                </li> 
                                <li>
                                    <a  href="../Actividades/Intermedio.jsp"  class="link" target="seccion"><img src="../Img/Iconos_menu/ejercicios.png" class="imgmenu usu">Ejercicios</a>
                                </li>
                                <li>
                                    <a  href="../Actividades/Avanzado.jsp"  class="link" target="seccion"><img src="../Img/Iconos_menu/apuntes.png" class="imgmenu">Exámenes</a>
                                </li>
                                <li>
                                    <a href="../Jsp/Actividades/material_apoyo.jsp" class="link" target="seccion"><img src="../Img/Iconos_menu/libros_1.png" class="imgmenu">Material de apoyo</a>
                                </li>
                            </ul>
                        </li>
                        <li><a href="../Jsp/Foros/foro_docente.jsp" class="link" target="seccion" >
                                <img  src="../Img/Iconos_menu/comentarios.png"  class="imgmenu">Foro</a>
                        </li>
                        <li><a href="../Jsp/Calificaciones/Lista_cal.jsp" class="link" target="seccion"> 
                                <img src="../Img/Iconos_menu/puntuaciones.png" class="imgmenu">Calificaciones</a>
                        </li>
                        <li><a href="../Jsp/Modelos/Modelos3D.jsp" class="link" target="seccion">
                                <img src="../Img/Iconos_menu/coheteM.png" class="imgmenu">Modelos 3D</a>
                        </li> 
                        <li class="opciones"><a class="link" target="seccion" >
                                <img src="../Img/Iconos_menu/desplegar.png" class="imgmenu usu"></a>
                            <ul>
                                <li class="link" style=" .linki:hover {background-color: none;} "> 
                                    <img src="../Img/Iconos_menu/correo.png"  class="imgmenu"><%=correo%>
                                </li>
                                <li><a href="pagina1.html" class="link" target="seccion">
                                        <img src="../Img/Iconos_menu/home.png" class="imgmenu">Home</a>
                                </li>
                                <li><a href="../Sesiones/perfil_usu.jsp" class="link" target="seccion">
                                        <img src="../Img/Iconos_menu/usuario.png"  class="imgmenu usu">Perfil</a>
                                </li>
                                <li><a href="../Jsp/Otros/planes/infoPlanes.jsp" class="link" target="seccion">
                                        <img src="../Img/Iconos_menu/premium.png"  class="imgmenu usu">Actualizar plan</a>
                                </li>
                                <li><a href="../Jsp/Otros/FAQs.jsp" class="link" target="seccion">
                                        <img src="../Img/Iconos_menu/help.png"  class="imgmenu usu">Ayuda y soporte</a>
                                </li>
                                <li><a href="../Sesiones/perfil_usu.jsp" class="link" target="seccion">
                                        <img src="../Img/Iconos_menu/acerca de.png"  class="imgmenu usu">Acerca de</a>
                                </li>
                                <li><a href="../Sesiones/cerrarSesion.jsp" class="link" >
                                        <img src="../Img/Iconos_menu/salir.png" class="imgmenu"> Cerrar sesión</a>
                                </li>
                            </ul>
                        </li>
                        
                    </ul>
                </center>
            </nav>
        </header>
    -->
    <header>
        <div class="cd-logo"><a href="menu_docente.jsp"><img src="../Img/logos/LogoCopernicus.png" width="30px" height="30px" alt="Logo"></a></div>

        <nav class="cd-main-nav-wrapper">
            <ul class="cd-main-nav">
                <li><a href="menu_docente.jsp" target="seccion">Menú</a></li>
                <li><a href="../Jsp/Clases/clasesitas.jsp" target="seccion">Clases</a></li>
                <li><a href="../Jsp/Foros/foro_docente.jsp" >Foro</a></li>
              
                <li><a href="../Jsp/Modelos/Modelos3D.html" target="seccion">Modelos3D</a></li>
                <li><a href="../Jsp/Actividades/Actividades.html" target="seccion">Actividades/Material educativo</a></li>
                <li><a href="../Jsp/Modelos/Galeria_modelos.html" target="seccion">Lecciones</a></li>
                <li>
                    <a href="#0" class="cd-subnav-trigger"><span>Opciones </span></a>
                    <ul style="color: white;">
                        <li class="go-back"><a href="#0">Menu</a></li>
                        <li><a href="../Sesiones/perfil_usu.jsp" target="seccion">Perfil</a></li>
                        <li><a href="../Jsp/Otros/planes/precios_docente.html" target="seccion">Actualizar plan</a></li>
                        <li><a href="../Jsp/Help/Intro.html" target="seccion">Ayuda y soporte</a></li>
                        <li><a href="../nexTech/OurTeamCS.html" target="seccion">Acerca de</a></li>
                        <li><a href="../Sesiones/cerrarSesion.jsp">Cerrar sesión</a></li>
                        <li><a href="#0" class="placeholder">Placeholder</a></li>
                    </ul>
                </li>
            </ul> <!-- .cd-main-nav -->
        </nav> <!-- .cd-main-nav-wrapper -->
        <a href="#0" class="cd-nav-trigger">Menu<span></span></a>
    </header>
    <div class="cd-main-content" >
        <!-- main content here -->
    </div>


    <div >
        <iframe name="seccion" src="bienvenido.jsp" width="100%" height="860vh"></iframe>
    </div>

    <script src="menu.js"></script>
    <script src="../js/jquery-2.1.1.js"></script>
    <script src="../js/main.js"></script> <!-- Resource jQuery -->

</body>
</html>
