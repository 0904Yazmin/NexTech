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
    String hora = "";

    String textoPost = "";
    BD basesita = new BD();
    basesita.conectar();

    try {
        int id_foro = Integer.parseInt(request.getParameter("id_clase"));
        String strQry = "select * from Post where id_foro=' " + id_foro + " ' order by id_post DESC ";
        ResultSet rs = null;
        rs = basesita.consulta(strQry);

%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Posts</title>
        <link href="../../CSS/CSS_foro/menu_D.css" rel="stylesheet" type="text/css"/>
        <link href="../../CSS/CSS_foro/foro.css" rel="stylesheet" type="text/css"/>
        <link rel="shorcut icon" href="../../General/img/logos/Newlogo.png">
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Poppins&display=swap');
        </style>
    </head>

    <body style=" background:  none;">
        <div style="display: table; float: left; border: none; width:35%;"  >
            <iframe name="postMenu" src="MenusPost.jsp?id_clase=<%=id_foro%>" id="frameMenu" scrolling="no" style=" position: sticky;  position: -webkit-sticky; top: 10%; border: none;"></iframe>
        </div>
        <div id="publicaciones">
            <div id="tituloForo">
                <p><h1>Publicaciones de la clase</h1>
            </div>

            <%                while (rs.next()) {
                    nombre = rs.getString(2);
                    textoPost = rs.getString(3);
            %>
            <div id="post">
                <div>
                    <table id="tablaInfo">
                        <tr>
                            <td rowspan="2"><img class="imagenUsuCero" src="../../Img/fotos_perfil/<%=rs.getString(7)%>" style="margin-right: -20px; border-radius: 100px;"  width="60" height="60"></td>

                            <td><h1><%=nombre%></h1></td>
                            <td style="text-align: right;">Docente</td> 
                        </tr>
                        <tr>
                            <td><h3><%=hora%></h3></td>
                        </tr>
                    </table>
                </div>

                <%
                    if (rs.getString(6) == null) { // imagen del post
                %>
                <div id="txtPost">
                    <p>
                        <%=textoPost%>
                    </p>
                </div>

                <%
                } else {

                %>
                <div id="txtPost">
                    <p>
                        <%=textoPost%>
                    </p>
                    <div id="ImagePost">
                        <img class="imagenUsuCero" src="../../Img/Fotos_post/<%=rs.getString(6)%>" alt="image" style="width: 90%; height: 40%; " id="ImagePost">
                    </div>
                </div>
                <%                }
                %>

                <div id="cajitaComent" style="border-top: 1px gray;">
                    <form name="form" action="ValidarUsu.jsp" method="post" > 
                        <h3 style="margin-top: 10px;">Comentarios</h3>
                        <div style=" display: flex; ">
                            <input class="postInput" type="text" id="TxtComent" name="comentario" placeholder="Escribe un comentario">
                            <input class="enviarComent" type="submit" id="btnComent" name="btnComent" value="Comentar">
                        </div>
                    </form>
                </div>
            </div>
            <%                    }

                    rs.close();

                    basesita.cierraConexion();
                } catch (Exception ex) {
                    out.print(ex.getMessage());
                }


            %>





        </div>

    </body> 
</html>
