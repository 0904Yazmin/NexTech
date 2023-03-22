
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="../../../CSS/premium_form.css" rel="stylesheet" type="text/css"/>
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Quicksand:wght@500&display=swap');
        </style>
    </head>
    <body>
        <div class="container" id="blur">
            <div class="content">
                
                
                <div class="card" id="card">
                    <center><h1 class="titlePlanes"> Planes y precios </h1></center>
                    <div class="Plan_card">
                        <p><h2> Plan gratuito</h2>
                        <p><h1>MXN $0</h1>
                        <p>
                        <ul>
                            <li>Liimite de hasta 3 clases</li>
                            <li>Acceso limitado a todas las lecciones</li>
                            <li>Acceso limitado a los examenes y ejercicios</li>
                        </ul>
                    </div>
                    <div class="Plan_card" >
                        <p><h2> Plan premium</h2>
                        <p><h1>MXN $79 <span>al mes</span></h1> 
                        <p>
                        <ul>
                            <li>Clases ilimitadas</li>
                            <li>Acceso ilimitado a todas las lecciones</li>
                            <li>Acceso a todos los examenes y ejercicios</li>
                        </ul>
                        <a class="botoncito_Act" href="#" onclick="toggle()">Actualizar</a>
                    </div>
                </div>
            </div>
        </div>

        <div id="popup">
            <div class="modal">
                <form class="form">
                    <div class="separator">
                        <hr class="line">
                        <h3>Tarjeta de crédito</h3> 
                        <hr class="line">
                    </div>
                    <div class="credit-card-info--form">
                        <div class="input_container">
                            <label for="password_field" class="input_label">Nombre en la tarjeta</label>
                            <input id="password_field" class="input_field" type="text" name="input-name" title="Inpit title" placeholder="Enter your full name">
                        </div>
                        <div class="input_container">
                            <label for="password_field" class="input_label">Número de tarjeta</label>
                            <input id="password_field" class="input_field" type="number" name="input-name" title="Inpit title" placeholder="0000 0000 0000 0000">
                        </div>
                        <div class="input_container">
                            <label for="password_field" class="input_label">Expiry Date / CVV</label>
                            <div class="split">
                                <input id="password_field" class="input_field" type="text" name="input-name date" title="Expiry Date" placeholder="01/23" >
                                <input id="password_field" class="input_field" type="number" name="cvv" title="CVV" placeholder="CVV">
                            </div>
                        </div>
                    </div>
                    <div class="input_container">
                        <p>Total a pagar:   <strong>MX $79.00</strong></p>
                    </div>
                    <div style="display: flex;">
                        <button class="purchase--btn"  >Ok</button>
                        <button class="purchase--btn"  onclick="toggle()">Cerrar</button>
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
