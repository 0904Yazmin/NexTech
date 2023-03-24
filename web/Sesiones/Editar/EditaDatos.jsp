<%@page import="Conexion.BD"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%
    HttpSession miSessiondelUsuario = (HttpSession) request.getSession();

    int idPersona = (int) (miSessiondelUsuario.getAttribute("id_usu") == null ? 0 : miSessiondelUsuario.getAttribute("id_usu"));
    if (idPersona < 1) {
        response.sendRedirect("../jsp/Menu.jsp");
    }
    try {
        String nombre = "";
        String correo = "";

        BD basesita = new BD();
        basesita.conectar();

        String datitos = "Select * from Usuario where id_usu = '" + idPersona + "'";
        String info2 = "Select * from imgUsu where id_usu = '" + idPersona + "'"; // no hagas caso a esto xd
        ResultSet rsDatosPer = basesita.consulta(datitos);

        while (rsDatosPer.next()) {
            nombre = rsDatosPer.getString(2);


%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tu cuenta</title>
        <link href="../../CSS/editaDatos.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="../css_A/menu_A.css" >
        <style>@import url('https://fonts.googleapis.com/css2?family=Quicksand:wght@500&display=swap');</style>
        <style>@import url('https://fonts.googleapis.com/css2?family=Poppins&display=swap');</style>
        <link rel="shorcut icon" href="../../General/img/logos/Newlogo.png">
    </head>
    <body id="principal">

        <div class="dos">
            <!-- Frames que contienen paginas jsp con los 3 formularios para editar info (foto del usuario, info del usuario y cambio de contraeña)-->

            <div id="cuadro1"><!-- frame con el jsp para cambiar contraseña-->
                <iframe id="FRAME" src="editaPass.jsp" width="380" height="450" style="border:none; z-index: 100; " scrolling="no" ></iframe>
            </div>

            <div id="cuadro2"> <!-- frame con el formulario para editar info de usuario -->
                <iframe id="FRAME" src="editaInfo.jsp" width="350" height="450" style="border:none; z-index: 100; " scrolling="no" ></iframe>
            </div>

            <div id="cuadro3"> <!-- frame con formulario para agregar foto de perfil -->
                <iframe id="FRAME" src="editaFoto.jsp" width="400" height="450" style="border:none; z-index: 100; " scrolling="no" ></iframe>
            </div>

        </div>


        <%            }
                rsDatosPer.close();
                basesita.cierraConexion();

            } catch (Exception ex) {
                out.print(ex.getMessage());
            }


        %>
    </body>
</html>
