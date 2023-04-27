<%-- 
    Document   : bienvenido
    Created on : 18 mar. 2023, 22:57:30
    Author     : kim53
--%>
<%@page import="java.sql.ResultSet"%>
<%@page import="Conexion.BD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession miSessiondelUsuario = (HttpSession) request.getSession();

    int idPersona = (int) (miSessiondelUsuario.getAttribute("id_usu") == null ? 0 : miSessiondelUsuario.getAttribute("id_usu"));
    if (idPersona < 1) {
        response.sendRedirect("../jsp/Menu.jsp");
    }
    String nombre = "";
    String correo = "";
    BD basesita = new BD();
    basesita.conectar();
    String datitos = "Select * from Usuario where id_usu = '" + idPersona + "'";
    ResultSet rsDatosPer = basesita.consulta(datitos);
    if (rsDatosPer.next()) {
        nombre = rsDatosPer.getString(2);
        correo = rsDatosPer.getString(3);
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Copernicus System</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Poppins&display=swap');
        </style>
        <link rel="shorcut icon" href="../Img/logos/LogoCopernicus.png">
        <link href="../CSS/menu_bienvendo.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
   
    <div  style="z-index: -10;">
        <iframe src='https://my.spline.design/forestlightscopy-7af51de18e755a4630775ceb04bd50e6/' frameborder='0' width="100%" height="900" 
        ></iframe>
    </div>


    <div class="Principal" id="Principal">
        <center><h1>Bienvenido  <%=nombre%> </h1></center>
    </div>
</body>
</html>
