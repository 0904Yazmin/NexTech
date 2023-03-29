<%-- 
    Document   : validarClave
    Created on : 19 nov. 2022, 21:17:10
    Author     : kim53
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="Conexion.BD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    HttpSession miSessiondelUsuario = (HttpSession) request.getSession();

    int id_estudiante = (int) (miSessiondelUsuario.getAttribute("id_usu") == null ? 0 : miSessiondelUsuario.getAttribute("id_usu"));
    if (id_estudiante < 1) {
        response.sendRedirect("../jsp/Menu.jsp");
    }
    String clave = request.getParameter("code");

    if (clave == null) {
        clave = "0";
    } else {
        if (clave.equals("")) {
            clave = "0";
        }
    }
    if (!clave.equals("0")) {
        BD bd = new BD();
        bd.conectar();
        int num = 0;

        String strQry = "Select * from Clases where clave='" + clave + "'";
        ResultSet DatosClass = bd.consulta(strQry);
        if (DatosClass.next()) {
            int id_clasesita = DatosClass.getInt(1);
            String gradito = DatosClass.getString(3);
            String infoClass = "insert into Usuario_Clase(id_usu, id_clase)" + "values( '" + id_estudiante + "','" + id_clasesita + "' )";
            String act = "update Usuario set grado_usuario ='" + gradito + "'where id_usu='" + id_estudiante + "'";
            bd.insertar(infoClass);
            bd.insertar(act);

            response.sendRedirect("../../Menu_nav/menu_alumno.jsp");

        } else {

        }
    } else {

    }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Unirse a una clase</title>
        <link rel="stylesheet" href="../../Docente/css_D/newClass.css" ><!--  -->
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Poppins&display=swap');
            @import url('https://fonts.googleapis.com/css2?family=Mulish&display=swap');
        </style>
        
    </head>
    <body>
        <header>
            <table>
                <tr>
                    <td>
                        <img src="../../Img/logos/LogoCopernicus.png"  alt="logoCS" class="imglogo"/>
                    </td>
                    <td>
                        <a href="../../index.html"><h1>Copernicus System</h1></a>
                    </td>
                </tr>
            </table>
        </header>
        <div class="cuadro4">
            <div class="p2">
                <img src="../../Img/logos/LogoCopernicus.png" alt="logoCS" id="logoCS"/>Copernicus System

            </div>
            <div class="ingresarCode">
                <h1>El código ingresado no existe</h1><br>
                <a href="claveLoginClass.jsp">Regresar</a>
            </div>
        </div>
    </body>
</html>
