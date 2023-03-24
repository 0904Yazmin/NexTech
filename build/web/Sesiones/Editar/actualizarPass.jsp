<%-- 
    Document   : actualizarPass
    Created on : 13 nov. 2022, 09:44:15
    Author     : kim53
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="Conexion.Digest"%>
<%@page import="Conexion.BD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>new pass</title>
    </head>
    <body>
        <%
            HttpSession miSessiondelUsuario = (HttpSession) request.getSession();

            int id = (int) (miSessiondelUsuario.getAttribute("id_usu") == null ? 0 : miSessiondelUsuario.getAttribute("id_usu"));
            BD base = new BD();
            // datos del formulario para cambiar contraseña
            String pass = request.getParameter("pass");
            String newPass = request.getParameter("passNew");
            String ConfirmPass = request.getParameter("passConfirm");
            if (!pass.equals("") && !newPass.equals("") && !pass.equals("") && !ConfirmPass.equals("")) {

                // cifrado de contraseñas para compararlas con las guardadas en la BD
                String pswd = Digest.bytesToHex(Digest.createSha1(pass));  // contraseña vieja cifrada, se va a comparar con la que esta en la BD
                String NEWPASSWORD = Digest.bytesToHex(Digest.createSha1(newPass)); // nueva contraseña cifrada con sha1
                try {
                    base.conectar();

                    //String strQry = "Select pass_usuario from Estudiante where id_usuario = '" + id + "'";
                    String strQry = "Select * from Usuario where id_usu = '" + id + "'";
                    ResultSet result = base.consulta(strQry);
                    if (result.next()) {
                        String datitoPass = result.getString(4);
                        if (datitoPass.equals(pswd) || pswd.equals(datitoPass)) {
                            if (newPass.equals(ConfirmPass) || newPass == ConfirmPass) {
                                String dato = "update Usuario set pass_usu ='" + NEWPASSWORD + "'where id_usu='" + id + "'";
                                int resultadoEdita = base.edita(dato);
                                if (resultadoEdita == 1) {
        %>
        <script>
            window.alert("La contraseña se ha actualizado correctamente");
        </script>
        <%
            }

        } else {
        %>
        <script>
            window.alert("La contraseñas no coinciden");
        </script>
        <%
            }
        } else {

        %>
        <script>
            window.alert("La contraseñas no coinciden");
        </script>


        <%                }
                }
            } catch (Exception ex) {
                out.println(ex.getMessage());
            }

        } else {

        %>
        <script>
            window.alert("Rellena los campos");
        </script>
        <%                response.sendRedirect("editaPassA.jsp");
            }

        %>

    </body>
</html>
