package Conexion;

public class Exam {

    int[] correctas = {1, 2, 2, 2, 3, 2, 1, 2, 1, 2, 3, 3, 1, 2, 2, 3, 1};
    int[] opcion_elegida;

    public int[] getCorrectas() {
        return correctas;
    }

    public void setCorrectas(int[] correctas) {
        this.correctas = correctas;
    }

    public int[] getOpcion_elegida() {
        return opcion_elegida;
    }

    public void setOpcion_elegida(int[] opcion_elegida) {
        this.opcion_elegida = opcion_elegida;
    }

    public int getAciertos() {
        return aciertos;
    }

    public void setAciertos(int aciertos) {
        this.aciertos = aciertos;
    }
    public int aciertos;

    
    
    public void respuesta(int num_pregunta, int seleccionada) {

        opcion_elegida[num_pregunta] = seleccionada;

        //String id = "p" + num_pregunta;
    }

    public int corregir() {
        int cantidad_correctas = 0;
        for (int i = 0; i < correctas.length; i++) {
            if (correctas[i] == opcion_elegida[i]) {
                cantidad_correctas++;
            }
        }
        return cantidad_correctas;
        //int aciertos = Integer.parseInt(request.getParameter("resultado"));;
    }
}
