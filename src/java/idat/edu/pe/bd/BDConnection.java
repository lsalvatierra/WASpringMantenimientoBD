/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package idat.edu.pe.bd;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author LuisAngel
 */
public class BDConnection {
   
     private String url="jdbc:sqlserver://LUISANGEL:1433;databaseName=bdnotas";
    private String login="lsalvat";
    private String password="lsalvat1989";
    private String driver="com.microsoft.sqlserver.jdbc.SQLServerDriver";  
    Connection conn = null;

    
    public BDConnection() {
        
    }
    public Connection EstablecerConexion(){
        try{
            Class.forName(driver);
            conn = DriverManager.getConnection(url,login,password);    
        }catch(ClassNotFoundException | SQLException e){
            e.printStackTrace();
        }        
        return conn;
    }
    
    public void Desconectar(){
        try{
            conn.close();
        }catch(SQLException e){
            e.printStackTrace();
        }
    }    
}
