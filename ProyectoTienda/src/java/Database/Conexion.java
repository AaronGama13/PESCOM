/*
    AUTOR: SÁNCHEZ CASTRO AARÓN GAMALIEL
    VERSIÓN: 1.0
    DESCRIPCIÓN: 
    FECHA:
*/
package Database;

import java.sql.*;

public class Conexion {

	private static final String URLD = "jdbc:mysql://localhost:3306/";
	private static final String DATABASE = "tienda";
	private static final String DRIVER = "com.mysql.jdbc.Driver";
	private static final String USERNAME = "root";
	private static final String PASSWORD = "";
	private static Connection cnx = null;

	public static Connection getConexion(){
            if(cnx==null){
                try{
                    Class.forName(DRIVER);
                    cnx = DriverManager.getConnection(URLD+DATABASE,USERNAME,PASSWORD);
                }catch(Exception e){
                    System.out.println("ERROR (Conexion.getConexion): "+e);
                    e.printStackTrace();
                }
            }
            return cnx;
	}

	public static void closeConexion(){
            try{
                if(cnx!=null){
                    cnx.close();
                }
            }catch(Exception e){
                System.out.println("ERROR (Conexion.closeConexion): "+e);
                e.printStackTrace();
            }
	}

}
