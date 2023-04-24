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
       
        <div class="si6-bg-dark">
            <div class="si6-container si6-max-width-lg">
                <div class="subnav  js-subnav">
                    <button class="si6-btn si6-btn--subtle si6-margin-y-sm subnav__control js-subnav__control">
                        <span>Show Categories</span>
                        <svg class="si6-icon si6-icon--2xs si6-margin-left-2xs" aria-hidden="true" viewBox="0 0 12 12">
                        <polyline points="0.5 3.5 6 9.5 11.5 3.5" fill="none" stroke-width="1" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"></polyline>
                        </svg>
                    </button>

                    <div class="subnav__wrapper js-subnav__wrapper">
                        <nav class="subnav__nav si6-justify-center">
                            <button class="subnav__close-btn js-subnav__close-btn js-tab-focus" aria-label="Close navigation">
                                <svg class="si6-icon" viewBox="0 0 16 16">
                                <g stroke-width="1" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round" stroke-miterlimit="10">
                                <line x1="13.5" y1="2.5" x2="2.5" y2="13.5"></line>
                                <line x1="2.5" y1="2.5" x2="13.5" y2="13.5"></line>
                                </g>
                                </svg>
                            </button>

                            <ul class="subnav__list" ">
                                <li class="subnav__item"><a href="menu_docente.jsp" class="subnav__link" aria-current=page>
                                    Menú</a></li>
                                <li class="subnav__item"><a href="#0" class="subnav__link" target="seccion">Clases</a></li>
                                <li class="subnav__item"><a href="#0" class="subnav__link" target="seccion">Photos</a></li>
                                <li class="subnav__item"><a href="../Jsp/Actividades/timeline.html" class="subnav__link" target="seccion">timeline</a></li>
                                <li class="subnav__item"><a href="#0" class="subnav__link" target="seccion">Specs</a></li>
                                <li class="subnav__item"><a href="#0" class="subnav__link" target="seccion">Support</a></li>
                                <li class="subnav__item"><a href="../Jsp/Foros/foro_docente.jsp" class="subnav__link" target="seccion">Foro</a></li>
                                <li class="subnav__item"><a href="#0" class="subnav__link" target="seccion">Buy</a></li>
                               
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>
        </div>
   

    <dic class="container">
        <iframe name="seccion" src="bienvenido.jsp"  style="width: 100%; height:max-content; border:none; margin: 0; " ></iframe>
    </div>

    <script src="menu.js"></script>
    

</body>
</html>
