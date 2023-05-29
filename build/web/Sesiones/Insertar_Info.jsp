<%@page import="Conexion.Digest"%>
<%@page import="Conexion.BD"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>MyInfo</title>
        <link rel="stylesheet" href="../Css_A/login.css" >
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Poppins&display=swap');
            @import url('https://fonts.googleapis.com/css2?family=Mulish&display=swap');
        </style>
        <link rel="shorcut icon" href="../../Imagenes/logos/logo_AN.png">
    </head>

    <%
            //Datos de formulario de registro para Estudiante y docente
            String usuario = request.getParameter("TxtUsu");
            String correo = request.getParameter("TxtMail");
            String tipoUsu = request.getParameter("SelectUsu");
            String pass = request.getParameter("TxtPass");
            String tipoPlan = "basico";
            String fotoUsu = "Orion_foto.png";
            
            String pswd = Digest.bytesToHex(Digest.createSha1(pass));
            
            String strQry = null;

            if (!usuario.equals("") && !correo.equals("") && !pass.equals("") && !tipoUsu.equals("")) {
                BD base = new BD();
                try {
                    base.conectar();
                    strQry = "insert into Usuario(nombre_usu, correo_usu, pass_usu, tipo_usu, tipo_plan, foto_usu)" + "values( '" + usuario + "','" + correo + "','" + pswd + "','" + tipoUsu +  "','" + tipoPlan + "' ,'" + fotoUsu + "' )";
                    base.insertar(strQry);

                    
                    /** no sirve xd
                     * switch (tipoUsu) { case "Alumno": strQry = "insert into
                     * Estudiante(nom_usuario, correo_usuario, pass_usuario,
                     * tipo_usuario)" + "values( '" + usuario + "','" + correo +
                     * "','" + pswd + "','" + tipoUsu + "' )";
                     * base.insertar(strQry); break; case "Docente": //strQry =
                     * "insert into Docente(nom_docen, correo_docen, pass_docen,
                     * tipo)" + "values( '" + usuario + "','" + correo + "','" +
                     * pswd + "','" + tipoUsu + "' )"; strQry = "insert into
                     * Estudiante(nom_usuario, correo_usuario, pass_usuario,
                     * tipo_usuario)" + "values( '" + usuario + "','" + correo +
                     * "','" + pswd + "','" + tipoUsu + "' )";
                     * base.insertar(strQry); break; case "Independiente":
                     * strQry = "insert into Estudiante(nom_usuario,
                     * correo_usuario, pass_usuario, tipo_usuario)" + "values(
                     * '" + usuario + "','" + correo + "','" + pswd + "','" +
                     * tipoUsu + "' )"; base.insertar(strQry); break; *
                     */
            }catch (Exception ex) {
                out.print(ex.getMessage());
            }
            response.sendRedirect("Login.jsp");
        }
    %>


    <body>
        <h1> </h1>
    </body>
</html>
