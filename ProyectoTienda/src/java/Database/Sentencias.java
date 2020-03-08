/*
    AUTOR: SÁNCHEZ CASTRO AARÓN GAMALIEL
    VERSIÓN: 1.0
    DESCRIPCIÓN: 
    FECHA:
*/

package Database;
import Modelos.Producto;
import java.io.InputStream;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Sentencias {
    
    private static final String INSERT_USER = "INSERT INTO usuario VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
    private static final String INSERT_COMPRA = "INSERT INTO compra VALUES (?,?,?)";
    private static final String INSERT_PRODUCT_COMPRA = "INSERT INTO productocompra values (?,?,?,?)";
    private static final String SELECT_USERNAME = "SELECT * FROM usuario where username=? and  pass=?"
            + "and priv = 'a' or priv = 'u'";
    private static final String SELECT_USER_DIR= "SELECT np,ap,am,calle,noExt,noInt,col,alc,muni,edo,cd,cp FROM usuario where username=?";
    private static final String SELECT_PRIV = "SELECT priv FROM usuario where username = ?";
    private static final String SELECT_PRODUCTOS = "SELECT * FROM Producto";
    private static final String SELECT_PRODUCTOS_ID = "SELECT * FROM Producto WHERE idProducto=?";
    private static final String SELECT_PRODUCTOS_TIPO = "SELECT * FROM Producto WHERE tipo=?";
    private static final String DELETE_USERNAME = "DELETE FROM usuario WHERE username = ? and pass = ?";
    private static final String SELECT_LOW_STOCK_PRODUCT = "SELECT * FROM Producto WHERE stock<5";
    private static final String INSERT_PRODUCTO = "INSERT INTO producto (nom, precio, stock, tipo, foto, detalles)"
            + "VALUES (?, ?, ?, ?, ?, ?)";
    private static final String UPDATE_PRODUCT_INFO = "UPDATE producto SET nom=?, precio=?, stock=?, detalles=? WHERE idProducto=?";
    private static final String MAX_NOPEDIDO = "SELECT MAX(noPedido) as max from productocompra";   
    private static final String SELECT_VENTAS = "SELECT * FROM compra";
    private static final String SELECT_NOVENTAS = "SELECT * FROM compra natural join productocompra WHERE NoPedido = ?";
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
    
    public static boolean autenticacion(String username, String pass){
        PreparedStatement pst= null;
        ResultSet rs= null;
         try {             
             pst = Conexion.getConexion().prepareStatement(SELECT_USERNAME);
             pst.setString(1, username);
             pst.setString(2,pass);             
             rs = pst.executeQuery();
             if (rs.next()) {                      
                return true;                   
             }
        } catch (Exception e) {
              System.err.println("ERROR (Sentencias.autenticacion): "+e);
        }finally{
            try {
                if(Conexion.getConexion()!=null) //Conexion.getConexion().close();
                if(pst!=null) pst.close();
                if(rs!=null) rs.close();
            } catch (Exception e) {
              System.err.println("ERROR (Sentencias.autenticacion): "+e);
            }
        }
        return false;
    }
    
    public static String privilegio(String username){
        PreparedStatement pst= null;
        ResultSet rs= null;
        String priv;
         try {             
             pst = Conexion.getConexion().prepareStatement(SELECT_PRIV);
             pst.setString(1, username);
             //pst.setString(2,pass);             
             rs = pst.executeQuery();
             if (rs.next()) {                      
                priv = (String) rs.getObject("priv");
                return priv;
             }
        } catch (Exception e) {
              System.err.println("ERROR (Sentencias.privilegio): "+e);
        }finally{
            try {
                if(Conexion.getConexion()!=null) //Conexion.getConexion().close();
                if(pst!=null) pst.close();
                if(rs!=null) rs.close();
            } catch (Exception e) {
              System.err.println("ERROR (Sentencias.privilegio): "+e);
              return "no sirvio jasjasj";
            }
        }
        return "No sirvio jajsjas";
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
            System.out.println("ERROR (Sentencias.readProductoId): "+error);
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
                System.out.println("ERROR (Sentencias.borrarUsuario): " + e);
            }
        }

        return true;
    }
    
    public static ArrayList<Producto> readBajoStock(){
        ArrayList<Producto> array = new ArrayList();
        Producto aux;
        try {
            PreparedStatement ps = Conexion.getConexion().prepareStatement(SELECT_LOW_STOCK_PRODUCT);
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                aux = new Producto(
                        rs.getInt("idProducto"),
                        rs.getString("nom"),
                        rs.getDouble("precio"), //precio
                        rs.getInt("stock"), //stock
                        rs.getBlob("foto"), //foto
                        rs.getString("detalles") //detalles
                );
                array.add(aux);
            }
        } catch (SQLException ex) {
            System.out.println("ERROR (Sentencias.readBajoStock): "+ex);
            ex.printStackTrace();
        }
        return array;
    }
    
    public static int insertarProducto(String [] params, InputStream foto) {
        try {
            PreparedStatement ps = Conexion.getConexion().prepareStatement(INSERT_PRODUCTO);
            ps.setString(1, params[0]);            
            ps.setDouble(2, Double.parseDouble(params[1]));
            ps.setInt(3, Integer.parseInt(params[2]));
            ps.setString(4, params[3]);
            ps.setBlob(5, foto);
            ps.setString(6, params[4]);
            return ps.executeUpdate();
        } catch (SQLException ex) {
            System.out.println("ERROR (Sentencias.insertarProducto): " + ex);
            return 10;
        }                
    }
    public static String insertarCompra(String comprador, int[][] Cantidad){
        //SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd.HH.mm.ss");
        Timestamp timestamp = new Timestamp(System.currentTimeMillis());
        String msj;   
        Calendar c = Calendar.getInstance();
        String fecha = Integer.toString(c.get(Calendar.YEAR)) + "/" + Integer.toString(c.get(Calendar.MONTH)) + "/" + Integer.toString(c.get(Calendar.DATE));
        try{
            int NoPedido = maxNoPedido();
            PreparedStatement ps = Conexion.getConexion().prepareStatement(INSERT_COMPRA);
            ps.setInt(1, NoPedido);
            ps.setTimestamp(2, timestamp);
            ps.setString(3, comprador);
            ps.executeUpdate();
            msj = insertarProductoCompra(NoPedido, Cantidad);
        }catch(Exception e){
            msj = "insertarCompra(error): " + e.toString();
        }
        
        return msj;
        
    }
    
    public static String insertarProductoCompra(int NoPedido, int[][] Cantidad){
        String msj = "Compra realizada con éxito"; 
        try{
            for(int i = 0; i < 100; i++){
                if(Cantidad[i][0] == 0)
                    break;
                PreparedStatement ps = Conexion.getConexion().prepareStatement(INSERT_PRODUCT_COMPRA);
                ps.setInt(1, NoPedido);
                ps.setInt(2, Cantidad[i][0]);
                
                Producto p  = readProductoId(Cantidad[i][0]);
                /*
                AQUI CHECAMOS STOCK DE CADA PRODUCTO Y RESTAMOS
                */
                ps.setString(3, p.getNombre());
                ps.setInt(4, Cantidad[i][1]); 
                ps.executeUpdate();
            }   
        }catch(Exception e){
            msj = "insertarProductoCompra(error): " + e.toString();
        }
        return msj;
    }
    
    public static int updateProductInfo(String nom, Double precio, int stock, String detalles, int id){
        try{
            PreparedStatement ps = Conexion.getConexion().prepareStatement(UPDATE_PRODUCT_INFO);
            ps.setString(1,nom);
            ps.setDouble(2,precio);
            ps.setInt(3,stock);
            ps.setString(4,detalles);
            ps.setInt(5, id);
            return ps.executeUpdate();
        }catch(Exception e){
            System.out.println("ERROR (Sentencias.updateProductInfo): "+e);
            e.printStackTrace();
            return 0;
        }
    }
    
    public static int maxNoPedido(){
        int max = -1;
        try{
            PreparedStatement ps = Conexion.getConexion().prepareStatement(MAX_NOPEDIDO);
            ResultSet rs = ps.executeQuery();
            if(rs.next())
                max = rs.getInt("max") + 1;
        } catch(Exception e){ }
        return max;
    } 
    
    public static ResultSet Ventas(){
        ResultSet rs = null;
        try{
            PreparedStatement ps = Conexion.getConexion().prepareStatement(SELECT_VENTAS);
            rs = ps.executeQuery();
        }catch(Exception e){ }
        return rs;
    }
    
    public static ResultSet NoVenta(int NoPedido){
        ResultSet rs = null;
        try{
            PreparedStatement ps = Conexion.getConexion().prepareStatement(SELECT_NOVENTAS);
            ps.setInt(1,NoPedido);
            rs = ps.executeQuery();
        }catch(Exception e){ }
        return rs;
    }
    
    public static ResultSet datosEnvio(String comprador){
        ResultSet rs = null;
        try{
            PreparedStatement ps = Conexion.getConexion().prepareStatement(SELECT_USER_DIR);
            ps.setString(1,comprador);
            rs = ps.executeQuery();
        }catch(Exception e){
            System.out.println("ERROR");
        }
        return rs;
    }
}   