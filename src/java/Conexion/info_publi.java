package Conexion;

public class info_publi {
    /* 
    String usuario = request.getParameter("TxtUsu");
    String correo = request.getParameter("TxtMail");
    String tipoUsu = request.getParameter("SelectUsu");
    String pass = request.getParameter("TxtPass");
    String tipoPlan = "basico";
    String fotoUsu = "fotoUsu_0.png";

    // metodo para obtener la informacion de la publicacion
    public String[] info_publi(int id_publi) {
        String[] info = new String[5];
        try {
            BD basesita = new BD();
            BD.conectar();
            String str = "SELECT * FROM publicacion WHERE id_publicacion = " + id_publi;
            ResultSet rs = basesita.consulta(str);
            while (rs.next()) {
                info[0] = rs.getString("titulo");
                info[1] = rs.getString("descripcion");
                info[2] = rs.getString("fecha");
                info[3] = rs.getString("hora");
                info[4] = rs.getString("id_usuario");
            }
            basesita.cierraConexion();
        } catch (SQLException ex) {
            Logger.getLogger(info_publi.class.getName()).log(Level.SEVERE, null, ex);
        }
        return info;
    }
*/
}
