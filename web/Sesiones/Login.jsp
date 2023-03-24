<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <link href="../CSS/login.css" rel="stylesheet" type="text/css"/>
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Poppins&display=swap');
            @import url('https://fonts.googleapis.com/css2?family=Mulish&display=swap');
        </style>
        <link rel="shorcut icon" href="../Img/logos/LogoCopernicus.png">
</head>
<body>
    <header>
        <table>
            <tr>
                <td>
                    <img src="../Img/logos/LogoCopernicus.png" alt="CS" class="imglogo"/>
                </td>
                <td>
                    <a href="../index.html" ><h1>Copernicus System</h1></a>
                </td>
            </tr>
        </table>
        <nav class="navegacion">
            <a href="Registro.html" class="link" >Registro</a>
            <a href="Login.jsp" class="link">Conócenos</a>
            <a href="Login.jsp" class="link">NexTech Company</a>
        </nav>
    </header>

    <div class="cuadro">
        <center>
            <p><h1>Iniciar Sesión</h1> <br>
            <form name="form" action="ValidarUsuario.jsp" method="post" > 
                <div class="section">
                    <div class="form-group">
                            <img src="../Img/Iconos_menu/arroba.png"  alt="arroba" class="icons"/>
                            <input  type="email" id="TxtCorreo" name="email" placeholder="Ingrese su correo" autocomplete="off"  required/>
                            <label class="form-label">Correo electrónico</label></p>
                    </div>
                    <div class="form-group">
                            <img src="../Img/Iconos_menu/pass.png"  alt="candado" class="icons"/>
                            <input type="password" id="TxtPass" name="password" placeholder="Ingrese su contraseña"minlength="4" maxlength="30" 
                                   autocomplete="off" required=""/>
                            <label class="form-label">Contraseña</label></p>
                    </div>

                    <label class="form-label"><p><a href="olvidoPass.html" class="linkRegis olvidopass" >¿Olvidaste tu contraseña?</a></p></label>
                    <br > 

                    <p><input class="info" type="submit" id="btnLogin" name="btnLogin" value="Iniciar Sesión"></p><br>
                    <p>¿Aún no tienes una cuenta? <a href="Registro.html" class="linkRegis">Registrate</a></p>
                </div>
            </form>
        </center>
    </div>

    <div class="tierra">
        <iframe src='https://my.spline.design/tierracopy-75bc5b92c6c686be9d4697874f43f6f1/' frameborder='0' width='1500' height='1000'></iframe>
    </div>

    <footer>
        <div class="footer1">
            <p>
                Copernicus System
            </p>
        </div>
        <div class="footer2">
            <p>Equipo 1</p>

        </div>
    </footer>
</body>
</html>
