<%@page import="Conexion.Exam"%>
<%@page import="Conexion.BD"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>

<html>
    <head>
        <title>Examen diagnóstico</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="../../CSS/examD.css" rel="stylesheet" type="text/css"/>
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Poppins&display=swap');
        </style>
        <link rel="shorcut icon" href="../../Img/logos/LogoCopernicus.png">
    </head>
    <body>
        <header >
            <img src="../../Img/logos/LogoCopernicus.png" alt="logoCS" class="imglogo" style="width: 28px; height: 28px; margin-right: 9px;"/>
            <h1>Copernicus System</h1>
        </header>

        <div class="container">
            <div class="head">
                <h1>Examen Diagnóstico</h1>
                <p>Este examen nos ayudará a evaluar tus conocimientos previos sobre Astronomia, de esta manera podemos asignarte un grado de conocimientos adecuado para tu aprendizaje.</p>
            </div>
            <form name="form" action="PuntosExamD.jsp" method="post" > 
                <section id="p0">
                    <h3>1. ¿Qué es el espacio?</h3>
                    <ul>
                        <li>
                            <label>
                                <input type="radio" value="1" name="p0">Es un lugar donde se encuentran muchos cuerpos celestes
                            </label>
                        </li>
                        <li>
                            <label>
                                <input type="radio" value="2" name="p0">Es un lugar en el que no hay nada
                            </label>
                        </li>
                        <li>
                            <label><input type="radio" value="3" name="p0">Es la presentación de un lugar en el cielo</label>
                        </li>
                    </ul>
                </section>

                <section id="p1">
                    <h3>2. ¿Qué es el sistema solar?</h3>
                    <ul>
                        <li>
                            <label><input type="radio" value="1" name="p1" onclick="respuesta(1, this)">Conjunto de estrellas que orbitan entre ellas </label>
                        </li>
                        <li>
                            <label><input type="radio" value="2" name="p1" onclick="respuesta(1, this)">Conjunto de cuerpos que orbitan a una estrella</label>
                        </li>
                        <li>
                            <label><input type="radio" value="3" name="p1" onclick="respuesta(1, this)">Conjunto de cuerpos que orbitan entre ellos</label>
                        </li>
                    </ul>
                </section>

                <section id="p2">
                    <h3>3. Selecciona los nombres de los planetas que conforman el sistema solar en el orden correcto</h3>
                    <ul>
                        <li><label><input type="radio" value="1" name="p2" onclick="respuesta(2, this)">Mercurio, Marte, Júpiter, Tierra, Venus, Saturno, Urano, Neptuno</label></li>
                        <li><label><input type="radio" value="2" name="p2" onclick="respuesta(2, this)">Mercurio, Venus, Tierra, Marte, Júpiter, Saturno, Urano, Neptuno</label></li>
                        <li><label><input type="radio" value="3" name="p2" onclick="respuesta(2, this)">Mercurio, Urano, Júpiter, Saturno, Marte, Venus, Tierra, Neptuno</label></li>
                    </ul>
                </section>

                <section id="p3">
                    <h3>4. El día y la noche se generan a partir del movimiento de…</h3>
                    <ul>
                        <li><label> <input type="radio" value="1" name="p3" onclick="respuesta(3, this)">traslación</label></li>
                        <li><label><input type="radio" value="2" name="p3" onclick="respuesta(3, this)">rotación</label></li>
                        <li><label><input type="radio" value="3" name="p3" onclick="respuesta(3, this)">órbita</label></li>
                    </ul>
                </section>

                <section id="p4">
                    <h3>5. ¿Qué son los cometas?</h3>
                    <ul>
                        <li>
                            <label>
                                <input type="radio" value="1" name="p4" onclick="respuesta(4, this)">Cuerpos que tienen una órbita cerca del sol
                            </label>
                        </li>
                        <li>
                            <label>
                                <input type="radio" value="2" name="p4" onclick="respuesta(4, this)">Cuerpos que tienen una órbita lejos del sol
                            </label>
                        </li>
                        <li>
                            <label>
                                <input type="radio" value="3" name="p4" onclick="respuesta(4, this)">Cuerpos que giran en una orbita que se acerca y aleja del sol
                            </label>
                        </li>
                    </ul>
                </section>

                <section id="p5">
                    <h3>6. ¿De qué forma son las orbitas de los planetas?</h3>
                    <ul>
                        <li>
                            <label>
                                <input type="radio" value="1" name="p5" onclick="respuesta(5, this)">Circulares
                            </label>
                        </li>
                        <li>
                            <label>
                                <input type="radio" value="2" name="p5" onclick="respuesta(5, this)">Elípticas
                            </label>
                        </li>
                        <li>
                            <label>
                                <input type="radio" value="3" name="p5" onclick="respuesta(5, this)">Esféricas
                            </label>
                        </li>
                    </ul>
                </section>

                <section id="p6">
                    <h3>7. ¿Quién fue el padre de la astronomía moderna?</h3>
                    <ul>
                        <li>
                            <label>
                                <input type="radio" value="1" name="p6" onclick="respuesta(6, this)">Galileo Galilei
                            </label>
                        </li>
                        <li>
                            <label>
                                <input type="radio" value="2" name="p6" onclick="respuesta(6, this)">Albert Einstein
                            </label>
                        </li>
                        <li>
                            <label>
                                <input type="radio" value="3" name="p6" onclick="respuesta(6, this)">Sócrates
                            </label>
                        </li>
                    </ul>
                </section>

                <section id="p7">
                    <h3>8. ¿Cómo se llama la teoría más aceptada de la creación del universo?</h3>
                    <ul>
                        <li>
                            <label>
                                <input type="radio" value="1" name="p7" onclick="respuesta(7, this)">Big Bounce
                            </label>
                        </li>
                        <li>
                            <label>
                                <input type="radio" value="2" name="p7" onclick="respuesta(7, this)">Big Bang
                            </label>
                        </li>
                        <li>
                            <label>
                                <input type="radio" value="3" name="p7" onclick="respuesta(7, this)">Big Creation
                            </label>
                        </li>
                    </ul>
                </section>

                <section id="p8">
                    <h3>9. ¿A cuánto equivale un año luz en kilómetros?</h3>
                    <ul>
                        <li>
                            <label>
                                <input type="radio" value="1" name="p8" onclick="respuesta(8, this)">9.46x10 ^12
                            </label>
                        </li>
                        <li>
                            <label>
                                <input type="radio" value="2" name="p8" onclick="respuesta(8, this)">8.45x10 ^15
                            </label>
                        </li>
                        <li>
                            <label>
                                <input type="radio" value="3" name="p8" onclick="respuesta(8, this)">9.25x10 ^12
                            </label>
                        </li>
                    </ul>
                </section>

                <section id="p9">
                    <h3>10. ¿Qué tipo de fuerza ejerce la gravedad?</h3>
                    <ul>
                        <li>
                            <label>
                                <input type="radio" value="1" name="p9" onclick="respuesta(9, this)">Expansión
                            </label>
                        </li>
                        <li>
                            <label>
                                <input type="radio" value="2" name="p9" onclick="respuesta(9, this)">Atracción
                            </label>
                        </li>
                        <li>
                            <label>
                                <input type="radio" value="3" name="p9" onclick="respuesta(9, this)">Expulsión
                            </label>
                        </li>
                    </ul>
                </section>

                <section id="p10">
                    <h3>11. ¿Cuál es el evento más colosal del universo?</h3>
                    <ul>
                        <li><label>
                                <input type="radio" value="1" name="p10" onclick="respuesta(10, this)">Bomba Atómica
                            </label></li>
                        <li><label>
                                <input type="radio" value="2" name="p10" onclick="respuesta(10, this)">Llamarada solar
                            </label></li>
                        <li><label>
                                <input type="radio" value="3" name="p10" onclick="respuesta(10, this)">Supernova
                            </label></li>
                    </ul>
                </section>

                <section id="p11">
                    <h3>12. En tamaño, cuál de los siguientes cuerpos celestes es más brillante.</h3>
                    <ul>
                        <li> <label>
                                <input type="radio" value="1" name="p11" onclick="respuesta(11, this)">Estrella Supermasiva
                            </label>
                        </li>
                        <li><label>
                                <input type="radio" value="2" name="p11" onclick="respuesta(11, this)">Agujero Negro
                            </label>
                        </li>
                        <li><label>
                                <input type="radio" value="3" name="p11" onclick="respuesta(11, this)">Cuásar
                            </label>
                        </li>                    
                    </ul>
                </section>

                <section id="p12">
                    <h3>13. ¿Qué son las constelaciones?</h3>
                    <ul>
                        <li>
                            <label>
                                <input type="radio" value="1" name="p12" onclick="respuesta(12, this)">Conjuntos de estrellas que formas una figura
                            </label>
                        </li>
                        <li>
                            <label>
                                <input type="radio" value="2" name="p12" onclick="respuesta(12, this)">Símbolos conformados por cuerpos celestes
                            </label>
                        </li>
                        <li>
                            <label>
                                <input type="radio" value="3" name="p12" onclick="respuesta(12, this)">Conjuntos de estrellas que forman un sistema
                            </label>
                        </li>
                    </ul>
                </section>

                <section id="p13">
                    <h3>14. ¿Qué estrellas componen el cinturón de orión?</h3>
                    <ul>
                        <li>
                            <label>
                                <input type="radio" value="1" name="p13" onclick="respuesta(13, this)">UY Scuti, Mintaka, Arcturus
                            </label>
                        </li>
                        <li>
                            <label>
                                <input type="radio" value="2" name="p13" onclick="respuesta(13, this)">Alnitak, Alnilam, y Mintaka
                            </label>
                        </li>
                        <li>
                            <label>
                                <input type="radio" value="3" name="p13" onclick="respuesta(13, this)">Alnitak, VY Canis mayoris, Mintaka
                            </label>
                        </li>
                    </ul>
                </section>

                <section id="p14">
                    <h3>15. ¿A cuánto equivale un Parsec?</h3>
                    <ul>
                        <li>
                            <label>
                                <input type="radio" value="1" name="p14" onclick="respuesta(14, this)">2.34 Años luz
                            </label>
                        </li>
                        <li>
                            <label>
                                <input type="radio" value="2" name="p14" onclick="respuesta(14, this)">3.26 Años luz
                            </label>
                        </li>
                        <li>
                            <label>
                                <input type="radio" value="3" name="p14" onclick="respuesta(14, this)">20 U.A
                            </label>
                        </li>
                    </ul>
                </section>

                <section id="p15">
                    <h3>16. ¿Cómo se llama la estrella mas brillante en el cielo? (Pista: Se encuentra en la constelación de Can Mayor)</h3>
                    <ul>
                        <li>
                            <label>
                                <input type="radio" value="1" name="p15" onclick="respuesta(15, this)">VY Canis Mayoris
                            </label>
                        </li>
                        <li>
                            <label>
                                <input type="radio" value="2" name="p15" onclick="respuesta(15, this)">Stephenson 218
                            </label>
                        </li>
                        <li>
                            <label>
                                <input type="radio" value="3" name="p15" onclick="respuesta(15, this)">Sirio
                            </label>
                        </li>
                    </ul>
                </section>

                <section id="p16">
                    <h3>17. Elige correctamente la representación de medición sencilla correcta para ángulos</h3>
                    <ul>
                        <li>
                            <label>
                                <input type="radio" value="1" name="p16" onclick="respuesta(16, this)">Pulgar: 2 grados
                                Puño: 10 grados
                                Mano Abierta: 20 grados
                            </label>
                        </li>
                        <li>
                            <label>
                                <input type="radio" value="2" name="p16" onclick="respuesta(16, this)">Pulgar: 1 grados
                                Puño: 8 grados
                                Mano Abierta: 30 grados
                            </label>
                        </li>
                        <li>
                            <label>
                                <input type="radio" value="3" name="p16" onclick="respuesta(16, this)">Pulgar: 5 grados
                                Puño: 10 grados
                                Mano Abierta: 20 grados
                            </label>
                        </li>
                    </ul>

                </section>
               
            <p><input class="info" type="submit" id="btnLogin" name="btnLogin" value="Enviar respuestas"></p>
            <%--<input class="botonE" onclick="corregir()">ENVIAR</button><br> <br>
            <p><input class="info" type="submit" id="btnLogin" name="btnLogin" value="Iniciar Sesión"></p>--%>


                <%--<section style=" margin-right:  50px;">
                    <p><input class="info" type="submit" id="btnLogin" name="btnLogin" value="Iniciar Sesión"></p>
                    <input class="botonE" onclick="corregir()">ENVIAR</button><br> <br>
                </section>--%>
            </form>
        </div>


    </body>
</html>
