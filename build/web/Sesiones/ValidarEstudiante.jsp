<%@page import="Conexion.Digest"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="Conexion.BD"%>
<%@page contentType="text/html" pageEncoding="UTF-8" session="true" %>
<!DOCTYPE html>
<%
    String usuario = request.getParameter("email");
    String pass = request.getParameter("password");
    String pswd = Digest.bytesToHex(Digest.createSha1(pass));

    if (usuario == null) {
        usuario = "0";
    } else {
        if (usuario.equals("")) {
            usuario = "0";
        }
    }
    if (pass == null) {
        pass = "0";
    } else {
        if (pass.equals("")) {
            pass = "0";
        }
    }
    if (!usuario.equals("0") && !pass.equals("0")) {
        BD bd = new BD();
        bd.conectar();
        int num = 0;

        String strQry = "Select * from Estudiante where correo_usuario='" + usuario + "'and pass_usuario = '" + pswd + "'";
        ResultSet DatosUsu = bd.consulta(strQry);
        if (DatosUsu.next()) {
            HttpSession miSessiondelUsuario = (HttpSession) request.getSession();
            int idPersona = DatosUsu.getInt("id_usuario");
            String nombre = DatosUsu.getString("nom_usuario");
            String tipo = DatosUsu.getString("tipo_usuario");
            miSessiondelUsuario.setAttribute("id_usuario", idPersona);
            miSessiondelUsuario.setAttribute("Nombre del alumno", nombre);
            String grado = DatosUsu.getString(7);

            switch (tipo) {
                case "Alumno":
                    if (grado == null) {
                        response.sendRedirect("../Alumno/jsp_A/claveLoginClass.jsp");
                    } else {
                        response.sendRedirect("../Alumno/jsp_A/Menu_A.jsp");
                    }
                    break;
                case "Docente":
                    if (grado == null) {
                        response.sendRedirect("../Menu_nav/menu_docente.jsp");
                    } else {
                        response.sendRedirect("../Alumno/jsp_A/Menu_A.jsp");
                    }
                    break;
                case "Independiente":
                    if (grado == null) {
                        response.sendRedirect("../Indep/jsp_I/ExamD_Grado.jsp");
                    } else {
                        response.sendRedirect("../Indep/jsp_I/Menu_I.jsp");
                    }
                    break;
            }
        } else {

        }
    } else {
        response.sendRedirect("Registro.html");
    }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Usuario desconocido</title>
        <link rel="stylesheet" href="css/registro.css" >
    </head>
    <body>
        <div class="div2">
            <center>
                <h1>Este usuario no existe :(</h1>
                <h3><a href="Login.jsp">Regresar al inicio de sesión</a></h3>
            </center>
        </div>
    </body>
    <footer>
        <div class="footer1">
            <p>
                Copernicus System
            </p>
        </div>
        <div class="footer2">
            <p>Equipo 6 Tuna tech</p>
            <p>Integrantes</p>
            <p>Aguilera García Christopher Emmanuel
            <p>Cisneros Mendoza Gerardo Uriel</p>
            <p>García López Arturo</p>
            <p> Reyes Barquera Yazmin</p>

        </div>
    </footer>
</html>
