<%-- 
    Document   : edad
    Created on : 28 mar. 2023, 02:01:51
    Author     : kim53
--%>

<%@page import="Conexion.BD"%>
<%@page import="Conexion.Digest"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            //Datos de formulario de registro para Estudiante y docente
          int edad =request.getParameter("edad");
          String nivel =request.getParameter("nivel");

            String strQry = null;

            BD base = new BD();
            try {
                base.conectar();
                strQry = "insert into Usuario(nombre_usu, correo_usu, pass_usu, tipo_usu, tipo_plan, foto_usu)" + "values( '" + usuario + "','" + correo + "','" + pswd + "','" + tipoUsu + "','" + tipoPlan + "' ,'" + fotoUsu + "' )";
                base.insertar(strQry);

            } catch (Exception ex) {
                out.print(ex.getMessage());
            }
            response.sendRedirect("Login.jsp");

        %>

    </body>
</html>
