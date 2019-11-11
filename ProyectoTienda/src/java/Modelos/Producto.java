/*
    AUTOR: SÁNCHEZ CASTRO AARÓN GAMALIEL
    VERSIÓN: 1.0
    DESCRIPCIÓN: 
    FECHA:
*/

package Modelos;

import java.sql.Blob;
import java.sql.SQLException;
import java.util.Base64;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Producto {
    
    private String nombre,detalles;
    private Double precio;
    private int stock, idProducto;
    private String foto;
    
    public Producto(int idProducto, String nombre, Double precio, int stock, Blob foto, String detalles){
        try {
            this.idProducto=idProducto;
            this.nombre=nombre;
            this.precio=precio;
            this.stock=stock;
            byte[] aux = foto.getBytes(1,(int) foto.length());
            this.foto = Base64.getEncoder().encodeToString(aux);
            this.detalles=detalles;
        } catch (SQLException ex) {
            Logger.getLogger(Producto.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public int getId(){
        return idProducto;
    }
    
    public String getNombre(){
        return nombre;
    }
    
    public Double getPrecio(){
        return precio;
    }
    
    public int getStock(){
        return stock;
    }
    
    public String getFoto(){
        return foto;
    }
    
    public String getDetalles(){
        return detalles;
    }
    
}
