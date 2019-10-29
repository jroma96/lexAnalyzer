/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package lexanalyzer;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
/**
 *
 * @author Roma
 */
public class Main {
    public static void main(String[] args) throws Exception {
        String ruta = "C:/Users/Obed/Documents/GitHub/lexAnalyzer/src/lexanalyzer/lexer.flex";
        String [] rutaS = {"-parser", "Syntax", "C:/Users/Obed/Documents/GitHub/lexAnalyzer/src/lexanalyzer/Syntax.cup"};
        genFiles(ruta, rutaS);
    }
    public static void genFiles(String ruta, String [] rutaS) throws IOException, Exception{
        File archivo;
        archivo = new File(ruta);
        jflex.Main.generate(archivo);
        java_cup.Main.main(rutaS);
        if(Paths.get("C:/Users/Obed/Documents/GitHub/lexAnalyzer/src/lexanalyzer/sym.java").toFile().exists()){
            Paths.get("C:/Users/Obed/Documents/GitHub/lexAnalyzer/src/lexanalyzer/sym.java").toFile().delete();
            Paths.get("C:/Users/Obed/Documents/GitHub/lexAnalyzer/src/lexanalyzer/Syntax.java").toFile().delete();
            Files.move(
                    Paths.get("C:/Users/Obed/Documents/GitHub/lexAnalyzer/sym.java"), 
                    Paths.get("C:/Users/Obed/Documents/GitHub/lexAnalyzer/src/lexanalyzer/sym.java")
            );
            Files.move(
                    Paths.get("C:/Users/Obed/Documents/GitHub/lexAnalyzer/Syntax.java"), 
                    Paths.get("C:/Users/Obed/Documents/GitHub/lexAnalyzer/src/lexanalyzer/Syntax.java")
            );
        }
        else{
            Files.move(
                    Paths.get("C:/Users/Obed/Documents/GitHub/lexAnalyzer/sym.java"), 
                    Paths.get("C:/Users/Obed/Documents/GitHub/lexAnalyzer/src/lexanalyzer/sym.java")
            );
            Files.move(
                    Paths.get("C:/Users/Obed/Documents/GitHub/lexAnalyzer/Syntax.java"), 
                    Paths.get("C:/Users/Obed/Documents/GitHub/lexAnalyzer/src/lexanalyzer/Syntax.java")
            );
        }
    }
}
