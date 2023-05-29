<%@page import="java.sql.ResultSet"%>
<%@page import="java.io.File"%>
<%@page import="Conexion.BD"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.DataInputStream"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>

        <%
            HttpSession miSessiondelUsuario = (HttpSession) request.getSession();
            int id = (int) (miSessiondelUsuario.getAttribute("id_usu") == null ? 0 : miSessiondelUsuario.getAttribute("id_usu"));
            BD base = new BD();
            base.conectar();
            // Parametros del form CrearPost
            String texto = request.getParameter("textoPost");
            // String img = request.getParameter("fileImg");
            String date = request.getParameter("hora");
            String idclase = request.getParameter("idclase");
            String nombre = "";
            String foto = "";
            String tipo = "";

            String UsuarioInfo = "";

            int MAX_SIZE = 102440 * 10244000;
            String rootPath;
            DataInputStream in = null;
            FileOutputStream fileOut = null;
            String remoteAddr = request.getRemoteAddr();
            String serverName = request.getServerName();
            String realPath = "C:\\NexTech\\web\\Img\\Img_posts\\";
            rootPath = realPath;
            String contentType = request.getContentType();
            String saveFile = "";

            try {
                if (contentType.indexOf("multipart/form-data") >= 0) {
                    in = new DataInputStream(request.getInputStream());
                    int formDataLength = request.getContentLength();
                    if (formDataLength > MAX_SIZE) {
                        out.println("<p> El archivo de carga máxima no puede exceder " + MAX_SIZE + "</p>");
                        return;
                    }
                    byte dataBytes[] = new byte[formDataLength];
                    int byteRead = 0;
                    int totalBytesRead = 0;
                    while (totalBytesRead < formDataLength) {
                        byteRead = in.read(dataBytes, totalBytesRead, formDataLength);
                        totalBytesRead += byteRead;
                    }
                    String file = new String(dataBytes, "UTF-8");
                    saveFile = file.substring(file.indexOf("filename=\"") + 10);
                    saveFile = saveFile.substring(0, saveFile.indexOf("\n"));
                    saveFile = saveFile.substring(saveFile.lastIndexOf("\\") + 1, saveFile.indexOf("\""));
                    int lastIndex = contentType.lastIndexOf("=");
                    String boundary = contentType.substring(lastIndex + 1, contentType.length());

                    String fileName = rootPath + saveFile;
                    int pos;
                    pos = file.indexOf("filename=\"");
                    pos = file.indexOf("\n", pos) + 1;
                    pos = file.indexOf("\n", pos) + 1;
                    pos = file.indexOf("\n", pos) + 1;
                    int boundaryLocation = file.indexOf(boundary, pos) - 4;

                    int startPos = ((file.substring(0, pos)).getBytes()).length;
                    int endPos = ((file.substring(0, boundaryLocation)).getBytes()).length;

                    File fileDir = new File(rootPath);
                    if (!fileDir.exists()) {
                        fileDir.mkdir();
                    }
                    fileOut = new FileOutputStream(fileName);
                    fileOut.write(dataBytes, startPos, (endPos - startPos));
                    fileOut.close();

                } else {
                    String content = request.getContentType();
                    out.println("<p> El tipo de dato cargado no es multipart / form-data </p>");
                }
            } catch (Exception ex) {
                throw new ServletException(ex.getMessage());
            }
            //  --------------------------------------------------------------------------------- INSERTAR ------------------------------------
            try {
                UsuarioInfo = "Select * from Usuario where id_usu = '" + id + "'"; //selecionamos los datos del usuario de la tabla Usuario
                ResultSet rsDatosPer = base.consulta(UsuarioInfo);
                String datitos = "Select * from Clases where id_clase = '" + idclase + "'"; // seleccionamos los datos de la clase de la tabla Usuario_Clase
                ResultSet Datos = base.consulta(datitos);

                if (rsDatosPer.next()) {
                    while (Datos.next()) {
                        nombre = rsDatosPer.getString(2);
                        foto = rsDatosPer.getString(5);
                        String dato = "insert into Post(autor_post, msj, id_usu, id_foro,  img_autor, hora_post)" + "values( ' " + nombre + " ' , ' " + texto + "','" + id + "','" + idclase + "','" + foto + "','" + date + "' )";
                        //   String dato = "insert into Post(autor_post, msj, id_usu, id_foro, img_post, img_autor, hora_post)" + "values( ' " + nombre + " ' , ' " + texto + "','" + id + "','" + idclase + "','" + saveFile + "','" + foto + "','" + date + "' )";
                        int resultadoEdita = base.insertar(dato);

                    }

                    String select = "Select max(id_post) from Post where id_foro = '" + idclase + "'";
                    ResultSet resultado = base.consulta(select);
                    String id_publi = resultado.getString(1);
                    String str = "update Post set img_post= ' " + saveFile + " '  where id_post=' " + id_publi + " ";
                    base.edita(str);
                    int actualizacion = base.edita(str);

                    //out.print("hola" + saveFile);
                    if (actualizacion == 1) {
        %>
        <script>
            window.alert(saveFile);
        </script>

        <%
                    }

                }
                response.sendRedirect("Posts_doc.jsp?id_clase=" + idclase);
                base.cierraConexion();
            } catch (Exception XD) {

            }


        %>

       





    </body>
</html>
