<%-- 
    Document   : Info_claseUsuario
    Created on : 28 mar. 2023, 00:39:43
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
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Poppins&display=swap');
            @import url('https://fonts.googleapis.com/css2?family=Mulish&display=swap');
            *{
                font-family: 'Poppins', sans-serif;
            }
            .card {
                position: relative;
                width: 600px;
                height: 400px;
                margin: auto; margin-top: 140px;
                border-radius: 10px;
                overflow: hidden;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
                transition: transform 0.5s cubic-bezier(0.215, 0.61, 0.355, 1);
            }

            .card__image {
                position: absolute;
                top: 0;
                left: 0;
                width: 600px;
                height: 100%;
                overflow: hidden;
                border-radius: 10px;
            }

            .card__image img {
                width: 600px;
                height: 100%;
                object-fit: cover;
                transition: transform 0.5s cubic-bezier(0.215, 0.61, 0.355, 1);
            }

            .card__content {
                position: absolute;
                bottom: 0;
                left: 0;
                width: 100%;
                padding: 20px;
                background-color: #fff;
                transition: transform 0.5s cubic-bezier(0.215, 0.61, 0.355, 1);
            }

            .card__title {
                font-size: 24px;
                font-weight: bold;
                margin-bottom: 10px;
            }

            .card__text {
                font-size: 16px;
                line-height: 1.5;
                margin-bottom: 20px;
            }

            .card__button {
                display: inline-block;
                padding: 10px 20px;
                background-color: #000;
                color: #fff;
                text-decoration: none;
                border-radius: 5px;
            }


            .card__image {
                height: 400px;
                width: 600px;
                background-color: #000;
                /* you can put img url here  */
            }
        </style>
    </head>
    <body>
        <%
            HttpSession miSessiondelUsuario = (HttpSession) request.getSession();

            int idPersona = (int) (miSessiondelUsuario.getAttribute("id_usu") == null ? 0 : miSessiondelUsuario.getAttribute("id_usu"));
            if (idPersona < 1) {
                response.sendRedirect("../jsp/Menu.jsp");
            }
            String nombre_c = "";
            String grado = "";
            String color = "";
            int id_class = 0;
            BD basesita = new BD();
            basesita.conectar();
            String strQry = "Select * from Usuario_Clase where id_usu ='" + idPersona + "'"; //seleccionar la ultima clase creada por el docente de la tabla Clases
            ResultSet DatosID = basesita.consulta(strQry); // consultar en la BD
            if (DatosID.next()) {
                id_class = DatosID.getInt(1); //obtener el id de esa clase

                String datitos = "Select * from Clases where id_clase = '" + id_class + "'";  //Seleccionar todos los datos de la clase encontrada
                ResultSet DatosClass = basesita.consulta(datitos);
                while(DatosClass.next()) {
                    nombre_c = DatosClass.getString(2);
                    grado = DatosClass.getString(3);
                    color = DatosClass.getString(4);
                }
            }
        %>

        <div class="Info_clase">
            <div class="card">
                <div class="card__image"  style="background-color:<%= color%>;">

                </div>
                <div class="card__content">
                    <p>Nombre de la clase</p>
                    <p class="card__title"><%=nombre_c%></p>
                    <p>Grado de la clase</p>
                    <p class="card__text"><%=grado%></p>
                    <a class="card__button" href="#"></a>
                </div>
            </div>
           
        </div>
    </body>
</html>
