<%@page import="java.sql.ResultSet"%>
<%@page import="Conexion.BD"%>
<%@page contentType="text/html" pageEncoding="UTF-8" session="true"%>
<!DOCTYPE html>
<%
    HttpSession miSessiondelUsuario = (HttpSession) request.getSession();

    int id = (int) (miSessiondelUsuario.getAttribute("id_usu") == null ? 0 : miSessiondelUsuario.getAttribute("id_usu"));
    BD base = new BD();

    try {
        String nombre = "";
        String correo = "";
        String grado = "";
        String tipo = "";
        String foto = "";
        String pass = "";

        base.conectar();
        String strQry = "select * from Usuario where id_usu='" + id + "'";

        ResultSet info = base.consulta(strQry);

        while (info.next()) {
            nombre = info.getString(2);
            correo = info.getString(3);
            tipo = info.getString(6);
            grado = info.getString(7);
            foto = info.getString(5);
            pass = info.getString(4);
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Editar perfil</title>
        <link href="../../CSS/editaDatos.css" rel="stylesheet" type="text/css"/>
        <style>@import url('https://fonts.googleapis.com/css2?family=Quicksand:wght@500&display=swap');</style>
        <style>@import url('https://fonts.googleapis.com/css2?family=Poppins&display=swap');</style>

        <style>
            .modal {
                background-color: rgb(255, 255, 255);
                border-radius: 1em;
                box-shadow: 0px 100px 48px -60px rgba(0,0,0,0.1);
                color: rgb(15, 14, 14);
                max-width: 330px;
                overflow: hidden;
                position: relative;
                transition: background-color 0.3s, color 0.3s;
            }

            .content > *, .modal > * {
                padding: 0.875em;
            }

            .title {
                font-size: 1.25em;
                font-weight: 600;
                line-height: 1.2;
                display: flex;
                justify-content: center;
            }

            .message {
                line-height: 1.2;
                text-align: center;
            }

            .actions {
                display: flex;
                align-items: center;
                flex-wrap: wrap;
            }

            .upload-btn {
                background-color: transparent;
                border: 0.125rem dashed hsla(223,10%,50%,0.4);
                flex: 1;
                padding: 0.375rem 2rem;
            }

            .upload-btn:hover {
                background-color: hsla(223,10%,60%,0.2);
            }

            .close {
                display: flex;
                align-items: center;
                justify-content: center;
                background-color: rgb(226, 94, 54);
                height: 30px;
                width: 30px;
                border-radius: 50%;
                position: absolute;
                right: 10px;
                top: 10px;
                color: #fff;
                font-weight: bold;
                cursor: pointer;
            }

            .result {
                margin-top: 4px;
                background-color: rgba(0, 140, 255, 0.062);
                display: flex;
                align-items: center;
                position: relative;
                border-radius: 1em;
            }

            .file-uploaded {
                font-weight: 300;
            }

            .file-uploaded::before {
                position: absolute;
                content: "X";
                display: flex;
                align-items: center;
                justify-content: center;
                background-color: rgba(26, 7, 1, 0.212);
                height: 30px;
                width: 30px;
                border-radius: 50%;
                right: 10px;
                top: 10px;
                color: rgb(255, 255, 255);
                font-weight: bold;
                cursor: pointer;
            }

            .file-uploaded:hover::before {
                background-color: rgba(233, 40, 6, 0.664);
            }

        </style>
    </head>

    <body id="Principal">
        <form name="datosEdit" action="guardar_img.jsp" method="post" enctype="MULTIPART/FORM-DATA">
            <div id="cuadro4" style="background-color: white; color: black;">
                <div class="modal">
                    <h1>Foto de perfil</h1>
                    <%
                        if (info.getString(5) == null) {
                    %>
                    <img src="../../Img/fotoUsu_0.png" width="130" height="120" alt="foto 0" class="imagenUsuCero blanco"/>
                    <%
                    } else {

                    %>
                    <img class="imagenUsuCero" src="../../Img/fotos_perfil/<%=foto%>" width="135" height="135">

                    <%                }
                    %>
                    <div class="content">
                        <span class="title">Subir una foto</span>
                        <p class="message">Selecciona una imagen de perfil desde tu computadora</p>

                        <div class="actions">
                            <label for="file" class="button upload-btn">Abrir archivo
                                <input  type="file"  id="file" name="fileImg"  class="fileImg" accept="image/*" hidden="" required>
                            </label>
                        </div>
                    </div>
                    <input id="BtnEditar" name="BtnEditar" type="submit"  class="actu_b" value="Actualizar foto"/>
                </div>





            </div>
            <%            }
                } catch (Exception ex) {
                    out.println(ex.getMessage());
                }
            %>
        </form>


    </body>
</html>
