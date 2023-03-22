<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Actualizar plan</title>
        <link href="../../../CSS/premium_form.css" rel="stylesheet" type="text/css"/>
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Quicksand:wght@500&display=swap');
        </style>
    </head>
    <body>
        <h1>
            Actualización del plan premium
        </h1>

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
                            <input id="password_field" class="input_field" type="text" name="input-name" title="Expiry Date" placeholder="01/23">
                            <input id="password_field" class="input_field" type="number" name="cvv" title="CVV" placeholder="CVV">
                        </div>
                    </div>
                </div>
                <div class="input_container">
                    <p>Total a pagar:   <strong>MX $79.00</strong></p>
                </div>
                
                <button class="purchase--btn">Ok</button>
            </form>
        </div>

        <script type="text/javascript">
            function toogle(){
                
            }
        </script>
    </body>
</html>
