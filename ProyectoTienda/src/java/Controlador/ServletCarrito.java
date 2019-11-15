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
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "ServletCarrito", urlPatterns = {"/ServletCarrito"})
public class ServletCarrito extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try (PrintWriter out = response.getWriter()) {
            
            int idProducto = Integer.parseInt(request.getParameter("id"));
            String accion = request.getParameter("accion");
            HttpSession sesion = request.getSession();
            ArrayList<Producto> Carrito = (ArrayList<Producto>) sesion.getAttribute("Carrito");
            
            if(accion.equals("agregar")){
                Producto aux = Sentencias.readProductoId(idProducto);
                if(Carrito == null)
                    Carrito = new ArrayList<Producto>();
                Carrito.add(aux);
                sesion.setAttribute("Carrito", Carrito);
                response.sendRedirect("productos.jsp");
            }
            else if(accion.equals("quitar")){
                //Producto aux = Sentencias.readProductoId(idProducto);
                Carrito.remove(idProducto);
                if(Carrito == null)
                    Carrito = new ArrayList<Producto>();
                sesion.setAttribute("Carrito", Carrito);
                response.sendRedirect("carrito.jsp");
            }
        } catch(Exception e){
            System.out.println("ERROR (Sentencias.readProductos): "+e);
            e.printStackTrace();
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
