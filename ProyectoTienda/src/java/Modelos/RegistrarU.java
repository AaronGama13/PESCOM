/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Modelos;

import Database.Conexion;
import java.sql.*;

/**
 *
 * @author saulg
 */
public class RegistrarU {
    
    public boolean registro(String username, String np, String ap, String am,
            String calle, int noExt, int noInt, String col, String alc,
            String muni, String edo, String cd, int cp, int tel, String pass) {
        PreparedStatement ps = null;
        
        try{
            String consulta = "INSERT INTO comprador (username, np, ap, am,"
                    + "calle, noExt, noInt, col, alc, muni, edo, cd, cp, tel, "
                    + "pass) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            ps = Conexion.getConexion().prepareStatement(consulta);
            ps.setString(1, username);
            ps.setString(2, np);
            ps.setString(3, ap);
            ps.setString(4, am);
            ps.setString(5, calle);
            ps.setInt(6, noExt);
            ps.setInt(7, noInt);
            ps.setString(8, col);
            ps.setString(9, alc);
            ps.setString(10, muni);
            ps.setString(11, edo);
            ps.setString(12, cd);
            ps.setInt(13, cp);
            ps.setInt(14, tel);
            ps.setString(15, pass);
            
            if(ps.executeUpdate() == 1) {
                return true;
            }
        } catch(Exception e) {
            System.out.println("Error en RegistrarU " + e);
        } finally {
            try{
                if(Conexion.getConexion() != null) Conexion.getConexion().close();
                if(ps != null) ps.close();
            }catch(Exception e){
            System.out.println("Error en RegistrarU en el finally" + e);    
            }
        }          
        return false;
    }
    
}
