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
    
    private static final String INSERT_USER = "INSERT INTO usuario VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
    private static final String SELECT_USERNAME = "SELECT * FROM usuario where username=? and  pass=?"
            + "and priv = 'a' or priv = 'u'";
    private static final String SELECT_PRIV = "SELECT priv FROM usuario where priv = 'a'";
    private static final String SELECT_PRODUCTOS = "SELECT * FROM Producto";
    private static final String SELECT_PRODUCTOS_ID = "SELECT * FROM Producto WHERE idProducto=?";
    private static final String SELECT_PRODUCTOS_TIPO = "SELECT * FROM Producto WHERE tipo=?";
    private static final String DELETE_USERNAME = "DELETE FROM usuario WHERE username = ? and pass = ?";
    
    public static int createUsuario(String [] params){
        try{
            Connection cnx = Conexion.getConexion();
            PreparedStatement ps = cnx.prepareStatement(INSERT_USER);
            ps.setString(1,params[0]); //username
            ps.setString(2, params[1]);//privilegio
            ps.setString(3,params[2]); //np (nombre de pila)
            ps.setString(4,params[3]); //ap (apellido paterno)
            ps.setString(5,params[4]); //am (apellido materno)
            ps.setString(6,params[5]); //calle 
            ps.setInt(7,Integer.parseInt(params[6])); //no. Exterior
            ps.setInt(8,Integer.parseInt(params[7])); //no. Interior
            ps.setString(9,params[8]); //col 
            ps.setString(10,params[9]); //alc (alcaldia)
            ps.setString(11,params[10]); //muni (municipio)
            ps.setString(12,params[11]); //edo
            ps.setString(13,params[12]); //cd (ciudad)
            ps.setInt(14,Integer.parseInt(params[13]));
            ps.setString(15, params[14]); //numero de telefono
            ps.setString(16,params[15]); //password         
            return ps.executeUpdate();
        }catch(Exception error){
            System.out.println("ERROR (Sentencias.createUsuario): "+error);
            error.printStackTrace();
            return 10;
        }
    }        
    
    public static boolean autenticacion(String username, String pass, String priv){
        PreparedStatement pst= null;
        ResultSet rs= null;
         try {             
             pst = Conexion.getConexion().prepareStatement(SELECT_USERNAME);
             pst.setString(1, username);
             pst.setString(2,pass);             
             rs = pst.executeQuery();
             if (rs.next()) {      
                rs.getString("priv");
                return true;                   
             }
        } catch (Exception e) {
              System.err.println("Error "+e);
        }finally{
            try {
                if(Conexion.getConexion()!=null) //Conexion.getConexion().close();
                if(pst!=null) pst.close();
                if(rs!=null) rs.close();
            } catch (Exception e) {
              System.err.println("Error "+e);
            }
        }
        return false;
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
                        rs.getInt("idProducto"),
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
    
    public static Producto readProductoId(int idProducto){
        Producto aux = null;
        try{
            PreparedStatement ps = null;
            ps = Conexion.getConexion().prepareStatement(SELECT_PRODUCTOS_ID);
            ps.setString(1,String.valueOf(idProducto));
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                aux = new Producto(
                        rs.getInt("idProducto"),
                        rs.getString("nom"),
                        rs.getDouble("precio"), //precio
                        rs.getInt("stock"), //stock
                        rs.getBlob("foto"), //foto
                        rs.getString("detalles") //detalles
                );
            }
            return aux;
        }catch(Exception error){
            System.out.println("ERROR (Sentencias.readProductos): "+error);
        }
        return aux;
    }
    
    public static boolean borrarUsuario(String username, String pass) {

        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            ps = Conexion.getConexion().prepareStatement(SELECT_USERNAME);
            ps.setString(1, username);
            ps.setString(2, pass);
            rs = ps.executeQuery();
            if (rs.absolute(1)) {
                ps = Conexion.getConexion().prepareStatement(DELETE_USERNAME);
                ps.setString(1, username);
                ps.setString(2, pass);
                if (ps.executeUpdate() == 1) {
                    return true;
                } else {
                    return false;
                }
            }
        } catch (SQLException e) {

        } finally {
            try {
                ps.close();
            } catch (SQLException e) {
                System.out.println("Error perro, en sentencias " + e);
            }
        }

        return true;
    }
}