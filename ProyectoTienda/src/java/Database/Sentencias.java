/*
    AUTOR: SÁNCHEZ CASTRO AARÓN GAMALIEL
    VERSIÓN: 1.0
    DESCRIPCIÓN: 
    FECHA:
*/

package Database;
import Modelos.Producto;
import java.sql.*;
import java.util.ArrayList;

public class Sentencias {
    
    private static final String INSERT_USER = "INSERT INTO comprador VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
    private static final String SELECT_PRODUCTOS = "SELECT * FROM Producto";
    private static final String SELECT_PRODUCTOS_TIPO = "SELECT * FROM Producto WHERE tipo=?";
    
    public static int createUsuario(String [] params){
        try{
            Connection cnx = Conexion.getConexion();
            PreparedStatement ps = cnx.prepareStatement(INSERT_USER);
            ps.setString(1,params[0]); //username
            ps.setString(2,params[1]); //np (nombre de pila)
            ps.setString(3,params[2]); //ap (apellido paterno)
            ps.setString(4,params[3]); //am (apellido materno)
            ps.setString(5,params[4]); //calle 
            ps.setInt(6,Integer.parseInt(params[5])); //no. Exterior
            ps.setInt(7,Integer.parseInt(params[6])); //no. Interior
            ps.setString(8,params[7]); //col 
            ps.setString(9,params[8]); //alc (alcaldia)
            ps.setString(10,params[9]); //muni (municipio)
            ps.setString(11,params[10]); //edo
            ps.setString(12,params[11]); //cd (ciudad)
            ps.setInt(13,Integer.parseInt(params[12]));
            ps.setString(14, params[13]); //numero de telefono
            ps.setString(15,params[14]); //password         
            return ps.executeUpdate();
        }catch(Exception error){
            System.out.println("ERROR (Sentencias.createUsuario): "+error);
            error.printStackTrace();
            return 10;
        }
    }
    
    public static ArrayList<Producto> readProductos(char tipo){
        ArrayList<Producto> productos = new ArrayList();
        try{
            PreparedStatement ps = null;
            if(tipo!='N'){
                ps = Conexion.getConexion().prepareStatement(SELECT_PRODUCTOS_TIPO);
                ps.setString(1,String.valueOf(tipo));
            }else{
                ps = Conexion.getConexion().prepareStatement(SELECT_PRODUCTOS);
            }
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                Producto aux = new Producto(
                        rs.getString("nom"),
                        rs.getDouble("precio"), //precio
                        rs.getInt("stock"), //stock
                        rs.getBlob("foto"), //foto
                        rs.getString("detalles") //detalles
                );
                productos.add(aux);
            }
            return productos;
        }catch(Exception error){
            System.out.println("ERROR (Sentencias.readProductos): "+error);
        }
        return productos;
    }
}