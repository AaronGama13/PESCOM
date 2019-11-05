/*
    AUTOR: SÁNCHEZ CASTRO AARÓN GAMALIEL
    VERSIÓN: 1.0
    DESCRIPCIÓN: 
    FECHA:
*/

package Modelos;

import java.sql.Blob;

public class Producto {
    
    private String nombre,detalles;
    private Double precio;
    private int stock;
    private Blob foto;
    
    public Producto(String nombre, Double precio, int stock, Blob foto, String detalles){
        this.nombre=nombre;
        this.precio=precio;
        this.stock=stock;
        this.foto=foto;
        this.detalles=detalles;
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
    
    public Blob getFoto(){
        return foto;
    }
    
    public String getDetalles(){
        return detalles;
    }
    
}
