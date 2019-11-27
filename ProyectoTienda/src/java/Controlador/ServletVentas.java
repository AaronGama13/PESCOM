/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controlador;

import Database.Sentencias;
import Modelos.Producto;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author AnonimusCrack
 */
@WebServlet(name = "ServletVentas", urlPatterns = {"/ServletVentas"})
public class ServletVentas extends HttpServlet {
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try(PrintWriter out = response.getWriter()){
            HttpSession sesion = request.getSession();
            String username = (String) sesion.getAttribute("username");
            String priv = (String) sesion.getAttribute("priv");
            String accion = request.getParameter("accion");
            int idVenta = Integer.parseInt(request.getParameter("id"));
            
            if(accion.equals("mostrar")){
                ResultSet Compra = Sentencias.NoVenta(idVenta);
                sesion.setAttribute("username", username);
                sesion.setAttribute("priv", priv);
                sesion.setAttribute("rs", Compra);
                response.sendRedirect("venta_detalles.jsp");
            }
            
        }catch(Exception e){
            System.out.println("ERROR (Sentencias.readProductos): "+e);
            e.printStackTrace();
        }
    }
   
    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
