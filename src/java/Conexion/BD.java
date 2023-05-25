package Conexion;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;


public class BD {

    private String usrBD;
    private String passBD;
    private String urlBD;
    private String driverClassName;
    private Connection conn = null;
    private Statement estancia;

    public BD() {
        // Agregar datos para conectarse
        this.usrBD = "root";
        this.passBD = "yar3ni"; //1234
        this.urlBD = "jdbc:mysql://localhost:3306/nexTech";  // ruta del servidor de la base de datos
        this.driverClassName = "com.mysql.jdbc.Driver"; //inicializamos driver
    }

    public String getUsurBD() {
        return usrBD;
    }

    public void setUsurBD(String usurBD) {
        this.usrBD = usurBD;
    }

    public String getPassBD() {
        return passBD;
    }

    public void setPassBD(String passBD) {
        this.passBD = passBD;
    }

    public String getUrlBD() {
        return urlBD;
    }

    public void setUrlBD(String urlBD) {
        this.urlBD = urlBD;
    }

    public String getDriverClassName() {
        return driverClassName;
    }

    public void setDriverClassName(String driverClassName) {
        this.driverClassName = driverClassName;
    }

    public Connection getConn() {
        return conn;
    }

    public void setConn(Connection conn) {
        this.conn = conn;
    }

    // Conexion a aBD
    public void conectar() throws SQLException {
        try {
            Class.forName(this.driverClassName).newInstance();
            this.conn = DriverManager.getConnection(this.urlBD, this.usrBD, this.passBD);

        } catch (Exception err) {
            System.out.println("Error " + err.getMessage());
        }
    }

    //  Cerrar la conexion de BD
    public void cierraConexion() throws SQLException {
        this.conn.close();
    }

    // Metodos para ejecutar sentencias SQL
    public int insertar(String inserta) throws SQLException {
        Statement st = (Statement) this.conn.createStatement();
        return st.executeUpdate(inserta);
    }
    
    // Generar una funcion para mandar a llamar las imagenes de la tabla de Post de
    // la base de datos
    // Path: src\java\Conexion\BD.java
    public String getImagenPost(int id) throws SQLException {
        String imagenPost = "";
        ResultSet rs = this.consulta("SELECT img_post FROM Post WHERE id = " + id);
        while (rs.next()) {
            imagenPost = rs.getString("img_post");
        }
        return imagenPost;
    }

    public ResultSet consulta(String consulta) throws SQLException {
        this.estancia = (Statement) conn.createStatement();
        return this.estancia.executeQuery(consulta);
    }

    public int borrar(String borra) throws SQLException {
        Statement st = (Statement) this.conn.createStatement();
        return st.executeUpdate(borra);
    }

    public int edita(String editar) throws SQLException {
        Statement st = (Statement) this.conn.createStatement();
        return st.executeUpdate(editar);
    }

}