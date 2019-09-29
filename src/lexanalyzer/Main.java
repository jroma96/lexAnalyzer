/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package lexanalyzer;

import java.io.File;

/**
 *
 * @author Roma
 */
public class Main {
    public static void main(String[] args) {
        String ruta = "C:\\Users\\Obed\\Documents\\GitHub\\lexAnalyzer\\src\\lexanalyzer\\lexer.flex";
        genLexer(ruta);
    }
    public static void genLexer (String ruta){
        File archivo = new File(ruta);
        jflex.Main.generate(archivo);
    }
}
