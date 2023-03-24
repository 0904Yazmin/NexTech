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
        String foto = "";
        String pass = "";

        base.conectar();
        String strQry = "select * from Usuario where id_usu='" + id + "'";

        ResultSet info = base.consulta(strQry);

        while (info.next()) {
            nombre = info.getString(2);
            correo = info.getString(3);
            tipo = info.getString(6);
            grado = info.getString(7);
            foto = info.getString(5);
            pass = info.getString(4);
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
        <form name="datosEdit" action="actualizarPass.jsp" method="post">
            <div id="cuadro4" style="background-color: white; color: black;">
                <table class="tablita" border="0">
                    <tr>
                        <td><h1>Cambiar contraseña</h1></td>
                    </tr>
                    <tr>
                        <td>Escriba su contraseña anterior</td>
                    </tr>
                    <tr>
                        <td><input id="pass" type="text" name="pass"  class="actu" value="" ></td>
                    </tr>
                    <tr>
                        <td>Nueva contraseña</td>
                    </tr>
                    <tr>
                        <td><input id="passNew" type="password" name="passNew"  class="actu" value="" ></td>
                    </tr>
                    <tr>
                        <td>Confirmar nueva contraseña </td><td>
                    </tr>
                    <tr>
                        <td><input id="passConfirm" type="password" name="passConfirm"  class="actu" value="" ></td>
                    </tr>
                    <tr>
                    <center><td colspan='2'><input id="BtnEditar" name="BtnEditar" type="submit"  class="actu_b" value="Actualizar contraseña"/></td></center>
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
