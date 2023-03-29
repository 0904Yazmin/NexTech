
<%@page import="java.sql.ResultSet"%>
<%@page import="Conexion.BD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession miSessiondelUsuario = (HttpSession) request.getSession();

    int idPersona = (int) (miSessiondelUsuario.getAttribute("id_usuario") == null ? 0 : miSessiondelUsuario.getAttribute("id_usuario"));
    if (idPersona < 1) {
        response.sendRedirect("../jsp/Menu.jsp");
    }
    String nombre = "";
    String correo = "";
    BD basesita = new BD();
    basesita.conectar();
    String datitos = "Select * from Estudiante where id_usuario = '" + idPersona + "'";
    ResultSet rsDatosPer = basesita.consulta(datitos);
    if (rsDatosPer.next()) {
        nombre = rsDatosPer.getString(2);
        correo = rsDatosPer.getString(3);
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Plutón</title>
        <link rel="stylesheet" href="../../css_A/menu_A.css" >
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Poppins&display=swap');
        </style>
        <link rel="shorcut icon" href="../../../General/img/logos/Newlogo.png">
    </head>

    <body>
    <center>
        <header>
            <a href="Menu_A.jsp" ><img src="../../../General/img/logos/Newlogo.png" alt="logo" class="logo"></a>
            <nav class="nav_A">
                <center>
                    <ul>
                        <li><a href="../../../General/Actividades/Lecciones/Nivel2/Lecciones.html" class="link" ><img src="../../../General/img/Iconos_menu/lecciones.png" class="imgmenu"> Lecciones <img src="../../../General/img/Iconos_menu/desplegar.png" class="imgmenu usu"></a>
                            <ul>
                                <li><a href="../../Actividades/Temario.jsp" class="link" ><img src="../../../General/img/Iconos_menu/temario.png" class="imgmenu">Temario</a> </li>
                                <li><a href="../../Actividades/Basico.jsp" class="link" ><img src="../../../General/img/Iconos_menu/apuntes.png" class="imgmenu"> Nivel Básico</a></li> 
                                <li><a  href="../../Actividades/Intermedio.jsp"  class="link" ><img src="../../../General/img/Iconos_menu/apuntes.png" class="imgmenu usu">Nivel Intermedio</a></li> <br>
                                <li><a  href="../../Actividades/Avanzado.jsp"  class="link" ><img src="../../../General/img/Iconos_menu/apuntes.png" class="imgmenu">Nivel Avanzado</a></li>
                                <li><a href="../../Actividades/MaterialApoyoA.jsp" class="link" ><img src="../../../General/img/Iconos_menu/libros_1.png" class="imgmenu">Material de apoyo</a></li>
                            </ul>
                        </li>
                        <li><a href="../../foro_A/foro_A.jsp" class="link" ><img src="../../../General/img/Iconos_menu/comentarios.png" class="imgmenu">Foro</a></li>
                        <li><a href="#" class="link" ><img src="../../../General/img/Iconos_menu/ejercicios.png" class="imgmenu"> Ejercicios</a></li>
                        <li><a href="#" class="link" > <img src="../../../General/img/Iconos_menu/puntuaciones.png" class="imgmenu"> Puntuaciones</a></li>
                        <li><a href="../Modelos3D.jsp" class="link" ><img src="../../../General/img/Iconos_menu/coheteM.png" class="imgmenu">Mapas</a></li> 
                        <li class="opciones"><a class="link" ><img src="../../../General/img/Iconos_menu/desplegar.png" class="imgmenu usu"></a>
                            <ul>
                                <li class="link"><img src="../../../General/img/Iconos_menu/correo.png" class="imgmenu"><%=correo%></li>
                                <li><a href="../Menu_A.jsp" class="link" ><img src="../../../General/img/Iconos_menu/home.png" class="imgmenu">   Inicio</a></li> 
                                <li><a href="../../Perfil_A.jsp" class="link" ><img src="../../../General/img/Iconos_menu/usuario.png" class="imgmenu usu">Perfil</a></li>
                                <li><a href="../../../General/cerrarSesion.jsp" class="link" ><img src="../../../General/img/Iconos_menu/salir.png" class="imgmenu"> Cerrar sesión</a></li>
                            </ul>
                        </li>
                    </ul>
                </center>
            </nav>
        </header>
    </center>

    <div class="Mapa_interactivo">
        <iframe src='https://my.spline.design/plutoncopy-b2791f267f7e5ec842b198bd06404c27/' frameborder='0' width='1500' height='700'></iframe>
    </div>

</body>
</html>
