<%-- 
    Document   : Insert_comentario
    Created on : 26 mar. 2023, 19:32:37
    Author     : kim53
--%>

<%@page import="Conexion.BD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            HttpSession miSessiondelUsuario = (HttpSession) request.getSession();
            int id = (int) (miSessiondelUsuario.getAttribute("id_usu") == null ? 0 : miSessiondelUsuario.getAttribute("id_usu"));
            BD base = new BD();
            base.conectar();
            // Parametros del form CrearPost
            String texto = request.getParameter("textoPost");
            String img = request.getParameter("fileImg");
            String date = request.getParameter("hora");
            String idclase = request.getParameter("idclase");
            String nombre = "";
            String foto = "";
            String tipo = "";
        
        
        %>
    </body>
</html>
