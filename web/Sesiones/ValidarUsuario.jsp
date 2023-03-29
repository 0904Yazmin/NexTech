<%@page import="Conexion.Digest"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="Conexion.BD"%>
<%@page contentType="text/html" pageEncoding="UTF-8" session="true" %>
<!DOCTYPE html>
<%
    String usuario = request.getParameter("email");
    String pass = request.getParameter("password");
    String pswd = Digest.bytesToHex(Digest.createSha1(pass));

    if (usuario == null) {
        usuario = "0";
    } else {
        if (usuario.equals("")) {
            usuario = "0";
        }
    }
    if (pass == null) {
        pass = "0";
    } else {
        if (pass.equals("")) {
            pass = "0";
        }
    }
    if (!usuario.equals("0") && !pass.equals("0")) {
        BD bd = new BD();
        bd.conectar();
        int num = 0;

        String strQry = "Select * from Usuario where correo_usu='" + usuario + "'and pass_usu = '" + pswd + "'";
        ResultSet DatosUsu = bd.consulta(strQry);
        if (DatosUsu.next()) {
            HttpSession miSessiondelUsuario = (HttpSession) request.getSession();
            int idPersona = DatosUsu.getInt("id_usu");
            String nombre = DatosUsu.getString("nombre_usu");
            String tipo = DatosUsu.getString("tipo_usu");
            miSessiondelUsuario.setAttribute("id_usu", idPersona);
            miSessiondelUsuario.setAttribute("Nombre del alumno", nombre);
            String grado = DatosUsu.getString(7);

            switch (tipo) {
                case "Alumno":
                    if (grado == null) {
                        response.sendRedirect("../Jsp/Otros/claveLoginClass.jsp");
                    } else {
                        response.sendRedirect("../Menu_nav/menu_alumno.jsp");
                    }
                    break;
                case "Docente":
                    if (grado == null) {
                        response.sendRedirect("../Menu_nav/menu_docente.jsp");
                    } else {
                        response.sendRedirect("../Alumno/jsp_A/Menu_A.jsp");
                    }
                    break;
                case "Independiente":
                    if (grado == null) {
                        response.sendRedirect("../Jsp/Otros/ExamD_Grado.jsp");
                    } else {
                        response.sendRedirect("../Menu_nav/menu_indep.jsp");
                    }
                    break;
            }
        } else {

        }
    } else {
        response.sendRedirect("Registro.html");
    }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Usuario desconocido</title>
        <link href="../CSS/registro.css" rel="stylesheet" type="text/css"/>
        <link rel="shorcut icon" href="../Img/logos/LogoNexTech.png">
        <style>
            /* -------------------------------- 
    
    File#: _1_404
    Title: 404
    Descr: 404 error section
    Usage: codyhouse.co/license
    
    -------------------------------- */
            @import url('https://fonts.googleapis.com/css2?family=Poppins&display=swap');
            header{
                background-color: #1E222D;
                color: white;
                height: 50px;
            }
            header h1{
                font-size: 17px;
                color: white;
            }
            /* reset */
            *, *::after, *::before {
                box-sizing: border-box;
            }

            * {
                font: inherit;
                margin: 0;
                padding: 0;
                border: 0;
                font-family: 'Poppins', sans-serif;
            }

            html {
                -webkit-font-smoothing: antialiased;
                -moz-osx-font-smoothing: grayscale;
            }

            body {
                background-color: hsl(0, 0%, 100%);
                font-family: system-ui, sans-serif;
                color: hsl(230, 7%, 23%);
                font-size: 1.125rem; /* 18px */
                line-height: 1.4;
            }

            h1, h2, h3, h4 {
                line-height: 1.2;
                color: hsl(230, 13%, 9%);
                font-weight: 700;
            }

            h1 {
                font-size: 2.5rem; /* 40px */
            }

            h2 {
                font-size: 2.125rem; /* 34px */
            }

            h3 {
                font-size: 1.75rem; /* 28px */
            }

            h4 {
                font-size: 1.375rem; /* 22px */
            }

            ol, ul, menu {
                list-style: none;
            }

            button, input, textarea, select {
                background-color: transparent;
                border-radius: 0;
                color: inherit;
                line-height: inherit;
                -webkit-appearance: none;
                appearance: none;
            }

            textarea {
                resize: vertical;
                overflow: auto;
                vertical-align: top;
            }

            a {
                color: hsl(250, 84%, 54%);
            }

            table {
                border-collapse: collapse;
                border-spacing: 0;
            }

            img, video, svg {
                display: block;
                max-width: 100%;
            }

            /* -------------------------------- 
            
            Component 
            
            -------------------------------- */

            .fof {
                padding: 4.5rem 0;
            }

            .fof__container {
                width: calc(100% - 3rem);
                max-width: 48rem;
                margin-left: auto;
                margin-right: auto;
            }

            .fof__text {
                text-align: center;
                margin-bottom: 3rem;
            }

            .fof__text > *:not(:last-child) {
                margin-bottom: 1.5rem;
            }

            .fof__animation svg {
                display: block;
                max-width: 520px;
                margin-left: auto;
                margin-right: auto;
            }

            #i-fof-browser {
                transform-origin: 260px 304px;
                animation: i-fof-browser 4s infinite;
            }

            #i-fof-shadow {
                transform-origin: 282px 410px;
                animation: i-fof-shadow 4s infinite;
            }

            @keyframes i-fof-browser {
                0%, 100% {
                    transform: translateY(0) scale(1);
                }
                50% {
                    transform: translateY(-10%) scale(0.9);
                }
            }

            @keyframes i-fof-shadow {
                0%, 100% {
                    transform: scale(1);
                }
                50% {
                    transform: scale(0.8);
                }
            }

            /* -------------------------------- 
            
            Utilities 
            
            -------------------------------- */

            .cd-container {
                width: calc(100% - 3rem);
                margin-left: auto;
                margin-right: auto;
            }

            .cd-max-width-sm {
                max-width: 48rem;
            }
        </style>
    </head>

    <body>
        <header>
            <a href="../index.html" class="link" ><img src="../Img/logos/LogoCopernicus.png" alt="LogoCS" class="imglogo"/></a> <a href="../index.html" class="link" ><h1>Copernicus System</h1></a>
            <nav>

                <a href="Login.jsp" class="link">Iniciar sesión</a>
                <a href="Login.jsp" class="link">Conócenos</a>
                <a href="Login.jsp" class="link">NexTech Company</a>
            </nav>
        </header>
        <section class="fof">
            <div class="cd-container cd-max-width-sm">
                <div class="fof__text">
                    <h1>Este usuario no existe :(</h1>
                    <p>El correo o contraseña ingresados son incorrectos</p>
                    <p><a href="Login.jsp">Regresar al inicio de sesión</a> or <a href="Registro.html">Registrarse</a>.</p>
                </div>

                <div class="fof__animation" aria-label="404 animation">
                    <svg id="i-fof" viewBox="0 0 520 450"><g id="i-fof-ship"><path id="i-fof-capsule" d="M260,9a53,53,0,0,0-53,53H313A53,53,0,0,0,260,9Z" fill="hsl(240, 4%, 85%)"/><path id="i-fof-ship-top" d="M448,73H72s78-37,188-37S448,73,448,73Z" fill="hsl(240, 4%, 65%)"/><path id="i-fof-ship-bottom" d="M448,73A1185.633,1185.633,0,0,0,72,73c80.173,34.484,144.2,37,188,37C370,110,448,73,448,73Z" fill="hsl(230, 7%, 23%)"/></g><g id="i-fof-browser"><rect id="i-fof-browser-canvas" x="179" y="243" width="160" height="109" rx="6" transform="translate(131.361 -75.723) rotate(22.162)" fill="hsl(230, 13%, 9%)"/><g id="i-fof-browser-dots" fill="hsl(0, 0%, 100%)"><circle cx="211.713" cy="228.029" r="3"/><circle cx="221.9" cy="232.179" r="3"/><circle cx="232.088" cy="236.328" r="3"/></g><rect id="i-fof-browser-body" x="180.737" y="258.557" width="152" height="89" rx="2" transform="translate(133.29 -74.459) rotate(22.162)" fill="hsl(0, 0%, 100%)"/><g id="i-fof-emoji"><path d="M248.626,322.968A22,22,0,1,1,277.3,310.893,22,22,0,0,1,248.626,322.968Z" fill="hsl(35, 79%, 66%)"/><path d="M264.3,311a7,7,0,1,1,9.124-3.843A7,7,0,0,1,264.3,311Z" fill="hsl(0, 0%, 100%)"/><path d="M245.778,303.452a7,7,0,1,1,9.123-3.842A7,7,0,0,1,245.778,303.452Z" fill="hsl(0, 0%, 100%)"/><path d="M258.5,317.274l-12.966-5.281a1,1,0,0,1,.755-1.853l12.966,5.282a1,1,0,0,1-.755,1.852Z" fill="hsl(230, 7%, 23%)"/><path d="M247.287,299.747a3,3,0,1,1,3.91-1.646A3,3,0,0,1,247.287,299.747Z" fill="hsl(230, 7%, 23%)"/><path d="M265.809,307.292a3,3,0,1,1,3.91-1.647A3,3,0,0,1,265.809,307.292Z" fill="hsl(230, 7%, 23%)"/></g></g><polygon id="i-fof-radar-body" points="415 410 105 410 196 106 324 106 415 410" fill="hsl(170, 78%, 36%)" opacity="0.5"/><ellipse id="i-fof-radar-bottom" cx="260" cy="410" rx="155" ry="28" fill="hsl(170, 78%, 36%)"/><ellipse id="i-fof-shadow" cx="282" cy="410" rx="72" ry="10" opacity="0.4" fill="hsl(230, 13%, 9%)"/><ellipse id="i-fof-radar-top" cx="260" cy="106" rx="64" ry="6" fill="hsl(170, 78%, 36%)"/></svg>
                </div>
            </div>
        </section>
    </body>

</html>
