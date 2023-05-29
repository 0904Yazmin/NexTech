<%-- 
    Document   : Insert_comentario
    Created on : 26 mar. 2023, 19:32:37
    Author     : kim53
--%>

<%@page import="java.sql.ResultSet"%>
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
            String texto = request.getParameter("textarea");

            try {
                String UsuarioInfo = "Select * from Usuario where id_usu = '" + id + "'"; //selecionamos los datos del usuario de la tabla Usuario
                ResultSet rsDatosPer = base.consulta(UsuarioInfo);

                String datitos = "Select * from Usuario_Clase where id_usu = '" + id + "'"; // seleccionamos los datos de la clase de la tabla Usuario_Clase
                ResultSet Datos = base.consulta(datitos);

                if (rsDatosPer.next()) {
                    String nombre_usu = rsDatosPer.getString(2);
                    while (Datos.next()) {
                        int id_clase = Datos.getInt(2);
                        String posts = "Select * from Post where id_foro = '" + id_clase + "'"; // seleccionamos los datos de la clase de la tabla Usuario_Clase
                        ResultSet rsPOST = base.consulta(posts);
                        if (rsPOST.next()) {
                            int id_postito = rsPOST.getInt(1);
                            String dato = "INSERT into Comentarios (autor_com, comentario, id_usu, id_post)" + "values( ' " + nombre_usu + " ' , ' " + texto + "','" + id + "','"  + id_postito + "' )";

                            base.insertar(dato);

                        }
                    }
                }
                response.sendRedirect("../foro_usuarioA.jsp");
                base.cierraConexion();
            } catch (Exception XD) {
            }
        %>


        %>
    </body>
</html>
