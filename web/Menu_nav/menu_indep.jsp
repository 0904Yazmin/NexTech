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

        /* -------------------------------- 
        
        Icons 
        
        -------------------------------- */

        .cd-icon {
            --size: 1em;
            font-size: var(--size);
            height: 1em;
            width: 1em;
            display: inline-block;
            color: inherit;
            fill: currentColor;
            line-height: 1;
            flex-shrink: 0;
            max-width: initial;
        }

        .cd-icon use { /* SVG symbols - enable icon color corrections */
            color: inherit;
            fill: currentColor;
        }

        /* -------------------------------- 
        
        Component 
        
        -------------------------------- */

        .alert {
            background-color: hsla(250, 84%, 54%, 0.2);
            color: hsl(230, 13%, 9%);
            border-radius: 0.375em;
            padding: 1rem;
            position: absolute;
            -webkit-clip-path: inset(50%);
            clip-path: inset(50%);
            font-size: 0.9375rem;
        }

        .alert__icon {
            --size: 24px;
            margin-right: 0.5rem;
            color: hsl(250, 84%, 54%);
        }

        .alert__label {
            font-weight: 700;
        }

        .alert__close-btn {
            display: inline-flex;
            flex-shrink: 0;
            margin-left: 1.5rem;
            transition: 0.3s cubic-bezier(0.215, 0.61, 0.355, 1);
        }

        .alert__close-btn .cd-icon {
            --size: 16px;
            display: block;
        }

        .alert__close-btn:hover {
            transform: scale(1.1);
        }

        .alert--success {
            background-color: hsla(170, 78%, 36%, 0.2);
        }

        .alert--success .alert__icon {
            color: hsl(170, 78%, 36%);
        }

        .alert--error {
            background-color: hsla(342, 89%, 48%, 0.2);
        }

        .alert--error .alert__icon {
            color: hsl(342, 89%, 48%);
        }

        .alert--warning {
            background-color: hsla(35, 79%, 66%, 0.2);
        }

        .alert--warning .alert__icon {
            color: hsl(35, 79%, 66%);
        }

        .alert__list {
            list-style: disc;
            list-style-position: inside;
        }

        .alert--is-visible {
            position: static;
            -webkit-clip-path: none;
            clip-path: none;
        }

        /* -------------------------------- 
        
        Utilities 
        
        -------------------------------- */

        .cd-flex {
            display: flex;
        }

        .cd-items-center {
            align-items: center;
        }

        .cd-justify-between {
            justify-content: space-between;
        }

        .cd-margin-top-3xs {
            margin-top: 0.5rem;
        }

        .cd-color-inherit {
            color: inherit;
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
        <div class="cd-logo"><a href="menu_indep.jsp"><img src="../Img/logos/LogoCopernicus.png" width="30px" height="30px" alt="Logo"></a></div>

        <nav class="cd-main-nav-wrapper">
            <ul class="cd-main-nav">
                <li><a href="menu_indep.jsp" target="seccion">Menú</a></li>
                <li><a href="../Jsp/Foros/foro_usuIndep.jsp" target="seccion">Foro</a></li>
                <li><a href="../Jsp/Calificaciones/Lista_cal.jsp" target="seccion">Calificaciones</a></li>
                <li><a href="../Jsp/Modelos/Modelos3D.html" target="seccion">Modelos3D</a></li>
                <li><a href="../Jsp/Actividades/Actividades.html" target="seccion">Actividades/Material educativo</a></li>
                <li><a href="../Jsp/Modelos/Galeria_modelos.html" target="seccion">Lecciones</a></li>
                <li>
                    <a href="#0" class="cd-subnav-trigger"><span>Opciones </span></a>
                    <ul style="color: white;">
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


    <%
        if (rsDatosPer.getString(9) == null) {
    %>

    <div class="alert alert--is-visible js-alert" role="alert" style="z-index: 20;" >
        <div class="cd-flex cd-items-center cd-justify-between">
            <div class="cd-flex cd-items-center">
                <svg class="alert__icon cd-icon" viewBox="0 0 24 24" aria-hidden="true">
                <g fill="currentColor">
                <path fill-opacity=".2" d="M12 24a12 12 0 1 0 0-24 12 12 0 1 0 0 24z"></path>
                <path d="M12 9a1 1 0 0 1 1 1l0 9a1 1 0 0 1-2 0l0-9a1 1 0 0 1 1-1z"></path>
                <path d="M12 7a1.5 1.5 0 1 0 0-3 1.5 1.5 0 1 0 0 3z"></path>
                </g>
                </svg>
                <p><strong class="alert__label">Atención:</strong> Aún tienes que agregar el correo de tu tutor <a href="#0" class="cd-color-inherit">Learn more</a></p>
            </div>
            <button class="alert__close-btn js-alert__close-btn">
                <svg class="cd-icon" viewBox="0 0 16 16">
                <title>Close alert</title>
                <g fill="currentColor">
                <path fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 3l10 10"></path>
                <path fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 3L3 13"></path>
                </g>
                </svg>
            </button>
        </div>
    </div>
    <div >
        <iframe name="seccion" src="bienvenido.jsp" width="100%" height="860vh"></iframe>
    </div>

    <%
        } else {
        }
    %>
    <div >
        <iframe name="seccion" src="bienvenido.jsp" width="100%" height="860vh"></iframe>
    </div>

    <script src="menu.js"></script>
    <script src="../js/jquery-2.1.1.js"></script>
    <script src="../js/main.js"></script> <!-- Resource jQuery -->
    <script>
        // File#: _1_alert
// Usage: codyhouse.co/license
        (function () {
            var alertClose = document.getElementsByClassName('js-alert__close-btn');
            if (alertClose.length > 0) {
                for (var i = 0; i < alertClose.length; i++) {
                    (function (i) {
                        initAlertEvent(alertClose[i]);
                    })(i);
                }
            }
            ;
        }());

        function initAlertEvent(element) {
            element.addEventListener('click', function (event) {
                event.preventDefault();
                element.closest('.js-alert').classList.remove('alert--is-visible');
            });
        }
        ;
    </script>
</body>
</html>

