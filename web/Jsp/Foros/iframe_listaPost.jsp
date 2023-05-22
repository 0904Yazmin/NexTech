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
    String nombre = "";
    String correo = "";
    String foto = "";
    String tipo = "";
    String grado = "";
    BD basesita = new BD();
    basesita.conectar(); // no conectamos a la base de datos nexTech

    // (apartir de su id) Mandamos la instruccion (guardada en la variable UsuarioInfo) donde le decimos que vamos a seleccionar todos los datos del usuario que estan en la tabla Usuario 
    String UsuarioInfo = "Select * from Usuario where id_usu= '" + idPersona + "'";
    // Aparitr de un ResulSet consulta los datos 
    ResultSet rsDatosPer = basesita.consulta(UsuarioInfo);

    // (apartir de la id del usuario) Mandamos la instruccion (guardada en la variable datitos) donde decimos que vamos a seleccionar todos los datos que estan en la tabla Usuario_Clase, esto para obtener el id de la clase
     String datitos = "Select id_clase from Usuario_Clase where id_usu = '" + idPersona + "'";
     //ResultSet Datos = basesita.consulta(datitos);
    ResultSet Dato_idClase = basesita.consulta(datitos);
    // obtenemos la id de la clase (de la tabla Usuario_Clase) para relacionarla con la tabla Clases
    int id_class = Dato_idClase.getInt(2);

    // (apartir de la id de clase) Mandamos la instruccion donde decimos que vamos a seleccionar todos los datos de la clase 
    String info_clase = "Select * from Clases where id_clase = '" + id_class + "'"; // seleccionamos los datos de la tabla Clases
    ResultSet ClaseInfo = basesita.consulta(info_clase);

    /*
    if (rsDatosPer.next()) {
        nombre = rsDatosPer.getString(2);
        correo = rsDatosPer.getString(3);
        foto = rsDatosPer.getString(5);
        tipo = rsDatosPer.getString(6);
        grado = rsDatosPer.getString(7);
    } */
    try {
        // (apartir de la id de clase) Mandamos la instruccion (guardada en la variable Post_Info) donde le decimos que vamos a seleccionar todos los datos del post que estan en la tabla Post
        String Post_Info = "Select * from Post where id_foro = '" + id_class + "'"; // NOTA: el id_foro es igual al id_class pues al crear una clase tambien se crea su foro
        ResultSet post = basesita.consulta(Post_Info);

%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Posts</title>
        <link href="../../CSS/CSS_foro/menu_D.css" rel="stylesheet" type="text/css"/>
        <link href="../../CSS/CSS_foro/foro.css" rel="stylesheet" type="text/css"/>
        <link href="../../CSS/CSS_foro/hero_foroA.css" rel="stylesheet" type="text/css"/>
        <link rel="shorcut icon" href="../../General/img/logos/Newlogo.png">
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Poppins&display=swap');
        </style>
    </head>

    <body style=" background-image: url('https://d3ae4wrz2ljkbq.cloudfront.net/components/img-16-9-dark-1.svg'); background-size: cover; background-repeat: no-repeat;">


        <div >
            <div>
                <section class="hero hero--center" style="background-image: url('https://d3ae4wrz2ljkbq.cloudfront.net/components/img-16-9-light-1.svg')">
                    <div class="cd-container cd-max-width-adaptive-sm">
                        <h1 class="cd-margin-bottom-xs">Nombre de la clase_ foro</h1>
                        <p class="cd-line-height-lg cd-margin-bottom-sm">Número de estudiantes:</p>
                        <p class="cd-line-height-lg cd-margin-bottom-sm">Nombre del profesor: </p>
                        <p class="cd-line-height-lg cd-margin-bottom-sm">Fecha de creación</p>

                    </div>
                </section>
            </div>
            <%                while (post.next()) {
            %>
            <div id="post">
                <div>
                    <table id="tablaInfo">
                        <tr>
                            <td rowspan="2"><img class="imagenUsuCero" src="../../Img/fotos_perfil/<%=post.getString(7)%>" style="margin-right: -20px; border-radius: 100px;"  width="60" height="60"></td>
                            <td><h1><%=post.getString(2)%></h1></td>

                        </tr>
                        <tr>
                            <td><h3>hora</h3></td>
                        </tr>
                    </table>
                </div>
                
                <div id="txtPost">
                    <p>
                        <%=post.getString(3)%>
                    </p>
                    <div id="ImagePost">
                        <img class="imagenUsuCero" src="../../Img/Fotos_post/<%=post.getString(6)%>" alt="image" style="width: 90%; height: 40%; " id="ImagePost">
                    </div>
                </div>
                <%//}
                %>

                <div id="cajitaComent" style="border-top: 1px gray;">
                    <form name="form" action="ValidarUsu.jsp" method="post" > 
                        <h3 style="margin-top: 10px;">Comentarios</h3>
                        <div style=" display: flex; ">
                            <input class="postInput" type="text" id="TxtComent" name="comentario" placeholder="Escribe un comentario">
                            <input class="enviarComent" type="submit" id="btnComent" name="btnComent" value="Comentar">
                        </div>
                    </form>
                </div>
            </div>
            <%                    }

                    post.close();
                    basesita.cierraConexion();
                } catch (Exception ex) {
                    out.print(ex.getMessage());
                }
            %>





        </div>

    </body> 
</html>
