<%@page import="Conexion.BD"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.ResultSet"%>
<%

    HttpSession miSessiondelUsuario = (HttpSession) request.getSession();

    int idPersona = (int) (miSessiondelUsuario.getAttribute("id_usu") == null ? 0 : miSessiondelUsuario.getAttribute("id_usu"));
    if (idPersona < 1) {
        response.sendRedirect("../jsp/Menu.jsp");
    }
    String nombre = "";
    String clave = "";
    String color = "";
    String grado = "";
    BD basesita = new BD();
    basesita.conectar();

%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="../../CSS/CSS_foro/foro.css" rel="stylesheet" type="text/css"/>
        <link rel="shorcut icon" href="../../General/img/logos/Newlogo.png">
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Poppins&display=swap');
            .botoncitos:hover{ background-color: <%=color%>;}
        </style>
    </head>
    <body id="crearP">
        <div class="div_1">
            <%                try {
                    int id_clasesita = Integer.parseInt(request.getParameter("id_clase"));
                    String strQry = "select * from Clases where id_clase='" + id_clasesita + "'";
                    ResultSet rs = null;
                    rs = basesita.consulta(strQry);

                    while (rs.next()) {
                        nombre = rs.getString(2);
                        clave = rs.getString(4);
                        grado = rs.getString(3);
                        color = rs.getString(6);
            %>

            <div class="infoClase">
                <aside class="card">
                    <h1><%=nombre%></h1>
                    <div class="clip" style="background-color:<%= color%>; font-size: 13px; line-height: 15px;">
                        <div style="display: flex; color: white;"> <p>Grado de la clase: <%=grado%> </p></div>
                        <div style="display: flex; color: white;"> <p>Clave: <%=clave%></p></div>
                    </div>
                </aside>
            </div>

            <nav id="indice">
                <center><h1>Crear publicación</h1></center>
                <form name="crearPost" action="infoForo.jsp" method="post"> 
                    <table class="tablita" border="0">
                        <tr>
                            <td>
                        <center><textarea cols="75" rows="5" name="textoPost" id="textoPost" class="info textArea" placeholder="Escribe lo que quieras" required></textarea></center>
                        </td>
                        </tr>
                        <tr>
                            <td>
                                <input id="fileImg" type="file" name="fileImg"  class="fileImg" accept="image/*" >
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <input   type="reset" class="botoncitos" >
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <input type="hidden"  id="idclase" name="idclase" value="<%=rs.getString(1)%>">
                                <input type="hidden"  id="hora" name="hora" onclick="Date()" value="">
                                <input class="botoncitos" type="submit" id="btn" name="btn"  value="Publicar"  >
                            </td>
                        </tr>
                    </table>
                </form>
            </nav>
        </div>


        <%                 }

                rs.close();

                basesita.cierraConexion();
            } catch (Exception ex) {
                out.print(ex.getMessage());
            }


        %>
        <script>
            document.getElementById("hora").innerHTML = Date();
        </script>

    </body>
</html>
