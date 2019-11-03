/*
    AUTOR: SÁNCHEZ CASTRO AARÓN GAMALIEL
    VERSIÓN: 1.0
    DESCRIPCIÓN: 
    FECHA:
*/

package Database;
import java.sql.*;

public class Sentencias {
    
    private static final String INSERT_USER = "INSERT INTO comprador VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
    
    public static int createUser(String [] params){
        try{
            Connection cnx = Conexion.getConexion();
            PreparedStatement ps = cnx.prepareStatement(INSERT_USER);
            ps.setString(1,params[0]); //username
            ps.setString(2,params[1]); //np (nombre de pila)
            ps.setString(3,params[2]); //ap (apellido paterno)
            ps.setString(4,params[3]); //am (apellido materno)
            ps.setString(5,params[4]); //calle 
            ps.setInt(6,Integer.parseInt(params[5]));
            ps.setInt(7,Integer.parseInt(params[6]));
            ps.setString(8,params[7]); //col 
            ps.setString(9,params[8]); //alc (alcaldia)
            ps.setString(10,params[9]); //muni (municipio)
            ps.setString(11,params[10]); //edo
            ps.setString(12,params[11]); //cd (ciudad)
            ps.setInt(13,Integer.parseInt(params[12]));
            ps.setInt(14,Integer.parseInt(params[13]));
            ps.setString(15,params[14]); //password         
            return ps.executeUpdate();
        }catch(Exception error){
            System.out.println("ERROR (Sentencias.createUser): "+error);
            error.printStackTrace();
            return 10;
        }
    }
}