<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession miSessiondelUsuario = (HttpSession) request.getSession();
    miSessiondelUsuario.invalidate();
    response.sendRedirect("Login.jsp");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Salir</h1>
    </body>
</html>
