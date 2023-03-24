<%-- 
    Document   : eliminarConfirm
    Created on : 13 nov. 2022, 11:06:32
    Author     : kim53
--%>

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
    try {
        String nombre = "";
        String correo = "";
        String grado = "";
        String tipo = "";
        String foto = "";

        BD basesita = new BD();
        basesita.conectar();

        String datitos = "Select * from Usuario where id_usu = '" + idPersona + "'";
        ResultSet rsDatosPer = basesita.consulta(datitos);

        while (rsDatosPer.next()) {
            nombre = rsDatosPer.getString(2);
            correo = rsDatosPer.getString(3);
            tipo = rsDatosPer.getString(6);
            grado = rsDatosPer.getString(7);
            foto = rsDatosPer.getString(5);

%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Eliminar cuenta</title>

        <link href="../../CSS/guardarImg.css" rel="stylesheet" type="text/css"/>
        <style>@import url('https://fonts.googleapis.com/css2?family=Quicksand:wght@500&display=swap');</style>
        <style>@import url('https://fonts.googleapis.com/css2?family=Poppins&display=swap');</style>
        <link rel="shorcut icon" href="../../../General/img/logos/Newlogo.png">
    </head>
    <body>
        <div class="window-notice" id="window-notice">
            <div class="content">
                <div class="content-text">
                    <p><h1>Eliminar cuenta</h1>
                    <p>¿Seguro que quieres eliminar tu cuenta?</p>
                    <p>Se eliminarán todos tus datos y progreso en Copernicus System</p>
                    <br> <br>
                    
                </div>
                <div class="content-buttons">
                    <p><a href="eliminarCuenta.jsp?id_usu=<%=idPersona%>" class="boton_eliminar">Eliminar mi cuenta</a></p>
                    <a href="../perfil_usu.jsp" class="boton_eliminar">Regresar</a></div>
            </div>
        </div>
    </body>

    <%            }
            rsDatosPer.close();
            basesita.cierraConexion();

        } catch (Exception ex) {
            out.print(ex.getMessage());
        }
        //}


    %>
</html>
