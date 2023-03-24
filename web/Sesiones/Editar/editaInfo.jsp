<%@page import="java.sql.ResultSet"%>
<%@page import="Conexion.BD"%>
<%@page contentType="text/html" pageEncoding="UTF-8" session="true"%>
<!DOCTYPE html>
<%
    HttpSession miSessiondelUsuario = (HttpSession) request.getSession();

    int id = (int) (miSessiondelUsuario.getAttribute("id_usu") == null ? 0 : miSessiondelUsuario.getAttribute("id_usu"));
    BD base = new BD();

    try {
        String nombre = "";
        String correo = "";
        String grado = "";
        String tipo = "";
        base.conectar();
        String strQry = "select * from Usuario where id_usu='" + id + "'";

        ResultSet info = base.consulta(strQry);

        while (info.next()) {
            nombre = info.getString(2);
            correo = info.getString(3);
            tipo = info.getString(6);
            grado = info.getString(7);
            
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Editar perfil</title>
        <link href="../../CSS/editaDatos.css" rel="stylesheet" type="text/css"/>
        <style>@import url('https://fonts.googleapis.com/css2?family=Quicksand:wght@500&display=swap');</style>
        <style>@import url('https://fonts.googleapis.com/css2?family=Poppins&display=swap');</style>
        <link rel="shorcut icon" href="../../General/img/logos/Newlogo.png">
    </head>
    <body id="Principal">
        <form name="datosEdit" action="actualizarInfo.jsp" method="post">
            <div id="cuadro4" style="background-color: white; color: black;">
                <table class="tablita" border="0">
                    <tr>
                        <td><h1>Editar datos</h1></td>
                    </tr>
                    <tr>
                        <td>Nombre de usuario</td>
                    </tr>
                    <tr>
                        <td><input id="txtN" type="text" name="txtN"  class="actu" value="<%=nombre%>" ></td>
                    </tr>
                    <tr>
                        <td>Correo electrónico: </td>
                    </tr>
                    <tr>
                        <td><input id="TxtCorreo" type="text" name="TxtCorreo"  class="actu" value="<%=correo%>" readonly="readonly"></td>
                    </tr>
                    <tr>
                        <td>Grado de estudiante</td><td>
                    </tr>
                    <tr>
                        <td><input id="TxtCorreo" type="text" name="TxtCorreo"  class="actu" value="<%=grado%>" readonly="readonly"></td>
                    </tr>
                    <tr>
                    <center><td colspan='2'><input id="BtnEditar" name="BtnEditar" type="submit"  class="actu_b" value="Actualizar datos"/></td></center>
                    </tr>
                   
                    <br><br> <br>

                </table>

            </div>

        </form>

        <%            }
            } catch (Exception ex) {
                out.println(ex.getMessage());
            }
        %>
    </body>
</html>
