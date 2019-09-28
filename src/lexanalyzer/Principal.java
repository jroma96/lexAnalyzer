/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package lexanalyzer;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.Reader;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JFileChooser;

/**
 *
 * @author Obed
 */
public class Principal extends javax.swing.JFrame {

    /**
     * Creates new form Principal
     */
    public Principal() {
        initComponents();
        this.setLocationRelativeTo(null);
    }

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        btn_analizar = new javax.swing.JButton();
        jScrollPane1 = new javax.swing.JScrollPane();
        txtA_resultado = new javax.swing.JTextArea();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);

        btn_analizar.setFont(new java.awt.Font("Tahoma", 0, 18)); // NOI18N
        btn_analizar.setText("Analizar");
        btn_analizar.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btn_analizarActionPerformed(evt);
            }
        });

        txtA_resultado.setColumns(20);
        txtA_resultado.setRows(5);
        jScrollPane1.setViewportView(txtA_resultado);

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addGap(35, 35, 35)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                    .addComponent(jScrollPane1, javax.swing.GroupLayout.DEFAULT_SIZE, 326, Short.MAX_VALUE)
                    .addComponent(btn_analizar, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                .addContainerGap(37, Short.MAX_VALUE))
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addGap(43, 43, 43)
                .addComponent(btn_analizar, javax.swing.GroupLayout.PREFERRED_SIZE, 48, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(33, 33, 33)
                .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, 148, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(28, Short.MAX_VALUE))
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    Lexer lex;
    Tokens tokens;
    boolean bandera;
    private void btn_analizarActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btn_analizarActionPerformed
        // TODO add your handling code here:
        JFileChooser pick = new JFileChooser();
        pick.showOpenDialog(null);      
        try {
            Reader lector = new BufferedReader(new FileReader(pick.getSelectedFile()));
            lex = new Lexer(lector);
            while (true) {
                tokens = lex.yylex();
                if(tokens == null){
                    txtA_resultado.setText("CORRECTO");
                    break;
                }
                switch(tokens){
                    case ERROR:
                        error();
                        break;
                    case Reservadas:
                        switch(lex.lexeme){
                            case "SELECT":
                                break;
                            case "DELETE":
                                //delete();
                                break;
                            case "INSERT":
                                break;
                            case "UPDATE":
                                break;
                            case "DROP":
                                drop();
                                txtA_resultado.setText("CORRECTO");
                                break;
                            default:
                                error();
                                break;
                        }    
                        break;
                    default:
                        error();
                        break;
                
                }
            }
        } catch (FileNotFoundException ex) {
            Logger.getLogger(Principal.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(Principal.class.getName()).log(Level.SEVERE, null, ex);
        }
    }//GEN-LAST:event_btn_analizarActionPerformed
       
    public void drop(){
        try{
            tokens = lex.yylex();
            switch(lex.lexeme){
                case "LOGIN":
                    B();
                    break;
                case "TABLE":
                    C();
                    break;
                case "DATABASE":
                    break;
                case "VIEW":
                    break;
                case "INDEX":
                    break;
                default:
                    error();
                    break;
            }
        }
        catch(Exception ex){
            Logger.getLogger(Principal.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    public void C(){
        try{
            tokens = lex.yylex();
            if(lex.lexeme.equals("IF")){
                tokens = lex.yylex();
                if(lex.lexeme.equals("EXISTS")){
                    G();
                }
            }
            else{
                G();
            }
        }
        catch(Exception ex){
            Logger.getLogger(Principal.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public void G(){
        try{
            tokens = lex.yylex();
            if(tokens == Tokens.Identificador){
                tokens = lex.yylex();
                if(lex.lexeme.equals(".")){
                    tokens = lex.yylex();
                    if(tokens == Tokens.Identificador){
                        tokens = lex.yylex();
                        if(lex.lexeme.equals(".")){
                            tokens = lex.yylex();
                            if(tokens == Tokens.Identificador){
                                H();
                            }
                            else{
                                error();
                            }
                        }
                        else {
                            H();
                        }
                    }
                    else{
                        error();
                    }
                }
                else{
                    H();
                }
            }
            else{
                error();
            }
        }
        catch(Exception ex){
            Logger.getLogger(Principal.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public void H(){
        try{
            tokens = lex.yylex();
            if(lex.lexeme.equals(",")){
                tokens = lex.yylex();
            if(tokens == Tokens.Identificador){
                tokens = lex.yylex();
                if(lex.lexeme.equals(".")){
                    tokens = lex.yylex();
                    if(tokens == Tokens.Identificador){
                        tokens = lex.yylex();
                        if(lex.lexeme.equals(".")){
                            tokens = lex.yylex();
                            if(tokens == Tokens.Identificador){
                                H();
                            }
                            else{
                                error();
                            }
                        }
                        else {
                            H();
                        }
                    }
                    else{
                        error();
                    }
                }
                else{
                    H();
                }
            }
            else{
                error();
            }
            }
            else{
                return;
            }
        }
        catch(Exception ex){
            Logger.getLogger(Principal.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public void B(){
        try{
            
        }
        catch(Exception ex){
            Logger.getLogger(Principal.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public void FIN(){
        try{
            tokens = lex.yylex();
            if(lex.lexeme.equals("GO") || lex.lexeme.equals(";")){
                return;
            }
            else{
                error();
            }
        }
        catch(Exception ex){
            Logger.getLogger(Principal.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public void error(){
        try{
            tokens = lex.yylex();
            while(lex.lexeme.equals(";") | lex.lexeme.equals("GO")){
                lex.yylex();
            }
       
        }
        catch(Exception ex){
            Logger.getLogger(Principal.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    /**
     * @param args the command line arguments
     */
    public static void main(String args[]) {
        /* Set the Nimbus look and feel */
        //<editor-fold defaultstate="collapsed" desc=" Look and feel setting code (optional) ">
        /* If Nimbus (introduced in Java SE 6) is not available, stay with the default look and feel.
         * For details see http://download.oracle.com/javase/tutorial/uiswing/lookandfeel/plaf.html 
         */
        try {
            for (javax.swing.UIManager.LookAndFeelInfo info : javax.swing.UIManager.getInstalledLookAndFeels()) {
                if ("Nimbus".equals(info.getName())) {
                    javax.swing.UIManager.setLookAndFeel(info.getClassName());
                    break;
                }
            }
        } catch (ClassNotFoundException ex) {
            java.util.logging.Logger.getLogger(Principal.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(Principal.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(Principal.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(Principal.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                new Principal().setVisible(true);
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton btn_analizar;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JTextArea txtA_resultado;
    // End of variables declaration//GEN-END:variables
}
