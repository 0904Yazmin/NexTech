<%@page import="java.sql.ResultSet"%>
<%@page import="Conexion.Crear_Clase"%>
<%@page import="java.security.SecureRandom"%>
<%@page import="Conexion.BD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Crear clase</title>
    </head>

    <%
        HttpSession miSessiondelUsuario = (HttpSession) request.getSession();

        int id = (int) (miSessiondelUsuario.getAttribute("id_usu") == null ? 0 : miSessiondelUsuario.getAttribute("id_usu"));

        //Datos del formulario para crear clase
        int len = 8;
        String nom_clase = request.getParameter("TxtClase");
        String gradoClase = request.getParameter("SelectGrado");
        String color = request.getParameter("color");
        String clave = Crear_Clase.generarClase(len);

        if (!nom_clase.equals("") && !gradoClase.equals("")) {
            BD clasesita = new BD();
            try {
                clasesita.conectar();
                // Crear una nueva clase
                String infoClass = "insert into Clases(nom_clase, grado, clave ,id_usu, color)" + "values( '" + nom_clase + "','" + gradoClase + "','" + clave + "','" + id +  "','" + color +"' )";
                int resultadoInsert = clasesita.insertar(infoClass);

                try {
                    // Seleccionar el id de esta nueva clase
                    String strQry = "Select max(id_clase) from Clases where id_usu ='" + id + "'";
                    ResultSet Datito = clasesita.consulta(strQry);
                    if (Datito.next()) {
                        HttpSession sesionClase = (HttpSession) request.getSession();
                        int id_class = Datito.getInt(1);
                        //System.out.println(id_class);
                        //System.out.println(strQry);
                        sesionClase.setAttribute("id_clase", id_class); 

                        String newForo = "insert into Foro(id_clase)" + "values( '" + id_class + "' )";  //Creamos el foro de la clase apartir del id de la clase creada
                        clasesita.insertar(newForo);
                    } else {

                    }
                } catch (Exception ex) {
                    out.print(ex.getMessage());
                }

            } catch (Exception ex) {
                out.print(ex.getMessage());
            }

            response.sendRedirect("ClasesitaCreada.jsp"); 
         //   response.sendRedirect("../html_D/CrearClaseForm.html");
        }
    %>
    <body>
        <!-- 
        <script>
            // location.href = '';
        </script>
        -->
    </body>
</html>
