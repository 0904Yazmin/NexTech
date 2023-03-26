<%-- 
    Document   : clasesitas
    Created on : 20 mar. 2023, 21:37:21
    Author     : kim53
--%>

<%@page import="Conexion.BD"%>
<%@page import="java.sql.ResultSet"%>
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
        <title>JSP Page</title>
        <link href="../../CSS/CSS_foro/clasesitas.css" rel="stylesheet" type="text/css"/>
        <link rel="shorcut icon" href="../Img/logos/LogoNexTech.png">
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Poppins&display=swap');
        </style>
    </head>
    <body>
        <h1>clases</h1>
        
    </body>
</html>
