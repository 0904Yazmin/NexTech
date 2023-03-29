<%@page import="Conexion.Exam"%>
<%@page import="Conexion.BD"%>
<%@page import="Conexion.Digest"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%  int q1 = Integer.parseInt(request.getParameter("p0"));
    int q2 = Integer.parseInt(request.getParameter("p1"));
    int q3 = Integer.parseInt(request.getParameter("p2"));
    int q4 = Integer.parseInt(request.getParameter("p3"));
    int q5 = Integer.parseInt(request.getParameter("p4"));
    int q6 = Integer.parseInt(request.getParameter("p5"));
    int q7 = Integer.parseInt(request.getParameter("p6"));
    int q8 = Integer.parseInt(request.getParameter("p7"));
    int q9 = Integer.parseInt(request.getParameter("p8"));
    int q10 = Integer.parseInt(request.getParameter("p9"));
    int q11 = Integer.parseInt(request.getParameter("p10"));
    int q12 = Integer.parseInt(request.getParameter("p11"));
    int q13 = Integer.parseInt(request.getParameter("p12"));
    int q14 = Integer.parseInt(request.getParameter("p13"));
    int q15 = Integer.parseInt(request.getParameter("p14"));
    int q16 = Integer.parseInt(request.getParameter("p15"));
    int q17 = Integer.parseInt(request.getParameter("p16"));
    int[] opcion_elegida = {q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, q12, q13, q14, q15, q16, q17};
    int[] correctas = {1, 2, 2, 2, 3, 2, 1, 2, 1, 2, 3, 3, 1, 2, 2, 3, 1};
    /*String q2 = request.getParameter("p1");
    String q3 = request.getParameter("p2");
    String q4 = request.getParameter("p3");
    String q5 = request.getParameter("p4");
    String q6 = request.getParameter("p5");
    String q7 = request.getParameter("p6");
    String q8 = request.getParameter("p7");
    String q9 = request.getParameter("p8");
    String q10 = request.getParameter("p9");
    String q11 = request.getParameter("p10");
    String q12 = request.getParameter("p11");
    String q13 = request.getParameter("p12");
    String q14 = request.getParameter("p13");
    String q15 = request.getParameter("p14");
    String q16 = request.getParameter("p15");
    String q17 = request.getParameter("p16");*/

    int cantidad_correctas = 0;
    for (int i = 0; i < correctas.length; i++) {
        if (correctas[i] == opcion_elegida[i]) {
            cantidad_correctas++;
        }
    }
    //int aciertos=cantidad_correctas;


%>
<%            //Datos de formulario de registro para Estudiante y docente
    HttpSession miSessiondelUsuario = (HttpSession) request.getSession();
    int id = (int) (miSessiondelUsuario.getAttribute("id_usu") == null ? 0 : miSessiondelUsuario.getAttribute("id_usu"));
    //Exam examen = new Exam();
    //int aciertos = request.getParameter("aciertos");
    String strQry = null;
    String nivel = "";
    BD base = new BD();
    try {
        base.conectar();
        if (cantidad_correctas >= 12) {
            strQry = "update Usuario set grado_usuario='" + "Avanzado" + "' where id_usu='" + id + "'";
            nivel = "Avanzado";
        } else {
            if (cantidad_correctas >= 7) {
                strQry = "update Usuario set grado_usuario='" + "Intermedio" + "' where id_usu='" + id + "'";
                nivel = "Intermedio";
            } else {
                strQry = "update Usuario set grado_usuario='" + "Basico" + "' where id_usu='" + id + "'";
                nivel = "Básico";
            }
        }
        base.insertar(strQry);

%>

<script>
    window.alert("buenas" + aciertos);
</script>

<%            } catch (Exception ex) {
        out.print(ex.getMessage());
    }
    //response.sendRedirect("Perfil_I.jsp");

%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Resultado</title>
        <link href="../../CSS/premium_form.css" rel="stylesheet" type="text/css"/>
        <link href="../../CSS/newClass.css" rel="stylesheet" type="text/css"/>
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Poppins&display=swap');
            @import url('https://fonts.googleapis.com/css2?family=Mulish&display=swap');
        </style>
        <link rel="shorcut icon" href="../../Img/logos/LogoCopernicus.png">
    </head>
    <body>
        <div class="container div2" id="blur">

            <div class="cuadro4">
                <div class="p2">
                    <img src="../../Img/logos/LogoCopernicus.png" alt="logoCS" id="logoCS"/>Copernicus System

                </div>
                <div class="ingresarCode">
                    <h1>Examen diagnóstico</h1><br>
                    <center>
                        <h1>Tu puntaje es de <%=cantidad_correctas%>/17</h1>
                        <h3>Tu nivel de aprendizaje adecuado es: <%=nivel%></h3>
                        <br>
                        <button class="purchase--btn"  onclick="toggle()">Siguiente</button>
                    </center>
                </div>
            </div>
        </div>


        <div id="popup">
            <div class="modal2">
                <form class="form" action="edad.jsp" method="POST" >
                    <div class="separator">
                        <hr class="line">
                        <h3>Edad</h3> 
                        <hr class="line">
                    </div>
                    <div class="credit-card-info--form">
                        <div class="input_container">
                            <label for="password_field" class="input_label">Ingresa tu edad para asignarte un foro adecuado a tu edad</label>
                            <input id="edad" class="input_field" type="number" name="edad" title="Inpit title" placeholder="Ingresa tu edad" required>
                            <input id="edad" class="input_field" type="hidden" name="nivel" title="Inpit title" value="<%=nivel%>">
                        </div>
                    </div>
                    
                    <div style="display: flex;">
                        <button class="purchase--btn"  >Ok</button>
                        
                    </div>

                </form>
            </div>
        </div>
                        
                        
                        
        <script type="text/javascript">
            function toggle() {
                var blur = document.getElementById('blur');
                blur.classList.toggle('active');
                var popup = document.getElementById('popup');
                popup.classList.toggle('active');
            }
        </script>
    </body>
</html>
