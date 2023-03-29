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
        <title>Foro</title>
        <link rel="stylesheet" href="../css_A/menu_A.css" >
        <link rel="stylesheet" href="../../General/css/foro_estilitos.css" >
        <link href="../../CSS/CSS_foro/foro_estilitos.css" rel="stylesheet" type="text/css"/>
        <link rel="shorcut icon" href="../../General/img/logos/Newlogo.png">
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Poppins&display=swap');
        </style>
    </head>
    <body id="foro1" style="background: white;">
    <center>
        <header>
            <a href="../jsp_A/Menu_A.jsp" ><img src="../../General/img/logos/Newlogo.png" alt="logo" class="logo"></a>
            <nav class="nav_A">
                <center>
                    <ul>
                        <li> <a href="Clase_A.jsp" class="link" ><img src="../../General/img/Iconos_menu/clases.png" class="imgmenu"> Clase</a></li>
                        <li><a href="../../General/Actividades/Lecciones/Nivel2/Lecciones.html" class="link" ><img src="../../General/img/Iconos_menu/lecciones.png" class="imgmenu"> Lecciones <img src="../../General/img/Iconos_menu/desplegar.png" class="imgmenu usu"></a>
                            <ul>
                                <li><a href="../../General/Actividades/Temario.jsp" class="link" ><img src="../../General/img/Iconos_menu/temario.png" class="imgmenu">Temario</a> </li>
                                <li><a href="#" class="link" ><img src="../../General/img/Iconos_menu/apuntes.png" class="imgmenu"> Nivel Básico</a></li> 
                                <li><a href="#" class="link" ><img src="../../General/img/Iconos_menu/apuntes.png" class="imgmenu usu">Nivel Intermedio</a></li> 
                                <li><a href="#" class="link" ><img src="../../General/img/Iconos_menu/apuntes.png" class="imgmenu">Nivel Avanzado</a></li>
                                <li><a href="MaterialApoyoA.jsp" class="link" ><img src="../../General/img/Iconos_menu/libros_1.png" class="imgmenu">Material de apoyo</a></li>
                            </ul>
                        </li>
                        <li><a href="foro_A.jsp" class="link" ><img src="../../General/img/Iconos_menu/comentarios.png" class="imgmenu">Foro</a></li>
                        <li><a href="#" class="link" ><img src="../../General/img/Iconos_menu/ejercicios.png" class="imgmenu"> Ejercicios</a></li>
                        <li><a href="#" class="link" > <img src="../../General/img/Iconos_menu/puntuaciones.png" class="imgmenu"> Puntuaciones</a></li>
                        <li><a href="../jsp_A/Modelos3D.jsp" class="link" ><img src="../../General/img/Iconos_menu/coheteM.png" class="imgmenu">Mapa</a></li> 
                        <li class="opciones"><a class="link" ><img src="../../General/img/Iconos_menu/desplegar.png" class="imgmenu usu"></a>
                            <ul>
                                <li class="link"><img src="../../General/img/Iconos_menu/correo.png" class="imgmenu"><%=correo%></li>
                                <li><a href="../jsp_A/Menu_A.jsp" class="link" ><img src="../../General/img/Iconos_menu/home.png" class="imgmenu">   Inicio</a></li> 
                                <li><a href="../jsp_A/Perfil_A.jsp" class="link" ><img src="../../General/img/Iconos_menu/usuario.png" class="imgmenu usu">Perfil</a></li> 
                                <li><a href="../../General/cerrarSesion.jsp" class="link" ><img src="../../General/img/Iconos_menu/salir.png" class="imgmenu"> Cerrar sesión</a></li>
                            </ul>
                        </li>
                    </ul>
                </center>
            </nav>
        </header>
    </center>

    <div class="contenedor-imagen">

    </div>

    <main id="blog">

        <div class="contenedor">
            <aside>
                <iframe id="FRAME" src="crearPost.jsp" width="420" height="420" style="border:none; z-index: 100; " scrolling="no" ></iframe>
            </aside>

            <div class="contenido" style="position:absolute; left: 48%;">
                <%
                    try {
                        String strQry = "select * from Post where id_foro =" + id_class + "" ;
                        ResultSet rs = null;
                        rs = basesita.consulta(strQry);

                        while (rs.next()) {
                %>
                <div class="post">
                    <div class="infoPost">
                        <%
                            if (rs.getString(8) == null) {
                        %>
                        <div class="headerPost">
                            <table>
                                <tr>
                                    <td><img src="../../General/img/fotoUsu_0.png" width="30" height="20" alt="foto 0" class="imagenUsuCero"/></td>
                                    <td> <h1 class="titulo"><%=rs.getString(2)%></h1></td>
                                </tr>
                            </table>
                        </div>
                        <div class="headerPost">
                            <%=rs.getString(9)%>
                        </div>

                        <%
                        } else {

                        %>
                        <div class="headerPost">
                            <table>
                                <tr>
                                    <td><img class="imagenUsuCero" src="../../General/Usu_img/fotosPerfil/<%=rs.getString(8)%>" width="130" height="130"></td>
                                    <td><h1 class="titulo"><%=rs.getString(2)%></h1></td>
                                </tr>
                            </table>
                        </div>
                        <div class="headerPost">
                            <%=rs.getString(9)%>
                        </div>
                        <%
                            }
                        %>
                    </div>
                    <div class="textoPost">
                        <p>
                            <%=rs.getString(3)%>
                        </p>
                    </div>

                    <form name="form" action="ValidarUsu.jsp" method="post" > 
                        <h3 style="margin-top: 10px;">Comentarios</h3>
                        <div style=" display: flex; ">
                            <input class="postInput" type="text" id="TxtComent" name="comentario" placeholder="Escribe un comentario">
                            <input class="enviarComent" type="submit" id="btnComent" name="btnComent" value="Comentar">
                        </div>
                    </form>
                </div>
                <%
                        }
                        rs.close();
                        basesita.cierraConexion();
                    } catch (Exception ex) {
                        out.print(ex.getMessage());
                    }
                %>


            </div>
        </div>
    </main>

    <footer>
        <div class="contenedor-imagen">

        </div>
    </footer>
    <%            }

    %>
</body>
</html>
