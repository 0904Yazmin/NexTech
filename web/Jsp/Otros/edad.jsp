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
            HttpSession miSessiondelUsuario = (HttpSession) request.getSession();

            int idPersona = (int) (miSessiondelUsuario.getAttribute("id_usu") == null ? 0 : miSessiondelUsuario.getAttribute("id_usu"));
            if (idPersona < 1) {
                response.sendRedirect("../jsp/Menu.jsp");
            }
            int edad = Integer.parseInt(request.getParameter("edad"));
            String nivel = request.getParameter("nivel");

            String strQry = null;
            BD base = new BD();
            try {
                base.conectar();
                if (edad < 13) {
                    switch (nivel) {
                        case "Basico":
                            strQry = "insert into Usuario_Clase(id_usu, id_clase)" + "values( '" + idPersona + "','" + 1 + "' )";
                            break;
                        case "Intermedio":
                            strQry = "insert into Usuario_Clase(id_usu, id_clase)" + "values( '" + idPersona + "','" + 2 + "' )";
                            break;
                        case "Avanzado":
                            strQry = "insert into Usuario_Clase(id_usu, id_clase)" + "values( '" + idPersona + "','" + 3 + "' )";
                            break;
                    }
                } else {
                    switch (nivel) {
                        case "Basico":
                            strQry = "insert into Usuario_Clase(id_usu, id_clase)" + "values( '" + idPersona + "','" + 4 + "' )";
                            break;
                        case "Intermedio":
                            strQry = "insert into Usuario_Clase(id_usu, id_clase)" + "values( '" + idPersona + "','" + 5 + "' )";
                            break;
                        case "Avanzado":
                            strQry = "insert into Usuario_Clase(id_usu, id_clase)" + "values( '" + idPersona + "','" + 6 + "' )";
                            break;
                    }
                }
                base.insertar(strQry);

            } catch (Exception ex) {
                out.print(ex.getMessage());
            }
            response.sendRedirect("../../Menu_nav/menu_indep.jsp");

        %>

    </body>
</html>
