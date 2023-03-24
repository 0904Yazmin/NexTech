<%-- 
    Document   : eliminarCuenta
    Created on : 13 nov. 2022, 11:29:52
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
            int id_usu = (int) (miSessiondelUsuario.getAttribute("id_usu") == null ? 0 : miSessiondelUsuario.getAttribute("id_usu"));
            BD bd = new BD();
            try {
                bd.conectar();
                String strQryPer = "delete from Usuario where id_usu = '" + id_usu + "'";
                int resultadoBorra = bd.borrar(strQryPer);

                response.sendRedirect("../Login.jsp");
            } catch (Exception XD) {
            }
        %>
    </body>
</html>
