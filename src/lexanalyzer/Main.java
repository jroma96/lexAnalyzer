/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package lexanalyzer;

import java.io.File;
import java.nio.file.*;
import java.nio.file.Paths;

/**
 *
 * @author Roma
 */
public class Main {
    public static void main(String[] args) {
        String ruta = FileSystems.getDefault().getPath("").toAbsolutePath()+"\\src\\lexanalyzer\\lexer.flex";
        System.out.println(ruta);
        genLexer(ruta);
    }
    public static void genLexer (String ruta){
        File archivo = new File(ruta);
        jflex.Main.generate(archivo);
    }
}
