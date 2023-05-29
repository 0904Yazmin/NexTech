<%-- 
    Document   : actualizarInfo
    Created on : 13 nov. 2022, 09:00:59
    Author     : kim53
--%>

<%@page import="Conexion.BD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>new info</title>
    </head>
    <body>
        <%
            HttpSession miSessiondelUsuario = (HttpSession) request.getSession();

            int id = (int) (miSessiondelUsuario.getAttribute("id_usu") == null ? 0 : miSessiondelUsuario.getAttribute("id_usu"));
            BD base = new BD();

            String nombre = request.getParameter("txtN");

            try {
                base.conectar();

                String dato = "update Usuario set nombre_usu ='" + nombre + "'where id_usu='" + id + "'";
                int resultadoEdita = base.edita(dato);
                String dato2 = "update Post set autor_post ='" + nombre + "'where id_usu='" + id + "'";
                base.edita(dato2);
                String dato3 = "update Comentarios set autor_com ='" + nombre + "'where id_usu='" + id + "'";
                base.edita(dato3);
                /**
                 * out.println("Instrucción en SQL a realizar " + dato);
                 * out.println("Resultado de la modificación " +
                 * resultadoEdita); *
                 */

                if (resultadoEdita == 1) {
        %>
        <script>
            window.alert("Los datos se modificaron correctamente");
        </script>

        <%
                }
                response.sendRedirect("editaInfo.jsp");
            } catch (Exception ex) {
                out.println(ex.getMessage());
            }
        %>




    </body>
</html>
