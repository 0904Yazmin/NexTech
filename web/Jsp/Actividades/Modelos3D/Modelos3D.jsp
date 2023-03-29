<%@page import="java.sql.ResultSet"%>
<%@page import="Conexion.BD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    <head>
        <title>Mapas interactivos</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Poppins&display=swap');
            @import url('https://fonts.googleapis.com/css2?family=Mulish&display=swap');
        </style>
        <link rel="shorcut icon" href="../../General/img/logos/Newlogo.png">
        <link rel="stylesheet" href="../css_A/menu_A.css" >
        <link href="estilitosMapas.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <div class="contenedor_1" id="p1">

            <div class="row">
                <div class="col" id="col1">
                    <h1>Mapas</h1>
                    <p>  Aqui encontraras todos los modelos 3D que </p>
                    <P> te ayudarán a tu aprendizaje en Copernicus </p><p>System </p>
                    <button type="button"><a href="#p2"> Explorar </a></button>
                </div>

                <div class="col">

                </div>
            </div>
        </div>

        <div class="contenedor_1" id="p2">
            <a name="primero"></a>
            <div class="row">
                <div class="col">

                    <a href="modelos/Mapa.jsp">
                        <div class="card SOLAR_S" id="solar_s">
                            <h5>Ir al Sistema solar</h5>
                        </div>
                    </a>
                    <a href="modelos/Mercurio.jsp">
                        <div class="card card4" >
                            <h5>Mercurio</h5>
                        </div>
                    </a>
                    <a href="modelos/Venus.jsp">
                        <div class="card card3" >
                            <h5>Venus</h5>
                        </div>
                    </a>
                    <a href="modelos/Tierra.jsp">
                        <div class="card card1" >
                            <h5>Tierra</h5>
                        </div>
                    </a>
                    <a href="modelos/Marte.jsp">
                        <div class="card card2" >
                            <h5>Marte</h5>
                        </div>
                    </a>
                    <a href="modelos/Jupiter.jsp">
                        <div class="card card9" >
                            <h5>Jupiter</h5>
                        </div>
                    </a>
                    <a href="modelos/Saturno.jsp">
                        <div class="card card7" >
                            <h5>Saturno</h5>
                        </div>
                    </a>
                    <a href="modelos/Urano.jsp">
                        <div class="card card5" >
                            <h5>Urano</h5>
                        </div>
                    </a>
                    <a href="modelos/Neptuno.jsp">
                        <div class="card card6" >
                            <h5>Neptuno</h5>
                        </div>
                    </a>
                    <a href="modelos/Pluton.jsp">
                        <div class="card card8" >
                            <h5>Plutón</h5>
                        </div>
                    </a>
                   
                </div>    

            </div>
        </div>

    </body>
</html>
