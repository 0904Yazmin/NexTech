<%@page import="java.sql.ResultSet"%>
<%@page import="Conexion.BD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    HttpSession miSessiondelUsuario = (HttpSession) request.getSession();

    int idPersona = (int) (miSessiondelUsuario.getAttribute("id_usu") == null ? 0 : miSessiondelUsuario.getAttribute("id_usu"));
    if (idPersona < 1) {
        response.sendRedirect("../jsp/Menu.jsp");
    }
    String nombre_c = "";
    String grado = "";
    String clave = "";
    int id_class = 0;
    BD basesita = new BD();
    basesita.conectar();
    String strQry = "Select max(id_clase) from Clases where id_usu ='" + idPersona + "'"; //seleccionar la ultima clase creada por el docente de la tabla Clases
    ResultSet DatosID = basesita.consulta(strQry); // consultar en la BD
    if (DatosID.next()) {
        id_class = DatosID.getInt(1); //obtener el id de esa clase
    }
    String datitos = "Select * from Clases where id_clase = '" + id_class + "'";  //Seleccionar todos los datos de la clase encontrada
    ResultSet DatosClass = basesita.consulta(datitos);
    if (DatosClass.next()) {
        nombre_c = DatosClass.getString(2);
        grado = DatosClass.getString(3);
        clave = DatosClass.getString(4);
    }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tu Clase</title>
        <link href="../../CSS/newClass.css" rel="stylesheet" type="text/css"/>
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Poppins&display=swap');
            @import url('https://fonts.googleapis.com/css2?family=Mulish&display=swap');
        </style>
        <link rel="shorcut icon" href="../../General/img/logos/Newlogo.png">
    </head>


    <body>
        
        <div class='cuadro3'>
            <div class="newClass">
                <h1>Nueva clase</h1>
                <table>
                    <tr>
                        <td>Nombre de la clase:</td><td><%=nombre_c%></td>
                    </tr>
                    <tr>
                        <td>Grado de la clase: </td><td><%=grado%></td>
                    </tr>
                </table>
                <br> <br> <br>
                <p> <a href="Menu_D.jsp">Regresar al menú principal</a> </p>
            </div>

            <div class="div_clave">
                <p>El código de tu nueva clase es:</p>
                <div id="TextoACopiar"><h1><%=clave%></h1></div>
                <button id="BotonCopiar" class="btn btn-primary">Copiar clave</button>
                <br>
                <p>¡Comparte este código con tus alumnos para que se unan a esta clase!</p>
            </div>

        </div>
        <script>
            document.getElementById('BotonCopiar').addEventListener('click', copiarAlPortapapeles);
            function copiarAlPortapapeles(ev) {
                // Obtener contenido del div oculto
                let contenido = document.getElementById('TextoACopiar').textContent;
                // Crear input
                let input = document.createElement('input');
                // Asignar contenido
                input.value = contenido;
                // Agregar input a documento
                document.body.appendChild(input);
                // Seleccionar contenido
                input.select();
                // Copiar
                document.execCommand('copy');
                // Eliminar input
            }
        </script>
    </body>
</html>
