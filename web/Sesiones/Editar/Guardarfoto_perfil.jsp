
<%@page import="org.apache.tomcat.util.http.fileupload.FileItemIterator"%>
<%@page import="org.apache.tomcat.util.http.fileupload.FileItemFactory"%>
<%@page import="org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload"%>
<%@page import="org.apache.tomcat.util.http.fileupload.FileItemStream"%>
<%@page import="Conexion.BD"%>
<%@page import="org.apache.tomcat.util.http.fileupload.util.Streams"%>
<%@page import="org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory"%>
<%@ page import="java.io.InputStream" %>
<%@ page import="import java.util.*" %>
<%@ page import="java.sql.Connection" %>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.io.File"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.DataInputStream"%>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>

<%
    HttpSession miSessiondelUsuario = (HttpSession) request.getSession();

    int id = (int) (miSessiondelUsuario.getAttribute("id_usu") == null ? 0 : miSessiondelUsuario.getAttribute("id_usu"));
    BD base = new BD();

// Verifica que el formulario se haya enviado y contiene un archivo
    boolean isMultipart = ServletFileUpload.isMultipartContent(request);
    if (isMultipart) {
        // Crea un objeto FileItemFactory
        FileItemFactory factory = new DiskFileItemFactory();

        // Crea un objeto ServletFileUpload
        ServletFileUpload upload = new ServletFileUpload(factory);

        try {
            // Procesa los elementos del formulario
            FileItemIterator iter = upload.getItemIterator(request);
            while (iter.hasNext()) {
                FileItemStream item = iter.next();
                String fieldName = item.getFieldName();

                // Si el elemento es un archivo, guárdalo en la base de datos
                if (!item.isFormField() && fieldName.equals("imagen")) {
                    InputStream inputStream = item.openStream();

                    // Lee los bytes de la imagen
                    byte[] bytes = Streams.toByteArray(inputStream);

                    // Prepara la consulta para guardar los bytes en la base de datos
                    String sql = "INSERT INTO Usuario (foto_usu) VALUES ('" + bytes + "' )  where id_usu=' " + id + " ' ";

                    //   PreparedStatement statement = connection.prepareStatement(sql);
                    base.insertar(sql);
                    //statement.setBytes(1, bytes);

                    // Ejecuta la consulta
                    base.edita(sql);
               //     base.close();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

// Cierra la conexión a la base de datos
    try {
        if (base != null) {

            base.cierraConexion();
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }



    // quiero guardar una imagen en una base de datos MySQL y recuperarla después. ¿Cómo puedo hacerlo?
    // 1. Crea una tabla en la base de datos con un campo BLOB
    // 2. Crea un formulario HTML con un campo de tipo file
    // 3. Crea un servlet que procese el formulario y guarde el archivo en la base de datos
    // 4. Crea un servlet que recupere el archivo de la base de datos y lo muestre en el navegador
    // 5. Crea un enlace en una página HTML que apunte al servlet que muestra el archivo
    // 6. Prueba el enlace y verifica que el archivo se muestra correctamente
    // 7. Modifica el servlet que guarda el archivo para que también guarde el nombre del archivo en la base de datos

%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
    </body>
</html>
