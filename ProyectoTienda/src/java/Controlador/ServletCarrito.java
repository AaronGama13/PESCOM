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

/**
 *
 * @author dacov
 */
@WebServlet(name = "ServletCarrito", urlPatterns = {"/ServletCarrito"})
public class ServletCarrito extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String accion = request.getParameter("accion");
            
            if(accion.equals("agregar"))
            {
                int idProducto = Integer.parseInt( request.getParameter("idProducto"));
                
                HttpSession sesion = request.getSession();
                
                ArrayList<Producto> Carrito = (ArrayList<Producto>) sesion.getAttribute("Carrito");
                Producto aux = Sentencias.readProductoId(idProducto);
                if(Carrito == null)
                    Carrito = new ArrayList<Producto>();
                Carrito.add(aux);
                sesion.setAttribute("Carrito", Carrito);
                response.sendRedirect("productos.jsp");
            }
            else if(accion.equals("verCarrito"))
            {
                HttpSession sesion = request.getSession();
                
                String username = (String) sesion.getAttribute("username");
                sesion.setAttribute("username", username);
                ArrayList<Producto> Carrito = (ArrayList<Producto>) sesion.getAttribute("Carrito");
                sesion.setAttribute("Carrito", Carrito);
                
                response.sendRedirect("carrito.jsp");
            }
            else if(accion.equals("filtrar"))
            {
                HttpSession sesion = request.getSession();
            }
        } catch(Exception e)
        {
            System.out.println("ERROR (Sentencias.readProductos): "+e);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
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
