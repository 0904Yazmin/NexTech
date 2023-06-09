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
    BD basesita = new BD();
    basesita.conectar();

    String UsuarioInfo = "Select * from Usuario where id_usu = '" + idPersona + "'"; //selecionamos los datos del maestro de la tabla Docente
    ResultSet rsDatosPer = basesita.consulta(UsuarioInfo);
    if (rsDatosPer.next()) {
        correo = rsDatosPer.getString(3);
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
                            <a href="../../Menu_nav/menu_docente.jsp">
                                <i class='bx bx-home-alt icon' ></i>
                                <span class="text nav-text">Menú principal</span>
                            </a>
                        </li>
                        <%
                            try {
                                String strQry = "select * from Clases where id_usu = '" + idPersona + "'";
                                ResultSet rs = null;
                                rs = basesita.consulta(strQry);
                                int id_clase;
                                while (rs.next()) {
                                    id_clase = Integer.parseInt(rs.getString(1));
                        %>
                        <li class="nav-link">
                            <a href="Posts_doc.jsp?id_clase=<%=id_clase%>" target="postList">
                                <i class='bx bx-pencil icon' style="margin-right: -6px;"></i>
                                <span class="text nav-text"><%=rs.getString(2)%></span>
                            </a>
                        </li>
                        <%
                                }
                                rs.close();
                                basesita.cierraConexion();
                            } catch (Exception ex) {
                                out.print(ex.getMessage());
                            }
                        %>
                    </ul>
                </div>

                <div class="bottom-content">
                    <li class="">
                        <a href="../../Sesiones/cerrarSesion.jsp">
                            <i class='bx bx-log-out icon' ></i>
                            <span class="text nav-text">Cerrar sesión</span>
                        </a>
                    </li>
                </div>
            </div>
        </nav>

        <section class="home">
            <div class="PostsFrame">
                <iframe name="postList" src="fondoForo.html" style="width: 100%; height: 100vh; border:none;" border="no"  overflow: hidden;></iframe>
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
