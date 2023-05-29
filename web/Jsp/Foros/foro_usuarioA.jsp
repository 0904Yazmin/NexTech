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
    String foto = "";
    String tipo = "";
    String grado = "";
    BD basesita = new BD();
    basesita.conectar();

    String UsuarioInfo = "Select * from Usuario where id_usu= '" + idPersona + "'"; //selecionamos los datos del usuario de la tabla Estudiante
    ResultSet rsDatosPer = basesita.consulta(UsuarioInfo);
    String datitos = "Select * from Usuario_Clase where id_usu = '" + idPersona + "'"; // seleccionamos los datos de la clase de la tabla Usuario_Clase
    ResultSet Datos = basesita.consulta(datitos);
    if (Datos.next()) {
        int id_class = Datos.getInt(2); // obtenemos la id de la clase (de la tabla Usuario_Clase) para relacionarla con la tabla Clases

        String info_clase = "Select * from Clases where id_clase = '" + id_class + "'"; // seleccionamos los datos de la tabla Clases
        ResultSet ClaseInfo = basesita.consulta(info_clase);
        if (ClaseInfo.next()) {
            String PostInfo = "Select * from Post where id_foro = '" + id_class + "'"; //selecionamos los datos del usuario de la tabla Estudiante 
            ResultSet publi = basesita.consulta(PostInfo);

        }
        if (rsDatosPer.next()) {
            nombre = rsDatosPer.getString(2);
            correo = rsDatosPer.getString(3);
            foto = rsDatosPer.getString(5);
            tipo = rsDatosPer.getString(6);
            grado = rsDatosPer.getString(7);
        }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Foro de la clase</title>
        <link href="../../CSS/foro_doc.css" rel="stylesheet" type="text/css"/>
        <link href="../../CSS/barra_foro_doc.css" rel="stylesheet" type="text/css"/>
        <link href='https://unpkg.com/boxicons@2.1.1/css/boxicons.min.css' rel='stylesheet'>
        <link rel="shorcut icon" href="../Img/logos/LogoNexTech.png">
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Poppins&display=swap');
            *{
                overflow: hidden;
            }
            body{
                overflow: hidden;
            }
            .menu-links ul li a{
                font-size: 19px;
            }
            .text nav-text{
                font-size: 22px;
            }
        </style>
    </head>
    <body id="foro1">
        <nav class="sidebar close">
            <header id="header2">
                <div class="image-text">
                    <div class="text logo-text">
                        <br> 
                        <span class="profession">Clases</span>
                    </div>
                </div>
                <i class='bx bx-chevron-right toggle'></i>
            </header>
            <div class="menu-bar">
                <div class="menu">
                    <ul class="menu-links">
                        <li class="nav-link">
                            <a href="../../Menu_nav/menu_alumno.jsp">
                                <i class='bx bx-home-alt icon' ></i>
                                <span class="text nav-text">Menú principal</span>
                            </a>
                        </li>
                        <li class="nav-link">
                            <a href="../../Jsp/Foros/foro_usuarioA.jsp">
                                <i class='bx bx-message icon' ></i>
                                <span class="text nav-text">Mis posts</span>
                            </a>
                        </li>
                        <li class="nav-link">
                            <a href="../../Menu_nav/menu_docente.jsp">
                                <i class='bx bx-group icon' ></i>
                                <span class="text nav-text">Miembros de la clase</span>
                            </a>
                        </li>
                        <li class="nav-link">
                            <a href="../../Menu_nav/menu_docente.jsp">
                                <i class='bx bx-heart icon' ></i>
                                <span class="text nav-text">Me gusta</span>
                            </a>
                        </li>
                        <li class="nav-link">
                        <a href="../../Sesiones/cerrarSesion.jsp">
                            <i class='bx bx-log-out icon' ></i>
                            <span class="text nav-text">Cerrar sesión</span>
                        </a>
                    </li>
                    </ul>
                </div>

                <div class="bottom-content">
                    
                </div>
            </div>
        </nav>

        <section>
            <div>
                <iframe name="postList" src="iframe_listaPost.jsp" style="width: 100%; height: 100vh; border:none;  border:no;  overflow: hidden;"></iframe>
            </div>
        </section>
        <%
            }
        %>


        <script>
            const body = document.querySelector('body'),
                    sidebar = body.querySelector('nav'),
                    toggle = body.querySelector(".toggle"),
                    searchBtn = body.querySelector(".search-box"),
                    modeSwitch = body.querySelector(".toggle-switch"),
                    modeText = body.querySelector(".mode-text");


            toggle.addEventListener("click", () => {
                sidebar.classList.toggle("close");
            })

            searchBtn.addEventListener("click", () => {
                sidebar.classList.remove("close");
            })

            modeSwitch.addEventListener("click", () => {
                body.classList.toggle("dark");

                if (body.classList.contains("dark")) {
                    modeText.innerText = "Light mode";
                } else {
                    modeText.innerText = "Dark mode";

                }
            });
        </script>
    </body>
</html>
