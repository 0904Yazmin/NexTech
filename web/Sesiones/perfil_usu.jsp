
<%@page import="java.sql.ResultSet"%>
<%@page import="Conexion.BD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession miSessiondelUsuario = (HttpSession) request.getSession();

    int idPersona = (int) (miSessiondelUsuario.getAttribute("id_usu") == null ? 0 : miSessiondelUsuario.getAttribute("id_usu"));
    if (idPersona < 1) {
        response.sendRedirect("../jsp/Menu.jsp");
    }
    try {
        String nombre = "";
        String correo = "";
        String grado = "";
        String tipo = "";
        String foto = "";

        BD basesita = new BD();
        basesita.conectar();

        String datitos = "Select * from Usuario where id_usu= '" + idPersona + "'";
        String info2 = "Select * from imgUsu where id_usu = '" + idPersona + "'";
        ResultSet rsDatosPer = basesita.consulta(datitos);

        while (rsDatosPer.next()) {
            nombre = rsDatosPer.getString(2);
            correo = rsDatosPer.getString(3);
            tipo = rsDatosPer.getString(6);
            grado = rsDatosPer.getString(7);
            foto = rsDatosPer.getString(5);

%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tu cuenta</title>
        <link rel="stylesheet" href="../css_A/menu_A.css" >
        <link href="../CSS/perfil.css" rel="stylesheet" type="text/css"/>
        <style>@import url('https://fonts.googleapis.com/css2?family=Quicksand:wght@500&display=swap');</style>
        <style>@import url('https://fonts.googleapis.com/css2?family=Poppins&display=swap');</style>
        <link rel="shorcut icon" href="../../General/img/logos/Newlogo.png">
    </head>
    <body id="principal">


        <div class="dos">
            <div id="cuadro1">
                <br>
                <p><h1>Tu cuenta</h1>
                <p>  <%=nombre%></p>
            </div>

            <div id="cuadro2">
                <p>Foto de perfil</p>
                <%
                    if (rsDatosPer.getString(5) == null) {
                %>
                <img src="../Img/fotoUsu_0.png" width="130" height="120" alt="foto 0" class="imagenUsuCero"/>

                <%
                } else {

                %>
                <img class="imagenUsuCero" src="../Img/fotos_perfil/<%=foto%>" width="130" height="130">

                <%
                    }
                %>

                <p><a href="Editar/EditaDatos.jsp" class="editarBtn">Editar datos de usuario</a></p>


            </div>


            <div id="cuadro3">
                <table class="tablita2">
                    <tr>
                        <td>Nombre de usuario: </td><td><%=nombre%></td>
                    </tr>
                    <tr>
                        <td>Correo electrónico: </td><td><%=correo%></td>
                    </tr>
                    <tr>
                        <td>Tipo de usuario</td><td><%=tipo%></td>
                    </tr>
                    <tr><br>
                    <td><a  class="link_borrar" href="Editar/eliminarConfirm.jsp">Borrar cuenta</a></td>
                    <td></td>
                    </tr>
                </table>

            </div>

        </div>



        <%            }
                rsDatosPer.close();
                basesita.cierraConexion();

            } catch (Exception ex) {
                out.print(ex.getMessage());
            }
            //}


        %>
    </body>
</html>
