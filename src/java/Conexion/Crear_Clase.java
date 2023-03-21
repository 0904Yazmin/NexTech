package Conexion;

import java.security.SecureRandom;

public class Crear_Clase {
    
    public static String generarClase(int len) {
        final String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        SecureRandom random = new SecureRandom();
        StringBuilder sb = new StringBuilder();
        for (int i = 0;  i < 8;  i++) {
            int randomIndex = random.nextInt(chars.length());
            sb.append(chars.charAt(randomIndex));
        }

        return sb.toString();
    }

    public static void main(String[] args) {
        int len = 8;
        System.out.println(generarClase(len));
    }
}